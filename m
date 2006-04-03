Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750892AbWDCQlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbWDCQlr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 12:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWDCQlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 12:41:47 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:65218 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750892AbWDCQlq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 12:41:46 -0400
Subject: [PATCH 1/7] tpm: spacing cleanups
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>,
       Marcel Selhorst <selhorst@crypto.rub.de>
Content-Type: text/plain
Date: Mon, 03 Apr 2006 11:42:24 -0500
Message-Id: <1144082544.29910.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes minor spacing issues.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
drivers/char/tpm/tpm.c |    9 ++++-----
1 files changed, 4 insertions(+), 5 deletions(-)

--- linux-2.6.16/drivers/char/tpm/tpm.c	2006-03-19 23:53:29.000000000 -0600
+++ linux-2.6.16-rc1-tpm/drivers/char/tpm/tpm.c	2006-03-22 12:05:26.830788000 -0600
@@ -46,7 +326,7 @@ static void user_reader_timeout(unsigned
 	schedule_work(&chip->work);
 }
 
-static void timeout_work(void * ptr)
+static void timeout_work(void *ptr)
 {
 	struct tpm_chip *chip = ptr;
 
@@ -425,7 +963,7 @@ int tpm_release(struct inode *inode, str
 EXPORT_SYMBOL_GPL(tpm_release);
 
 ssize_t tpm_write(struct file *file, const char __user *buf,
-		  size_t size, loff_t * off)
+		  size_t size, loff_t *off)
 {
 	struct tpm_chip *chip = file->private_data;
 	int in_size = size, out_size;
@@ -457,11 +995,10 @@ ssize_t tpm_write(struct file *file, con
 
 	return in_size;
 }
-
 EXPORT_SYMBOL_GPL(tpm_write);
 
-ssize_t tpm_read(struct file * file, char __user *buf,
-		 size_t size, loff_t * off)
+ssize_t tpm_read(struct file *file, char __user *buf,
+		 size_t size, loff_t *off)
 {
 	struct tpm_chip *chip = file->private_data;
 	int ret_size;


