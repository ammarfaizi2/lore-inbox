Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422661AbWJRQdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422661AbWJRQdd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422654AbWJRQdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:33:32 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:56155 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422661AbWJRQdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:33:31 -0400
Date: Wed, 18 Oct 2006 18:33:38 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [S390] update default configuration
Message-ID: <20061018163338.GA15229@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[S390] update default configuration

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/defconfig |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff -urpN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2006-10-18 17:12:28.000000000 +0200
+++ linux-2.6-patched/arch/s390/defconfig	2006-10-18 17:12:48.000000000 +0200
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.18
-# Wed Oct  4 19:45:46 2006
+# Linux kernel version: 2.6.19-rc2
+# Wed Oct 18 17:11:10 2006
 #
 CONFIG_MMU=y
 CONFIG_LOCKDEP_SUPPORT=y
@@ -211,6 +211,7 @@ CONFIG_INET6_XFRM_MODE_TRANSPORT=y
 CONFIG_INET6_XFRM_MODE_TUNNEL=y
 CONFIG_INET6_XFRM_MODE_BEET=y
 # CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
+CONFIG_IPV6_SIT=y
 # CONFIG_IPV6_TUNNEL is not set
 # CONFIG_IPV6_SUBTREES is not set
 # CONFIG_IPV6_MULTIPLE_TABLES is not set
@@ -528,6 +529,7 @@ CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_POSIX_ACL is not set
 # CONFIG_EXT3_FS_SECURITY is not set
+# CONFIG_EXT4DEV_FS is not set
 CONFIG_JBD=y
 # CONFIG_JBD_DEBUG is not set
 CONFIG_FS_MBCACHE=y
@@ -646,10 +648,6 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_NLS is not set
 
 #
-# Distributed Lock Manager
-#
-
-#
 # Instrumentation Support
 #
 
@@ -669,7 +667,6 @@ CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_KERNEL=y
 CONFIG_LOG_BUF_SHIFT=17
-# CONFIG_DETECT_SOFTLOCKUP is not set
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 CONFIG_DEBUG_PREEMPT=y
@@ -690,6 +687,7 @@ CONFIG_DEBUG_FS=y
 # CONFIG_FRAME_POINTER is not set
 # CONFIG_UNWIND_INFO is not set
 CONFIG_FORCED_INLINING=y
+CONFIG_HEADERS_CHECK=y
 # CONFIG_RCU_TORTURE_TEST is not set
 # CONFIG_LKDTM is not set
 
