Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbWILVuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbWILVuk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 17:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWILVuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 17:50:40 -0400
Received: from server6.greatnet.de ([83.133.96.26]:33967 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP
	id S1030295AbWILVui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 17:50:38 -0400
Message-ID: <45072BB9.8080809@nachtwindheim.de>
Date: Tue, 12 Sep 2006 23:50:49 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] wd33c93-dependend drivers: prototype removal
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henrik Kretzschmar <henne@nachtwindheim.de>

Remove unneeded prototypes from scsi headers.
Signed-off-by: Henrik Kretzschmar <henne@nachwindheim.de>

---

diff -ruN linux-2.6/drivers/scsi/a2091.h devel/drivers/scsi/a2091.h
--- linux-2.6/drivers/scsi/a2091.h	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/a2091.h	2006-09-12 23:42:48.000000000 +0200
@@ -13,10 +13,6 @@
 
 int a2091_detect(struct scsi_host_template *);
 int a2091_release(struct Scsi_Host *);
-const char *wd33c93_info(void);
-int wd33c93_queuecommand(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-int wd33c93_abort(Scsi_Cmnd *);
-int wd33c93_reset(Scsi_Cmnd *, unsigned int);
 
 #ifndef CMD_PER_LUN
 #define CMD_PER_LUN 2
diff -ruN linux-2.6/drivers/scsi/a3000.h devel/drivers/scsi/a3000.h
--- linux-2.6/drivers/scsi/a3000.h	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/a3000.h	2006-09-12 23:43:01.000000000 +0200
@@ -13,10 +13,6 @@
 
 int a3000_detect(struct scsi_host_template *);
 int a3000_release(struct Scsi_Host *);
-const char *wd33c93_info(void);
-int wd33c93_queuecommand(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-int wd33c93_abort(Scsi_Cmnd *);
-int wd33c93_reset(Scsi_Cmnd *, unsigned int);
 
 #ifndef CMD_PER_LUN
 #define CMD_PER_LUN 2
diff -ruN linux-2.6/drivers/scsi/gvp11.h devel/drivers/scsi/gvp11.h
--- linux-2.6/drivers/scsi/gvp11.h	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/gvp11.h	2006-09-12 23:43:21.000000000 +0200
@@ -13,10 +13,6 @@
 
 int gvp11_detect(struct scsi_host_template *);
 int gvp11_release(struct Scsi_Host *);
-const char *wd33c93_info(void);
-int wd33c93_queuecommand(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-int wd33c93_abort(Scsi_Cmnd *);
-int wd33c93_reset(Scsi_Cmnd *, unsigned int);
 
 #ifndef CMD_PER_LUN
 #define CMD_PER_LUN 2
diff -ruN linux-2.6/drivers/scsi/mvme147.h devel/drivers/scsi/mvme147.h
--- linux-2.6/drivers/scsi/mvme147.h	2006-08-01 01:31:43.000000000 +0200
+++ devel/drivers/scsi/mvme147.h	2006-09-12 23:43:43.000000000 +0200
@@ -12,10 +12,6 @@
 
 int mvme147_detect(struct scsi_host_template *);
 int mvme147_release(struct Scsi_Host *);
-const char *wd33c93_info(void);
-int wd33c93_queuecommand(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-int wd33c93_abort(Scsi_Cmnd *);
-int wd33c93_reset(Scsi_Cmnd *, unsigned int);
 
 #ifndef CMD_PER_LUN
 #define CMD_PER_LUN 2


