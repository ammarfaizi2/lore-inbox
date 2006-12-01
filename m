Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936539AbWLAUIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936539AbWLAUIG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 15:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759287AbWLAUIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 15:08:06 -0500
Received: from mailer-b2.gwdg.de ([134.76.10.29]:21923 "EHLO mailer-b2.gwdg.de")
	by vger.kernel.org with ESMTP id S1758823AbWLAUIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 15:08:02 -0500
Date: Fri, 1 Dec 2006 21:07:06 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Torben Mathiasen <torben.mathiasen@hp.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New updated devices.txt - LANANA
In-Reply-To: <20061201103051.GA31988@linux>
Message-ID: <Pine.LNX.4.61.0612012105250.1258@yvahk01.tjqt.qr>
References: <20061201103051.GA31988@linux>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 1 2006 11:30, Torben Mathiasen wrote:
>Here's the updated version with additonal spelling fixes.
>
>Please use this one instead of the one that was sent 2 days ago.

And here's a style update (have one free line between each, and a few 
tabs). Applies _on top_ of yours.

Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

Index: linux-2.6.19/Documentation/devices.txt
===================================================================
--- linux-2.6.19.orig/Documentation/devices.txt
+++ linux-2.6.19/Documentation/devices.txt
@@ -94,6 +94,7 @@ Your cooperation is appreciated.
 		  9 = /dev/urandom	Faster, less secure random number gen.
 		 10 = /dev/aio		Asynchronous I/O notification interface
 		 11 = /dev/kmsg		Writes to this come out as printk's
+
   1 block	RAM disk
 		  0 = /dev/ram0		First RAM disk
 		  1 = /dev/ram1		Second RAM disk
@@ -506,6 +507,7 @@ Your cooperation is appreciated.
 		 33 = /dev/patmgr1	Sequencer patch manager
 		 34 = /dev/midi02	Third MIDI port
 		 50 = /dev/midi03	Fourth MIDI port
+
  14 block	BIOS harddrive callback support {2.6}
 		  0 = /dev/dos_hda	First BIOS harddrive whole disk
 		 64 = /dev/dos_hdb	Second BIOS harddrive whole disk
@@ -527,6 +529,7 @@ Your cooperation is appreciated.
 
  16 char	Non-SCSI scanners
 		  0 = /dev/gs4500	Genius 4500 handheld scanner
+
  16 block	GoldStar CD-ROM
 		  0 = /dev/gscd		GoldStar CD-ROM
 
@@ -548,6 +551,7 @@ Your cooperation is appreciated.
 		  0 = /dev/ttyC0	First Cyclades port
 		    ...
 		 31 = /dev/ttyC31	32nd Cyclades port
+
  19 block	"Double" compressed disk
 		  0 = /dev/double0	First compressed disk
 		    ...
@@ -563,6 +567,7 @@ Your cooperation is appreciated.
 		  0 = /dev/cub0		Callout device for ttyC0
 		    ...
 		 31 = /dev/cub31	Callout device for ttyC31
+
  20 block	Hitachi CD-ROM (under development)
 		  0 = /dev/hitcd	Hitachi CD-ROM
 
@@ -639,6 +644,7 @@ Your cooperation is appreciated.
 
  26 char	Quanta WinVision frame grabber {2.6}
 		  0 = /dev/wvisfgrab	Quanta WinVision frame grabber
+
  26 block	Second Matsushita (Panasonic/SoundBlaster) CD-ROM
 		  0 = /dev/sbpcd4	Panasonic CD-ROM controller 1 unit 0
 		  1 = /dev/sbpcd5	Panasonic CD-ROM controller 1 unit 1
@@ -670,6 +676,7 @@ Your cooperation is appreciated.
 		 37 = /dev/nrawqft1	Unit 1, no rewind-on-close, no file marks
 		 38 = /dev/nrawqft2	Unit 2, no rewind-on-close, no file marks
 		 39 = /dev/nrawqft3	Unit 3, no rewind-on-close, no file marks
+
  27 block	Third Matsushita (Panasonic/SoundBlaster) CD-ROM
 		  0 = /dev/sbpcd8	Panasonic CD-ROM controller 2 unit 0
 		  1 = /dev/sbpcd9	Panasonic CD-ROM controller 2 unit 1
@@ -681,6 +688,7 @@ Your cooperation is appreciated.
 		  1 = /dev/staliomem1	Second Stallion card I/O memory
 		  2 = /dev/staliomem2	Third Stallion card I/O memory
 		  3 = /dev/staliomem3	Fourth Stallion card I/O memory
+
  28 char	Atari SLM ACSI laser printer (68k/Atari)
 		  0 = /dev/slm0		First SLM laser printer
 		  1 = /dev/slm1		Second SLM laser printer
@@ -690,6 +698,7 @@ Your cooperation is appreciated.
 		  1 = /dev/sbpcd13	Panasonic CD-ROM controller 3 unit 1
 		  2 = /dev/sbpcd14	Panasonic CD-ROM controller 3 unit 2
 		  3 = /dev/sbpcd15	Panasonic CD-ROM controller 3 unit 3
+
  28 block	ACSI disk (68k/Atari)
 		  0 = /dev/ada		First ACSI disk whole disk
 		 16 = /dev/adb		Second ACSI disk whole disk
@@ -750,6 +759,7 @@ Your cooperation is appreciated.
  31 char	MPU-401 MIDI
 		  0 = /dev/mpu401data	MPU-401 data port
 		  1 = /dev/mpu401stat	MPU-401 status port
+
  31 block	ROM/flash memory card
 		  0 = /dev/rom0		First ROM card (rw)
 		      ...
@@ -818,6 +828,7 @@ Your cooperation is appreciated.
 		129 = /dev/smpte1	Second MIDI port, SMPTE timed
 		130 = /dev/smpte2	Third MIDI port, SMPTE timed
 		131 = /dev/smpte3	Fourth MIDI port, SMPTE timed
+
  35 block	Slow memory ramdisk
 		  0 = /dev/slram	Slow memory ramdisk
 
@@ -828,6 +839,7 @@ Your cooperation is appreciated.
 		 16 = /dev/tap0		First Ethertap device
 		    ...
 		 31 = /dev/tap15	16th Ethertap device
+
  36 block	MCA ESDI hard disk
 		  0 = /dev/eda		First ESDI disk whole disk
 		 64 = /dev/edb		Second ESDI disk whole disk
@@ -882,6 +894,7 @@ Your cooperation is appreciated.
 
  40 char	Matrox Meteor frame grabber {2.6}
 		  0 = /dev/mmetfgrab	Matrox Meteor frame grabber
+
  40 block	Syquest EZ135 parallel port removable drive
 		  0 = /dev/eza		Parallel EZ135 drive, whole disk
 
@@ -893,6 +906,7 @@ Your cooperation is appreciated.
 
  41 char	Yet Another Micro Monitor
 		  0 = /dev/yamm		Yet Another Micro Monitor
+
  41 block	MicroSolutions BackPack parallel port CD-ROM
 		  0 = /dev/bpcd		BackPack CD-ROM
 
@@ -901,6 +915,7 @@ Your cooperation is appreciated.
 		the parallel port ATAPI CD-ROM driver at major number 46.
 
  42 char	Demo/sample use
+
  42 block	Demo/sample use
 
 		This number is intended for use in sample code, as
@@ -918,6 +933,7 @@ Your cooperation is appreciated.
 		  0 = /dev/ttyI0	First virtual modem
 		    ...
 		 63 = /dev/ttyI63	64th virtual modem
+
  43 block	Network block devices
 		  0 = /dev/nb0		First network block device
 		  1 = /dev/nb1		Second network block device
@@ -934,6 +950,7 @@ Your cooperation is appreciated.
 		  0 = /dev/cui0		Callout device for ttyI0
 		    ...
 		 63 = /dev/cui63	Callout device for ttyI63
+
  44 block	Flash Translation Layer (FTL) filesystems
 		  0 = /dev/ftla		FTL on first Memory Technology Device
 		 16 = /dev/ftlb		FTL on second Memory Technology Device
@@ -958,6 +975,7 @@ Your cooperation is appreciated.
 		191 = /dev/ippp63	64th SyncPPP device
 
 		255 = /dev/isdninfo	ISDN monitor interface
+
  45 block	Parallel port IDE disk devices
 		  0 = /dev/pda		First parallel port IDE disk
 		 16 = /dev/pdb		Second parallel port IDE disk
@@ -1044,6 +1062,7 @@ Your cooperation is appreciated.
 		  1 = /dev/dcbri1	Second DataComm card
 		  2 = /dev/dcbri2	Third DataComm card
 		  3 = /dev/dcbri3	Fourth DataComm card
+
  52 block	Mylex DAC960 PCI RAID controller; fifth controller
 		  0 = /dev/rd/c4d0	First disk, whole disk
 		  8 = /dev/rd/c4d1	Second disk, whole disk
@@ -1093,6 +1112,7 @@ Your cooperation is appreciated.
 
  55 char	DSP56001 digital signal processor
 		  0 = /dev/dsp56k	First DSP56001
+
  55 block	Mylex DAC960 PCI RAID controller; eighth controller
 		  0 = /dev/rd/c7d0	First disk, whole disk
 		  8 = /dev/rd/c7d1	Second disk, whole disk
@@ -1130,6 +1150,7 @@ Your cooperation is appreciated.
 		  0 = /dev/cup0		Callout device for ttyP0
 		  1 = /dev/cup1		Callout device for ttyP1
 		    ...
+
  58 block	Reserved for logical volume manager
 
  59 char	sf firewall package
@@ -1149,6 +1170,7 @@ Your cooperation is appreciated.
 		NAMING CONFLICT -- PROPOSED REVISED NAME /dev/rpda0 etc
 
  60-63 char	LOCAL/EXPERIMENTAL USE
+
  60-63 block	LOCAL/EXPERIMENTAL USE
 		Allocated for local/experimental use.  For devices not
 		assigned official numbers, these ranges should be
@@ -1434,7 +1456,6 @@ Your cooperation is appreciated.
 		DAC960 (see major number 48) except that the limit on
 		partitions is 15.
 
-
  78 char	PAM Software's multimodem boards
 		  0 = /dev/ttyM0	First PAM modem
 		  1 = /dev/ttyM1	Second PAM modem
@@ -1450,7 +1471,6 @@ Your cooperation is appreciated.
 		DAC960 (see major number 48) except that the limit on
 		partitions is 15.
 
-
  79 char	PAM Software's multimodem boards - alternate devices
 		  0 = /dev/cum0		Callout device for ttyM0
 		  1 = /dev/cum1		Callout device for ttyM1
@@ -1466,7 +1486,6 @@ Your cooperation is appreciated.
 		DAC960 (see major number 48) except that the limit on
 		partitions is 15.
 
-
  80 char	Photometrics AT200 CCD camera
 		  0 = /dev/at200	Photometrics AT200 CCD camera
 
@@ -1679,7 +1698,7 @@ Your cooperation is appreciated.
 		  1 = /dev/dcxx1	Second capture card
 		    ...
 
- 94 block IBM S/390 DASD block storage
+ 94 block	IBM S/390 DASD block storage
     		  0 = /dev/dasda First DASD device, major
     		  1 = /dev/dasda1 First DASD device, block 1
 	    	  2 = /dev/dasda2 First DASD device, block 2
@@ -1705,7 +1724,7 @@ Your cooperation is appreciated.
 		129 = /dev/npt1		Second p.p. ATAPI tape, no rewind
 		    ...
 
- 96 block Inverse NAND Flash Translation Layer
+ 96 block	Inverse NAND Flash Translation Layer
 		  0 = /dev/inftla First INFTL layer
 		 16 = /dev/inftlb Second INFTL layer
 		    ...
@@ -1937,7 +1956,6 @@ Your cooperation is appreciated.
 		    ...
 
 113 block	IBM iSeries virtual CD-ROM
-
 		  0 = /dev/iseries/vcda	First virtual CD-ROM
 		  1 = /dev/iseries/vcdb	Second virtual CD-ROM
 		    ...
@@ -2059,11 +2077,12 @@ Your cooperation is appreciated.
 		    ...
 
 119 char	VMware virtual network control
-		  0 = /dev/vnet0	1st virtual network
-		  1 = /dev/vnet1	2nd virtual network
+		  0 = /dev/vmnet0	1st virtual network
+		  1 = /dev/vmnet1	2nd virtual network
 		    ...
 
 120-127 char	LOCAL/EXPERIMENTAL USE
+
 120-127 block	LOCAL/EXPERIMENTAL USE
 		Allocated for local/experimental use.  For devices not
 		assigned official numbers, these ranges should be
@@ -2075,7 +2094,6 @@ Your cooperation is appreciated.
 		nodes; instead they should be accessed through the
 		/dev/ptmx cloning interface.
 
-
 128 block       SCSI disk devices (128-143)
                   0 = /dev/sddy         129th SCSI disk whole disk
                  16 = /dev/sddz         130th SCSI disk whole disk
@@ -2087,7 +2105,6 @@ Your cooperation is appreciated.
 		disks (see major number 3) except that the limit on
 		partitions is 15.
 
-
 129 block       SCSI disk devices (144-159)
                   0 = /dev/sdeo         145th SCSI disk whole disk
                  16 = /dev/sdep         146th SCSI disk whole disk
@@ -2123,7 +2140,6 @@ Your cooperation is appreciated.
 		disks (see major number 3) except that the limit on
 		partitions is 15.
 
-
 132 block       SCSI disk devices (192-207)
                   0 = /dev/sdgk         193rd SCSI disk whole disk
                  16 = /dev/sdgl         194th SCSI disk whole disk
@@ -2135,7 +2151,6 @@ Your cooperation is appreciated.
 		disks (see major number 3) except that the limit on
 		partitions is 15.
 
-
 133 block       SCSI disk devices (208-223)
                   0 = /dev/sdha         209th SCSI disk whole disk
                  16 = /dev/sdhb         210th SCSI disk whole disk
@@ -2147,7 +2162,6 @@ Your cooperation is appreciated.
 		disks (see major number 3) except that the limit on
 		partitions is 15.
 
-
 134 block       SCSI disk devices (224-239)
                   0 = /dev/sdhq         225th SCSI disk whole disk
                  16 = /dev/sdhr         226th SCSI disk whole disk
@@ -2159,7 +2173,6 @@ Your cooperation is appreciated.
 		disks (see major number 3) except that the limit on
 		partitions is 15.
 
-
 135 block       SCSI disk devices (240-255)
                   0 = /dev/sdig         241st SCSI disk whole disk
                  16 = /dev/sdih         242nd SCSI disk whole disk
@@ -2171,7 +2184,6 @@ Your cooperation is appreciated.
 		disks (see major number 3) except that the limit on
 		partitions is 15.
 
-
 136-143 char	Unix98 PTY slaves
 		  0 = /dev/pts/0	First Unix98 pseudo-TTY
 		  1 = /dev/pts/1	Second Unix98 pesudo-TTY
@@ -2384,6 +2396,7 @@ Your cooperation is appreciated.
 		    ...
 
 159 char	RESERVED
+
 159 block	RESERVED
 
 160 char	General Purpose Instrument Bus (GPIB)
@@ -2483,7 +2496,6 @@ Your cooperation is appreciated.
 
 171 char	Reserved for IEEE 1394 (Firewire)
 
-
 172 char	Moxa Intellio serial card
 		  0 = /dev/ttyMX0	First Moxa port
 		  1 = /dev/ttyMX1	Second Moxa port
@@ -2833,7 +2845,6 @@ Your cooperation is appreciated.
 		 82 = /dev/cuvr0		Callout device for ttyVR0
 		 83 = /dev/cuvr1		Callout device for ttyVR1
 
-
 206 char	OnStream SC-x0 tape devices
 		  0 = /dev/osst0		First OnStream SCSI tape, mode 0
 		  1 = /dev/osst1		Second OnStream SCSI tape, mode 0
@@ -2923,7 +2934,6 @@ Your cooperation is appreciated.
 		    ...
 
 212 char	LinuxTV.org DVB driver subsystem
-
 		  0 = /dev/dvb/adapter0/video0    first video decoder of first card
 		  1 = /dev/dvb/adapter0/audio0    first audio decoder of first card
 		  2 = /dev/dvb/adapter0/sec0      (obsolete/unused)
@@ -3084,12 +3094,14 @@ Your cooperation is appreciated.
 234-239		UNASSIGNED
 
 240-254 char	LOCAL/EXPERIMENTAL USE
+
 240-254 block	LOCAL/EXPERIMENTAL USE
 		Allocated for local/experimental use.  For devices not
 		assigned official numbers, these ranges should be
 		used in order to avoid conflicting with future assignments.
 
 255 char	RESERVED
+
 255 block	RESERVED
 
 		This major is reserved to assist the expansion to a
#<EOF>


	-`J'
-- 
