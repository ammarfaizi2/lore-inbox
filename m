Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbUEQUQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbUEQUQs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 16:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUEQUQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 16:16:47 -0400
Received: from lists.us.dell.com ([143.166.224.162]:13452 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261421AbUEQUQo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 16:16:44 -0400
Date: Mon, 17 May 2004 15:16:25 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: akpm@osdl.org
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
Subject: EDD: remove unused SCSI header files
Message-ID: <20040517201625.GA19268@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EDD: Remove no longer needed SCSI header file inclusion.

Thanks to ArjanV for reminding me.

-Matt
-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


===== drivers/firmware/edd.c 1.25 vs edited =====
--- 1.25/drivers/firmware/edd.c	Mon May 10 06:25:45 2004
+++ edited/drivers/firmware/edd.c	Mon May 17 14:39:49 2004
@@ -43,12 +43,9 @@
 #include <linux/device.h>
 #include <linux/blkdev.h>
 #include <linux/edd.h>
-/* FIXME - this really belongs in include/scsi/scsi.h */
-#include <../drivers/scsi/scsi.h>
-#include <../drivers/scsi/hosts.h>
 
-#define EDD_VERSION "0.14"
-#define EDD_DATE    "2004-Apr-28"
+#define EDD_VERSION "0.15"
+#define EDD_DATE    "2004-May-17"
 
 MODULE_AUTHOR("Matt Domsch <Matt_Domsch@Dell.com>");
 MODULE_DESCRIPTION("sysfs interface to BIOS EDD information");
