Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284186AbRL1Wqi>; Fri, 28 Dec 2001 17:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284191AbRL1Wq2>; Fri, 28 Dec 2001 17:46:28 -0500
Received: from gear.torque.net ([204.138.244.1]:49422 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S284186AbRL1WqR>;
	Fri, 28 Dec 2001 17:46:17 -0500
Message-ID: <3C2CF6C7.F3FEF08F@torque.net>
Date: Fri, 28 Dec 2001 17:48:39 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] lk 2.5.3-pre3 drivers/scsi/ide-scsi typo
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/ide-scsi.c fails to compile after the latest
pre-patch (lk 2.5.2-pre3).

Doug Gilbert


diff -du linux/drivers/scsi/ide-scsi.c252p3 linux/drivers/scsi/ide-scsi.c
--- linux/drivers/scsi/ide-scsi.c252p3	Fri Dec 28 16:05:15 2001
+++ linux/drivers/scsi/ide-scsi.c	Fri Dec 28 16:24:19 2001
@@ -841,7 +841,7 @@
 
 static Scsi_Host_Template idescsi_template = {
 	module:		THIS_MODULE,
-	name:		"idescsi"
+	name:		"idescsi",
 	detect:		idescsi_detect,
 	release:	idescsi_release,
 	info:		idescsi_info,
