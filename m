Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbULETwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbULETwN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 14:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbULETwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 14:52:13 -0500
Received: from amsfep16-int.chello.nl ([213.46.243.26]:16205 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S261367AbULETvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 14:51:11 -0500
Date: Sun, 5 Dec 2004 20:51:07 +0100
Message-Id: <200412051951.iB5Jp7XQ000697@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 536] M68k: Update defconfigs for 2.6.10-rc3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Update defconfigs for 2.6.10-rc3

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc3/arch/m68k/configs/amiga_defconfig	2004-12-05 14:12:51.000000000 +0100
+++ linux-m68k-2.6.10-rc3/arch/m68k/configs/amiga_defconfig	2004-12-05 14:21:25.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc2-m68k
-# Mon Nov 15 12:46:49 2004
+# Linux kernel version: 2.6.10-rc3-m68k
+# Sun Dec  5 14:21:25 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -137,6 +137,7 @@
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
@@ -724,6 +725,10 @@
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
@@ -955,7 +960,7 @@
 # Library routines
 #
 CONFIG_CRC_CCITT=m
-CONFIG_CRC32=m
+CONFIG_CRC32=y
 CONFIG_LIBCRC32C=m
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=m
--- linux-2.6.10-rc3/arch/m68k/configs/apollo_defconfig	2004-12-05 14:06:55.000000000 +0100
+++ linux-m68k-2.6.10-rc3/arch/m68k/configs/apollo_defconfig	2004-12-05 14:21:29.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc2-m68k
-# Mon Nov 15 12:47:18 2004
+# Linux kernel version: 2.6.10-rc3-m68k
+# Sun Dec  5 14:21:29 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -122,6 +122,7 @@
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
@@ -581,6 +582,10 @@
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
--- linux-2.6.10-rc3/arch/m68k/configs/atari_defconfig	2004-12-05 14:06:55.000000000 +0100
+++ linux-m68k-2.6.10-rc3/arch/m68k/configs/atari_defconfig	2004-12-05 14:21:34.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc2-m68k
-# Mon Nov 15 12:48:18 2004
+# Linux kernel version: 2.6.10-rc3-m68k
+# Sun Dec  5 14:21:34 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -129,6 +129,7 @@
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
@@ -634,6 +635,10 @@
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
@@ -865,7 +870,7 @@
 # Library routines
 #
 CONFIG_CRC_CCITT=m
-CONFIG_CRC32=m
+CONFIG_CRC32=y
 CONFIG_LIBCRC32C=m
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=m
--- linux-2.6.10-rc3/arch/m68k/configs/bvme6000_defconfig	2004-12-05 14:12:51.000000000 +0100
+++ linux-m68k-2.6.10-rc3/arch/m68k/configs/bvme6000_defconfig	2004-12-05 14:21:38.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc2-m68k
-# Mon Nov 15 12:48:27 2004
+# Linux kernel version: 2.6.10-rc3-m68k
+# Sun Dec  5 14:21:38 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -122,6 +122,7 @@
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
@@ -582,6 +583,10 @@
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
--- linux-2.6.10-rc3/arch/m68k/configs/hp300_defconfig	2004-12-05 14:06:55.000000000 +0100
+++ linux-m68k-2.6.10-rc3/arch/m68k/configs/hp300_defconfig	2004-12-05 14:21:44.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc2-m68k
-# Mon Nov 15 12:48:53 2004
+# Linux kernel version: 2.6.10-rc3-m68k
+# Sun Dec  5 14:21:44 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -123,6 +123,7 @@
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
@@ -582,6 +583,10 @@
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
--- linux-2.6.10-rc3/arch/m68k/configs/mac_defconfig	2004-12-05 14:06:55.000000000 +0100
+++ linux-m68k-2.6.10-rc3/arch/m68k/configs/mac_defconfig	2004-12-05 14:21:47.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc2-m68k
-# Mon Nov 15 12:49:04 2004
+# Linux kernel version: 2.6.10-rc3-m68k
+# Sun Dec  5 14:21:47 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -124,6 +124,7 @@
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
@@ -643,6 +644,10 @@
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
--- linux-2.6.10-rc3/arch/m68k/configs/mvme147_defconfig	2004-12-05 14:06:55.000000000 +0100
+++ linux-m68k-2.6.10-rc3/arch/m68k/configs/mvme147_defconfig	2004-12-05 14:21:49.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc2-m68k
-# Mon Nov 15 12:49:10 2004
+# Linux kernel version: 2.6.10-rc3-m68k
+# Sun Dec  5 14:21:49 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -122,6 +122,7 @@
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
@@ -597,6 +598,10 @@
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
--- linux-2.6.10-rc3/arch/m68k/configs/mvme16x_defconfig	2004-12-05 14:12:51.000000000 +0100
+++ linux-m68k-2.6.10-rc3/arch/m68k/configs/mvme16x_defconfig	2004-12-05 14:21:52.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc2-m68k
-# Mon Nov 15 12:49:35 2004
+# Linux kernel version: 2.6.10-rc3-m68k
+# Sun Dec  5 14:21:52 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -122,6 +122,7 @@
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
@@ -598,6 +599,10 @@
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
@@ -829,7 +834,7 @@
 # Library routines
 #
 CONFIG_CRC_CCITT=m
-CONFIG_CRC32=m
+CONFIG_CRC32=y
 CONFIG_LIBCRC32C=m
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=m
--- linux-2.6.10-rc3/arch/m68k/configs/q40_defconfig	2004-12-05 14:06:55.000000000 +0100
+++ linux-m68k-2.6.10-rc3/arch/m68k/configs/q40_defconfig	2004-12-05 14:21:55.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc2-m68k
-# Mon Nov 15 12:49:42 2004
+# Linux kernel version: 2.6.10-rc3-m68k
+# Sun Dec  5 14:21:55 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -127,6 +127,7 @@
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
@@ -673,6 +674,10 @@
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
@@ -900,7 +905,7 @@
 # Library routines
 #
 CONFIG_CRC_CCITT=m
-CONFIG_CRC32=m
+CONFIG_CRC32=y
 CONFIG_LIBCRC32C=m
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=m
--- linux-2.6.10-rc3/arch/m68k/configs/sun3_defconfig	2004-12-05 14:06:55.000000000 +0100
+++ linux-m68k-2.6.10-rc3/arch/m68k/configs/sun3_defconfig	2004-12-05 14:21:58.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc2-m68k
-# Mon Nov 15 12:49:50 2004
+# Linux kernel version: 2.6.10-rc3-m68k
+# Sun Dec  5 14:21:58 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -110,6 +110,7 @@
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
@@ -586,6 +587,10 @@
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
@@ -815,7 +820,7 @@
 # Library routines
 #
 CONFIG_CRC_CCITT=m
-CONFIG_CRC32=m
+CONFIG_CRC32=y
 CONFIG_LIBCRC32C=m
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=m
--- linux-2.6.10-rc3/arch/m68k/configs/sun3x_defconfig	2004-12-05 14:06:55.000000000 +0100
+++ linux-m68k-2.6.10-rc3/arch/m68k/configs/sun3x_defconfig	2004-12-05 14:22:01.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc2-m68k
-# Mon Nov 15 12:49:55 2004
+# Linux kernel version: 2.6.10-rc3-m68k
+# Sun Dec  5 14:22:01 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -121,6 +121,7 @@
 CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
@@ -596,6 +597,10 @@
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
@@ -825,7 +830,7 @@
 # Library routines
 #
 CONFIG_CRC_CCITT=m
-CONFIG_CRC32=m
+CONFIG_CRC32=y
 CONFIG_LIBCRC32C=m
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=m
--- linux-2.6.10-rc3/arch/m68k/defconfig	2004-12-05 14:12:51.000000000 +0100
+++ linux-m68k-2.6.10-rc3/arch/m68k/defconfig	2004-12-05 14:21:41.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc2-m68k
-# Mon Nov 15 12:48:44 2004
+# Linux kernel version: 2.6.10-rc3-m68k
+# Sun Dec  5 14:21:41 2004
 #
 CONFIG_M68K=y
 CONFIG_MMU=y
@@ -115,6 +115,7 @@
 # CONFIG_BLK_DEV_LOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
@@ -454,6 +455,10 @@
 # CONFIG_USB_ARCH_HAS_OHCI is not set
 
 #
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
