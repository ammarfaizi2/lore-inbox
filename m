Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWGWQui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWGWQui (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 12:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWGWQui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 12:50:38 -0400
Received: from cpe-74-70-38-78.nycap.res.rr.com ([74.70.38.78]:4623 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1750829AbWGWQui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 12:50:38 -0400
Date: Sun, 23 Jul 2006 12:49:20 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org
Subject: [PATCH 18-rc2] Fix typos in /Documentation : 'F'-'G'
Message-Id: <20060723124920.76a5d725.kernel1@cyberdogtech.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Sun, 23 Jul 2006 12:49:30 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Sun, 23 Jul 2006 12:49:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes typos in various Documentation txts. The patch addresses some words starting with the letters 'F'-'G'.  

Signed-off-by: Matt LaPlante <kernel1@cyberdogtech.com>
--

diff -ru a/Documentation/block/barrier.txt b/Documentation/block/barrier.txt
--- a/Documentation/block/barrier.txt	2006-07-22 15:09:50.000000000 -0400
+++ b/Documentation/block/barrier.txt	2006-07-22 17:08:16.000000000 -0400
@@ -56,7 +56,7 @@
 i. No write-back cache.  Keeping requests ordered is enough.
 
 ii. Write-back cache but no flush operation.  There's no way to
-gurantee physical-medium commit order.  This kind of devices can't to
+guarantee physical-medium commit order.  This kind of devices can't to
 I/O barriers.
 
 iii. Write-back cache and flush operation but no FUA (forced unit
diff -ru a/Documentation/block/deadline-iosched.txt b/Documentation/block/deadline-iosched.txt
--- a/Documentation/block/deadline-iosched.txt	2006-07-22 15:09:50.000000000 -0400
+++ b/Documentation/block/deadline-iosched.txt	2006-07-22 17:04:24.000000000 -0400
@@ -23,7 +23,7 @@
 read_expire	(in ms)
 -----------
 
-The goal of the deadline io scheduler is to attempt to guarentee a start
+The goal of the deadline io scheduler is to attempt to guarantee a start
 service time for a request. As we focus mainly on read latencies, this is
 tunable. When a read request first enters the io scheduler, it is assigned
 a deadline that is the current time + the read_expire value in units of
diff -ru a/Documentation/cpu-freq/cpufreq-stats.txt b/Documentation/cpu-freq/cpufreq-stats.txt
--- a/Documentation/cpu-freq/cpufreq-stats.txt	2006-07-22 15:10:37.000000000 -0400
+++ b/Documentation/cpu-freq/cpufreq-stats.txt	2006-07-22 16:47:03.000000000 -0400
@@ -53,7 +53,7 @@
 This gives the amount of time spent in each of the frequencies supported by
 this CPU. The cat output will have "<frequency> <time>" pair in each line, which
 will mean this CPU spent <time> usertime units of time at <frequency>. Output
-will have one line for each of the supported freuencies. usertime units here 
+will have one line for each of the supported frequencies. usertime units here 
 is 10mS (similar to other time exported in /proc).
 
 --------------------------------------------------------------------------------
diff -ru a/Documentation/cpu-freq/governors.txt b/Documentation/cpu-freq/governors.txt
--- a/Documentation/cpu-freq/governors.txt	2006-07-22 15:10:37.000000000 -0400
+++ b/Documentation/cpu-freq/governors.txt	2006-07-22 17:01:55.000000000 -0400
@@ -109,7 +109,7 @@
 2.4 Ondemand
 ------------
 
-The CPUfreq govenor "ondemand" sets the CPU depending on the
+The CPUfreq governor "ondemand" sets the CPU depending on the
 current usage. To do this the CPU must have the capability to
 switch the frequency very quickly.  There are a number of sysfs file
 accessible parameters:
diff -ru a/Documentation/dell_rbu.txt b/Documentation/dell_rbu.txt
--- a/Documentation/dell_rbu.txt	2006-07-22 15:09:50.000000000 -0400
+++ b/Documentation/dell_rbu.txt	2006-07-22 16:58:20.000000000 -0400
@@ -55,8 +55,8 @@
 In the packet update mechanism, the user neesd to create a new file having
 packets of data arranged back to back. It can be done as follows
 The user creates packets header, gets the chunk of the BIOS image and
-placs it next to the packetheader; now, the packetheader + BIOS image chunk
-added to geather should match the specified packet_size. This makes one
+places it next to the packetheader; now, the packetheader + BIOS image chunk
+added together should match the specified packet_size. This makes one
 packet, the user needs to create more such packets out of the entire BIOS
 image file and then arrange all these packets back to back in to one single
 file.
diff -ru a/Documentation/dvb/faq.txt b/Documentation/dvb/faq.txt
--- a/Documentation/dvb/faq.txt	2006-07-22 15:09:50.000000000 -0400
+++ b/Documentation/dvb/faq.txt	2006-07-22 16:34:12.000000000 -0400
@@ -153,7 +153,7 @@
 	- video-buf: capture helper module for the saa7146_vv driver. This
 	  one is responsible to handle capture buffers.
 
-	- dvb-ttpci: The main driver for AV7110 based, full-featued
+	- dvb-ttpci: The main driver for AV7110 based, full-featured
 	  DVB-S/C/T cards
 
 eof
diff -ru a/Documentation/fb/sisfb.txt b/Documentation/fb/sisfb.txt
--- a/Documentation/fb/sisfb.txt	2006-07-22 15:09:50.000000000 -0400
+++ b/Documentation/fb/sisfb.txt	2006-07-22 16:41:20.000000000 -0400
@@ -72,7 +72,7 @@
 supported options including some explanation.
 
 The desired display mode can be specified using the keyword "mode" with
-a parameter in one of the follwing formats:
+a parameter in one of the following formats:
   - XxYxDepth or
   - XxY-Depth or
   - XxY-Depth@Rate or
diff -ru a/Documentation/fb/sstfb.txt b/Documentation/fb/sstfb.txt
--- a/Documentation/fb/sstfb.txt	2006-07-22 15:09:50.000000000 -0400
+++ b/Documentation/fb/sstfb.txt	2006-07-22 16:42:00.000000000 -0400
@@ -77,7 +77,7 @@
 	for module : insmod sstfb.o option1=value1 option2=value2 ...
 	in kernel :  video=sstfb:option1,option2:value2,option3 ...
 	
-	sstfb supports the folowing options :
+	sstfb supports the following options :
 
 Module		Kernel		Description
 
diff -ru a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
--- a/Documentation/feature-removal-schedule.txt	2006-07-22 15:10:37.000000000 -0400
+++ b/Documentation/feature-removal-schedule.txt	2006-07-22 16:33:30.000000000 -0400
@@ -168,7 +168,7 @@
 ---------------------------
 
 What:	USB driver API moves to EXPORT_SYMBOL_GPL
-When:	Febuary 2008
+When:	February 2008
 Files:	include/linux/usb.h, drivers/usb/core/driver.c
 Why:	The USB subsystem has changed a lot over time, and it has been
 	possible to create userspace USB drivers using usbfs/libusb/gadgetfs
diff -ru a/Documentation/filesystems/relayfs.txt b/Documentation/filesystems/relayfs.txt
--- a/Documentation/filesystems/relayfs.txt	2006-07-22 15:09:50.000000000 -0400
+++ b/Documentation/filesystems/relayfs.txt	2006-07-22 16:37:08.000000000 -0400
@@ -361,7 +361,7 @@
 
 By default of course, relay_open() creates relay files in the relayfs
 filesystem.  Because relay_file_operations is exported, however, it's
-also possible to create and use relay files in other pseudo-filesytems
+also possible to create and use relay files in other pseudo-filesystems
 such as debugfs.
 
 For this purpose, two callback functions are provided,
diff -ru a/Documentation/filesystems/spufs.txt b/Documentation/filesystems/spufs.txt
--- a/Documentation/filesystems/spufs.txt	2006-07-22 15:09:50.000000000 -0400
+++ b/Documentation/filesystems/spufs.txt	2006-07-22 16:30:37.000000000 -0400
@@ -84,7 +84,7 @@
    /ibox
        The  second  SPU  to CPU communication mailbox. This file is similar to
        the first mailbox file, but can be read in blocking I/O mode,  and  the
-       poll  familiy of system calls can be used to wait for it.  The possible
+       poll  family of system calls can be used to wait for it.  The  possible
        operations on an open ibox file are:
 
        read(2)
diff -ru a/Documentation/input/ff.txt b/Documentation/input/ff.txt
--- a/Documentation/input/ff.txt	2006-07-22 15:09:50.000000000 -0400
+++ b/Documentation/input/ff.txt	2006-07-22 17:07:10.000000000 -0400
@@ -13,7 +13,7 @@
 At the moment, only I-Force devices are supported, and not officially. That
 means I had to find out how the protocol works on my own. Of course, the
 information I managed to grasp is far from being complete, and I can not
-guarranty that this driver will work for you.
+guaranty that this driver will work for you.
 This document only describes the force feedback part of the driver for I-Force
 devices. Please read joystick.txt before reading further this document.
 
diff -ru a/Documentation/input/iforce-protocol.txt b/Documentation/input/iforce-protocol.txt
--- a/Documentation/input/iforce-protocol.txt	2006-07-22 15:09:50.000000000 -0400
+++ b/Documentation/input/iforce-protocol.txt	2006-07-22 16:23:56.000000000 -0400
@@ -157,7 +157,7 @@
 
 **** Query ram size ****
 QUERY = 42 ('B'uffer size)
-The device should reply with the same packet plus two additionnal bytes
+The device should reply with the same packet plus two additional bytes
 containing the size of the memory:
 ff 03 42 03 e8 CS would mean that the device has 1000 bytes of ram available.
 
diff -ru a/Documentation/lockdep-design.txt b/Documentation/lockdep-design.txt
--- a/Documentation/lockdep-design.txt	2006-07-22 15:09:50.000000000 -0400
+++ b/Documentation/lockdep-design.txt	2006-07-22 16:32:38.000000000 -0400
@@ -136,7 +136,7 @@
 In this case the locking is done on a bdev object that is known to be a
 partition.
 
-The validator treats a lock that is taken in such a nested fasion as a
+The validator treats a lock that is taken in such a nested fashion as a
 separate (sub)class for the purposes of validation.
 
 Note: When changing code to use the _nested() primitives, be careful and
diff -ru a/Documentation/networking/cxgb.txt b/Documentation/networking/cxgb.txt
--- a/Documentation/networking/cxgb.txt	2006-07-22 15:10:37.000000000 -0400
+++ b/Documentation/networking/cxgb.txt	2006-07-22 16:45:58.000000000 -0400
@@ -172,7 +172,7 @@
    smaller window prevents congestion and facilitates better pacing,
    especially if/when MAC level flow control does not work well or when it is
    not supported on the machine. Experimentation may be necessary to attain
-   the correct value. This method is provided as a starting point fot the
+   the correct value. This method is provided as a starting point for the
    correct receive buffer size.
    Setting the min, max, and default receive buffer (RX_WINDOW) size is
    performed in the same manner as single connection.
diff -ru a/Documentation/networking/fib_trie.txt b/Documentation/networking/fib_trie.txt
--- a/Documentation/networking/fib_trie.txt	2006-07-22 15:10:37.000000000 -0400
+++ b/Documentation/networking/fib_trie.txt	2006-07-22 16:51:03.000000000 -0400
@@ -79,7 +79,7 @@
 
 resize()
 	Analyzes a tnode and optimizes the child array size by either inflating
-	or shrinking it repeatedly until it fullfills the criteria for optimal
+	or shrinking it repeatedly until it fulfills the criteria for optimal
 	level compression. This part follows the original paper pretty closely
 	and there may be some room for experimentation here.
 
diff -ru a/Documentation/power/devices.txt b/Documentation/power/devices.txt
--- a/Documentation/power/devices.txt	2006-07-22 15:09:50.000000000 -0400
+++ b/Documentation/power/devices.txt	2006-07-22 16:44:01.000000000 -0400
@@ -156,10 +156,10 @@
 should only look at event, and ignore flags.]
 
 #Prepare for suspend -- userland is still running but we are going to
-#enter suspend state. This gives drivers chance to load firmware from
-#disk and store it in memory, or do other activities taht require
+#enter suspend state. This gives drivers a chance to load firmware from
+#disk and store it in memory, or do other activities that require
 #operating userland, ability to kmalloc GFP_KERNEL, etc... All of these
-#are forbiden once the suspend dance is started.. event = ON, flags =
+#are forbidden once the suspend dance is started.. event = ON, flags =
 #PREPARE_TO_SUSPEND
 
 Apm standby -- prepare for APM event. Quiesce devices to make life
diff -ru a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
--- a/Documentation/powerpc/booting-without-of.txt	2006-07-22 15:10:38.000000000 -0400
+++ b/Documentation/powerpc/booting-without-of.txt	2006-07-22 16:39:35.000000000 -0400
@@ -573,7 +573,7 @@
 the Open Firmware client interface, those properties will be created
 by the trampoline code in the kernel's prom_init() file. For example,
 that's where you'll have to add code to detect your board model and
-set the platform number. However, when using the flatenned device-tree
+set the platform number. However, when using the flattened device-tree
 entry point, there is no prom_init() pass, and thus you have to
 provide those properties yourself.
 
@@ -689,7 +689,7 @@
 4) Note about node and property names and character set
 -------------------------------------------------------
 
-While open firmware provides more flexibe usage of 8859-1, this
+While open firmware provides more flexible usage of 8859-1, this
 specification enforces more strict rules. Nodes and properties should
 be comprised only of ASCII characters 'a' to 'z', '0' to
 '9', ',', '.', '_', '+', '#', '?', and '-'. Node names additionally
diff -ru a/Documentation/powerpc/eeh-pci-error-recovery.txt b/Documentation/powerpc/eeh-pci-error-recovery.txt
--- a/Documentation/powerpc/eeh-pci-error-recovery.txt	2006-07-22 15:10:38.000000000 -0400
+++ b/Documentation/powerpc/eeh-pci-error-recovery.txt	2006-07-22 16:40:49.000000000 -0400
@@ -116,7 +116,7 @@
 so that individual device drivers do not need to be modified to support
 EEH recovery.  This generic mechanism piggy-backs on the PCI hotplug
 infrastructure,  and percolates events up through the userspace/udev
-infrastructure.  Followiing is a detailed description of how this is
+infrastructure.  Following is a detailed description of how this is
 accomplished.
 
 EEH must be enabled in the PHB's very early during the boot process,
diff -ru a/Documentation/powerpc/hvcs.txt b/Documentation/powerpc/hvcs.txt
--- a/Documentation/powerpc/hvcs.txt	2006-07-22 15:10:38.000000000 -0400
+++ b/Documentation/powerpc/hvcs.txt	2006-07-22 17:05:00.000000000 -0400
@@ -259,7 +259,7 @@
 
 It should be noted that due to the system hotplug I/O capabilities of a
 system the /dev/hvcs* entry that interacts with a particular vty-server
-adapter is not guarenteed to remain the same across system reboots.  Look
+adapter is not guaranteed to remain the same across system reboots.  Look
 in the Q & A section for more on this issue.
 
 ---------------------------------------------------------------------------
diff -ru a/Documentation/s390/Debugging390.txt b/Documentation/s390/Debugging390.txt
--- a/Documentation/s390/Debugging390.txt	2006-07-22 15:09:50.000000000 -0400
+++ b/Documentation/s390/Debugging390.txt	2006-07-22 16:25:10.000000000 -0400
@@ -88,7 +88,7 @@
 0       0     Reserved ( must be 0 ) otherwise specification exception occurs.
 
 1       1     Program Event Recording 1 PER enabled, 
-	      PER is used to facilititate debugging e.g. single stepping.
+	      PER is used to facilitate debugging e.g. single stepping.
 
 2-4    2-4    Reserved ( must be 0 ). 
 
diff -ru a/Documentation/s390/s390dbf.txt b/Documentation/s390/s390dbf.txt
--- a/Documentation/s390/s390dbf.txt	2006-07-22 15:09:50.000000000 -0400
+++ b/Documentation/s390/s390dbf.txt	2006-07-22 16:27:42.000000000 -0400
@@ -11,7 +11,7 @@
 (e.g. device drivers) can have one separate debug log.
 One purpose of this is to inspect the debug logs after a production system crash
 in order to analyze the reason for the crash.
-If the system still runs but only a subcomponent which uses dbf failes,
+If the system still runs but only a subcomponent which uses dbf fails,
 it is possible to look at the debug logs on a live system via the Linux
 debugfs filesystem.
 The debug feature may also very useful for kernel and driver development.
diff -ru a/Documentation/scsi/aic7xxx_old.txt b/Documentation/scsi/aic7xxx_old.txt
--- a/Documentation/scsi/aic7xxx_old.txt	2006-07-22 15:09:50.000000000 -0400
+++ b/Documentation/scsi/aic7xxx_old.txt	2006-07-22 16:56:25.000000000 -0400
@@ -317,7 +317,7 @@
 	initial DEVCONFIG values for each of your aic7xxx controllers as
 	they are listed, and also record what the machine is detecting as
 	the proper termination on your controllers.  NOTE: the order in
-	which the initial DEVCONFIG values are printed out is not gauranteed
+	which the initial DEVCONFIG values are printed out is not guaranteed
 	to be the same order as the SCSI controllers are registered.  The
 	above option and this option both work on the order of the SCSI
 	controllers as they are registered, so make sure you match the right
diff -ru a/Documentation/uml/UserModeLinux-HOWTO.txt b/Documentation/uml/UserModeLinux-HOWTO.txt
--- a/Documentation/uml/UserModeLinux-HOWTO.txt	2006-07-22 15:09:50.000000000 -0400
+++ b/Documentation/uml/UserModeLinux-HOWTO.txt	2006-07-22 16:35:21.000000000 -0400
@@ -4671,7 +4671,7 @@
   Chris Reahard built a specialized root filesystem for running a DNS
   server jailed inside UML.  It's available from the download
   <http://user-mode-linux.sourceforge.net/dl-sf.html>  page in the Jail
-  Filesysems section.
+  Filesystems section.
 
 
 
diff -ru a/Documentation/watchdog/watchdog-api.txt b/Documentation/watchdog/watchdog-api.txt
--- a/Documentation/watchdog/watchdog-api.txt	2006-07-22 15:10:37.000000000 -0400
+++ b/Documentation/watchdog/watchdog-api.txt	2006-07-22 16:31:46.000000000 -0400
@@ -207,7 +207,7 @@
 support the GETBOOTSTATUS call.
 
 Some drivers can measure the temperature using the GETTEMP ioctl.  The
-returned value is the temperature in degrees farenheit.
+returned value is the temperature in degrees fahrenheit.
 
     int temperature;
     ioctl(fd, WDIOC_GETTEMP, &temperature);

