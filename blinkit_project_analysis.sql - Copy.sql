
 ================================================================================ 
-- Project : Flipkart E-Commerce Data Analysis 
-- Aurthor : Suruchi Upadhyay
-- Description : Database creation for customers, products,orders with PK & FK
-- Tool : MySQL Workbench
-- GitHub : 
==================================================================================

------------------------------
-- STEP 1: CREATE DATABASE --
------------------------------
CREATE DATABASE flipkart;
use flipkart;

------------------------------------
-- STEP 2: CREATE CUSTOMERS TABLE
-- Primary Key : customer_id 
------------------------------------

CREATE TABLE customers(customer_id varchar(30) PRIMARY KEY ,
customer_name varchar(30), age int, gender varchar(10),
city varchar(30), state varchar(50), signup_date date,
customer_segment varchar(30));

-------------------------------------
-- STEP 3: CREATE PRODUCTS TABLE
-- Primary Key : product_id
-------------------------------------

CREATE TABLE products(product_id varchar(30) PRIMARY KEY, product_name varchar(30), cetegory varchar(30),
brand varchar(30), mrp_inr decimal(10,2), discount_percent int, selling_price_inr decimal(10,2), 
stock_quantity int, seller_rating decimal(10,2), is_active varchar(10));

--------------------------------------------
-- STEP 4: CREATE ORDERS TABLE
-- Primary Key : order_id
-- Foreign key : customer_id , product_id
---------------------------------------------

CREATE TABLE orders(order_id varchar(30) PRIMARY KEY, order_date date, customer_id varchar(30), product_id varchar(30),
quantity int, unit_price_inr decimal(10,2), discount_percent int, order_amount_inr decimal(10,2),
payment_method varchar(50), order_status varchar(30), delivery_days int  , sales_channel varchar(30) , 
foreign key(customer_id) references customers(customer_id),
foreign key (product_id) references products(product_id));


 ===============================================================
-- FLIPKART ANALYSIS - BUSINESS QUESTIONS & QUERIES
-- TOTAL QUESTIONS : 11
-- PURPOSE : TO FIND orders, products and customers insights
 ================================================================

-----------------------------------------------------------------------
-- Q1 : What is the total number of customers, products, and orders?

SELECT (SELECT COUNT(*) FROM customers) AS total_customers,
(SELECT COUNT(*) FROM products) as total_products,
(select count(*) from orders) AS total_orders;

-- Q2: What is the total sales amount?

SELECT SUM(order_amount_inr) as total_sales_amount from orders;

-- Q3: Top 5 best-selling products?

SELECT product_id, sum(quantity) as total_qty_sold
FROM orders group by product_id order by total_qty_sold
desc limit 5;

-- Q4: Sales by Payment method?

SELECT payment_method , SUM(order_amount_inr)as 
total_sales from orders group by payment_method;

-- Q5: Sales by Order Status (How many Delivered, Cancelled, Returned)?

SELECT order_status,count(*) as count from orders
group by order_status; 

-- Q6: Sales by Customer Segment (premium/ new / Regular)?

SELECT  c.customer_segment ,sum(o.order_amount_inr) as total_sales
from customers c
join orders o on c.customer_id = o.customer_id 
GROUP BY c.customer_segment;

-- Q7: Which category generates the most sales?

SELECT p.cetegory , sum(order_amount_inr) as total_sales from orders o
JOIN products p on  o. product_id = p.product_id 
GROUP BY p.cetegory order by total_sales DESC;

-- Q8: State-wise sales analysis?

SELECT C.state , SUM(order_amount_inr) AS sales FROM orders o
JOIN  customers c ON o.customer_id = c.customer_id 
group by state order by sales desc;

-- Q9: Monthly sales trend?

SELECT DATE_FORMAT(order_date ,'%y-%m') as month, 
SUM(order_amount_inr) AS total_sales 
FROM orders group by month order by month;

-- Q10: What is the average delivery time?

SELECT AVG(delivery_days) as avg_delivery_time from orders;

-- Q11: Sales Channel wise performance (Online vs Offline)?

SELECT sales_channel, sum(order_amount_inr) AS total_sales 
from orders group by sales_channel;

-- Q12:  What are the top 5 best-selling products?

SELECT product_id, sum(quantity) as total_quantity_sold 
from orders group by product_id order by total_quantity_sold
DESC LIMIT 5;
----------------------------------------------------------------------------------------------

==================================================================================================================================================================================
## Conclusion ##
-------------------
-- This Flipkart E-Commerce project successfully demonstrates the complete flow of a DBMS project from database creation to business analysis.

-- 1.  A normalized database was created with 3 tables (customers, products, orders) using Primary Key and Foreign Key constraints to maintain data integrity.
-- 2.  SQL queries were used to extract key business insights such as total sales, best-selling products, and customer behavior.
-- 3.  The analysis revealed that understanding payment methods, customer segments, and product categories is crucial for an e-commerce business to increase sales.
-- 4.  The project can be further extended by integrating this SQL database with Tableau for interactive dashboard visualization and with Python for predictive sales analysis.

-- Overall, this project provides a strong foundation in SQL, Data Modeling, and E-Commerce Analytics.
====================================================================================================================================================================================