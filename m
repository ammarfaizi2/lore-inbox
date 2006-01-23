Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWAWQhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWAWQhe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 11:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWAWQhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 11:37:34 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:21979 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932305AbWAWQhd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 11:37:33 -0500
Subject: [PATCH] tpm: tpm-bios: fix module license issue
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 23 Jan 2006 10:38:31 -0600
Message-Id: <1138034311.5076.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attemepting to insert the tpm modules fails because the tpm_bios file is
missing a license statement.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
--- 
diff -uprN --exclude-from=linux_excludes linux-2.6.16-rc1/drivers/char/tpm/tpm_bios.c linux-2.6.16-rc1-tpm/drivers/char/tpm/tpm_bios.c
--- linux-2.6.16-rc1/drivers/char/tpm/tpm_bios.c	2006-01-20 14:21:13.000000000 -0600
+++ linux-2.6.16-rc1-tpm/drivers/char/tpm/tpm_bios.c	2006-01-20 14:05:41.000000000 -0600
@@ -547,3 +546,4 @@ void tpm_bios_log_teardown(struct dentry
 		securityfs_remove(lst[i]);
 }
 EXPORT_SYMBOL_GPL(tpm_bios_log_teardown);
+MODULE_LICENSE("GPL");


