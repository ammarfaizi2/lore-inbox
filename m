Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265820AbUAHSla (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 13:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265939AbUAHSla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 13:41:30 -0500
Received: from bender.bawue.de ([193.7.176.20]:39369 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S265820AbUAHSlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 13:41:15 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Trivial Patch Monkey <trivial@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.1-rc3] Canonically reference files in Documentation/,
 Documentation/ part
From: Hans Ulrich Niedermann <linux-kernel@n-dimensional.de>
Date: Thu, 08 Jan 2004 19:25:41 +0100
Message-ID: <86isjm70wq.fsf@n-dimensional.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/01/07 12:41:50+01:00 kdim@n-dimensional.de 
#   Canonically reference files in Documentation/
#   All Documentation/ references in files README and Documentation/**/* adapted.
# 
# README
#   2004/01/07 12:41:42+01:00 kdim@n-dimensional.de +3 -3
#   Canonically reference files in Documentation/
# 
# Documentation/video4linux/Zoran
#   2004/01/07 12:41:42+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# Documentation/usb/usb-help.txt
#   2004/01/07 12:41:42+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# Documentation/usb/URB.txt
#   2004/01/07 12:41:42+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# Documentation/sysctl/README
#   2004/01/07 12:41:41+01:00 kdim@n-dimensional.de +2 -2
#   Canonically reference files in Documentation/
# 
# Documentation/sound/oss/PAS16
#   2004/01/07 12:41:41+01:00 kdim@n-dimensional.de +2 -2
#   Canonically reference files in Documentation/
# 
# Documentation/sound/oss/Introduction
#   2004/01/07 12:41:41+01:00 kdim@n-dimensional.de +2 -2
#   Canonically reference files in Documentation/
# 
# Documentation/sound/oss/INSTALL.awe
#   2004/01/07 12:41:41+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl
#   2004/01/07 12:41:41+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# Documentation/scsi/scsi_mid_low_api.txt
#   2004/01/07 12:41:41+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# Documentation/s390/3270.txt
#   2004/01/07 12:41:41+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# Documentation/networking/comx.txt
#   2004/01/07 12:41:41+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# Documentation/networking/Configurable
#   2004/01/07 12:41:41+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# Documentation/locks.txt
#   2004/01/07 12:41:41+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# Documentation/i386/boot.txt
#   2004/01/07 12:41:41+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# Documentation/filesystems/udf.txt
#   2004/01/07 12:41:41+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# Documentation/dvb/ttusb-dec.txt
#   2004/01/07 12:41:41+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# Documentation/dvb/firmware.txt
#   2004/01/07 12:41:41+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# Documentation/digiepca.txt
#   2004/01/07 12:41:41+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
# Documentation/computone.txt
#   2004/01/07 12:41:41+01:00 kdim@n-dimensional.de +2 -2
#   Canonically reference files in Documentation/
# 
# Documentation/cdrom/aztcd
#   2004/01/07 12:41:41+01:00 kdim@n-dimensional.de +2 -2
#   Canonically reference files in Documentation/
# 
# Documentation/arm/Booting
#   2004/01/07 12:41:41+01:00 kdim@n-dimensional.de +1 -1
#   Canonically reference files in Documentation/
# 
diff -Nru a/Documentation/arm/Booting b/Documentation/arm/Booting
--- a/Documentation/arm/Booting	Thu Jan  8 18:52:40 2004
+++ b/Documentation/arm/Booting	Thu Jan  8 18:52:40 2004
@@ -50,7 +50,7 @@
 option to the kernel via the tagged lists specifying the port, and
 serial format options as described in
 
-       linux/Documentation/kernel-parameters.txt.
+       Documentation/kernel-parameters.txt.
 
 
 3. Detect the machine type
diff -Nru a/Documentation/cdrom/aztcd b/Documentation/cdrom/aztcd
--- a/Documentation/cdrom/aztcd	Thu Jan  8 18:52:40 2004
+++ b/Documentation/cdrom/aztcd	Thu Jan  8 18:52:40 2004
@@ -1,5 +1,5 @@
 $Id: README.aztcd,v 2.60 1997/11/29 09:51:25 root Exp root $
-          Readme-File /usr/src/Documentation/cdrom/aztcd
+          Readme-File Documentation/cdrom/aztcd
            			for 
 	     AZTECH CD-ROM CDA268-01A, ORCHID CD-3110,
       OKANO/WEARNES CDD110, CONRAD TXC, CyCDROM CR520, CR540
@@ -524,7 +524,7 @@
 
 A reworked and improved version called 'cdtester.c', which has yet more
 features for testing CDROM-drives can be found in
-/usr/src/linux/Documentation/cdrom/sbpcd, written by E.Moenkeberg.
+Documentation/cdrom/sbpcd, written by E.Moenkeberg.
 
 Werner Zimmermann
 Fachhochschule fuer Technik Esslingen
diff -Nru a/Documentation/computone.txt b/Documentation/computone.txt
--- a/Documentation/computone.txt	Thu Jan  8 18:52:40 2004
+++ b/Documentation/computone.txt	Thu Jan  8 18:52:40 2004
@@ -261,7 +261,7 @@
 management of symbolic links from the devfs name space to the conventional
 names.  More details on devfs can be found on the DEVFS home site at
 <http://www.atnf.csiro.au/~rgooch/linux/> or in the file kernel
-documentation files, .../linux/Documentation/filesystems/devfs/REAME.
+documentation files, Documentation/filesystems/devfs/README.
 
 If you are using devfs, existing devices are automatically created within
 the devfs name space.  Normal devices will be tts/F0 - tts/F255 and callout
@@ -302,7 +302,7 @@
 To create the ip2mkdev shell script change to a convenient directory (/tmp
 works just fine) and run the following command:
 
-	unshar /usr/src/linux/Documentation/computone.txt
+	unshar Documentation/computone.txt
 		(This file)
 
 You should now have a file ip2mkdev in your current working directory with
diff -Nru a/Documentation/digiepca.txt b/Documentation/digiepca.txt
--- a/Documentation/digiepca.txt	Thu Jan  8 18:52:40 2004
+++ b/Documentation/digiepca.txt	Thu Jan  8 18:52:40 2004
@@ -60,7 +60,7 @@
 Supporting Tools:
 -----------------
 Supporting tools include digiDload, digiConfig, buildPCI, and ditty.  See
-/usr/src/linux/Documentation/README.epca.dir/user.doc for more details.  Note,
+Documentation/README.epca.dir/user.doc for more details.  Note,
 this driver REQUIRES that digiDload be executed prior to it being used. 
 Failure to do this will result in an ENODEV error.
 
diff -Nru a/Documentation/dvb/firmware.txt b/Documentation/dvb/firmware.txt
--- a/Documentation/dvb/firmware.txt	Thu Jan  8 18:52:40 2004
+++ b/Documentation/dvb/firmware.txt	Thu Jan  8 18:52:40 2004
@@ -2,7 +2,7 @@
 binary-only firmware.
 
 The DVB drivers will be converted to use the request_firmware()
-hotplug interface (see linux/Documentation/firmware_class/).
+hotplug interface (see Documentation/firmware_class/).
 (CONFIG_FW_LOADER)
 
 The firmware can be loaded automatically via the hotplug manager
diff -Nru a/Documentation/dvb/ttusb-dec.txt b/Documentation/dvb/ttusb-dec.txt
--- a/Documentation/dvb/ttusb-dec.txt	Thu Jan  8 18:52:40 2004
+++ b/Documentation/dvb/ttusb-dec.txt	Thu Jan  8 18:52:40 2004
@@ -43,7 +43,7 @@
 Hotplug Firmware Loading for 2.6 kernels
 ----------------------------------------
 For 2.6 kernels the firmware is loaded at the point that the driver module is
-loaded.  See linux/Documentation/dvb/firmware.txt for more information.
+loaded.  See Documentation/dvb/firmware.txt for more information.
 
 mv STB_PC_T.bin /usr/lib/hotplug/firmware/dvb-ttusb-dec-2000t-2.15a.fw
 mv STB_PC_S.bin /usr/lib/hotplug/firmware/dvb-ttusb-dec-3000s-2.15a.fw
diff -Nru a/Documentation/filesystems/udf.txt b/Documentation/filesystems/udf.txt
--- a/Documentation/filesystems/udf.txt	Thu Jan  8 18:52:40 2004
+++ b/Documentation/filesystems/udf.txt	Thu Jan  8 18:52:40 2004
@@ -1,5 +1,5 @@
 *
-* ./Documentation/filesystems/udf.txt
+* Documentation/filesystems/udf.txt
 *
 UDF Filesystem version 0.9.5
 
diff -Nru a/Documentation/i386/boot.txt b/Documentation/i386/boot.txt
--- a/Documentation/i386/boot.txt	Thu Jan  8 18:52:40 2004
+++ b/Documentation/i386/boot.txt	Thu Jan  8 18:52:40 2004
@@ -334,7 +334,7 @@
 though not all of them are actually meaningful to the kernel.  Boot
 loader authors who need additional command line options for the boot
 loader itself should get them registered in
-linux/Documentation/kernel-parameters.txt to make sure they will not
+Documentation/kernel-parameters.txt to make sure they will not
 conflict with actual kernel options now or in the future.
 
   vga=<mode>
diff -Nru a/Documentation/locks.txt b/Documentation/locks.txt
--- a/Documentation/locks.txt	Thu Jan  8 18:52:40 2004
+++ b/Documentation/locks.txt	Thu Jan  8 18:52:40 2004
@@ -19,7 +19,7 @@
 
 This should not cause problems for anybody, since everybody using a
 2.1.x kernel should have updated their C library to a suitable version
-anyway (see the file "linux/Documentation/Changes".)
+anyway (see the file "Documentation/Changes".)
 
 1.2 Allow Mixed Locks Again
 ---------------------------
diff -Nru a/Documentation/networking/Configurable b/Documentation/networking/Configurable
--- a/Documentation/networking/Configurable	Thu Jan  8 18:52:40 2004
+++ b/Documentation/networking/Configurable	Thu Jan  8 18:52:40 2004
@@ -7,7 +7,7 @@
 The current list of parameters can be found in the files:
 
 	linux/net/TUNABLE
-	linux/Documentation/networking/ip-sysctl.txt
+	Documentation/networking/ip-sysctl.txt
 
 Some of these are accessible via the sysctl interface, and many more are
 scheduled to be added in this way. For example, some parameters related 
diff -Nru a/Documentation/networking/comx.txt b/Documentation/networking/comx.txt
--- a/Documentation/networking/comx.txt	Thu Jan  8 18:52:40 2004
+++ b/Documentation/networking/comx.txt	Thu Jan  8 18:52:40 2004
@@ -148,7 +148,7 @@
 The SliceCOM board doesn't require firmware. You can have 4 of these cards
 in one machine. The driver doesn't (yet) support shared interrupts, so
 you will need a separate IRQ line for every board.
-Read linux/Documentation/networking/slicecom.txt for help on configuring
+Read Documentation/networking/slicecom.txt for help on configuring
 this adapter.
 
 THE HDLC/PPP LINE PROTOCOL DRIVER
diff -Nru a/Documentation/s390/3270.txt b/Documentation/s390/3270.txt
--- a/Documentation/s390/3270.txt	Thu Jan  8 18:52:40 2004
+++ b/Documentation/s390/3270.txt	Thu Jan  8 18:52:40 2004
@@ -117,7 +117,7 @@
 
 	Then notify /sbin/init that /etc/inittab has changed, by issuing
 	the telinit command with the q operand:
-		cd /usr/src/linux/Documentation/s390
+		cd Documentation/s390
 		sh config3270.sh
 		sh /tmp/mkdev3270
 		telinit q
diff -Nru a/Documentation/scsi/scsi_mid_low_api.txt b/Documentation/scsi/scsi_mid_low_api.txt
--- a/Documentation/scsi/scsi_mid_low_api.txt	Thu Jan  8 18:52:40 2004
+++ b/Documentation/scsi/scsi_mid_low_api.txt	Thu Jan  8 18:52:40 2004
@@ -40,7 +40,7 @@
 Documentation
 =============
 There is a SCSI documentation directory within the kernel source tree, 
-typically /usr/src/linux/Documentation/scsi . Most documents are in plain
+typically Documentation/scsi . Most documents are in plain
 (i.e. ASCII) text. This file is named scsi_mid_low_api.txt and can be 
 found in that directory. A more recent copy of this document may be found
 at http://www.torque.net/scsi/scsi_mid_low_api.txt.gz . 
diff -Nru a/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl b/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl
--- a/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl	Thu Jan  8 18:52:40 2004
+++ b/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl	Thu Jan  8 18:52:40 2004
@@ -3623,7 +3623,7 @@
 
         <para>
           More precise information can be found in
-        <filename>alsa-kernel/Documentation/sound/alsa/ControlNames.txt</filename>.
+        <filename>Documentation/sound/alsa/ControlNames.txt</filename>.
         </para>
       </section>
     </section>
diff -Nru a/Documentation/sound/oss/INSTALL.awe b/Documentation/sound/oss/INSTALL.awe
--- a/Documentation/sound/oss/INSTALL.awe	Thu Jan  8 18:52:40 2004
+++ b/Documentation/sound/oss/INSTALL.awe	Thu Jan  8 18:52:40 2004
@@ -114,7 +114,7 @@
 		# insmod awe_wave
 		(Be sure to load awe_wave after sb!)
 
-		See /usr/src/linux/Documentation/sound/oss/AWE32 for
+		See Documentation/sound/oss/AWE32 for
 		more details.
 
   9. (only for obsolete systems) If you don't have /dev/sequencer
diff -Nru a/Documentation/sound/oss/Introduction b/Documentation/sound/oss/Introduction
--- a/Documentation/sound/oss/Introduction	Thu Jan  8 18:52:40 2004
+++ b/Documentation/sound/oss/Introduction	Thu Jan  8 18:52:40 2004
@@ -24,7 +24,7 @@
 ========
 0.1.0  11/20/1998  First version, draft
 1.0.0  11/1998     Alan Cox changes, incorporation in 2.2.0
-                   as /usr/src/linux/Documentation/sound/oss/Introduction
+                   as Documentation/sound/oss/Introduction
 1.1.0  6/30/1999   Second version, added notes on making the drivers,
                    added info on multiple sound cards of similar types,]
                    added more diagnostics info, added info about esd.
@@ -439,7 +439,7 @@
 
 4)  OSS's WWW site at http://www.opensound.com.
 
-5)  All the files in linux/Documentation/sound.
+5)  All the files in Documentation/sound.
 
 6)  The comments and code in linux/drivers/sound.
 
diff -Nru a/Documentation/sound/oss/PAS16 b/Documentation/sound/oss/PAS16
--- a/Documentation/sound/oss/PAS16	Thu Jan  8 18:52:40 2004
+++ b/Documentation/sound/oss/PAS16	Thu Jan  8 18:52:40 2004
@@ -9,7 +9,7 @@
 This documentation is relevant for the PAS16 driver (pas2_card.c and
 friends) under kernel version 2.3.99 and later.  If you are
 unfamiliar with configuring sound under Linux, please read the
-Sound-HOWTO, linux/Documentation/sound/oss/Introduction and other
+Sound-HOWTO, Documentation/sound/oss/Introduction and other
 relevant docs first.
 
 The following information is relevant information from README.OSS
@@ -60,7 +60,7 @@
 
 The new stuff for 2.3.99 and later
 ============================================================================
-The following configuration options from linux/Documentation/Configure.help
+The following configuration options from Documentation/Configure.help
 are relevant to configuring the PAS16:
 
 Sound card support
diff -Nru a/Documentation/sysctl/README b/Documentation/sysctl/README
--- a/Documentation/sysctl/README	Thu Jan  8 18:52:40 2004
+++ b/Documentation/sysctl/README	Thu Jan  8 18:52:40 2004
@@ -60,11 +60,11 @@
 dev/		device specific information (eg dev/cdrom/info)
 fs/		specific filesystems
 		filehandle, inode, dentry and quota tuning
-		binfmt_misc <linux/Documentation/binfmt_misc.txt>
+		binfmt_misc <Documentation/binfmt_misc.txt>
 kernel/		global kernel info / tuning
 		miscellaneous stuff
 net/		networking stuff, for documentation look in:
-		<linux/Documentation/networking/>
+		<Documentation/networking/>
 proc/		<empty>
 sunrpc/		SUN Remote Procedure Call (NFS)
 vm/		memory management tuning
diff -Nru a/Documentation/usb/URB.txt b/Documentation/usb/URB.txt
--- a/Documentation/usb/URB.txt	Thu Jan  8 18:52:40 2004
+++ b/Documentation/usb/URB.txt	Thu Jan  8 18:52:40 2004
@@ -4,7 +4,7 @@
     NOTE:
 
     The USB subsystem now has a substantial section in "The Linux Kernel API"
-    guide (in linux/Documentation/DocBook), generated from the current source
+    guide (in Documentation/DocBook), generated from the current source
     code.  This particular documentation file isn't particularly current or
     complete; don't rely on it except for a quick overview.
 
diff -Nru a/Documentation/usb/usb-help.txt b/Documentation/usb/usb-help.txt
--- a/Documentation/usb/usb-help.txt	Thu Jan  8 18:52:40 2004
+++ b/Documentation/usb/usb-help.txt	Thu Jan  8 18:52:40 2004
@@ -2,7 +2,7 @@
 2000-July-12
 
 For USB help other than the readme files that are located in
-linux/Documentation/usb/*, see the following:
+Documentation/usb/*, see the following:
 
 Linux-USB project:  http://www.linux-usb.org
   mirrors at        http://www.suse.cz/development/linux-usb/
diff -Nru a/Documentation/video4linux/Zoran b/Documentation/video4linux/Zoran
--- a/Documentation/video4linux/Zoran	Thu Jan  8 18:52:40 2004
+++ b/Documentation/video4linux/Zoran	Thu Jan  8 18:52:40 2004
@@ -308,7 +308,7 @@
 
 Information - video4linux:
 http://roadrunner.swansea.linux.org.uk/v4lapi.shtml
-/usr/src/linux/Documentation/video4linux/API.html
+Documentation/video4linux/API.html
 /usr/include/linux/videodev.h
 
 Information - video4linux/mjpeg extensions:
diff -Nru a/README b/README
--- a/README	Thu Jan  8 18:52:40 2004
+++ b/README	Thu Jan  8 18:52:40 2004
@@ -35,7 +35,7 @@
 
  - There are various README files in the Documentation/ subdirectory:
    these typically contain kernel-specific installation notes for some 
-   drivers for example. See ./Documentation/00-INDEX for a list of what
+   drivers for example. See Documentation/00-INDEX for a list of what
    is contained in each file.  Please read the Changes file, as it
    contains information about the problems, which may result by upgrading
    your kernel.
@@ -98,7 +98,7 @@
 
    Compiling and running the 2.6.xx kernels requires up-to-date
    versions of various software packages.  Consult
-   ./Documentation/Changes for the minimum version numbers required
+   Documentation/Changes for the minimum version numbers required
    and how to get updates for these packages.  Beware that using
    excessively old versions of these packages can cause indirect
    errors that are very difficult to track down, so don't assume that
@@ -168,7 +168,7 @@
    gcc 2.91.66 (egcs-1.1.2), and gcc 2.7.2.3 are known to miscompile
    some parts of the kernel, and are *no longer supported*.
    Also remember to upgrade your binutils package (for as/ld/nm and company)
-   if necessary. For more information, refer to ./Documentation/Changes.
+   if necessary. For more information, refer to Documentation/Changes.
 
    Please note that you can still run a.out user programs with this kernel.
 
