Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268353AbUIQEQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268353AbUIQEQF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 00:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUIQEOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 00:14:05 -0400
Received: from [12.177.129.25] ([12.177.129.25]:6596 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S268399AbUIQENF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 00:13:05 -0400
Message-Id: <200409170517.i8H5Ha2J005412@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - update defconfig
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Sep 2004 01:17:36 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9-rc2/arch/um/defconfig
===================================================================
--- 2.6.9-rc2.orig/arch/um/defconfig	2004-09-13 22:37:13.000000000 -0400
+++ 2.6.9-rc2/arch/um/defconfig	2004-09-17 00:09:18.000000000 -0400
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.8.1-mm3
-# Fri Aug 20 13:03:03 2004
+# Linux kernel version: 2.6.9-rc2-mm1
+# Thu Sep 16 23:44:48 2004
 #
 CONFIG_USERMODE=y
 CONFIG_MMU=y
@@ -20,7 +20,6 @@
 CONFIG_HPPFS=y
 CONFIG_MCONSOLE=y
 # CONFIG_HOST_2G_2G is not set
-# CONFIG_UML_SMP is not set
 # CONFIG_SMP is not set
 CONFIG_NEST_LEVEL=0
 CONFIG_KERNEL_HALF_GIGS=1
@@ -38,6 +37,7 @@
 #
 # General setup
 #
+CONFIG_LOCALVERSION=""
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_POSIX_MQUEUE is not set
@@ -47,6 +47,7 @@
 # CONFIG_AUDIT is not set
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_HOTPLUG is not set
+CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
@@ -54,12 +55,13 @@
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
-# CONFIG_CPUSETS is not set
 CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SHMEM=y
+# CONFIG_TINY_SHMEM is not set
 
 #
 # Loadable module support
@@ -144,6 +146,7 @@
 # CONFIG_INET_AH is not set
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
 # CONFIG_IPV6 is not set
 # CONFIG_NETFILTER is not set
 
@@ -255,6 +258,11 @@
 CONFIG_AUTOFS4_FS=y
 
 #
+# Caches
+#
+# CONFIG_CACHEFS is not set
+
+#
 # CD-ROM/DVD Filesystems
 #
 CONFIG_ISO9660_FS=y

