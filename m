Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312332AbSCYHuI>; Mon, 25 Mar 2002 02:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312325AbSCYHt7>; Mon, 25 Mar 2002 02:49:59 -0500
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:22734 "HELO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with SMTP
	id <S312291AbSCYHtv>; Mon, 25 Mar 2002 02:49:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rolf Eike Beer <eike@bilbo.math.uni-mannheim.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.7 Documentation/00-INDEX, second try
Date: Mon, 25 Mar 2002 08:50:04 +0100
X-Mailer: KMail [version 1.3.9]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200203250850.04685@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates Documentation/00-INDEX. It removes some lines describing 
files that have been removed/moved to subdirectories. Also it adds some lines 
on new files/directories. It has less typos than my previos one.

Eike

--- linux-2.5.7/Documentation/00-INDEX.orig	Thu Mar 21 08:04:54 2002
+++ linux-2.5.7/Documentation/00-INDEX	Thu Mar 21 09:20:57 2002
@@ -12,14 +12,14 @@
 
 00-INDEX
 	- this file.
+BK-usage/
+	- directory with info on BitKeeper.
 BUG-HUNTING
 	- brute force method of doing binary search of patches to find bug.
 Changes
 	- list of changes that break older software packages.
 CodingStyle
 	- how the boss likes the C code in the kernel to look.
-Configure.help
-	- text file that is used for help when you run "make config"
 DMA-mapping.txt
 	- info for PCI drivers using DMA portably across all platforms.
 DocBook/
@@ -34,6 +34,10 @@
 	- info on Mylex DAC960/DAC1100 PCI RAID Controller Driver for Linux
 README.moxa
 	- release notes for Moxa mutiport serial card.
+README.nsp_cs.eng
+	- info on WorkBiT NinjaSCSI-3/32Bi driver.
+SAK.txt
+	- info on Secure Attention Keys.
 SubmittingDrivers
 	- procedure to get a new driver source included into the kernel tree.
 SubmittingPatches
@@ -44,6 +48,8 @@
 	- directory with info about Linux on the ARM architecture.
 binfmt_misc.txt
 	- info on the kernel support for extra binary formats.
+block/
+	- info on the Block I/O (BIO) layer.
 cachetlb.txt
 	- describes the cache/TLB flushing interfaces Linux uses.
 cciss.txt
@@ -54,6 +60,8 @@
 	- info on Computone Intelliport II/Plus Multiport Serial Driver
 cpqarray.txt
 	- info on using Compaq's SMART2 Intelligent Disk Array Controllers.
+cris/
+	- directory with info about Linux on CRIS architecture.
 devices.txt
 	- plain ASCII listing of all the nodes in /dev/ with major minor #'s
 digiboard.txt
@@ -62,6 +70,8 @@
 	- info on Digi Intl. {PC,PCI,EISA}Xx and Xem series cards.
 dnotify.txt
 	- info about directory notification in Linux.
+driver-model.txt
+	- info about Linux driver model.
 exception.txt
 	- how Linux v2.2 handles exceptions without verify_area etc.
 fb/
@@ -80,12 +90,16 @@
 	- directory with info about the I2C bus/protocol (2 wire, kHz speed)
 i386/
 	- directory with info about Linux on intel 32 bit architecture.
+i810_rng.txt
+	- info on Linux support for random number generator in i8xx chipsets.
 ia64/
 	- directory with info about Linux on intel 64 bit architecture.
 ide.txt
 	- important info for users of ATA devices (IDE/EIDE disks and CD-ROMS)
 initrd.txt
 	- how to use the RAM disk as an initial/temporary root filesystem.
+input/
+	- info on Linux input device support.
 ioctl-number.txt
 	- how to implement and register device/driver ioctl calls.
 isapnp.txt
@@ -94,12 +108,6 @@
 	- directory with info on the Linux ISDN support, and supported cards.
 java.txt
 	- info on the in-kernel binary support for Java(tm)
-joystick-api.txt
-	- API specification for applications that will be using the joystick.
-joystick-parport.txt 
-	- info on how to hook joysticks/gamepads to the parallel port.
-joystick.txt
-	- info on using joystick devices (and driver) with Linux.
 kbuild/
 	- directory with info about the kernel build process
 kernel-doc-nano-HOWTO.txt
@@ -128,6 +136,8 @@
 	- info on boot arguments for the multiple devices driver
 memory.txt
 	- info on typical Linux memory problems.
+mips/
+	- directory with info about Linux on MIPS architecture.
 mkdev.cciss
 	- script to make /dev entries for SMART controllers (see cciss.txt)
 mkdev.ida
@@ -161,9 +171,13 @@
 pcwd-watchdog.txt
 	- info and sample code for using with the PC Watchdog reset card.
 pm.txt
-	- info on Linux power management support
+	- info on Linux power management support.
+power/
+	- directory with info on Linux PCI power management.
 powerpc/
 	- directory with info on using Linux with the PowerPC.
+preempt-locking.txt
+	- info on locking under a preemptive kernel.
 ramdisk.txt
 	- short guide on how to set up and use the RAM disk.
 riscom8.txt
@@ -172,6 +186,8 @@
 	- notes on how to use the Real Time Clock (aka CMOS clock) driver.
 s390/
 	- directory with info on using Linux on the IBM S390.
+sh/
+	- directory with info on porting Linux to a new architecture.
 scsi-generic.txt
 	- info on the sg driver for generic (non-disk/CD/tape) SCSI devices.
 scsi.txt
@@ -186,6 +202,8 @@
 	- LaTeX document describing implementation of Multiprocessor Linux
 smp.txt
 	- a few more notes on symmetric multi-processing
+sonypi.txt
+	- info on Linux Sony Programmable I/O Device support.
 sound/
 	- directory with info on sound card support
 sparc/
@@ -216,6 +234,8 @@
 	- directory with info on the Linux vm code.
 watchdog.txt
 	- how to auto-reboot Linux if it has "fallen and can't get up". ;-)
+x86_64/
+	- directory with info on Linux support for AMD x86-64 (Hammer) machines.
 xterm-linux.xpm
 	- XPM image of penguin logo (see logo.txt) sitting on an xterm.
 zorro.txt
