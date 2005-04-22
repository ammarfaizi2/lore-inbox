Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVDVO74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVDVO74 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 10:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVDVO7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 10:59:55 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:34201 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261956AbVDVO7s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 10:59:48 -0400
Date: Fri, 22 Apr 2005 16:59:15 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 1/12] s390: regenerate defconfig.
Message-ID: <20050422145915.GA17508@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 1/12] s390: regenerate defconfig.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Regenerate the default configuration for s390.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/defconfig |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff -urpN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2005-04-22 15:44:44.000000000 +0200
+++ linux-2.6-patched/arch/s390/defconfig	2005-04-22 15:44:58.000000000 +0200
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11
-# Wed Mar  2 16:57:55 2005
+# Linux kernel version: 2.6.12-rc3
+# Fri Apr 22 15:30:58 2005
 #
 CONFIG_MMU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
@@ -15,6 +15,7 @@ CONFIG_UID16=y
 CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
 CONFIG_LOCK_KERNEL=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
 
 #
 # General setup
@@ -26,24 +27,25 @@ CONFIG_SYSVIPC=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
-CONFIG_LOG_BUF_SHIFT=17
 CONFIG_HOTPLUG=y
 CONFIG_KOBJECT_UEVENT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
+# CONFIG_CPUSETS is not set
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SHMEM=y
 CONFIG_CC_ALIGN_FUNCTIONS=0
 CONFIG_CC_ALIGN_LABELS=0
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
 
 #
 # Loadable module support
@@ -261,7 +263,6 @@ CONFIG_NET=y
 #
 CONFIG_PACKET=y
 # CONFIG_PACKET_MMAP is not set
-# CONFIG_NETLINK_DEV is not set
 CONFIG_UNIX=y
 CONFIG_NET_KEY=y
 CONFIG_INET=y
@@ -329,6 +330,7 @@ CONFIG_NET_SCH_DSMARK=m
 CONFIG_NET_QOS=y
 CONFIG_NET_ESTIMATOR=y
 CONFIG_NET_CLS=y
+# CONFIG_NET_CLS_BASIC is not set
 CONFIG_NET_CLS_TCINDEX=m
 CONFIG_NET_CLS_ROUTE4=m
 CONFIG_NET_CLS_ROUTE=y
@@ -338,6 +340,7 @@ CONFIG_NET_CLS_U32=m
 # CONFIG_NET_CLS_IND is not set
 CONFIG_NET_CLS_RSVP=m
 CONFIG_NET_CLS_RSVP6=m
+# CONFIG_NET_EMATCH is not set
 # CONFIG_NET_CLS_ACT is not set
 CONFIG_NET_CLS_POLICE=y
 
@@ -393,6 +396,8 @@ CONFIG_CTC=m
 CONFIG_IUCV=m
 # CONFIG_NETIUCV is not set
 # CONFIG_SMSGIUCV is not set
+# CONFIG_CLAW is not set
+# CONFIG_MPC is not set
 CONFIG_QETH=y
 
 #
@@ -532,10 +537,13 @@ CONFIG_MSDOS_PARTITION=y
 #
 # Kernel hacking
 #
+# CONFIG_PRINTK_TIME is not set
 CONFIG_DEBUG_KERNEL=y
 CONFIG_MAGIC_SYSRQ=y
+CONFIG_LOG_BUF_SHIFT=17
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_INFO is not set
@@ -560,6 +568,7 @@ CONFIG_CRYPTO=y
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
 # CONFIG_CRYPTO_WP512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
 # CONFIG_CRYPTO_DES is not set
 # CONFIG_CRYPTO_DES_Z990 is not set
 # CONFIG_CRYPTO_BLOWFISH is not set
