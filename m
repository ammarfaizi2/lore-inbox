Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbULKRSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbULKRSL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 12:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbULKRSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 12:18:11 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:57864 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261973AbULKRR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 12:17:27 -0500
Date: Sat, 11 Dec 2004 18:17:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Benjamin LaHaise <bcrl@kvack.org>
Subject: Update email address of Benjamin LaHaise
Message-ID: <20041211171714.GW22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise's email address bcrl@redhat.com is bouncing.

The patch below (already ACK'ed by Benjamin LaHaise) changes all 
occurances of this address in the kernel sources to bcrl@kvack.org .


diffstat output:
 MAINTAINERS                    |    2 +-
 arch/i386/kernel/semaphore.c   |    2 +-
 arch/m32r/kernel/semaphore.c   |    2 +-
 arch/x86_64/kernel/semaphore.c |    2 +-
 drivers/net/ns83820.c          |    2 +-
 fs/aio.c                       |    2 +-
 include/linux/aio_abi.h        |    2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/MAINTAINERS.old	2004-12-07 02:29:07.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/MAINTAINERS	2004-12-07 02:30:29.000000000 +0100
@@ -155,7 +155,7 @@
 
 AIO
 P:	Benjamin LaHaise
-M:	bcrl@redhat.com
+M:	bcrl@kvack.org
 L:	linux-aio@kvack.org
 S:	Supported
 
--- linux-2.6.10-rc2-mm4-full/arch/i386/kernel/semaphore.c.old	2004-12-07 02:30:44.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/kernel/semaphore.c	2004-12-07 02:30:59.000000000 +0100
@@ -10,7 +10,7 @@
  *	as published by the Free Software Foundation; either version
  *	2 of the License, or (at your option) any later version.
  *
- * rw semaphores implemented November 1999 by Benjamin LaHaise <bcrl@redhat.com>
+ * rw semaphores implemented November 1999 by Benjamin LaHaise <bcrl@kvack.org>
  */
 #include <linux/config.h>
 #include <linux/sched.h>
--- linux-2.6.10-rc2-mm4-full/arch/m32r/kernel/semaphore.c.old	2004-12-07 02:31:10.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/m32r/kernel/semaphore.c	2004-12-07 02:31:27.000000000 +0100
@@ -19,7 +19,7 @@
  *	as published by the Free Software Foundation; either version
  *	2 of the License, or (at your option) any later version.
  *
- * rw semaphores implemented November 1999 by Benjamin LaHaise <bcrl@redhat.com>
+ * rw semaphores implemented November 1999 by Benjamin LaHaise <bcrl@kvack.org>
  */
 #include <linux/config.h>
 #include <linux/sched.h>
--- linux-2.6.10-rc2-mm4-full/arch/x86_64/kernel/semaphore.c.old	2004-12-07 02:31:36.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/x86_64/kernel/semaphore.c	2004-12-07 02:31:49.000000000 +0100
@@ -10,7 +10,7 @@
  *	as published by the Free Software Foundation; either version
  *	2 of the License, or (at your option) any later version.
  *
- * rw semaphores implemented November 1999 by Benjamin LaHaise <bcrl@redhat.com>
+ * rw semaphores implemented November 1999 by Benjamin LaHaise <bcrl@kvack.org>
  */
 #include <linux/config.h>
 #include <linux/sched.h>
--- linux-2.6.10-rc2-mm4-full/drivers/net/ns83820.c.old	2004-12-07 02:31:57.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/drivers/net/ns83820.c	2004-12-07 02:32:07.000000000 +0100
@@ -2204,7 +2204,7 @@
 	pci_unregister_driver(&driver);
 }
 
-MODULE_AUTHOR("Benjamin LaHaise <bcrl@redhat.com>");
+MODULE_AUTHOR("Benjamin LaHaise <bcrl@kvack.org>");
 MODULE_DESCRIPTION("National Semiconductor DP83820 10/100/1000 driver");
 MODULE_LICENSE("GPL");
 
--- linux-2.6.10-rc2-mm4-full/fs/aio.c.old	2004-12-07 02:32:16.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/fs/aio.c	2004-12-07 02:32:27.000000000 +0100
@@ -1,6 +1,6 @@
 /*
  *	An async IO implementation for Linux
- *	Written by Benjamin LaHaise <bcrl@redhat.com>
+ *	Written by Benjamin LaHaise <bcrl@kvack.org>
  *
  *	Implements an efficient asynchronous io interface.
  *
--- linux-2.6.10-rc2-mm4-full/include/linux/aio_abi.h.old	2004-12-07 02:32:35.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/aio_abi.h	2004-12-07 02:32:44.000000000 +0100
@@ -2,7 +2,7 @@
  *
  * Copyright 2000,2001,2002 Red Hat.
  *
- * Written by Benjamin LaHaise <bcrl@redhat.com>
+ * Written by Benjamin LaHaise <bcrl@kvack.org>
  *
  * Distribute under the terms of the GPLv2 (see ../../COPYING) or under 
  * the following terms.


