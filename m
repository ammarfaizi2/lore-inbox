Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751473AbWHWJaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWHWJaX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 05:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWHWJaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 05:30:23 -0400
Received: from europa.telenet-ops.be ([195.130.137.75]:38580 "EHLO
	europa.telenet-ops.be") by vger.kernel.org with ESMTP
	id S1751473AbWHWJaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 05:30:21 -0400
From: Peter Korsgaard <jacmet@sunsite.dk>
To: "Mathiasen, Torben" <Torben.Mathiasen@hp.com>
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, <linux-kernel@vger.kernel.org>,
       <device@lanana.org>
Subject: Re: [PATCH] Update Documentation/devices.txt
References: <93C4769E3BED6B42B7203BD6F065654C0424F3A0@dmoexc01.emea.cpqcorp.net>
Date: Wed, 23 Aug 2006 11:29:58 +0200
In-Reply-To: <93C4769E3BED6B42B7203BD6F065654C0424F3A0@dmoexc01.emea.cpqcorp.net>
	(Torben Mathiasen's message of "Wed, 23 Aug 2006 10:41:09 +0200")
Message-ID: <87irkjn6jt.fsf@slug.be.48ers.dk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Torben" == Mathiasen, Torben <Torben.Mathiasen@hp.com> writes:

 Torben> Yeah, sorry about the slow turnaround time lately. Hopefully it will better soon :).
 Torben> Please send me a patch and I'll have it in asap.

Ok, here you go:

--- devices-2.6+.txt.orig	2006-08-23 11:07:41.000000000 +0200
+++ devices-2.6+.txt	2006-08-23 11:19:24.000000000 +0200
@@ -122,7 +122,7 @@ Your cooperation is appreciated.
 		devices are on major 128 and above and use the PTY
 		master multiplex (/dev/ptmx) to acquire a PTY on
 		demand.
-  
+
   2 block	Floppy disks
 		  0 = /dev/fd0		Controller 0, drive 0, autodetect
 		  1 = /dev/fd1		Controller 0, drive 1, autodetect
@@ -257,7 +257,7 @@ Your cooperation is appreciated.
 		129 = /dev/vcsa1	tty1 text/attribute contents
 		    ...
 		191 = /dev/vcsa63	tty63 text/attribute contents
-	
+
 		NOTE: These devices permit both read and write access.
 
   7 block	Loopback devices
@@ -411,7 +411,7 @@ Your cooperation is appreciated.
 		207 = /dev/video/em8300_sp	EM8300 DVD decoder subpicture
 		208 = /dev/compaq/cpqphpc	Compaq PCI Hot Plug Controller
 		209 = /dev/compaq/cpqrid	Compaq Remote Insight Driver
-		210 = /dev/impi/bt	IMPI coprocessor block transfer	
+		210 = /dev/impi/bt	IMPI coprocessor block transfer
 		211 = /dev/impi/smic	IMPI coprocessor stream interface
 		212 = /dev/watchdogs/0	First watchdog device
 		213 = /dev/watchdogs/1	Second watchdog device
@@ -582,7 +582,7 @@ Your cooperation is appreciated.
 
 		This device is used on the ARM-based Acorn RiscPC.
 		Partitions are handled the same way as for IDE disks
-		(see major number 3). 
+		(see major number 3).
 
  22 char	Digiboard serial card
 		  0 = /dev/ttyD0	First Digiboard port
@@ -591,7 +591,7 @@ Your cooperation is appreciated.
  22 block	Second IDE hard disk/CD-ROM interface
 		  0 = /dev/hdc		Master: whole disk (or CD-ROM)
 		 64 = /dev/hdd		Slave: whole disk (or CD-ROM)
-		
+
 		Partitions are handled the same way as for the first
 		interface (see major number 3).
 
@@ -801,7 +801,7 @@ Your cooperation is appreciated.
  34 block	Fourth IDE hard disk/CD-ROM interface
 		  0 = /dev/hdg		Master: whole disk (or CD-ROM)
 		 64 = /dev/hdh		Slave: whole disk (or CD-ROM)
-		
+
 		Partitions are handled the same way as for the first
 		interface (see major number 3).
 
@@ -939,7 +939,7 @@ Your cooperation is appreciated.
 		 16 = /dev/ftlb		FTL on second Memory Technology Device
 		 32 = /dev/ftlc		FTL on third Memory Technology Device
 		    ...
-		240 = /dev/ftlp		FTL on 16th Memory Technology Device 
+		240 = /dev/ftlp		FTL on 16th Memory Technology Device
 
 		Partitions are handled in the same way as for IDE
 		disks (see major number 3) except that the partition
@@ -1522,7 +1522,7 @@ Your cooperation is appreciated.
 		disks (see major number 3) except that the limit on
 		partitions is 15.
 
- 83 char	Matrox mga_vid video driver 
+ 83 char	Matrox mga_vid video driver
  		 0 = /dev/mga_vid0	1st video card
 		 1 = /dev/mga_vid1	2nd video card
 		 2 = /dev/mga_vid2	3rd video card
@@ -1695,7 +1695,7 @@ Your cooperation is appreciated.
 		  1 = /dev/ipnat	NAT control device/log file
 		  2 = /dev/ipstate	State information log file
 		  3 = /dev/ipauth	Authentication control device/log file
-		    ...		
+		    ...
 
  96 char	Parallel port ATAPI tape devices
 		  0 = /dev/pt0		First parallel port ATAPI tape
@@ -1731,7 +1731,7 @@ Your cooperation is appreciated.
 		  0 = /dev/ubda		First user-mode block device
 		 16 = /dev/udbb		Second user-mode block device
 		    ...
-		
+
 		Partitions are handled in the same way as for IDE
 		disks (see major number 3) except that the limit on
 		partitions is 15.
@@ -2305,7 +2305,7 @@ Your cooperation is appreciated.
 		  0 = /dev/drbd0	First DRBD device
 		  1 = /dev/drbd1	Second DRBD device
 		    ...
-		
+
 148 char	Technology Concepts serial card
 		  0 = /dev/ttyT0	First TCL port
 		  1 = /dev/ttyT1	Second TCL port
@@ -2427,7 +2427,7 @@ Your cooperation is appreciated.
 
 		Partitions are handled in the same way as for IDE
 		disks (see major number 3) except that the limit on
-		partitions is 31. 
+		partitions is 31.
 
 162 char	Raw block device interface
 		  0 = /dev/rawctl	Raw I/O control device
@@ -2565,9 +2565,9 @@ Your cooperation is appreciated.
 		243 = /dev/usb/dabusb3	Fourth dabusb device
 
 180 block	USB block devices
-		0 = /dev/uba		First USB block device
-		8 = /dev/ubb		Second USB block device
-		16 = /dev/ubc		Third USB block device
+		  0 = /dev/uba		First USB block device
+		  8 = /dev/ubb		Second USB block device
+		 16 = /dev/ubc		Third USB block device
  		    ...
 
 181 char	Conrad Electronic parallel port radio clocks
@@ -2654,7 +2654,7 @@ Your cooperation is appreciated.
 		 32 = /dev/mvideo/status2	Third device
 		    ...
 		    ...
-		240 = /dev/mvideo/status15	16th device 
+		240 = /dev/mvideo/status15	16th device
 		    ...
 
 195 char	Nvidia graphics devices
@@ -2767,7 +2767,7 @@ Your cooperation is appreciated.
 		 42 = /dev/ttySMX1		Motorola i.MX - port 1
 		 43 = /dev/ttySMX2		Motorola i.MX - port 2
 		 44 = /dev/ttyMM0		Marvell MPSC - port 0
-		 45 = /dev/ttyMM1		Marvell MPSC - port 1	
+		 45 = /dev/ttyMM1		Marvell MPSC - port 1
 		 46 = /dev/ttyCPM0		PPC CPM (SCC or SMC) - port 0
 		    ...
 		 47 = /dev/ttyCPM5		PPC CPM (SCC or SMC) - port 5
@@ -3012,7 +3012,7 @@ Your cooperation is appreciated.
 		  0 = /dev/hvc0			First console port
 		  1 = /dev/hvc1			Second console port
 		    ...
-		  
+
 230 char	IBM iSeries virtual tape
 		  0 = /dev/iseries/vt0		First virtual tape, mode 0
 		  1 = /dev/iseries/vt1		Second virtual tape, mode 0
@@ -3094,7 +3094,7 @@ Your cooperation is appreciated.
 		This major is reserved to assist the expansion to a
 		larger number space.  No device nodes with this major
 		should ever be created on the filesystem.
-		(This is probaly not true anymore, but I'll leave it 
+		(This is probably not true anymore, but I'll leave it
 		for now /Torben)
 
 ---LARGE MAJORS!!!!!---


-- 
Bye, Peter Korsgaard
