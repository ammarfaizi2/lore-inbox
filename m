Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263015AbUKRWnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUKRWnK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 17:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbUKRUzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 15:55:39 -0500
Received: from amsfep15-int.chello.nl ([213.46.243.28]:60001 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S262959AbUKRUtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 15:49:40 -0500
Date: Thu, 18 Nov 2004 21:49:36 +0100
Message-Id: <200411182049.iAIKnaM6007088@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 528] M68k: Update defconfigs for 2.6.10-rc2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Update defconfigs for 2.6.10-rc2

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc2/arch/m68k/configs/amiga_defconfig	2004-10-30 15:26:08.000000000 +0200
+++ linux-m68k-2.6.10-rc2/arch/m68k/configs/amiga_defconfig	2004-11-15 12:46:49.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc1-m68k
-# Sat Oct 30 15:26:08 2004
+# Linux kernel version: 2.6.10-rc2-m68k
+# Mon Nov 15 12:46:49 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -38,6 +38,10 @@
 CONFIG_EPOLL=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
 
 #
@@ -264,6 +268,7 @@
 CONFIG_MD_RAID5=m
 CONFIG_MD_RAID6=m
 CONFIG_MD_MULTIPATH=m
+# CONFIG_MD_FAULTY is not set
 CONFIG_BLK_DEV_DM=m
 CONFIG_DM_CRYPT=m
 CONFIG_DM_SNAPSHOT=m
@@ -307,6 +312,8 @@
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
 CONFIG_INET_TUNNEL=m
+CONFIG_IP_TCPDIAG=m
+CONFIG_IP_TCPDIAG_IPV6=y
 
 #
 # IP: Virtual Server Configuration
@@ -442,7 +449,6 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
@@ -714,6 +720,8 @@
 #
 # USB support
 #
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
 # USB Gadget Support
@@ -757,6 +765,7 @@
 # CONFIG_QFMT_V1 is not set
 # CONFIG_QFMT_V2 is not set
 CONFIG_QUOTACTL=y
+CONFIG_DNOTIFY=y
 CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
 
@@ -851,6 +860,7 @@
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_AMIGA_PARTITION=y
+CONFIG_MSDOS_PARTITION=y
 
 #
 # Native Language Support
@@ -903,6 +913,7 @@
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_INFO is not set
 
@@ -934,6 +945,7 @@
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_ARC4=m
 CONFIG_CRYPTO_KHAZAD=m
+CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_DEFLATE=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_CRC32C=m
--- linux-2.6.10-rc2/arch/m68k/configs/apollo_defconfig	2004-10-30 15:26:10.000000000 +0200
+++ linux-m68k-2.6.10-rc2/arch/m68k/configs/apollo_defconfig	2004-11-15 12:47:18.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc1-m68k
-# Sat Oct 30 15:26:10 2004
+# Linux kernel version: 2.6.10-rc2-m68k
+# Mon Nov 15 12:47:18 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -38,6 +38,10 @@
 CONFIG_EPOLL=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
 
 #
@@ -185,6 +189,7 @@
 CONFIG_MD_RAID5=m
 CONFIG_MD_RAID6=m
 CONFIG_MD_MULTIPATH=m
+# CONFIG_MD_FAULTY is not set
 CONFIG_BLK_DEV_DM=m
 CONFIG_DM_CRYPT=m
 CONFIG_DM_SNAPSHOT=m
@@ -231,6 +236,8 @@
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
 CONFIG_INET_TUNNEL=m
+CONFIG_IP_TCPDIAG=m
+CONFIG_IP_TCPDIAG_IPV6=y
 
 #
 # IP: Virtual Server Configuration
@@ -366,7 +373,6 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
@@ -571,6 +577,8 @@
 #
 # USB support
 #
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
 # USB Gadget Support
@@ -612,6 +620,7 @@
 # CONFIG_QFMT_V1 is not set
 # CONFIG_QFMT_V2 is not set
 CONFIG_QUOTACTL=y
+CONFIG_DNOTIFY=y
 CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
 
@@ -759,6 +768,7 @@
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_INFO is not set
 
@@ -790,6 +800,7 @@
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_ARC4=m
 CONFIG_CRYPTO_KHAZAD=m
+CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_DEFLATE=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_CRC32C=m
--- linux-2.6.10-rc2/arch/m68k/configs/atari_defconfig	2004-10-30 15:26:13.000000000 +0200
+++ linux-m68k-2.6.10-rc2/arch/m68k/configs/atari_defconfig	2004-11-15 12:48:18.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc1-m68k
-# Sat Oct 30 15:26:13 2004
+# Linux kernel version: 2.6.10-rc2-m68k
+# Mon Nov 15 12:48:18 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -38,6 +38,10 @@
 CONFIG_EPOLL=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
 
 #
@@ -217,6 +221,7 @@
 CONFIG_MD_RAID5=m
 CONFIG_MD_RAID6=m
 CONFIG_MD_MULTIPATH=m
+# CONFIG_MD_FAULTY is not set
 CONFIG_BLK_DEV_DM=m
 CONFIG_DM_CRYPT=m
 CONFIG_DM_SNAPSHOT=m
@@ -260,6 +265,8 @@
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
 CONFIG_INET_TUNNEL=m
+CONFIG_IP_TCPDIAG=m
+CONFIG_IP_TCPDIAG_IPV6=y
 
 #
 # IP: Virtual Server Configuration
@@ -395,7 +402,6 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
@@ -623,6 +629,8 @@
 #
 # USB support
 #
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
 # USB Gadget Support
@@ -667,6 +675,7 @@
 # CONFIG_QFMT_V1 is not set
 # CONFIG_QFMT_V2 is not set
 CONFIG_QUOTACTL=y
+CONFIG_DNOTIFY=y
 CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
 
@@ -760,6 +769,7 @@
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_ATARI_PARTITION=y
+CONFIG_MSDOS_PARTITION=y
 
 #
 # Native Language Support
@@ -812,6 +822,7 @@
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_INFO is not set
 
@@ -843,6 +854,7 @@
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_ARC4=m
 CONFIG_CRYPTO_KHAZAD=m
+CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_DEFLATE=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_CRC32C=m
--- linux-2.6.10-rc2/arch/m68k/configs/bvme6000_defconfig	2004-10-30 15:26:16.000000000 +0200
+++ linux-m68k-2.6.10-rc2/arch/m68k/configs/bvme6000_defconfig	2004-11-15 12:48:28.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc1-m68k
-# Sat Oct 30 15:26:16 2004
+# Linux kernel version: 2.6.10-rc2-m68k
+# Mon Nov 15 12:48:27 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -38,6 +38,10 @@
 CONFIG_EPOLL=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
 
 #
@@ -187,6 +191,7 @@
 CONFIG_MD_RAID5=m
 CONFIG_MD_RAID6=m
 CONFIG_MD_MULTIPATH=m
+# CONFIG_MD_FAULTY is not set
 CONFIG_BLK_DEV_DM=m
 CONFIG_DM_CRYPT=m
 CONFIG_DM_SNAPSHOT=m
@@ -233,6 +238,8 @@
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
 CONFIG_INET_TUNNEL=m
+CONFIG_IP_TCPDIAG=m
+CONFIG_IP_TCPDIAG_IPV6=y
 
 #
 # IP: Virtual Server Configuration
@@ -367,7 +374,6 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
@@ -572,6 +578,8 @@
 #
 # USB support
 #
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
 # USB Gadget Support
@@ -613,6 +621,7 @@
 # CONFIG_QFMT_V1 is not set
 # CONFIG_QFMT_V2 is not set
 CONFIG_QUOTACTL=y
+CONFIG_DNOTIFY=y
 CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
 
@@ -760,6 +769,7 @@
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_INFO is not set
 
@@ -791,6 +801,7 @@
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_ARC4=m
 CONFIG_CRYPTO_KHAZAD=m
+CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_DEFLATE=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_CRC32C=m
--- linux-2.6.10-rc2/arch/m68k/configs/hp300_defconfig	2004-10-30 15:26:20.000000000 +0200
+++ linux-m68k-2.6.10-rc2/arch/m68k/configs/hp300_defconfig	2004-11-15 12:48:53.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc1-m68k
-# Sat Oct 30 15:26:20 2004
+# Linux kernel version: 2.6.10-rc2-m68k
+# Mon Nov 15 12:48:53 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -38,6 +38,10 @@
 CONFIG_EPOLL=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
 
 #
@@ -186,6 +190,7 @@
 CONFIG_MD_RAID5=m
 CONFIG_MD_RAID6=m
 CONFIG_MD_MULTIPATH=m
+# CONFIG_MD_FAULTY is not set
 CONFIG_BLK_DEV_DM=m
 CONFIG_DM_CRYPT=m
 CONFIG_DM_SNAPSHOT=m
@@ -232,6 +237,8 @@
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
 CONFIG_INET_TUNNEL=m
+CONFIG_IP_TCPDIAG=m
+CONFIG_IP_TCPDIAG_IPV6=y
 
 #
 # IP: Virtual Server Configuration
@@ -367,7 +374,6 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
@@ -572,6 +578,8 @@
 #
 # USB support
 #
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
 # USB Gadget Support
@@ -611,6 +619,7 @@
 # CONFIG_QFMT_V1 is not set
 # CONFIG_QFMT_V2 is not set
 CONFIG_QUOTACTL=y
+CONFIG_DNOTIFY=y
 CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
 
@@ -758,6 +767,7 @@
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_INFO is not set
 
@@ -789,6 +799,7 @@
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_ARC4=m
 CONFIG_CRYPTO_KHAZAD=m
+CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_DEFLATE=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_CRC32C=m
--- linux-2.6.10-rc2/arch/m68k/configs/mac_defconfig	2004-10-30 15:26:22.000000000 +0200
+++ linux-m68k-2.6.10-rc2/arch/m68k/configs/mac_defconfig	2004-11-15 12:49:04.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc1-m68k
-# Sat Oct 30 15:26:22 2004
+# Linux kernel version: 2.6.10-rc2-m68k
+# Mon Nov 15 12:49:04 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -38,6 +38,10 @@
 CONFIG_EPOLL=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
 
 #
@@ -212,6 +216,7 @@
 CONFIG_MD_RAID5=m
 CONFIG_MD_RAID6=m
 CONFIG_MD_MULTIPATH=m
+# CONFIG_MD_FAULTY is not set
 CONFIG_BLK_DEV_DM=m
 CONFIG_DM_CRYPT=m
 CONFIG_DM_SNAPSHOT=m
@@ -267,6 +272,8 @@
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
 CONFIG_INET_TUNNEL=m
+CONFIG_IP_TCPDIAG=m
+CONFIG_IP_TCPDIAG_IPV6=y
 
 #
 # IP: Virtual Server Configuration
@@ -405,7 +412,6 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
@@ -633,6 +639,8 @@
 #
 # USB support
 #
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
 # USB Gadget Support
@@ -676,6 +684,7 @@
 # CONFIG_QFMT_V1 is not set
 # CONFIG_QFMT_V2 is not set
 CONFIG_QUOTACTL=y
+CONFIG_DNOTIFY=y
 CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
 
@@ -837,6 +846,7 @@
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_INFO is not set
 
@@ -868,6 +878,7 @@
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_ARC4=m
 CONFIG_CRYPTO_KHAZAD=m
+CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_DEFLATE=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_CRC32C=m
--- linux-2.6.10-rc2/arch/m68k/configs/mvme147_defconfig	2004-10-30 15:26:25.000000000 +0200
+++ linux-m68k-2.6.10-rc2/arch/m68k/configs/mvme147_defconfig	2004-11-15 12:49:10.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc1-m68k
-# Sat Oct 30 15:26:25 2004
+# Linux kernel version: 2.6.10-rc2-m68k
+# Mon Nov 15 12:49:10 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -38,6 +38,10 @@
 CONFIG_EPOLL=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
 
 #
@@ -186,6 +190,7 @@
 CONFIG_MD_RAID5=m
 CONFIG_MD_RAID6=m
 CONFIG_MD_MULTIPATH=m
+# CONFIG_MD_FAULTY is not set
 CONFIG_BLK_DEV_DM=m
 CONFIG_DM_CRYPT=m
 CONFIG_DM_SNAPSHOT=m
@@ -232,6 +237,8 @@
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
 CONFIG_INET_TUNNEL=m
+CONFIG_IP_TCPDIAG=m
+CONFIG_IP_TCPDIAG_IPV6=y
 
 #
 # IP: Virtual Server Configuration
@@ -367,7 +374,6 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
@@ -587,6 +593,8 @@
 #
 # USB support
 #
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
 # USB Gadget Support
@@ -628,6 +636,7 @@
 # CONFIG_QFMT_V1 is not set
 # CONFIG_QFMT_V2 is not set
 CONFIG_QUOTACTL=y
+CONFIG_DNOTIFY=y
 CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
 
@@ -777,6 +786,7 @@
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_INFO is not set
 
@@ -808,6 +818,7 @@
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_ARC4=m
 CONFIG_CRYPTO_KHAZAD=m
+CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_DEFLATE=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_CRC32C=m
--- linux-2.6.10-rc2/arch/m68k/configs/mvme16x_defconfig	2004-10-30 15:26:27.000000000 +0200
+++ linux-m68k-2.6.10-rc2/arch/m68k/configs/mvme16x_defconfig	2004-11-15 12:49:35.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc1-m68k
-# Sat Oct 30 15:26:27 2004
+# Linux kernel version: 2.6.10-rc2-m68k
+# Mon Nov 15 12:49:35 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -38,6 +38,10 @@
 CONFIG_EPOLL=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
 
 #
@@ -187,6 +191,7 @@
 CONFIG_MD_RAID5=m
 CONFIG_MD_RAID6=m
 CONFIG_MD_MULTIPATH=m
+# CONFIG_MD_FAULTY is not set
 CONFIG_BLK_DEV_DM=m
 CONFIG_DM_CRYPT=m
 CONFIG_DM_SNAPSHOT=m
@@ -233,6 +238,8 @@
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
 CONFIG_INET_TUNNEL=m
+CONFIG_IP_TCPDIAG=m
+CONFIG_IP_TCPDIAG_IPV6=y
 
 #
 # IP: Virtual Server Configuration
@@ -368,7 +375,6 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
@@ -588,6 +594,8 @@
 #
 # USB support
 #
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
 # USB Gadget Support
@@ -629,6 +637,7 @@
 # CONFIG_QFMT_V1 is not set
 # CONFIG_QFMT_V2 is not set
 CONFIG_QUOTACTL=y
+CONFIG_DNOTIFY=y
 CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
 
@@ -778,6 +787,7 @@
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_INFO is not set
 
@@ -809,6 +819,7 @@
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_ARC4=m
 CONFIG_CRYPTO_KHAZAD=m
+CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_DEFLATE=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_CRC32C=m
--- linux-2.6.10-rc2/arch/m68k/configs/q40_defconfig	2004-10-30 15:26:29.000000000 +0200
+++ linux-m68k-2.6.10-rc2/arch/m68k/configs/q40_defconfig	2004-11-15 12:49:42.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc1-m68k
-# Sat Oct 30 15:26:29 2004
+# Linux kernel version: 2.6.10-rc2-m68k
+# Mon Nov 15 12:49:42 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -38,6 +38,10 @@
 CONFIG_EPOLL=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
 
 #
@@ -239,6 +243,7 @@
 CONFIG_MD_RAID5=m
 CONFIG_MD_RAID6=m
 CONFIG_MD_MULTIPATH=m
+# CONFIG_MD_FAULTY is not set
 CONFIG_BLK_DEV_DM=m
 CONFIG_DM_CRYPT=m
 CONFIG_DM_SNAPSHOT=m
@@ -285,6 +290,8 @@
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
 CONFIG_INET_TUNNEL=m
+CONFIG_IP_TCPDIAG=m
+CONFIG_IP_TCPDIAG_IPV6=y
 
 #
 # IP: Virtual Server Configuration
@@ -420,7 +427,6 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
@@ -538,7 +544,6 @@
 # CONFIG_GAMEPORT is not set
 CONFIG_SOUND_GAMEPORT=y
 CONFIG_SERIO=m
-# CONFIG_SERIO_I8042 is not set
 CONFIG_SERIO_SERPORT=m
 # CONFIG_SERIO_CT82C710 is not set
 CONFIG_SERIO_Q40KBD=m
@@ -664,6 +669,8 @@
 #
 # USB support
 #
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
 # USB Gadget Support
@@ -703,6 +710,7 @@
 # CONFIG_QFMT_V1 is not set
 # CONFIG_QFMT_V2 is not set
 CONFIG_QUOTACTL=y
+CONFIG_DNOTIFY=y
 CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
 
@@ -850,6 +858,7 @@
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_INFO is not set
 
@@ -881,6 +890,7 @@
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_ARC4=m
 CONFIG_CRYPTO_KHAZAD=m
+CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_DEFLATE=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_CRC32C=m
--- linux-2.6.10-rc2/arch/m68k/configs/sun3_defconfig	2004-10-30 15:26:31.000000000 +0200
+++ linux-m68k-2.6.10-rc2/arch/m68k/configs/sun3_defconfig	2004-11-15 12:49:50.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc1-m68k
-# Sat Oct 30 15:26:31 2004
+# Linux kernel version: 2.6.10-rc2-m68k
+# Mon Nov 15 12:49:50 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -38,6 +38,10 @@
 CONFIG_EPOLL=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
 
 #
@@ -174,6 +178,7 @@
 CONFIG_MD_RAID5=m
 CONFIG_MD_RAID6=m
 CONFIG_MD_MULTIPATH=m
+# CONFIG_MD_FAULTY is not set
 CONFIG_BLK_DEV_DM=m
 CONFIG_DM_CRYPT=m
 CONFIG_DM_SNAPSHOT=m
@@ -220,6 +225,8 @@
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
 CONFIG_INET_TUNNEL=m
+CONFIG_IP_TCPDIAG=m
+CONFIG_IP_TCPDIAG_IPV6=y
 
 #
 # IP: Virtual Server Configuration
@@ -355,7 +362,6 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
@@ -576,6 +582,8 @@
 #
 # USB support
 #
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
 # USB Gadget Support
@@ -615,6 +623,7 @@
 # CONFIG_QFMT_V1 is not set
 # CONFIG_QFMT_V2 is not set
 CONFIG_QUOTACTL=y
+CONFIG_DNOTIFY=y
 CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
 
@@ -764,6 +773,7 @@
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_INFO is not set
 
@@ -795,6 +805,7 @@
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_ARC4=m
 CONFIG_CRYPTO_KHAZAD=m
+CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_DEFLATE=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_CRC32C=m
--- linux-2.6.10-rc2/arch/m68k/configs/sun3x_defconfig	2004-10-30 15:26:34.000000000 +0200
+++ linux-m68k-2.6.10-rc2/arch/m68k/configs/sun3x_defconfig	2004-11-15 12:49:55.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc1-m68k
-# Sat Oct 30 15:26:34 2004
+# Linux kernel version: 2.6.10-rc2-m68k
+# Mon Nov 15 12:49:55 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -38,6 +38,10 @@
 CONFIG_EPOLL=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
 
 #
@@ -185,6 +189,7 @@
 CONFIG_MD_RAID5=m
 CONFIG_MD_RAID6=m
 CONFIG_MD_MULTIPATH=m
+# CONFIG_MD_FAULTY is not set
 CONFIG_BLK_DEV_DM=m
 CONFIG_DM_CRYPT=m
 CONFIG_DM_SNAPSHOT=m
@@ -231,6 +236,8 @@
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
 CONFIG_INET_TUNNEL=m
+CONFIG_IP_TCPDIAG=m
+CONFIG_IP_TCPDIAG_IPV6=y
 
 #
 # IP: Virtual Server Configuration
@@ -366,7 +373,6 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
@@ -586,6 +592,8 @@
 #
 # USB support
 #
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
 # USB Gadget Support
@@ -625,6 +633,7 @@
 # CONFIG_QFMT_V1 is not set
 # CONFIG_QFMT_V2 is not set
 CONFIG_QUOTACTL=y
+CONFIG_DNOTIFY=y
 CONFIG_AUTOFS_FS=m
 CONFIG_AUTOFS4_FS=m
 
@@ -774,6 +783,7 @@
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_KOBJECT is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_INFO is not set
 
@@ -805,6 +815,7 @@
 CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_ARC4=m
 CONFIG_CRYPTO_KHAZAD=m
+CONFIG_CRYPTO_ANUBIS=m
 CONFIG_CRYPTO_DEFLATE=m
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_CRC32C=m
--- linux-2.6.10-rc2/arch/m68k/defconfig	2004-10-30 15:26:18.000000000 +0200
+++ linux-m68k-2.6.10-rc2/arch/m68k/defconfig	2004-11-15 12:48:44.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc1-m68k
-# Sat Oct 30 15:26:18 2004
+# Linux kernel version: 2.6.10-rc2-m68k
+# Mon Nov 15 12:48:44 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -36,6 +36,10 @@
 CONFIG_EPOLL=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SHMEM=y
+CONFIG_CC_ALIGN_FUNCTIONS=0
+CONFIG_CC_ALIGN_LABELS=0
+CONFIG_CC_ALIGN_LOOPS=0
+CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
 
 #
@@ -219,6 +223,8 @@
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_TUNNEL is not set
+CONFIG_IP_TCPDIAG=y
+# CONFIG_IP_TCPDIAG_IPV6 is not set
 # CONFIG_IPV6 is not set
 # CONFIG_NETFILTER is not set
 
@@ -238,7 +244,6 @@
 # CONFIG_NET_DIVERT is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-# CONFIG_NET_HW_FLOWCONTROL is not set
 
 #
 # QoS and/or fair queueing
@@ -445,6 +450,8 @@
 #
 # USB support
 #
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
 # USB Gadget Support
@@ -472,6 +479,7 @@
 CONFIG_MINIX_FS=y
 # CONFIG_ROMFS_FS is not set
 # CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 
@@ -543,6 +551,7 @@
 #
 # CONFIG_PARTITION_ADVANCED is not set
 CONFIG_AMIGA_PARTITION=y
+CONFIG_MSDOS_PARTITION=y
 
 #
 # Native Language Support

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
