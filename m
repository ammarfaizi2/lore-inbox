Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030371AbWBHMba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbWBHMba (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 07:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbWBHMba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 07:31:30 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:12375 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030371AbWBHMba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 07:31:30 -0500
Date: Wed, 8 Feb 2006 13:31:27 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 01/10] s390: update default configuration
Message-ID: <20060208123127.GB1656@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Switch on CONFIG_DEBUG_FS again.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/defconfig |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff -urpN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2006-02-08 10:48:03.000000000 +0100
+++ linux-2.6-patched/arch/s390/defconfig	2006-02-08 10:48:41.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.16-rc1
-# Thu Jan 19 10:58:53 2006
+# Linux kernel version: 2.6.16-rc2
+# Wed Feb  8 10:44:39 2006
 #
 CONFIG_MMU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
@@ -12,7 +12,6 @@ CONFIG_S390=y
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-CONFIG_CLEAN_COMPILE=y
 CONFIG_LOCK_KERNEL=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 
@@ -154,6 +153,7 @@ CONFIG_NET=y
 #
 # Networking options
 #
+# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
 CONFIG_UNIX=y
@@ -607,6 +607,7 @@ CONFIG_MSDOS_PARTITION=y
 # Instrumentation Support
 #
 # CONFIG_PROFILING is not set
+# CONFIG_STATISTICS is not set
 
 #
 # Kernel hacking
@@ -624,7 +625,7 @@ CONFIG_DEBUG_MUTEXES=y
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_INFO is not set
-# CONFIG_DEBUG_FS is not set
+CONFIG_DEBUG_FS=y
 # CONFIG_DEBUG_VM is not set
 CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
