Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263081AbUKTQUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbUKTQUZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 11:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263080AbUKTQSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 11:18:36 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:45284 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S263029AbUKTQSS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 11:18:18 -0500
From: james4765@verizon.net
To: kernel-janitors@lists.osdl.org
Cc: linux-kernel@vger.kernel.org, james4765@verizon.net
Message-Id: <20041120161837.9319.60041.87620@localhost.localdomain>
Subject: [PATCH] floppy: relocate devfs comment
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [209.158.220.243] at Sat, 20 Nov 2004 10:18:14 -0600
Date: Sat, 20 Nov 2004 10:18:15 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Binary files linux-2.6.10-rc2-original/Documentation/.ioctl-number.txt.swp and linux-2.6.10-rc2/Documentation/.ioctl-number.txt.swp differ
diff -urN --exclude='*~' linux-2.6.10-rc2-original/drivers/block/floppy.c linux-2.6.10-rc2/drivers/block/floppy.c
--- linux-2.6.10-rc2-original/drivers/block/floppy.c	2004-11-15 21:38:15.000000000 -0500
+++ linux-2.6.10-rc2/drivers/block/floppy.c	2004-11-20 11:11:47.670201702 -0500
@@ -98,6 +98,10 @@
  */
 
 /*
+ * 1998/1/21 -- Richard Gooch <rgooch@atnf.csiro.au> -- devfs support
+ */
+
+/*
  * 1998/05/07 -- Russell King -- More portability cleanups; moved definition of
  * interrupt and dma channel to asm/floppy.h. Cleaned up some formatting &
  * use of '0' for NULL.
@@ -159,10 +163,6 @@
 #define FDPATCHES
 #include <linux/fdreg.h>
 
-/*
- * 1998/1/21 -- Richard Gooch <rgooch@atnf.csiro.au> -- devfs support
- */
-
 #include <linux/fd.h>
 #include <linux/hdreg.h>
 
