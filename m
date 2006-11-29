Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966877AbWK2KYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966877AbWK2KYJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 05:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966881AbWK2KYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 05:24:08 -0500
Received: from ccerelbas03.cce.hp.com ([161.114.21.106]:51611 "EHLO
	ccerelbas03.cce.hp.com") by vger.kernel.org with ESMTP
	id S966877AbWK2KYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 05:24:06 -0500
Date: Wed, 29 Nov 2006 11:21:59 +0100
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] devices.txt - LANANA merge
Message-ID: <20061129102159.GC11879@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-OS: Linux 2.6.16.21-0.21-default 
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a merge with the latest from LANANA. Its been a while, so _please_ let
me know if anyone sees unwanted changes. A few whitespaces and formatting
changes included too.

Thanks,
Torben


--- linux-2.6.19-rc6/Documentation/devices.txt	2006-11-16 05:03:40.000000000 +0100
+++ linux-2.6.19-rc6new/Documentation/devices.txt	2006-11-29 10:43:41.000000000 +0100
@@ -3,7 +3,7 @@
 
 	     Maintained by Torben Mathiasen <device@lanana.org>
 
-		      Last revised: 15 May 2006
+		      Last revised: 27 October 2006
 
 This list is the Linux Device List, the official registry of allocated
 device numbers and /dev directory nodes for the Linux operating
@@ -122,7 +122,7 @@
 		devices are on major 128 and above and use the PTY
 		master multiplex (/dev/ptmx) to acquire a PTY on
 		demand.
-  
+
   2 block	Floppy disks
 		  0 = /dev/fd0		Controller 0, drive 0, autodetect
 		  1 = /dev/fd1		Controller 0, drive 1, autodetect
@@ -257,7 +257,7 @@
 		129 = /dev/vcsa1	tty1 text/attribute contents
 		    ...
 		191 = /dev/vcsa63	tty63 text/attribute contents
-	
+
 		NOTE: These devices permit both read and write access.
 
   7 block	Loopback devices
@@ -411,7 +411,7 @@
 		207 = /dev/video/em8300_sp	EM8300 DVD decoder subpicture
 		208 = /dev/compaq/cpqphpc	Compaq PCI Hot Plug Controller
 		209 = /dev/compaq/cpqrid	Compaq Remote Insight Driver
-		210 = /dev/impi/bt	IMPI coprocessor block transfer	
+		210 = /dev/impi/bt	IMPI coprocessor block transfer
 		211 = /dev/impi/smic	IMPI coprocessor stream interface
 		212 = /dev/watchdogs/0	First watchdog device
 		213 = /dev/watchdogs/1	Second watchdog device
@@ -582,7 +582,7 @@
 
 		This device is used on the ARM-based Acorn RiscPC.
 		Partitions are handled the same way as for IDE disks
-		(see major number 3). 
+		(see major number 3).
 
  22 char	Digiboard serial card
 		  0 = /dev/ttyD0	First Digiboard port
@@ -591,7 +591,7 @@
  22 block	Second IDE hard disk/CD-ROM interface
 		  0 = /dev/hdc		Master: whole disk (or CD-ROM)
 		 64 = /dev/hdd		Slave: whole disk (or CD-ROM)
-		
+
 		Partitions are handled the same way as for the first
 		interface (see major number 3).
 
@@ -801,7 +801,7 @@
  34 block	Fourth IDE hard disk/CD-ROM interface
 		  0 = /dev/hdg		Master: whole disk (or CD-ROM)
 		 64 = /dev/hdh		Slave: whole disk (or CD-ROM)
-		
+
 		Partitions are handled the same way as for the first
 		interface (see major number 3).
 
@@ -939,7 +939,7 @@
 		 16 = /dev/ftlb		FTL on second Memory Technology Device
 		 32 = /dev/ftlc		FTL on third Memory Technology Device
 		    ...
-		240 = /dev/ftlp		FTL on 16th Memory Technology Device 
+		240 = /dev/ftlp		FTL on 16th Memory Technology Device
 
 		Partitions are handled in the same way as for IDE
 		disks (see major number 3) except that the partition
@@ -1695,7 +1695,7 @@
 		  1 = /dev/ipnat	NAT control device/log file
 		  2 = /dev/ipstate	State information log file
 		  3 = /dev/ipauth	Authentication control device/log file
-		    ...		
+		    ...
 
  96 char	Parallel port ATAPI tape devices
 		  0 = /dev/pt0		First parallel port ATAPI tape
@@ -2427,7 +2427,7 @@
 
 		Partitions are handled in the same way as for IDE
 		disks (see major number 3) except that the limit on
-		partitions is 31. 
+		partitions is 31.
 
 162 char	Raw block device interface
 		  0 = /dev/rawctl	Raw I/O control device
@@ -2543,9 +2543,6 @@
 		 64 = /dev/usb/rio500	Diamond Rio 500
 		 65 = /dev/usb/usblcd	USBLCD Interface (info@usblcd.de)
 		 66 = /dev/usb/cpad0	Synaptics cPad (mouse/LCD)
-		 67 = /dev/usb/adutux0	1st Ontrak ADU device
-		    ...
-		 76 = /dev/usb/adutux10	10th Ontrak ADU device
 		 96 = /dev/usb/hiddev0	1st USB HID device
 		    ...
 		111 = /dev/usb/hiddev15	16th USB HID device
@@ -2571,7 +2568,7 @@
 		  0 = /dev/uba		First USB block device
 		  8 = /dev/ubb		Second USB block device
 		 16 = /dev/ubc		Third USB block device
-		    ...
+ 		    ...
 
 181 char	Conrad Electronic parallel port radio clocks
 		  0 = /dev/pcfclock0	First Conrad radio clock
@@ -2657,7 +2654,7 @@
 		 32 = /dev/mvideo/status2	Third device
 		    ...
 		    ...
-		240 = /dev/mvideo/status15	16th device 
+		240 = /dev/mvideo/status15	16th device
 		    ...
 
 195 char	Nvidia graphics devices
@@ -2795,6 +2792,9 @@
 		    ...
 		 185 = /dev/ttyNX15		Hilscher netX serial port 15
 		 186 = /dev/ttyJ0		JTAG1 DCC protocol based serial port emulation
+		 187 = /dev/ttyUL0		Xilinx uartlite - port 0
+		    ...
+		 190 = /dev/ttyUL3		Xilinx uartlite - port 3
 
 205 char	Low-density serial ports (alternate device)
 		  0 = /dev/culu0		Callout device for ttyLU0
@@ -3008,9 +3008,9 @@
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
@@ -3115,7 +3115,20 @@
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
+		  1 = /dev/blockrom0	Second ROM card's translation layer interface
+		  ...
 
  ****	ADDITIONAL /dev DIRECTORY ENTRIES
 
