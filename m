Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWGGRsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWGGRsB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 13:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWGGRsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 13:48:01 -0400
Received: from cpe-72-226-39-15.nycap.res.rr.com ([72.226.39.15]:12816 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S932238AbWGGRsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 13:48:00 -0400
Date: Fri, 7 Jul 2006 13:46:56 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Still more typo fixes for RC1
Message-Id: <20060707134656.9a85ee3b.kernel1@cyberdogtech.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Fri, 07 Jul 2006 13:47:02 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Fri, 07 Jul 2006 13:47:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another set of typo fixes for RC1.  They should all be unique from previous patches.

By my count, this is in addition to 6 previous patches which are now waiting to be included in RC1.  I've not yet received any feedback regarding them, so hopefully they are all clear to merge.  If necessary, I can combine them all into a single patch at the request of the maintainers.

-- 
Matt LaPlante
CCNP, CCDP, A+, Linux+, CQS
kernel1@cyberdogtech.com
--

diff -ru a/arch/arm/mach-s3c2410/Kconfig b/arch/arm/mach-s3c2410/Kconfig
--- a/arch/arm/mach-s3c2410/Kconfig	2006-07-06 10:48:48.000000000 -0400
+++ b/arch/arm/mach-s3c2410/Kconfig	2006-07-06 11:28:09.000000000 -0400
@@ -6,7 +6,7 @@
 	bool "Simtec Electronics ANUBIS"
 	select CPU_S3C2440
 	help
-	  Say Y gere if you are using the Simtec Electronics ANUBIS
+	  Say Y here if you are using the Simtec Electronics ANUBIS
 	  development system
 
 config MACH_OSIRIS
diff -ru a/arch/ppc/platforms/85xx/Kconfig b/arch/ppc/platforms/85xx/Kconfig
--- a/arch/ppc/platforms/85xx/Kconfig	2006-07-06 10:42:57.000000000 -0400
+++ b/arch/ppc/platforms/85xx/Kconfig	2006-07-06 13:15:13.000000000 -0400
@@ -24,12 +24,12 @@
 config MPC8548_CDS
 	bool "Freescale MPC8548 CDS"
 	help
-	  This option enablese support for the MPC8548 CDS evaluation board.
+	  This option enables support for the MPC8548 CDS evaluation board.
 
 config MPC8555_CDS
 	bool "Freescale MPC8555 CDS"
 	help
-	  This option enablese support for the MPC8555 CDS evaluation board.
+	  This option enables support for the MPC8555 CDS evaluation board.
 
 config MPC8560_ADS
 	bool "Freescale MPC8560 ADS"
@@ -51,22 +51,22 @@
 config TQM8540
 	bool "TQ Components TQM8540"
 	help
-	  This option enablese support for the TQ Components TQM8540 board.
+	  This option enables support for the TQ Components TQM8540 board.
 
 config TQM8541
 	bool "TQ Components TQM8541"
 	help
-	  This option enablese support for the TQ Components TQM8541 board.
+	  This option enables support for the TQ Components TQM8541 board.
 
 config TQM8555
 	bool "TQ Components TQM8555"
 	help
-	  This option enablese support for the TQ Components TQM8555 board.
+	  This option enables support for the TQ Components TQM8555 board.
 
 config TQM8560
 	bool "TQ Components TQM8560"
 	help
-	  This option enablese support for the TQ Components TQM8560 board.
+	  This option enables support for the TQ Components TQM8560 board.
 
 endchoice
 
@@ -94,7 +94,7 @@
 	default y
 
 config 85xx_PCI2
-	bool "Supprt for 2nd PCI host controller"
+	bool "Support for 2nd PCI host controller"
 	depends on MPC8555_CDS
 	default y
 
diff -ru a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
--- a/arch/xtensa/Kconfig	2006-07-06 10:49:01.000000000 -0400
+++ b/arch/xtensa/Kconfig	2006-07-06 11:30:58.000000000 -0400
@@ -206,7 +206,7 @@
 
 endmenu
 
-menu "Exectuable file formats"
+menu "Executable file formats"
 
 # only elf supported
 config KCORE_ELF
@@ -241,7 +241,7 @@
 	bool "Embed root filesystem ramdisk into the kernel"
 
 config EMBEDDED_RAMDISK_IMAGE
-	string "Filename of gziped ramdisk image"
+	string "Filename of gzipped ramdisk image"
 	depends on EMBEDDED_RAMDISK
 	default "ramdisk.gz"
 	help
diff -ru a/drivers/infiniband/ulp/ipoib/Kconfig b/drivers/infiniband/ulp/ipoib/Kconfig
--- a/drivers/infiniband/ulp/ipoib/Kconfig	2006-07-06 10:45:13.000000000 -0400
+++ b/drivers/infiniband/ulp/ipoib/Kconfig	2006-07-06 13:50:52.000000000 -0400
@@ -27,7 +27,7 @@
 	bool "IP-over-InfiniBand data path debugging"
 	depends on INFINIBAND_IPOIB_DEBUG
 	---help---
-	  This option compiles debugging code into the the data path
+	  This option compiles debugging code into the data path
 	  of the IPoIB driver.  The output can be turned on via the
 	  data_debug_level module parameter; however, even with output
 	  turned off, this debugging code will have some performance
diff -ru a/drivers/media/video/cx88/Kconfig b/drivers/media/video/cx88/Kconfig
--- a/drivers/media/video/cx88/Kconfig	2006-07-06 10:49:13.000000000 -0400
+++ b/drivers/media/video/cx88/Kconfig	2006-07-06 12:21:12.000000000 -0400
@@ -88,7 +88,7 @@
 	select DVB_MT352
 	---help---
 	  This adds DVB-T support for cards based on the
-	  Connexant 2388x chip and the MT352 demodulator.
+	  Conexant 2388x chip and the MT352 demodulator.
 
 config VIDEO_CX88_DVB_VP3054
 	bool "VP-3054 Secondary I2C Bus Support"
@@ -97,7 +97,7 @@
 	select VIDEO_CX88_VP3054
 	---help---
 	  This adds DVB-T support for cards based on the
-	  Connexant 2388x chip and the MT352 demodulator,
+	  Conexant 2388x chip and the MT352 demodulator,
 	  which also require support for the VP-3054
 	  Secondary I2C bus, such at DNTV Live! DVB-T Pro.
 
@@ -108,7 +108,7 @@
 	select DVB_ZL10353
 	---help---
 	  This adds DVB-T support for cards based on the
-	  Connexant 2388x chip and the ZL10353 demodulator,
+	  Conexant 2388x chip and the ZL10353 demodulator,
 	  successor to the Zarlink MT352.
 
 config VIDEO_CX88_DVB_OR51132
@@ -118,7 +118,7 @@
 	select DVB_OR51132
 	---help---
 	  This adds ATSC 8VSB and QAM64/256 support for cards based on the
-	  Connexant 2388x chip and the OR51132 demodulator.
+	  Conexant 2388x chip and the OR51132 demodulator.
 
 config VIDEO_CX88_DVB_CX22702
 	bool "Conexant CX22702 DVB-T Support"
@@ -127,7 +127,7 @@
 	select DVB_CX22702
 	---help---
 	  This adds DVB-T support for cards based on the
-	  Connexant 2388x chip and the CX22702 demodulator.
+	  Conexant 2388x chip and the CX22702 demodulator.
 
 config VIDEO_CX88_DVB_LGDT330X
 	bool "LG Electronics DT3302/DT3303 ATSC Support"
@@ -136,7 +136,7 @@
 	select DVB_LGDT330X
 	---help---
 	  This adds ATSC 8VSB and QAM64/256 support for cards based on the
-	  Connexant 2388x chip and the LGDT3302/LGDT3303 demodulator.
+	  Conexant 2388x chip and the LGDT3302/LGDT3303 demodulator.
 
 config VIDEO_CX88_DVB_NXT200X
 	bool "NXT2002/NXT2004 ATSC Support"
@@ -145,7 +145,7 @@
 	select DVB_NXT200X
 	---help---
 	  This adds ATSC 8VSB and QAM64/256 support for cards based on the
-	  Connexant 2388x chip and the NXT2002/NXT2004 demodulator.
+	  Conexant 2388x chip and the NXT2002/NXT2004 demodulator.
 
 config VIDEO_CX88_DVB_CX24123
 	bool "Conexant CX24123 DVB-S Support"
@@ -155,4 +155,4 @@
 	select DVB_ISL6421
 	---help---
 	  This adds DVB-S support for cards based on the
-	  Connexant 2388x chip and the CX24123 demodulator.
+	  Conexant 2388x chip and the CX24123 demodulator.
diff -ru a/drivers/net/Kconfig b/drivers/net/Kconfig
--- a/drivers/net/Kconfig	2006-07-06 10:49:13.000000000 -0400
+++ b/drivers/net/Kconfig	2006-07-06 13:48:38.000000000 -0400
@@ -2071,7 +2071,7 @@
 	depends on PCI && EXPERIMENTAL
 	select CRC32
 	---help---
-	  This driver supports Gigabit Ethernet adapters based on the the
+	  This driver supports Gigabit Ethernet adapters based on the
 	  Marvell Yukon 2 chipset:
 	  Marvell 88E8021/88E8022/88E8035/88E8036/88E8038/88E8050/88E8052/
 	  88E8053/88E8055/88E8061/88E8062, SysKonnect SK-9E21D/SK-9S21
diff -ru a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
--- a/drivers/pci/hotplug/Kconfig	2006-07-06 10:44:29.000000000 -0400
+++ b/drivers/pci/hotplug/Kconfig	2006-07-06 14:05:06.000000000 -0400
@@ -165,7 +165,7 @@
 	tristate "RPA PCI Hotplug driver"
 	depends on HOTPLUG_PCI && PPC_PSERIES && PPC64 && !HOTPLUG_PCI_FAKE
 	help
-	  Say Y here if you have a a RPA system that supports PCI Hotplug.
+	  Say Y here if you have a RPA system that supports PCI Hotplug.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called rpaphp.
diff -ru a/drivers/usb/atm/Kconfig b/drivers/usb/atm/Kconfig
--- a/drivers/usb/atm/Kconfig	2006-07-06 10:44:33.000000000 -0400
+++ b/drivers/usb/atm/Kconfig	2006-07-06 13:56:14.000000000 -0400
@@ -64,7 +64,7 @@
 	  Say Y here if you have a DSL USB modem not explicitly supported by
 	  another USB DSL drivers.  In order to use your modem you will need to
 	  pass the vendor ID, product ID, and endpoint numbers for transmission
-	  and reception as module parameters.  You may need to initialize the
+	  and reception as module parameters.  You may need to initialize
 	  the modem using a user space utility (a firmware loader for example).
 
 	  To compile this driver as a module, choose M here: the
diff -ru a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
--- a/drivers/usb/gadget/Kconfig	2006-07-06 11:14:24.000000000 -0400
+++ b/drivers/usb/gadget/Kconfig	2006-07-06 14:04:48.000000000 -0400
@@ -7,7 +7,7 @@
 #
 #  - Host systems (like PCs) need CONFIG_USB (with "A" jacks).
 #  - Peripherals (like PDAs) need CONFIG_USB_GADGET (with "B" jacks).
-#  - Some systems have both kinds of of controller.
+#  - Some systems have both kinds of controllers.
 #
 # With help from a special transceiver and a "Mini-AB" jack, systems with
 # both kinds of controller can also support "USB On-the-Go" (CONFIG_USB_OTG).
diff -ru a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig	2006-07-06 11:14:24.000000000 -0400
+++ b/drivers/video/Kconfig	2006-07-06 13:56:46.000000000 -0400
@@ -181,7 +181,7 @@
 	bool "LogicPD LCD 3.5\" QVGA w/HRTFT IC"
 	help
 	  This is an implementation of the Sharp LQ035Q7DB02, a 3.5"
-	  color QVGA, HRTFT panel.  The LogicPD device includes an
+	  color QVGA, HRTFT panel.  The LogicPD device includes
 	  an integrated HRTFT controller IC.
 	  The native resolution is 240x320.
 
diff -ru a/fs/cifs/README b/fs/cifs/README
--- a/fs/cifs/README	2006-07-06 10:49:20.000000000 -0400
+++ b/fs/cifs/README	2006-07-06 14:09:41.000000000 -0400
@@ -269,7 +269,7 @@
 		(gid) mount option is specified.  For the uid (gid) of newly
 		created files and directories, ie files created since 
 		the last mount of the server share, the expected uid 
-		(gid) is cached as as long as the inode remains in 
+		(gid) is cached as long as the inode remains in 
 		memory on the client.   Also note that permission
 		checks (authorization checks) on accesses to a file occur
 		at the server, but there are cases in which an administrator
@@ -375,7 +375,7 @@
 		the local process on newly created files, directories, and
 		devices (create, mkdir, mknod).  If the CIFS Unix Extensions
 		are not negotiated, for newly created files and directories
-		instead of using the default uid and gid specified on the
+		instead of using the default uid and gid specified on
 		the mount, cache the new file's uid and gid locally which means
 		that the uid for the file can change when the inode is
 	        reloaded (or the user remounts the share).
@@ -440,7 +440,7 @@
 		create device files and fifos in a format compatible with
 		Services for Unix (SFU).  In addition retrieve bits 10-12
 		of the mode via the SETFILEBITS extended attribute (as
-		SFU does).  In the future the bottom 9 bits of the mode
+		SFU does).  In the future the bottom 9 bits of the
 		mode also will be emulated using queries of the security
 		descriptor (ACL).
  sign           Must use packet signing (helps avoid unwanted data modification
diff -ru a/fs/Kconfig b/fs/Kconfig
--- a/fs/Kconfig	2006-07-06 11:14:24.000000000 -0400
+++ b/fs/Kconfig	2006-07-06 14:02:55.000000000 -0400
@@ -1319,7 +1319,7 @@
 
 	  If you have floppies or hard disk partitions like that, it is likely
 	  that they contain binaries from those other Unix systems; in order
-	  to run these binaries, you will want to install linux-abi which is a
+	  to run these binaries, you will want to install linux-abi which is
 	  a set of kernel modules that lets you run SCO, Xenix, Wyse,
 	  UnixWare, Dell Unix and System V programs under Linux.  It is
 	  available via FTP (user: ftp) from
diff -ru a/net/ipv4/ipvs/Kconfig b/net/ipv4/ipvs/Kconfig
--- a/net/ipv4/ipvs/Kconfig	2006-07-06 11:14:24.000000000 -0400
+++ b/net/ipv4/ipvs/Kconfig	2006-07-06 13:49:13.000000000 -0400
@@ -204,7 +204,7 @@
 	  connections to the server with the shortest expected delay. The 
 	  expected delay that the job will experience is (Ci + 1) / Ui if 
 	  sent to the ith server, in which Ci is the number of connections
-	  on the the ith server and Ui is the fixed service rate (weight)
+	  on the ith server and Ui is the fixed service rate (weight)
 	  of the ith server.
 
 	  If you want to compile it in kernel, say Y. To compile it as a
diff -ru a/net/ipv4/Kconfig b/net/ipv4/Kconfig
--- a/net/ipv4/Kconfig	2006-07-06 11:14:24.000000000 -0400
+++ b/net/ipv4/Kconfig	2006-07-06 11:56:11.000000000 -0400
@@ -556,7 +556,7 @@
 	default n
 	---help---
 	TCP Low Priority (TCP-LP), a distributed algorithm whose goal is
-	to utiliza only the excess network bandwidth as compared to the
+	to utilize only the excess network bandwidth as compared to the
 	``fair share`` of bandwidth as targeted by TCP.
 	See http://www-ece.rice.edu/networks/TCP-LP/
 
diff -ru a/security/selinux/Kconfig b/security/selinux/Kconfig
--- a/security/selinux/Kconfig	2006-07-06 11:14:24.000000000 -0400
+++ b/security/selinux/Kconfig	2006-07-06 13:57:18.000000000 -0400
@@ -122,5 +122,5 @@
 	  well as any conntrack helpers for protocols which you
 	  wish to control.
 
-	  If you are unsure what do do here, select N.
+	  If you are unsure what to do here, select N.
 

