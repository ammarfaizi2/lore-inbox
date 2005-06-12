Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbVFLJ1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVFLJ1J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 05:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbVFLJ1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 05:27:09 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.21]:11598 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S261922AbVFLJZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 05:25:46 -0400
Date: Sun, 12 Jun 2005 11:25:43 +0200
Message-Id: <200506120925.j5C9PhjS004333@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 553] M68k: Update defconfigs for 2.6.12-rc6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Update defconfigs for 2.6.12-rc6

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

---
 configs/amiga_defconfig    |   16 ++++------------
 configs/apollo_defconfig   |    8 ++++----
 configs/atari_defconfig    |    8 ++++----
 configs/bvme6000_defconfig |    8 ++++----
 configs/hp300_defconfig    |    8 ++++----
 configs/mac_defconfig      |    8 ++++----
 configs/mvme147_defconfig  |    8 ++++----
 configs/mvme16x_defconfig  |    8 ++++----
 configs/q40_defconfig      |   16 ++++------------
 configs/sun3_defconfig     |    8 ++++----
 configs/sun3x_defconfig    |    8 ++++----
 defconfig                  |    8 ++++----
 12 files changed, 48 insertions(+), 64 deletions(-)

--- linux-2.6.12-rc6/arch/m68k/configs/amiga_defconfig	2005-04-21 07:44:19.000000000 +0200
+++ linux-m68k-2.6.12-rc6/arch/m68k/configs/amiga_defconfig	2005-06-07 20:34:23.000000000 +0200
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.12-rc2-m68k
-# Tue Apr  5 14:05:59 2005
+# Linux kernel version: 2.6.12-rc6-m68k
+# Tue Jun  7 20:34:23 2005
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -35,6 +35,8 @@ CONFIG_KOBJECT_UEVENT=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
@@ -135,7 +137,6 @@ CONFIG_PARPORT_1284=y
 #
 CONFIG_AMIGA_FLOPPY=y
 CONFIG_AMIGA_Z2RAM=y
-# CONFIG_BLK_DEV_XD is not set
 # CONFIG_PARIDE is not set
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
@@ -223,17 +224,12 @@ CONFIG_SCSI_CONSTANTS=y
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_7000FASST is not set
 # CONFIG_SCSI_AHA152X is not set
-# CONFIG_SCSI_AHA1542 is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_IN2000 is not set
 # CONFIG_SCSI_SATA is not set
-# CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DTC3280 is not set
-# CONFIG_SCSI_EATA is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
-# CONFIG_SCSI_GDTH is not set
 # CONFIG_SCSI_GENERIC_NCR5380 is not set
 # CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
 # CONFIG_SCSI_PPA is not set
@@ -244,7 +240,6 @@ CONFIG_SCSI_CONSTANTS=y
 # CONFIG_SCSI_QLOGIC_FAS is not set
 # CONFIG_SCSI_SYM53C416 is not set
 # CONFIG_SCSI_T128 is not set
-# CONFIG_SCSI_U14_34F is not set
 # CONFIG_SCSI_DEBUG is not set
 CONFIG_A3000_SCSI=y
 CONFIG_A2091_SCSI=y
@@ -494,7 +489,6 @@ CONFIG_HYDRA=m
 CONFIG_ZORRO8390=m
 CONFIG_APNE=m
 # CONFIG_NET_VENDOR_3COM is not set
-# CONFIG_LANCE is not set
 # CONFIG_NET_VENDOR_SMC is not set
 # CONFIG_NET_VENDOR_RACAL is not set
 # CONFIG_AT1700 is not set
@@ -622,7 +616,6 @@ CONFIG_SERIO_SERPORT=m
 # CONFIG_SERIO_PARKBD is not set
 # CONFIG_SERIO_RAW is not set
 # CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
 
 #
 # Character devices
--- linux-2.6.12-rc6/arch/m68k/configs/apollo_defconfig	2005-04-21 07:39:24.000000000 +0200
+++ linux-m68k-2.6.12-rc6/arch/m68k/configs/apollo_defconfig	2005-06-07 20:34:27.000000000 +0200
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.12-rc2-m68k
-# Tue Apr  5 14:06:00 2005
+# Linux kernel version: 2.6.12-rc6-m68k
+# Tue Jun  7 20:34:27 2005
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -35,6 +35,8 @@ CONFIG_KOBJECT_UEVENT=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
@@ -497,7 +499,6 @@ CONFIG_SERIO_SERPORT=m
 CONFIG_SERIO_LIBPS2=m
 # CONFIG_SERIO_RAW is not set
 # CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
 
 #
 # Character devices
--- linux-2.6.12-rc6/arch/m68k/configs/atari_defconfig	2005-04-21 07:39:24.000000000 +0200
+++ linux-m68k-2.6.12-rc6/arch/m68k/configs/atari_defconfig	2005-06-07 20:34:32.000000000 +0200
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.12-rc2-m68k
-# Tue Apr  5 14:06:18 2005
+# Linux kernel version: 2.6.12-rc6-m68k
+# Tue Jun  7 20:34:32 2005
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -35,6 +35,8 @@ CONFIG_KOBJECT_UEVENT=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
@@ -531,7 +533,6 @@ CONFIG_SERIO_SERPORT=y
 CONFIG_SERIO_LIBPS2=y
 # CONFIG_SERIO_RAW is not set
 # CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
 
 #
 # Character devices
--- linux-2.6.12-rc6/arch/m68k/configs/bvme6000_defconfig	2005-04-21 07:44:19.000000000 +0200
+++ linux-m68k-2.6.12-rc6/arch/m68k/configs/bvme6000_defconfig	2005-06-07 20:34:37.000000000 +0200
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.12-rc2-m68k
-# Tue Apr  5 14:06:19 2005
+# Linux kernel version: 2.6.12-rc6-m68k
+# Tue Jun  7 20:34:37 2005
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -35,6 +35,8 @@ CONFIG_KOBJECT_UEVENT=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
@@ -498,7 +500,6 @@ CONFIG_SERIO_SERPORT=m
 CONFIG_SERIO_LIBPS2=m
 # CONFIG_SERIO_RAW is not set
 # CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
 
 #
 # Character devices
--- linux-2.6.12-rc6/arch/m68k/configs/hp300_defconfig	2005-04-21 07:39:24.000000000 +0200
+++ linux-m68k-2.6.12-rc6/arch/m68k/configs/hp300_defconfig	2005-06-07 20:34:41.000000000 +0200
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.12-rc2-m68k
-# Tue Apr  5 14:06:21 2005
+# Linux kernel version: 2.6.12-rc6-m68k
+# Tue Jun  7 20:34:41 2005
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -35,6 +35,8 @@ CONFIG_KOBJECT_UEVENT=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
@@ -498,7 +500,6 @@ CONFIG_SERIO_SERPORT=m
 CONFIG_SERIO_LIBPS2=m
 # CONFIG_SERIO_RAW is not set
 # CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
 
 #
 # Character devices
--- linux-2.6.12-rc6/arch/m68k/configs/mac_defconfig	2005-04-21 07:39:24.000000000 +0200
+++ linux-m68k-2.6.12-rc6/arch/m68k/configs/mac_defconfig	2005-06-07 20:34:45.000000000 +0200
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.12-rc2-m68k
-# Tue Apr  5 14:06:24 2005
+# Linux kernel version: 2.6.12-rc6-m68k
+# Tue Jun  7 20:34:45 2005
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -35,6 +35,8 @@ CONFIG_KOBJECT_UEVENT=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
@@ -540,7 +542,6 @@ CONFIG_SERIO_SERPORT=m
 CONFIG_SERIO_LIBPS2=m
 # CONFIG_SERIO_RAW is not set
 # CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
 
 #
 # Character devices
--- linux-2.6.12-rc6/arch/m68k/configs/mvme147_defconfig	2005-04-21 07:39:24.000000000 +0200
+++ linux-m68k-2.6.12-rc6/arch/m68k/configs/mvme147_defconfig	2005-06-07 20:34:50.000000000 +0200
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.12-rc2-m68k
-# Tue Apr  5 14:06:28 2005
+# Linux kernel version: 2.6.12-rc6-m68k
+# Tue Jun  7 20:34:50 2005
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -35,6 +35,8 @@ CONFIG_KOBJECT_UEVENT=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
@@ -498,7 +500,6 @@ CONFIG_SERIO_SERPORT=m
 CONFIG_SERIO_LIBPS2=m
 # CONFIG_SERIO_RAW is not set
 # CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
 
 #
 # Character devices
--- linux-2.6.12-rc6/arch/m68k/configs/mvme16x_defconfig	2005-04-21 07:44:19.000000000 +0200
+++ linux-m68k-2.6.12-rc6/arch/m68k/configs/mvme16x_defconfig	2005-06-07 20:34:54.000000000 +0200
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.12-rc2-m68k
-# Tue Apr  5 14:06:31 2005
+# Linux kernel version: 2.6.12-rc6-m68k
+# Tue Jun  7 20:34:53 2005
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -35,6 +35,8 @@ CONFIG_KOBJECT_UEVENT=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
@@ -499,7 +501,6 @@ CONFIG_SERIO_SERPORT=m
 CONFIG_SERIO_LIBPS2=m
 # CONFIG_SERIO_RAW is not set
 # CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
 
 #
 # Character devices
--- linux-2.6.12-rc6/arch/m68k/configs/q40_defconfig	2005-04-21 07:39:24.000000000 +0200
+++ linux-m68k-2.6.12-rc6/arch/m68k/configs/q40_defconfig	2005-06-07 20:34:58.000000000 +0200
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.12-rc2-m68k
-# Tue Apr  5 14:06:34 2005
+# Linux kernel version: 2.6.12-rc6-m68k
+# Tue Jun  7 20:34:58 2005
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -35,6 +35,8 @@ CONFIG_KOBJECT_UEVENT=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
@@ -125,7 +127,6 @@ CONFIG_FW_LOADER=m
 # Block devices
 #
 # CONFIG_BLK_DEV_FD is not set
-# CONFIG_BLK_DEV_XD is not set
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=m
@@ -210,17 +211,12 @@ CONFIG_SCSI_CONSTANTS=y
 #
 # SCSI low-level drivers
 #
-# CONFIG_SCSI_7000FASST is not set
 # CONFIG_SCSI_AHA152X is not set
-# CONFIG_SCSI_AHA1542 is not set
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_IN2000 is not set
 # CONFIG_SCSI_SATA is not set
-# CONFIG_SCSI_BUSLOGIC is not set
 # CONFIG_SCSI_DTC3280 is not set
-# CONFIG_SCSI_EATA is not set
 # CONFIG_SCSI_FUTURE_DOMAIN is not set
-# CONFIG_SCSI_GDTH is not set
 # CONFIG_SCSI_GENERIC_NCR5380 is not set
 # CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
 # CONFIG_SCSI_NCR53C406A is not set
@@ -229,7 +225,6 @@ CONFIG_SCSI_CONSTANTS=y
 # CONFIG_SCSI_QLOGIC_FAS is not set
 # CONFIG_SCSI_SYM53C416 is not set
 # CONFIG_SCSI_T128 is not set
-# CONFIG_SCSI_U14_34F is not set
 # CONFIG_SCSI_DEBUG is not set
 
 #
@@ -466,7 +461,6 @@ CONFIG_EQUALIZER=m
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=m
 # CONFIG_NET_VENDOR_3COM is not set
-# CONFIG_LANCE is not set
 # CONFIG_NET_VENDOR_SMC is not set
 # CONFIG_NET_VENDOR_RACAL is not set
 # CONFIG_AT1700 is not set
@@ -570,7 +564,6 @@ CONFIG_SERIO_Q40KBD=m
 CONFIG_SERIO_LIBPS2=m
 # CONFIG_SERIO_RAW is not set
 # CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
 
 #
 # Character devices
--- linux-2.6.12-rc6/arch/m68k/configs/sun3_defconfig	2005-04-21 07:39:24.000000000 +0200
+++ linux-m68k-2.6.12-rc6/arch/m68k/configs/sun3_defconfig	2005-06-07 20:35:02.000000000 +0200
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.12-rc2-m68k
-# Tue Apr  5 14:06:37 2005
+# Linux kernel version: 2.6.12-rc6-m68k
+# Tue Jun  7 20:35:02 2005
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -35,6 +35,8 @@ CONFIG_KOBJECT_UEVENT=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
@@ -487,7 +488,6 @@ CONFIG_SERIO_SERPORT=m
 CONFIG_SERIO_LIBPS2=m
 # CONFIG_SERIO_RAW is not set
 # CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
 
 #
 # Character devices
--- linux-2.6.12-rc6/arch/m68k/configs/sun3x_defconfig	2005-04-21 07:39:24.000000000 +0200
+++ linux-m68k-2.6.12-rc6/arch/m68k/configs/sun3x_defconfig	2005-06-07 20:35:06.000000000 +0200
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.12-rc2-m68k
-# Tue Apr  5 14:06:40 2005
+# Linux kernel version: 2.6.12-rc6-m68k
+# Tue Jun  7 20:35:06 2005
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -35,6 +35,8 @@ CONFIG_KOBJECT_UEVENT=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_ALL is not set
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
@@ -497,7 +499,6 @@ CONFIG_SERIO_SERPORT=m
 CONFIG_SERIO_LIBPS2=m
 # CONFIG_SERIO_RAW is not set
 # CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
 
 #
 # Character devices
--- linux-2.6.12-rc6/arch/m68k/defconfig	2005-04-21 07:44:19.000000000 +0200
+++ linux-m68k-2.6.12-rc6/arch/m68k/defconfig	2005-06-07 20:34:17.000000000 +0200
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.12-rc2-m68k
-# Tue Apr  5 14:05:31 2005
+# Linux kernel version: 2.6.12-rc6-m68k
+# Tue Jun  7 20:34:17 2005
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -33,6 +33,8 @@ CONFIG_KOBJECT_UEVENT=y
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
@@ -357,7 +359,6 @@ CONFIG_SERIO_SERPORT=y
 CONFIG_SERIO_LIBPS2=y
 # CONFIG_SERIO_RAW is not set
 # CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
 
 #
 # Character devices

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
