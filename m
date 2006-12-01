Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030873AbWLAMKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030873AbWLAMKV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 07:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030898AbWLAMKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 07:10:21 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:1415 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1030873AbWLAMKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 07:10:18 -0500
Date: Fri, 1 Dec 2006 11:30:51 +0100
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] New updated devices.txt - LANANA
Message-ID: <20061201103051.GA31988@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-OS: Linux 2.6.16.21-0.21-default 
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the updated version with additonal spelling fixes.

Please use this one instead of the one that was sent 2 days ago.

Thanks,
Torben



--- linux-2.6.19-rc6/Documentation/devices.txt	2006-11-16 05:03:40.000000000 +0100
+++ linux-2.6.19-rc6new/Documentation/devices.txt	2006-12-01 11:04:28.000000000 +0100
@@ -3,7 +3,7 @@
 
 	     Maintained by Torben Mathiasen <device@lanana.org>
 
-		      Last revised: 15 May 2006
+		      Last revised: 29 November 2006
 
 This list is the Linux Device List, the official registry of allocated
 device numbers and /dev directory nodes for the Linux operating
@@ -92,7 +92,7 @@ Your cooperation is appreciated.
 		  7 = /dev/full		Returns ENOSPC on write
 		  8 = /dev/random	Nondeterministic random number gen.
 		  9 = /dev/urandom	Faster, less secure random number gen.
-		 10 = /dev/aio		Asyncronous I/O notification interface
+		 10 = /dev/aio		Asynchronous I/O notification interface
 		 11 = /dev/kmsg		Writes to this come out as printk's
   1 block	RAM disk
 		  0 = /dev/ram0		First RAM disk
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
@@ -1093,7 +1093,7 @@ Your cooperation is appreciated.
 
  55 char	DSP56001 digital signal processor
 		  0 = /dev/dsp56k	First DSP56001
- 55 block	Mylex DAC960 PCI RAID controller; eigth controller
+ 55 block	Mylex DAC960 PCI RAID controller; eighth controller
 		  0 = /dev/rd/c7d0	First disk, whole disk
 		  8 = /dev/rd/c7d1	Second disk, whole disk
 		    ...
@@ -1456,7 +1456,7 @@ Your cooperation is appreciated.
 		  1 = /dev/cum1		Callout device for ttyM1
 		    ...
 
- 79 block	Compaq Intelligent Drive Array, eigth controller
+ 79 block	Compaq Intelligent Drive Array, eighth controller
 		  0 = /dev/ida/c7d0	First logical drive whole disk
 		 16 = /dev/ida/c7d1	Second logical drive whole disk
 		    ...
@@ -1695,7 +1695,7 @@ Your cooperation is appreciated.
 		  1 = /dev/ipnat	NAT control device/log file
 		  2 = /dev/ipstate	State information log file
 		  3 = /dev/ipauth	Authentication control device/log file
-		    ...		
+		    ...
 
  96 char	Parallel port ATAPI tape devices
 		  0 = /dev/pt0		First parallel port ATAPI tape
@@ -1900,7 +1900,7 @@ Your cooperation is appreciated.
 		  1 = /dev/av1		Second A/V card
 		    ...
 
-111 block	Compaq Next Generation Drive Array, eigth controller
+111 block	Compaq Next Generation Drive Array, eighth controller
 		  0 = /dev/cciss/c7d0	First logical drive, whole disk
 		 16 = /dev/cciss/c7d1	Second logical drive, whole disk
 		    ...
@@ -2427,7 +2427,7 @@ Your cooperation is appreciated.
 
 		Partitions are handled in the same way as for IDE
 		disks (see major number 3) except that the limit on
-		partitions is 31. 
+		partitions is 31.
 
 162 char	Raw block device interface
 		  0 = /dev/rawctl	Raw I/O control device
@@ -2543,9 +2543,6 @@ Your cooperation is appreciated.
 		 64 = /dev/usb/rio500	Diamond Rio 500
 		 65 = /dev/usb/usblcd	USBLCD Interface (info@usblcd.de)
 		 66 = /dev/usb/cpad0	Synaptics cPad (mouse/LCD)
-		 67 = /dev/usb/adutux0	1st Ontrak ADU device
-		    ...
-		 76 = /dev/usb/adutux10	10th Ontrak ADU device
 		 96 = /dev/usb/hiddev0	1st USB HID device
 		    ...
 		111 = /dev/usb/hiddev15	16th USB HID device
@@ -2558,7 +2555,7 @@ Your cooperation is appreciated.
 		132 = /dev/usb/idmouse	ID Mouse (fingerprint scanner) device
 		133 = /dev/usb/sisusbvga1	First SiSUSB VGA device
 		    ...
-		140 = /dev/usb/sisusbvga8	Eigth SISUSB VGA device
+		140 = /dev/usb/sisusbvga8	Eighth SISUSB VGA device
 		144 = /dev/usb/lcd	USB LCD device
 		160 = /dev/usb/legousbtower0	1st USB Legotower device
 		    ...
@@ -2571,7 +2568,7 @@ Your cooperation is appreciated.
 		  0 = /dev/uba		First USB block device
 		  8 = /dev/ubb		Second USB block device
 		 16 = /dev/ubc		Third USB block device
-		    ...
+ 		    ...
 
 181 char	Conrad Electronic parallel port radio clocks
 		  0 = /dev/pcfclock0	First Conrad radio clock
@@ -2657,7 +2654,7 @@ Your cooperation is appreciated.
 		 32 = /dev/mvideo/status2	Third device
 		    ...
 		    ...
-		240 = /dev/mvideo/status15	16th device 
+		240 = /dev/mvideo/status15	16th device
 		    ...
 
 195 char	Nvidia graphics devices
@@ -2795,6 +2792,10 @@ Your cooperation is appreciated.
 		    ...
 		 185 = /dev/ttyNX15		Hilscher netX serial port 15
 		 186 = /dev/ttyJ0		JTAG1 DCC protocol based serial port emulation
+		 187 = /dev/ttyUL0		Xilinx uartlite - port 0
+		    ...
+		 190 = /dev/ttyUL3		Xilinx uartlite - port 3
+		 191 = /dev/xvc0		Xen virtual console - port 0
 
 205 char	Low-density serial ports (alternate device)
 		  0 = /dev/culu0		Callout device for ttyLU0
@@ -3008,9 +3009,9 @@ Your cooperation is appreciated.
 		  2 = /dev/3270/tub2		Second 3270 terminal
 		    ...
 
-229 char	IBM iSeries virtual console
-		  0 = /dev/iseries/vtty0	First console port
-		  1 = /dev/iseries/vtty1	Second console port
+229 char	IBM iSeries/pSeries virtual console
+		  0 = /dev/hvc0			First console port
+		  1 = /dev/hvc1			Second console port
 		    ...
 
 230 char	IBM iSeries virtual tape
@@ -3115,7 +3116,20 @@ Your cooperation is appreciated.
 257 char	Phoenix Technologies Cryptographic Services Driver
 		  0 = /dev/ptlsec	Crypto Services Driver
 
-
+257 block	SSFDC Flash Translation Layer filesystem
+		  0 = /dev/ssfdca	First SSFDC layer
+		  8 = /dev/ssfdcb	Second SSFDC layer
+		 16 = /dev/ssfdcc	Third SSFDC layer
+		 24 = /dev/ssfdcd	4th SSFDC layer
+		 32 = /dev/ssfdce	5th SSFDC layer
+		 40 = /dev/ssfdcf	6th SSFDC layer
+		 48 = /dev/ssfdcg	7th SSFDC layer
+		 56 = /dev/ssfdch	8th SSFDC layer
+
+258 block	ROM/Flash read-only translation layer
+		  0 = /dev/blockrom0	First ROM card's translation layer interface
+		  1 = /dev/blockrom1	Second ROM card's translation layer interface
+		  ...
 
  ****	ADDITIONAL /dev DIRECTORY ENTRIES
 
