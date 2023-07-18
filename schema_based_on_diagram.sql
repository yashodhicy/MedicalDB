--create patients table
CREATE TABLE patients (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    date_of_birth DATE
);
 
-- create medical_histories table
 CREATE TABLE medical_histories (
    id SERIAL PRIMARY KEY,
    admitted_at TIMESTAMP,
    patient_id INT REFERENCES patients(id),
    status VARCHAR(255)
);

-- create invoice table

CREATE TABLE invoices (
    id SERIAL PRIMARY KEY,
    total_amount DECIMAL(10, 2),
    generated_at TIMESTAMP,
    paid_at TIMESTAMP,
    medical_history_id INT UNIQUE REFERENCES medical_histories(id)
);

-- create treatments table
CREATE TABLE treatments (
    id SERIAL PRIMARY KEY,
    type VARCHAR(255),
    name VARCHAR(255)
);

-- create invoice_items table
CREATE TABLE invoices_items (
    id SERIAL PRIMARY KEY,
    unit_price DECIMAL(10, 2),
    quantity INT,
    total_price DECIMAL(10, 2),
    invoice_id INT REFERENCES invoices(id),
    treatment_id INT REFERENCES treatments(id)
   
);


-- create join table 'treatment_histories'
CREATE TABLE treatments_histories (
  treatment_id INT REFERENCES treatments (id),
  medical_histories_id INT REFERENCES medical_histories (id),
  PRIMARY KEY (  treatment_id, medical_histories_id)
);


--  Add the FK indexes
-- Create index for medical_histories_id in treatments_histories table
CREATE INDEX idx_treatments_histories_medical_histories_id
ON treatments_histories (medical_histories_id);

-- Create index for treatment_id in treatments_histories table
CREATE INDEX idx_treatments_histories_treatment_id
ON treatments_histories (treatment_id);

-- Create index for medical_history_id in invoices table
CREATE UNIQUE INDEX idx_invoices_medical_history_id
ON invoices (medical_history_id);

-- Create index for patient_id in medical_histories table
CREATE INDEX idx_medical_histories_patient_id
ON medical_histories (patient_id);

-- Create index for invoice_id in invoices_items table
CREATE INDEX idx_invoices_items_invoice_id
ON invoices_items (invoice_id);

-- Create index for treatment_id in invoices_items table
CREATE INDEX idx_invoices_items_treatment_id
ON invoices_items (treatment_id);
