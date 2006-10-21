Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2993127AbWJUQvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993127AbWJUQvY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 12:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993134AbWJUQvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 12:51:24 -0400
Received: from ns2.suse.de ([195.135.220.15]:63671 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S2993127AbWJUQvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 12:51:23 -0400
From: Andi Kleen <ak@suse.de>
References: <20061021 651.356252000@suse.de>
In-Reply-To: <20061021 651.356252000@suse.de>
To: patches@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [2/19] i386: Update defconfig
Message-Id: <20061021165121.B8F8213CEB@wotan.suse.de>
Date: Sat, 21 Oct 2006 18:51:21 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/defconfig |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

Index: linux/arch/i386/defconfig
===================================================================
--- linux.orig/arch/i386/defconfig
+++ linux/arch/i386/defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.19-rc1
-# Thu Oct  5 13:04:53 2006
+# Linux kernel version: 2.6.19-rc2-git4
+# Sat Oct 21 03:38:56 2006
 #
 CONFIG_X86_32=y
 CONFIG_GENERIC_TIME=y
@@ -380,8 +380,8 @@ CONFIG_INET6_XFRM_MODE_TRANSPORT=y
 CONFIG_INET6_XFRM_MODE_TUNNEL=y
 # CONFIG_INET6_XFRM_MODE_BEET is not set
 # CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
+CONFIG_IPV6_SIT=y
 # CONFIG_IPV6_TUNNEL is not set
-# CONFIG_IPV6_SUBTREES is not set
 # CONFIG_IPV6_MULTIPLE_TABLES is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
@@ -483,6 +483,13 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_ATA_OVER_ETH is not set
 
 #
+# Misc devices
+#
+# CONFIG_IBM_ASM is not set
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
+
+#
 # ATA/ATAPI/MFM/RLL support
 #
 CONFIG_IDE=y
@@ -1024,6 +1031,7 @@ CONFIG_HANGCHECK_TIMER=y
 #
 # Dallas's 1-wire bus
 #
+# CONFIG_W1 is not set
 
 #
 # Hardware Monitoring support
@@ -1032,12 +1040,6 @@ CONFIG_HANGCHECK_TIMER=y
 # CONFIG_HWMON_VID is not set
 
 #
-# Misc devices
-#
-# CONFIG_IBM_ASM is not set
-# CONFIG_TIFM_CORE is not set
-
-#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -1169,7 +1171,6 @@ CONFIG_USB_HIDINPUT=y
 # CONFIG_USB_ATI_REMOTE2 is not set
 # CONFIG_USB_KEYSPAN_REMOTE is not set
 # CONFIG_USB_APPLETOUCH is not set
-# CONFIG_USB_TRANCEVIBRATOR is not set
 
 #
 # USB Imaging devices
@@ -1215,6 +1216,7 @@ CONFIG_USB_MON=y
 # CONFIG_USB_APPLEDISPLAY is not set
 # CONFIG_USB_SISUSBVGA is not set
 # CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_TEST is not set
 
 #
@@ -1284,6 +1286,7 @@ CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 CONFIG_EXT3_FS_POSIX_ACL=y
 # CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
@@ -1307,6 +1310,7 @@ CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 CONFIG_AUTOFS4_FS=y
 # CONFIG_FUSE_FS is not set
+CONFIG_GENERIC_ACL=y
 
 #
 # CD-ROM/DVD Filesystems
@@ -1384,7 +1388,6 @@ CONFIG_SUNRPC=y
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
 # CONFIG_9P_FS is not set
-CONFIG_GENERIC_ACL=y
 
 #
 # Partition Types
@@ -1437,10 +1440,6 @@ CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_UTF8=y
 
 #
-# Distributed Lock Manager
-#
-
-#
 # Instrumentation Support
 #
 CONFIG_PROFILING=y
@@ -1480,6 +1479,7 @@ CONFIG_DEBUG_BUGVERBOSE=y
 CONFIG_UNWIND_INFO=y
 CONFIG_STACK_UNWIND=y
 # CONFIG_FORCED_INLINING is not set
+# CONFIG_HEADERS_CHECK is not set
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_LKDTM is not set
 CONFIG_EARLY_PRINTK=y
