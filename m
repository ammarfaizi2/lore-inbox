Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTIPPAW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 11:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTIPPAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 11:00:22 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:28433 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id S261898AbTIPPAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 11:00:20 -0400
Date: Tue, 16 Sep 2003 10:09:54 -0500
From: mike.miller@hp.com
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss version change
Message-ID: <20030916150954.GA31009@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch bumps the version of the cciss driver from 2.4.47 to 2.4.49 to more accurately reflect the capabilities of the driver. It was built/tested against 2.4.23-pre4.

Please consider this patch for inclusion.

Thanks,
mikem
--------------------------------------------------------------------------------
diff -burN lx2423-pre4/drivers/block/cciss.c lx2423-pre4.test/drivers/block/cciss.c
--- lx2423-pre4/drivers/block/cciss.c	2003-09-16 09:30:24.000000000 -0500
+++ lx2423-pre4.test/drivers/block/cciss.c	2003-09-16 10:02:34.000000000 -0500
@@ -45,12 +45,12 @@
 #include <linux/genhd.h>
 
 #define CCISS_DRIVER_VERSION(maj,min,submin) ((maj<<16)|(min<<8)|(submin))
-#define DRIVER_NAME "HP CISS Driver (v 2.4.47)"
-#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,4,47)
+#define DRIVER_NAME "HP CISS Driver (v 2.4.49)"
+#define DRIVER_VERSION CCISS_DRIVER_VERSION(2,4,49)
 
 /* Embedded module documentation macros - see modules.h */
 MODULE_AUTHOR("Hewlett-Packard Company");
-MODULE_DESCRIPTION("Driver for HP SA5xxx SA6xxx Controllers version 2.4.47");
+MODULE_DESCRIPTION("Driver for HP SA5xxx SA6xxx Controllers version 2.4.49");
 MODULE_SUPPORTED_DEVICE("HP SA5i SA5i+ SA532 SA5300 SA5312 SA641 SA642 SA6400"); 
 MODULE_LICENSE("GPL");
 
