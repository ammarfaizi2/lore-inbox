Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269628AbUJFXLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269628AbUJFXLT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 19:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269622AbUJFXKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 19:10:01 -0400
Received: from mail.dif.dk ([193.138.115.101]:64237 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S269610AbUJFXHg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:07:36 -0400
Date: Thu, 7 Oct 2004 01:15:02 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Paul Gortmaker <p_gortmaker@yahoo.com>
Subject: [PATCH][Documentation] update 00-INDEX - a bunch of entries missing.
Message-ID: <Pine.LNX.4.61.0410070109140.2975@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


00-INDEX is not exactely up to date, a lot of files and directories are 
missing an entry. I've updated the file and added an entry for all the 
files and dirs currently missing one.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -u linux-2.6.9-rc3-bk5-orig/Documentation/00-INDEX linux-2.6.9-rc3-bk5/Documentation/00-INDEX
--- linux-2.6.9-rc3-bk5-orig/Documentation/00-INDEX	2004-09-30 05:04:23.000000000 +0200
+++ linux-2.6.9-rc3-bk5/Documentation/00-INDEX	2004-10-07 01:08:21.000000000 +0200
@@ -20,6 +20,8 @@
 	- list of changes that break older software packages.
 CodingStyle
 	- how the boss likes the C code in the kernel to look.
+DMA-API.txt
+	- DMA API, pci_ API & extensions for non-consistent memory machines.
 DMA-mapping.txt
 	- info for PCI drivers using DMA portably across all platforms.
 DocBook/
@@ -30,8 +32,12 @@
 	- info on Linux Intelligent Platform Management Interface (IPMI) Driver.
 IRQ-affinity.txt
 	- how to select which CPU(s) handle which interrupt events on SMP.
+ManagementStyle
+	- how to (attempt to) manage kernel hackers.
 MSI-HOWTO.txt
 	- the Message Signaled Interrupts (MSI) Driver Guide HOWTO and FAQ.
+RCU/
+	- directory with info on RCU (read-copy update).
 README.DAC960
 	- info on Mylex DAC960/DAC1100 PCI RAID Controller Driver for Linux.
 README.moxa
@@ -60,16 +66,22 @@
 	- info, major/minor #'s for Compaq's SMART Array Controllers.
 cdrom/
 	- directory with information on the CD-ROM drivers that Linux has.
+cli-sti-removal.txt
+	- cli()/sti() removal guide.
 computone.txt
 	- info on Computone Intelliport II/Plus Multiport Serial Driver.
 cpqarray.txt
 	- info on using Compaq's SMART2 Intelligent Disk Array Controllers.
-cpufreq/
+cpu-freq/
 	- info on CPU frequency and voltage scaling.
 cris/
 	- directory with info about Linux on CRIS architecture.
+crypto/
+	- directory with info on the Crypto API.
 debugging-modules.txt
 	- some notes on debugging modules after Linux 2.6.3.
+device-mapper/
+	- directory with info on Device Mapper.
 devices.txt
 	- plain ASCII listing of all the nodes in /dev/ with major minor #'s.
 digiboard.txt
@@ -92,6 +104,8 @@
 	- directory with info on the frame buffer graphics abstraction layer.
 filesystems/
 	- directory with info on the various filesystems that Linux supports.
+firmware_class/
+	- request_firmware() hotplug interface info.
 floppy.txt
 	- notes and driver options for the floppy disk driver.
 ftape.txt
@@ -100,10 +114,14 @@
 	- info on using the Hayes ESP serial driver.
 highuid.txt
 	- notes on the change from 16 bit to 32 bit user/group IDs.
+hpet.txt
+	- High Precision Event Timer Driver for Linux.
 hw_random.txt
 	- info on Linux support for random number generator in i8xx chipsets.
 i2c/
 	- directory with info about the I2C bus/protocol (2 wire, kHz speed).
+i2o/
+	- directory with info about the Linux I2O subsystem.
 i386/
 	- directory with info about Linux on Intel 32 bit architecture.
 ia64/
@@ -114,6 +132,8 @@
 	- how to use the RAM disk as an initial/temporary root filesystem.
 input/
 	- info on Linux input device support.
+io_ordering.txt
+	- info on ordering I/O writes to memory-mapped addresses.
 ioctl-number.txt
 	- how to implement and register device/driver ioctl calls.
 iostats.txt
@@ -134,6 +154,8 @@
 	- summary listing of command line / boot prompt args for the kernel.
 kobject.txt
 	- info of the kobject infrastructure of the Linux kernel.
+laptop-mode.txt
+	- How to conserve battery power using laptop-mode.
 ldm.txt
 	- a brief description of LDM (Windows Dynamic Disks).
 locks.txt
@@ -160,6 +182,8 @@
 	- script to make /dev entries for SMART controllers (see cciss.txt).
 mkdev.ida
 	- script to make /dev entries for Intelligent Disk Array Controllers.
+mono.txt
+	- how to execute Mono-based .NET binaries with the help of BINFMT_MISC.
 moxa-smartio
 	- info on installing/using Moxa multiport serial driver.
 mtrr.txt
@@ -172,6 +196,8 @@
 	- short guide on setting up a diskless box with NFS root filesystem.
 nmi_watchdog.txt
 	- info on NMI watchdog for SMP systems.
+numastat.txt
+	- info on how to read Numa policy hit/miss statistics in sysfs.
 oops-tracing.txt
 	- how to decode those nasty internal kernel error dump messages.
 paride.txt
@@ -206,10 +232,18 @@
 	- notes on how to use the Real Time Clock (aka CMOS clock) driver.
 s390/
 	- directory with info on using Linux on the IBM S390.
+sched-coding.txt
+	- reference for various scheduler-related methods in the O(1) scheduler.
 sched-design.txt
 	- goals, design and implementation of the Linux O(1) scheduler.
+sched-domains.txt
+	- information on scheduling domains.
+sched-stats.txt
+	- information on schedstats (Linux Scheduler Statistics).
 scsi/
 	- directory with info on Linux scsi support.
+serial/
+	- directory with info on the low level serial API.
 serial-console.txt
 	- how to set up Linux with a serial line console as the default.
 sgi-visws.txt
@@ -242,14 +276,24 @@
 	- info on the magic SysRq key.
 telephony/
 	- directory with info on telephony (e.g. voice over IP) support.
+time_interpolators.txt
+	- info on time interpolators.
+tipar.txt
+	- information about Parallel link cable for Texas Instruments handhelds.
+tty.txt
+	- guide to the locking policies of the tty layer.
 unicode.txt
 	- info on the Unicode character/font mapping used in Linux.
+uml/
+	- directory with infomation about User Mode Linux.
 usb/
 	- directory with info regarding the Universal Serial Bus.
 video4linux/
 	- directory with info regarding video/TV/radio cards and linux.
 vm/
 	- directory with info on the Linux vm code.
+voyager.txt
+	- guide to running Linux on the Voyager architecture.
 watchdog/
 	- how to auto-reboot Linux if it has "fallen and can't get up". ;-)
 x86_64/


