Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWHVPIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWHVPIT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 11:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWHVPIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 11:08:19 -0400
Received: from europa.telenet-ops.be ([195.130.137.75]:56984 "EHLO
	europa.telenet-ops.be") by vger.kernel.org with ESMTP
	id S932298AbWHVPIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 11:08:18 -0400
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linux-kernel@vger.kernel.org
Cc: device@lanana.org
Subject: [PATCH] Update Documentation/devices.txt
Date: Tue, 22 Aug 2006 17:08:13 +0200
Message-ID: <87d5aserky.fsf@slug.be.48ers.dk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sync Documentation/devices.txt with the new version from the LANANA
site (http://www.lanana.org/docs/device-list/devices-2.6+.txt)

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

diff -urpN linux-2.6.18-rc4.orig/Documentation/devices.txt linux-2.6.18-rc4/Documentation/devices.txt
--- linux-2.6.18-rc4.orig/Documentation/devices.txt	2006-08-22 16:58:14.000000000 +0200
+++ linux-2.6.18-rc4/Documentation/devices.txt	2006-08-22 16:57:21.000000000 +0200
@@ -3,7 +3,7 @@
 
 	     Maintained by Torben Mathiasen <device@lanana.org>
 
-		      Last revised: 15 May 2006
+		      Last revised: 21 August 2006
 
 This list is the Linux Device List, the official registry of allocated
 device numbers and /dev directory nodes for the Linux operating
@@ -1522,7 +1522,7 @@ Your cooperation is appreciated.
 		disks (see major number 3) except that the limit on
 		partitions is 15.
 
- 83 char	Matrox mga_vid video driver
+ 83 char	Matrox mga_vid video driver 
  		 0 = /dev/mga_vid0	1st video card
 		 1 = /dev/mga_vid1	2nd video card
 		 2 = /dev/mga_vid2	3rd video card
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
@@ -2565,10 +2565,10 @@ Your cooperation is appreciated.
 		243 = /dev/usb/dabusb3	Fourth dabusb device
 
 180 block	USB block devices
-		  0 = /dev/uba		First USB block device
-		  8 = /dev/ubb		Second USB block device
-		 16 = /dev/ubc		Third USB block device
-		    ...
+		0 = /dev/uba		First USB block device
+		8 = /dev/ubb		Second USB block device
+		16 = /dev/ubc		Third USB block device
+ 		    ...
 
 181 char	Conrad Electronic parallel port radio clocks
 		  0 = /dev/pcfclock0	First Conrad radio clock
@@ -2767,7 +2767,7 @@ Your cooperation is appreciated.
 		 42 = /dev/ttySMX1		Motorola i.MX - port 1
 		 43 = /dev/ttySMX2		Motorola i.MX - port 2
 		 44 = /dev/ttyMM0		Marvell MPSC - port 0
-		 45 = /dev/ttyMM1		Marvell MPSC - port 1
+		 45 = /dev/ttyMM1		Marvell MPSC - port 1	
 		 46 = /dev/ttyCPM0		PPC CPM (SCC or SMC) - port 0
 		    ...
 		 47 = /dev/ttyCPM5		PPC CPM (SCC or SMC) - port 5
@@ -2792,6 +2792,9 @@ Your cooperation is appreciated.
 		    ...
 		 185 = /dev/ttyNX15		Hilscher netX serial port 15
 		 186 = /dev/ttyJ0		JTAG1 DCC protocol based serial port emulation
+		 187 = /dev/ttyUL0		Xilinx uartlite - port 0
+		    ...
+		 190 = /dev/ttyUL3		Xilinx uartlite - port 3
 
 205 char	Low-density serial ports (alternate device)
 		  0 = /dev/culu0		Callout device for ttyLU0
@@ -3005,11 +3008,11 @@ Your cooperation is appreciated.
 		  2 = /dev/3270/tub2		Second 3270 terminal
 		    ...
 
-229 char	IBM iSeries virtual console
-		  0 = /dev/iseries/vtty0	First console port
-		  1 = /dev/iseries/vtty1	Second console port
+229 char	IBM iSeries/pSeries virtual console
+		  0 = /dev/hvc0			First console port
+		  1 = /dev/hvc1			Second console port
 		    ...
-
+		  
 230 char	IBM iSeries virtual tape
 		  0 = /dev/iseries/vt0		First virtual tape, mode 0
 		  1 = /dev/iseries/vt1		Second virtual tape, mode 0
@@ -3091,7 +3094,7 @@ Your cooperation is appreciated.
 		This major is reserved to assist the expansion to a
 		larger number space.  No device nodes with this major
 		should ever be created on the filesystem.
-		(This is probaly not true anymore, but I'll leave it
+		(This is probaly not true anymore, but I'll leave it 
 		for now /Torben)
 
 ---LARGE MAJORS!!!!!---

-- 
Bye, Peter Korsgaard
