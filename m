Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262472AbULCTbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262472AbULCTbE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 14:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbULCTaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:30:11 -0500
Received: from pool-151-203-6-248.bos.east.verizon.net ([151.203.6.248]:11268
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262472AbULCT1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:27:21 -0500
Message-Id: <200412032143.iB3LhPZW004673@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: [PATCH] UML - defconfig update
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Dec 2004 16:43:25 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update defconfig for 2.6.10-rc2-mm4.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/defconfig
===================================================================
--- 2.6.9.orig/arch/um/defconfig	2004-12-01 23:43:12.000000000 -0500
+++ 2.6.9/arch/um/defconfig	2004-12-01 23:48:16.000000000 -0500
@@ -1,11 +1,13 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc1-mm5
-# Sun Nov 14 15:27:58 2004
+# Linux kernel version: 2.6.10-rc2-mm4
+# Wed Dec  1 13:45:40 2004
 #
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_USERMODE=y
 CONFIG_MMU=y
+# CONFIG_64_BIT is not set
+CONFIG_TOP_ADDR=0xc0000000
 CONFIG_UID16=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
@@ -24,6 +26,7 @@
 # CONFIG_SMP is not set
 CONFIG_NEST_LEVEL=0
 CONFIG_KERNEL_HALF_GIGS=1
+# CONFIG_HIGHMEM is not set
 CONFIG_KERNEL_STACK_ORDER=2
 CONFIG_UML_REAL_TIME_CLOCK=y
 
@@ -85,6 +88,7 @@
 #
 # Character Devices
 #
+CONFIG_STDERR_CONSOLE=y
 CONFIG_STDIO_CONSOLE=y
 CONFIG_SSL=y
 CONFIG_FD_CHAN=y
@@ -113,9 +117,7 @@
 CONFIG_BLK_DEV_COW_COMMON=y
 CONFIG_BLK_DEV_LOOP=m
 CONFIG_BLK_DEV_NBD=m
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=4096
-CONFIG_BLK_DEV_INITRD=y
+# CONFIG_BLK_DEV_RAM is not set
 CONFIG_INITRAMFS_SOURCE=""
 
 #

