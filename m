Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160995AbWJOQbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160995AbWJOQbg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 12:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWJOQbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 12:31:36 -0400
Received: from cpe-74-70-38-78.nycap.res.rr.com ([74.70.38.78]:4113 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1751125AbWJOQbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 12:31:35 -0400
Date: Sun, 15 Oct 2006 12:30:43 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 19-rc2]  Fix misc Kconfig typos
Message-Id: <20061015123043.7bf1d42e.kernel1@cyberdogtech.com>
In-Reply-To: <20061014210311.87ef41f6.randy.dunlap@oracle.com>
References: <20061014225447.49c9112a.kernel1@cyberdogtech.com>
	<20061014210311.87ef41f6.randy.dunlap@oracle.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Sun, 15 Oct 2006 12:30:56 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Sun, 15 Oct 2006 12:30:56 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Oct 2006 21:03:11 -0700
Randy Dunlap <randy.dunlap@oracle.com> wrote:

> > +	  but with the ability to manipulate with speed/link in software. The relevant MII
> 
> for the second "with":
> s/with/the/ or s/with//
> 
> ---
> ~Randy

Updated below...

-- 
Matt 
--

diff -ru a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
--- a/arch/arm/mach-ixp4xx/Kconfig	2006-09-19 23:42:06.000000000 -0400
+++ b/arch/arm/mach-ixp4xx/Kconfig	2006-10-14 22:25:11.000000000 -0400
@@ -133,7 +133,7 @@
              into the kernel and we can use the standard read[bwl]/write[bwl]
              macros. This is the preferred method due to speed but it
              limits the system to just 64MB of PCI memory. This can be 
-             problamatic if using video cards and other memory-heavy devices.
+             problematic if using video cards and other memory-heavy devices.
           
           2) If > 64MB of memory space is required, the IXP4xx can be 
 	     configured to use indirect registers to access PCI This allows 
diff -ru a/arch/arm/mach-lh7a40x/Kconfig b/arch/arm/mach-lh7a40x/Kconfig
--- a/arch/arm/mach-lh7a40x/Kconfig	2006-09-19 23:42:06.000000000 -0400
+++ b/arch/arm/mach-lh7a40x/Kconfig	2006-10-14 22:34:46.000000000 -0400
@@ -8,7 +8,7 @@
 	help
 	  Say Y here if you are using the Sharp KEV7A400 development
 	  board.  This hardware is discontinued, so I'd be very
-	  suprised if you wanted this option.
+	  surprised if you wanted this option.
 
 config MACH_LPD7A400
 	bool "LPD7A400 Card Engine"
diff -ru a/arch/arm/mach-s3c2410/Kconfig b/arch/arm/mach-s3c2410/Kconfig
--- a/arch/arm/mach-s3c2410/Kconfig	2006-10-14 20:31:55.000000000 -0400
+++ b/arch/arm/mach-s3c2410/Kconfig	2006-10-14 22:36:28.000000000 -0400
@@ -91,7 +91,7 @@
 config MACH_S3C2413
 	bool
 	help
-	  Internal node for S3C2413 verison of SMDK2413, so that
+	  Internal node for S3C2413 version of SMDK2413, so that
 	  machine_is_s3c2413() will work when MACH_SMDK2413 is
 	  selected
 
diff -ru a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
--- a/arch/arm/mm/Kconfig	2006-10-14 20:31:56.000000000 -0400
+++ b/arch/arm/mm/Kconfig	2006-10-14 22:46:06.000000000 -0400
@@ -197,7 +197,7 @@
 	select CPU_CP15_MPU
 	help
 	  ARM940T is a member of the ARM9TDMI family of general-
-	  purpose microprocessors with MPU and seperate 4KB
+	  purpose microprocessors with MPU and separate 4KB
 	  instruction and 4KB data cases, each with a 4-word line
 	  length.
 
diff -ru a/arch/cris/arch-v10/drivers/Kconfig b/arch/cris/arch-v10/drivers/Kconfig
--- a/arch/cris/arch-v10/drivers/Kconfig	2006-10-14 20:31:56.000000000 -0400
+++ b/arch/cris/arch-v10/drivers/Kconfig	2006-10-14 22:31:24.000000000 -0400
@@ -839,7 +839,7 @@
 	default "0"
 	help
 	  This controls the initial value of the trickle charge register.
-	  0 = disabled (use this if you are unsure or have a non rechargable battery)
+	  0 = disabled (use this if you are unsure or have a non rechargeable battery)
 	  Otherwise the following values can be OR:ed together to control the
 	  charge current:
 	  1 = 2kohm, 2 = 4kohm, 3 = 4kohm
diff -ru a/arch/cris/arch-v10/Kconfig b/arch/cris/arch-v10/Kconfig
--- a/arch/cris/arch-v10/Kconfig	2006-09-19 23:42:06.000000000 -0400
+++ b/arch/cris/arch-v10/Kconfig	2006-10-14 22:23:25.000000000 -0400
@@ -323,7 +323,7 @@
 	depends on ETRAX_ARCH_V10
 	default "95a6"
 	help
-	  Waitstates for SRAM, Flash and peripherials (not DRAM).  95f8 is a
+	  Waitstates for SRAM, Flash and peripherals (not DRAM).  95f8 is a
 	  good choice for most Axis products...
 
 config ETRAX_DEF_R_BUS_CONFIG
diff -ru a/arch/cris/arch-v32/drivers/Kconfig b/arch/cris/arch-v32/drivers/Kconfig
--- a/arch/cris/arch-v32/drivers/Kconfig	2006-09-19 23:42:06.000000000 -0400
+++ b/arch/cris/arch-v32/drivers/Kconfig	2006-10-14 22:47:53.000000000 -0400
@@ -88,7 +88,7 @@
 	help
 	  Enables the DMA7 input channel for ser0 (ttyS0).
 	  If you do not enable DMA, an interrupt for each character will be
-	  used when receiveing data.
+	  used when receiving data.
 	  Normally you want to use DMA, unless you use the DMA channel for
 	  something else.
 
@@ -157,7 +157,7 @@
 	help
 	  Enables the DMA5 input channel for ser1 (ttyS1).
 	  If you do not enable DMA, an interrupt for each character will be
-	  used when receiveing data.
+	  used when receiving data.
 	  Normally you want this on, unless you use the DMA channel for
 	  something else.
 
@@ -228,7 +228,7 @@
 	help
 	  Enables the DMA3 input channel for ser2 (ttyS2).
 	  If you do not enable DMA, an interrupt for each character will be
-	  used when receiveing data.
+	  used when receiving data.
 	  Normally you want to use DMA, unless you use the DMA channel for
 	  something else.
 
@@ -297,7 +297,7 @@
 	help
 	  Enables the DMA9 input channel for ser3 (ttyS3).
 	  If you do not enable DMA, an interrupt for each character will be
-	  used when receiveing data.
+	  used when receiving data.
 	  Normally you want to use DMA, unless you use the DMA channel for
 	  something else.
 
diff -ru a/arch/m68knommu/Kconfig b/arch/m68knommu/Kconfig
--- a/arch/m68knommu/Kconfig	2006-10-14 20:31:56.000000000 -0400
+++ b/arch/m68knommu/Kconfig	2006-10-14 22:41:50.000000000 -0400
@@ -565,7 +565,7 @@
 	depends on ROM
 	help
 	  This is almost always the same as the base of the ROM. Since on all
-	  68000 type varients the vectors are at the base of the boot device
+	  68000 type variants the vectors are at the base of the boot device
 	  on system startup.
 
 config ROMVECSIZE
@@ -574,7 +574,7 @@
 	depends on ROM
 	help
 	  Define the size of the vector region in ROM. For most 68000
-	  varients this would be 0x400 bytes in size. Set to 0 if you do
+	  variants this would be 0x400 bytes in size. Set to 0 if you do
 	  not want a vector region at the start of the ROM.
 
 config ROMSTART
diff -ru a/arch/mips/Kconfig b/arch/mips/Kconfig
--- a/arch/mips/Kconfig	2006-10-14 20:31:56.000000000 -0400
+++ b/arch/mips/Kconfig	2006-10-14 22:34:11.000000000 -0400
@@ -865,7 +865,7 @@
 	bool
 
 #
-# Endianess selection.  Suffiently obscure so many users don't know what to
+# Endianess selection.  Sufficiently obscure so many users don't know what to
 # answer,so we try hard to limit the available choices.  Also the use of a
 # choice statement should be more obvious to the user.
 #
@@ -874,7 +874,7 @@
 	help
 	  Some MIPS machines can be configured for either little or big endian
 	  byte order. These modes require different kernels and a different
-	  Linux distribution.  In general there is one prefered byteorder for a
+	  Linux distribution.  In general there is one preferred byteorder for a
 	  particular system but some systems are just as commonly used in the
 	  one or the other endianess.
 
diff -ru a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
--- a/arch/powerpc/Kconfig	2006-10-14 20:32:03.000000000 -0400
+++ b/arch/powerpc/Kconfig	2006-10-14 22:43:11.000000000 -0400
@@ -425,7 +425,7 @@
 	default n
 	help
           This option enables support for the Maple 970FX Evaluation Board.
-	  For more informations, refer to <http://www.970eval.com>
+	  For more information, refer to <http://www.970eval.com>
 
 config PPC_PASEMI
 	depends on PPC_MULTIPLATFORM && PPC64
diff -ru a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
--- a/arch/powerpc/platforms/83xx/Kconfig	2006-10-14 20:32:03.000000000 -0400
+++ b/arch/powerpc/platforms/83xx/Kconfig	2006-10-14 22:45:09.000000000 -0400
@@ -21,7 +21,7 @@
 	  Be aware that PCI buses can only function when SYS board is plugged
 	  into the PIB (Platform IO Board) board from Freescale which provide
 	  3 PCI slots.  The PIBs PCI initialization is the bootloader's
-	  responsiblilty.
+	  responsibility.
 
 config MPC834x_ITX
 	bool "Freescale MPC834x ITX"
@@ -30,7 +30,7 @@
 	  This option enables support for the MPC 834x ITX evaluation board.
 
 	  Be aware that PCI initialization is the bootloader's
-	  responsiblilty.
+	  responsibility.
 
 endchoice
 
diff -ru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	2006-10-14 20:32:03.000000000 -0400
+++ b/arch/ppc/Kconfig	2006-10-14 22:44:42.000000000 -0400
@@ -724,7 +724,7 @@
 	  Be aware that PCI buses can only function when SYS board is plugged
 	  into the PIB (Platform IO Board) board from Freescale which provide
 	  3 PCI slots.  The PIBs PCI initialization is the bootloader's
-	  responsiblilty.
+	  responsibility.
 
 config EV64360
 	bool "Marvell-EV64360BP"
diff -ru a/arch/sh/Kconfig b/arch/sh/Kconfig
--- a/arch/sh/Kconfig	2006-10-14 20:32:04.000000000 -0400
+++ b/arch/sh/Kconfig	2006-10-14 22:11:59.000000000 -0400
@@ -217,7 +217,7 @@
 	bool "SHMIN"
 	select CPU_SUBTYPE_SH7706
 	help
-	  Select SHMIN if configureing for the SHMIN board
+	  Select SHMIN if configuring for the SHMIN board.
 
 config SH_UNKNOWN
 	bool "BareCPU"
diff -ru a/arch/sparc/Kconfig b/arch/sparc/Kconfig
--- a/arch/sparc/Kconfig	2006-09-19 23:42:06.000000000 -0400
+++ b/arch/sparc/Kconfig	2006-10-14 22:33:07.000000000 -0400
@@ -212,8 +212,8 @@
 	tristate "Sun4m LED driver"
 	help
 	  This driver toggles the front-panel LED on sun4m systems
-	  in a user-specifyable manner.  It's state can be probed
-	  by reading /proc/led and it's blinking mode can be changed
+	  in a user-specifiable manner.  Its state can be probed
+	  by reading /proc/led and its blinking mode can be changed
 	  via writes to /proc/led
 
 source "fs/Kconfig.binfmt"
diff -ru a/drivers/char/Kconfig b/drivers/char/Kconfig
--- a/drivers/char/Kconfig	2006-10-14 20:32:05.000000000 -0400
+++ b/drivers/char/Kconfig	2006-10-14 22:23:59.000000000 -0400
@@ -1002,7 +1002,7 @@
 	help
 	  If you say Y here, you will have a miscdevice named "/dev/hpet/".  Each
 	  open selects one of the timers supported by the HPET.  The timers are
-	  non-periodioc and/or periodic.
+	  non-periodic and/or periodic.
 
 config HPET_RTC_IRQ
 	bool "HPET Control RTC IRQ" if !HPET_EMULATE_RTC
diff -ru a/drivers/media/dvb/dvb-core/Kconfig b/drivers/media/dvb/dvb-core/Kconfig
--- a/drivers/media/dvb/dvb-core/Kconfig	2006-10-14 20:32:06.000000000 -0400
+++ b/drivers/media/dvb/dvb-core/Kconfig	2006-10-14 22:20:49.000000000 -0400
@@ -19,6 +19,6 @@
 	  allow the card drivers to only load the frontend modules
 	  they require. This saves several KBytes of memory.
 
-	  Note: You will need moudule-init-tools v3.2 or later for this feature.
+	  Note: You will need module-init-tools v3.2 or later for this feature.
 
 	  If unsure say Y.
diff -ru a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
--- a/drivers/media/video/Kconfig	2006-10-14 20:32:07.000000000 -0400
+++ b/drivers/media/video/Kconfig	2006-10-14 22:14:19.000000000 -0400
@@ -24,7 +24,7 @@
 	  decode audio/video standards. This option will autoselect
 	  all pertinent modules to each selected video module.
 
-	  Unselect this only if you know exaclty what you are doing, since
+	  Unselect this only if you know exactly what you are doing, since
 	  it may break support on some boards.
 
 	  In doubt, say Y.
diff -ru a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
--- a/drivers/mtd/maps/Kconfig	2006-10-14 20:32:07.000000000 -0400
+++ b/drivers/mtd/maps/Kconfig	2006-10-14 22:28:46.000000000 -0400
@@ -607,7 +607,7 @@
 	default "4"
 
 config MTD_SHARP_SL
-	bool "ROM maped on Sharp SL Series"
+	bool "ROM mapped on Sharp SL Series"
 	depends on MTD && ARCH_PXA
 	help
 	  This enables access to the flash chip on the Sharp SL Series of PDAs.
diff -ru a/drivers/net/Kconfig b/drivers/net/Kconfig
--- a/drivers/net/Kconfig	2006-10-14 20:32:07.000000000 -0400
+++ b/drivers/net/Kconfig	2006-10-14 22:45:48.000000000 -0400
@@ -32,7 +32,7 @@
 	tristate "Intermediate Functional Block support"
 	depends on NET_CLS_ACT
 	---help---
-	  This is an intermidiate driver that allows sharing of
+	  This is an intermediate driver that allows sharing of
 	  resources.
 	  To compile this driver as a module, choose M here: the module
 	  will be called ifb.  If you want to use more than one ifb
@@ -2120,7 +2120,7 @@
 	  Marvell 88E8021/88E8022/88E8035/88E8036/88E8038/88E8050/88E8052/
 	  88E8053/88E8055/88E8061/88E8062, SysKonnect SK-9E21D/SK-9S21
 
-	  This driver does not support the original Yukon chipset: a seperate
+	  This driver does not support the original Yukon chipset: a separate
 	  driver, skge, is provided for Yukon-based adapters.
 
 	  To compile this driver as a module, choose M here: the module
@@ -2136,7 +2136,7 @@
 	  This driver supports the original Yukon chipset. A cleaner driver is 
 	  also available (skge) which seems to work better than this one.
 
-	  This driver does not support the newer Yukon2 chipset. A seperate
+	  This driver does not support the newer Yukon2 chipset. A separate
 	  driver, sky2, is provided to support Yukon2-based adapters.
 
 	  The following adapters are supported by this driver:
diff -ru a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
--- a/drivers/net/phy/Kconfig	2006-09-19 23:42:06.000000000 -0400
+++ b/drivers/net/phy/Kconfig	2006-10-14 22:16:01.000000000 -0400
@@ -61,8 +61,8 @@
 	depends on PHYLIB
 	---help---
 	  Adds the driver to PHY layer to cover the boards that do not have any PHY bound,
-	  but with the ability to manipulate with speed/link in software. The relavant MII
-	  speed/duplex parameters could be effectively handled in user-specified  fuction.
+	  but with the ability to manipulate the speed/link in software. The relevant MII
+	  speed/duplex parameters could be effectively handled in a user-specified function.
 	  Currently tested with mpc866ads.
 
 config FIXED_MII_10_FDX
diff -ru a/drivers/pci/Kconfig b/drivers/pci/Kconfig
--- a/drivers/pci/Kconfig	2006-10-14 20:32:21.000000000 -0400
+++ b/drivers/pci/Kconfig	2006-10-14 22:21:12.000000000 -0400
@@ -27,7 +27,7 @@
 	  smaller speedup on single processor machines.
 
 	  But it can also cause lots of bad things to happen.  A number
-	  of PCI drivers can not properly handle running in this way,
+	  of PCI drivers cannot properly handle running in this way,
 	  some will just not work properly at all, while others might
 	  decide to blow up power supplies with a huge load all at once,
 	  so use this option at your own risk.
diff -ru a/drivers/spi/Kconfig b/drivers/spi/Kconfig
--- a/drivers/spi/Kconfig	2006-09-19 23:42:06.000000000 -0400
+++ b/drivers/spi/Kconfig	2006-10-14 22:19:51.000000000 -0400
@@ -16,7 +16,7 @@
 	  controller and a chipselect.  Most SPI slaves don't support
 	  dynamic device discovery; some are even write-only or read-only.
 
-	  SPI is widely used by microcontollers to talk with sensors,
+	  SPI is widely used by microcontrollers to talk with sensors,
 	  eeprom and flash memory, codecs and various other controller
 	  chips, analog to digital (and d-to-a) converters, and more.
 	  MMC and SD cards can be accessed using SPI protocol; and for
diff -ru a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
--- a/drivers/usb/host/Kconfig	2006-10-14 20:32:22.000000000 -0400
+++ b/drivers/usb/host/Kconfig	2006-10-14 22:35:22.000000000 -0400
@@ -153,7 +153,7 @@
 	  adapter will *NOT* work with PC cards that do not contain an OHCI
 	  controller.
 
-	  For those PC cards that contain multiple OHCI controllers only ther
+	  For those PC cards that contain multiple OHCI controllers only the
 	  first one is used.
 
 	  The driver consists of two modules, the "ftdi-elan" module is a
diff -ru a/fs/Kconfig b/fs/Kconfig
--- a/fs/Kconfig	2006-10-14 20:32:22.000000000 -0400
+++ b/fs/Kconfig	2006-10-14 22:17:44.000000000 -0400
@@ -1141,7 +1141,7 @@
 	help
 	  The BeOS File System (BeFS) is the native file system of Be, Inc's
 	  BeOS. Notable features include support for arbitrary attributes
-	  on files and directories, and database-like indeces on selected
+	  on files and directories, and database-like indices on selected
 	  attributes. (Also note that this driver doesn't make those features
 	  available at this time). It is a 64 bit filesystem, so it supports
 	  extremely large volumes and files.
diff -ru a/net/Kconfig b/net/Kconfig
--- a/net/Kconfig	2006-10-14 20:32:26.000000000 -0400
+++ b/net/Kconfig	2006-10-14 22:42:58.000000000 -0400
@@ -189,13 +189,13 @@
 	  config (or if you simply don't have access to it).
 
 	  The other possible usages of diverting Ethernet Frames are
-	  numberous:
+	  numerous:
 	  - reroute smtp traffic to another interface
 	  - traffic-shape certain network streams
 	  - transparently proxy smtp connections
 	  - etc...
 
-	  For more informations, please refer to:
+	  For more information, please refer to:
 	  <http://diverter.sourceforge.net/>
 	  <http://perso.wanadoo.fr/magpie/EtherDivert.html>
 
diff -ru a/sound/Kconfig b/sound/Kconfig
--- a/sound/Kconfig	2006-09-19 23:42:06.000000000 -0400
+++ b/sound/Kconfig	2006-10-14 22:37:52.000000000 -0400
@@ -64,11 +64,11 @@
 
 source "sound/mips/Kconfig"
 
-# the following will depenend on the order of config.
+# the following will depend on the order of config.
 # here assuming USB is defined before ALSA
 source "sound/usb/Kconfig"
 
-# the following will depenend on the order of config.
+# the following will depend on the order of config.
 # here assuming PCMCIA is defined before ALSA
 source "sound/pcmcia/Kconfig"
 


