Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUDWXLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUDWXLu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 19:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbUDWXLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 19:11:50 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:9704 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261682AbUDWXLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 19:11:08 -0400
Date: Sat, 24 Apr 2004 01:10:58 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Cc: Hans Ulrich Niedermann <linux-kernel@n-dimensional.de>
Subject: [2.6 patch] Canonically reference files in Documentation/ code comments part
Message-ID: <20040423231057.GF24948@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is an updated version of a patch by 
Hans Ulrich Niedermann <linux-kernel@n-dimensional.de> to 
change all references in comments to files in Documentation/ to start 
with Documentation/ .

diffstat output:
 Documentation/arm/Booting                                    |    2 +-
 Documentation/cdrom/aztcd                                    |    4 ++--
 Documentation/computone.txt                                  |    2 +-
 Documentation/digiepca.txt                                   |    2 +-
 Documentation/dvb/firmware.txt                               |    2 +-
 Documentation/dvb/ttusb-dec.txt                              |    2 +-
 Documentation/filesystems/udf.txt                            |    2 +-
 Documentation/i386/boot.txt                                  |    2 +-
 Documentation/locks.txt                                      |    2 +-
 Documentation/networking/Configurable                        |    2 +-
 Documentation/networking/comx.txt                            |    2 +-
 Documentation/s390/3270.txt                                  |    2 +-
 Documentation/scsi/scsi_mid_low_api.txt                      |    2 +-
 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |    2 +-
 Documentation/sound/oss/INSTALL.awe                          |    2 +-
 Documentation/sound/oss/Introduction                         |    4 ++--
 Documentation/sound/oss/PAS16                                |    4 ++--
 Documentation/sysctl/README                                  |    4 ++--
 Documentation/usb/URB.txt                                    |    2 +-
 Documentation/usb/usb-help.txt                               |    2 +-
 Documentation/video4linux/Zoran                              |    2 +-
 README                                                       |    6 +++---
 arch/alpha/kernel/srm_env.c                                  |    2 +-
 drivers/block/floppy.c                                       |    2 +-
 drivers/block/floppy98.c                                     |    2 +-
 drivers/cdrom/aztcd.c                                        |    2 +-
 drivers/cdrom/optcd.c                                        |    2 +-
 drivers/cdrom/sbpcd.c                                        |    2 +-
 drivers/cdrom/sbpcd.h                                        |    2 +-
 drivers/char/README.scc                                      |    2 +-
 drivers/char/specialix.c                                     |    2 +-
 drivers/isdn/hisax/callc.c                                   |    2 +-
 drivers/isdn/hisax/config.c                                  |    2 +-
 drivers/isdn/hisax/diva.c                                    |    2 +-
 drivers/isdn/hisax/elsa.c                                    |    2 +-
 drivers/isdn/hisax/hfc_pci.c                                 |    2 +-
 drivers/isdn/hisax/isac.c                                    |    2 +-
 drivers/isdn/hisax/isdnl1.c                                  |    2 +-
 drivers/isdn/hisax/isdnl2.c                                  |    2 +-
 drivers/isdn/hisax/isdnl3.c                                  |    2 +-
 drivers/isdn/hisax/l3_1tr6.c                                 |    2 +-
 drivers/isdn/hisax/l3dss1.c                                  |    2 +-
 drivers/isdn/hisax/tei.c                                     |    2 +-
 drivers/isdn/i4l/isdn_x25iface.c                             |    4 ++--
 drivers/net/hamradio/scc.c                                   |    2 +-
 drivers/net/tlan.c                                           |    2 +-
 drivers/pcmcia/sa1100_generic.c                              |    2 +-
 drivers/pcmcia/sa11xx_core.c                                 |    2 +-
 drivers/pcmcia/sa11xx_core.h                                 |    2 +-
 drivers/scsi/aha152x.c                                       |    2 +-
 drivers/scsi/tmscsim.c                                       |    2 +-
 drivers/usb/media/ov511.c                                    |    2 +-
 drivers/usb/misc/tiglusb.c                                   |    2 +-
 fs/locks.c                                                   |    2 +-
 include/asm-arm/cacheflush.h                                 |    2 +-
 include/asm-arm/io.h                                         |    2 +-
 include/asm-arm/setup.h                               |    2 +-
 include/asm-arm26/io.h                                       |    2 +-
 include/asm-arm26/setup.h                                    |    2 +-
 include/scsi/sg.h                                            |    2 +-
 mm/swap.c                                                    |    2 +-
 sound/oss/via82cxxx_audio.c                                  |    2 +-
 sound/oss/vwsnd.c                                            |    2 +-
 arch/arm/Kconfig                                             |    2 +-
 arch/ppc/Kconfig                                             |    2 +-
 arch/sparc64/Kconfig                                         |    6 +++---
 drivers/ieee1394/dv1394.c                                    |    2 +-
 67 files changed, 76 insertions(+), 76 deletions(-)


cu
Adrian


diff -up old-doc-2.5/include/asm-arm/cacheflush.h doc-2.5/include/asm-arm/cacheflush.h
--- old-doc-2.5/include/asm-arm/cacheflush.h	Fri Jan  9 17:25:21 2004
+++ doc-2.5/include/asm-arm/cacheflush.h	Fri Jan  9 18:11:49 2004
@@ -89,7 +89,7 @@
  *	Start addresses are inclusive and end addresses are exclusive;
  *	start addresses should be rounded down, end addresses up.
  *
- *	See linux/Documentation/cachetlb.txt for more information.
+ *	See Documentation/cachetlb.txt for more information.
  *	Please note that the implementation of these, and the required
  *	effects are cache-type (VIVT/VIPT/PIPT) specific.
  *
diff -up old-doc-2.5/include/asm-arm/setup.h doc-2.5/include/asm-arm/setup.h
--- old-doc-2.5/include/asm-arm/setup.h	Fri Jan  9 17:25:21 2004
+++ doc-2.5/include/asm-arm/setup.h	Fri Jan  9 18:11:49 2004
@@ -8,7 +8,7 @@
  * published by the Free Software Foundation.
  *
  *  Structure passed to kernel to tell it about the
- *  hardware it's running on.  See linux/Documentation/arm/Setup
+ *  hardware it's running on.  See Documentation/arm/Setup
  *  for more info.
  */
 #ifndef __ASMARM_SETUP_H
diff -up old-doc-2.5/include/asm-arm/io.h doc-2.5/include/asm-arm/io.h
--- old-doc-2.5/include/asm-arm/io.h	Fri Jan  9 17:25:21 2004
+++ doc-2.5/include/asm-arm/io.h	Fri Jan  9 18:11:49 2004
@@ -260,7 +260,7 @@ out:
  * ioremap and friends.
  *
  * ioremap takes a PCI memory address, as specified in
- * linux/Documentation/IO-mapping.txt.
+ * Documentation/IO-mapping.txt.
  */
 extern void * __ioremap(unsigned long, size_t, unsigned long, unsigned long);
 extern void __iounmap(void *addr);
diff -up old-doc-2.5/include/asm-arm26/setup.h doc-2.5/include/asm-arm26/setup.h
--- old-doc-2.5/include/asm-arm26/setup.h	Fri Jan  9 17:25:33 2004
+++ doc-2.5/include/asm-arm26/setup.h	Fri Jan  9 18:12:00 2004
@@ -8,7 +8,7 @@
  * published by the Free Software Foundation.
  *
  *  Structure passed to kernel to tell it about the
- *  hardware it's running on.  See linux/Documentation/arm/Setup
+ *  hardware it's running on.  See Documentation/arm/Setup
  *  for more info.
  */
 #ifndef __ASMARM_SETUP_H
diff -up old-doc-2.5/include/asm-arm26/io.h doc-2.5/include/asm-arm26/io.h
--- old-doc-2.5/include/asm-arm26/io.h	Fri Jan  9 17:25:33 2004
+++ doc-2.5/include/asm-arm26/io.h	Fri Jan  9 18:11:59 2004
@@ -383,7 +383,7 @@ extern void _memset_io(unsigned long, in
  * ioremap and friends.
  *
  * ioremap takes a PCI memory address, as specified in
- * linux/Documentation/IO-mapping.txt.
+ * Documentation/IO-mapping.txt.
  */
 extern void * __ioremap(unsigned long, size_t, unsigned long, unsigned long);
 extern void __iounmap(void *addr);
diff -up old-doc-2.5/include/scsi/sg.h doc-2.5/include/scsi/sg.h
--- old-doc-2.5/include/scsi/sg.h	Fri Jan  9 17:25:34 2004
+++ doc-2.5/include/scsi/sg.h	Fri Jan  9 18:12:01 2004
@@ -76,7 +76,7 @@ Major new features in SG 3.x driver (cf 
 	http://www.torque.net/sg/p/scsi-generic_long.txt
  A version of this document (potentially out of date) may also be found in
  the kernel source tree, probably at:
-        /usr/src/linux/Documentation/scsi/scsi-generic.txt .
+        Documentation/scsi/scsi-generic.txt .
 
  Utility and test programs are available at the sg web site. They are 
  bundled as sg_utils (for the lk 2.2 series) and sg3_utils (for the
diff -up old-doc-2.5/Documentation/dvb/firmware.txt doc-2.5/Documentation/dvb/firmware.txt
--- old-doc-2.5/Documentation/dvb/firmware.txt	Fri Jan  9 17:25:37 2004
+++ doc-2.5/Documentation/dvb/firmware.txt	Fri Jan  9 18:12:05 2004
@@ -2,7 +2,7 @@ Some DVB cards and many newer frontends 
 binary-only firmware.
 
 The DVB drivers will be converted to use the request_firmware()
-hotplug interface (see linux/Documentation/firmware_class/).
+hotplug interface (see Documentation/firmware_class/).
 (CONFIG_FW_LOADER)
 
 The firmware can be loaded automatically via the hotplug manager
diff -up old-doc-2.5/Documentation/arm/Booting doc-2.5/Documentation/arm/Booting
--- old-doc-2.5/Documentation/arm/Booting	Fri Jan  9 17:25:37 2004
+++ doc-2.5/Documentation/arm/Booting	Fri Jan  9 18:12:05 2004
@@ -50,7 +50,7 @@ As an alternative, the boot loader can p
 option to the kernel via the tagged lists specifying the port, and
 serial format options as described in
 
-       linux/Documentation/kernel-parameters.txt.
+       Documentation/kernel-parameters.txt.
 
 
 3. Detect the machine type
diff -up old-doc-2.5/Documentation/sysctl/README doc-2.5/Documentation/sysctl/README
--- old-doc-2.5/Documentation/sysctl/README	Fri Jan  9 17:25:38 2004
+++ doc-2.5/Documentation/sysctl/README	Fri Jan  9 18:12:06 2004
@@ -60,11 +60,11 @@ debug/		<empty>
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
diff -up old-doc-2.5/Documentation/video4linux/Zoran doc-2.5/Documentation/video4linux/Zoran
--- old-doc-2.5/Documentation/video4linux/Zoran	Fri Jan  9 17:25:38 2004
+++ doc-2.5/Documentation/video4linux/Zoran	Fri Jan  9 18:12:06 2004
@@ -308,7 +308,7 @@ details (structs/ioctls).
 
 Information - video4linux:
 http://roadrunner.swansea.linux.org.uk/v4lapi.shtml
-/usr/src/linux/Documentation/video4linux/API.html
+Documentation/video4linux/API.html
 /usr/include/linux/videodev.h
 
 Information - video4linux/mjpeg extensions:
diff -up old-doc-2.5/Documentation/i386/boot.txt doc-2.5/Documentation/i386/boot.txt
--- old-doc-2.5/Documentation/i386/boot.txt	Fri Jan  9 17:25:38 2004
+++ doc-2.5/Documentation/i386/boot.txt	Fri Jan  9 18:12:06 2004
@@ -334,7 +334,7 @@ They should normally not be deleted from
 though not all of them are actually meaningful to the kernel.  Boot
 loader authors who need additional command line options for the boot
 loader itself should get them registered in
-linux/Documentation/kernel-parameters.txt to make sure they will not
+Documentation/kernel-parameters.txt to make sure they will not
 conflict with actual kernel options now or in the future.
 
   vga=<mode>
diff -up old-doc-2.5/Documentation/networking/Configurable doc-2.5/Documentation/networking/Configurable
--- old-doc-2.5/Documentation/networking/Configurable	Fri Jan  9 17:25:39 2004
+++ doc-2.5/Documentation/networking/Configurable	Fri Jan  9 18:12:07 2004
@@ -7,7 +7,7 @@ you should be aware they do exist and ca
 The current list of parameters can be found in the files:
 
 	linux/net/TUNABLE
-	linux/Documentation/networking/ip-sysctl.txt
+	Documentation/networking/ip-sysctl.txt
 
 Some of these are accessible via the sysctl interface, and many more are
 scheduled to be added in this way. For example, some parameters related 
diff -up old-doc-2.5/Documentation/networking/comx.txt doc-2.5/Documentation/networking/comx.txt
--- old-doc-2.5/Documentation/networking/comx.txt	Fri Jan  9 17:25:39 2004
+++ doc-2.5/Documentation/networking/comx.txt	Fri Jan  9 18:12:07 2004
@@ -148,7 +148,7 @@ THE SLICECOM DRIVER
 The SliceCOM board doesn't require firmware. You can have 4 of these cards
 in one machine. The driver doesn't (yet) support shared interrupts, so
 you will need a separate IRQ line for every board.
-Read linux/Documentation/networking/slicecom.txt for help on configuring
+Read Documentation/networking/slicecom.txt for help on configuring
 this adapter.
 
 THE HDLC/PPP LINE PROTOCOL DRIVER
diff -up old-doc-2.5/Documentation/cdrom/aztcd doc-2.5/Documentation/cdrom/aztcd
--- old-doc-2.5/Documentation/cdrom/aztcd	Fri Jan  9 17:25:39 2004
+++ doc-2.5/Documentation/cdrom/aztcd	Fri Jan  9 18:12:07 2004
@@ -1,5 +1,5 @@
 $Id: README.aztcd,v 2.60 1997/11/29 09:51:25 root Exp root $
-          Readme-File /usr/src/Documentation/cdrom/aztcd
+          Readme-File Documentation/cdrom/aztcd
            			for 
 	     AZTECH CD-ROM CDA268-01A, ORCHID CD-3110,
       OKANO/WEARNES CDD110, CONRAD TXC, CyCDROM CR520, CR540
@@ -524,7 +524,7 @@ should try restoring from a backup copy 
 
 A reworked and improved version called 'cdtester.c', which has yet more
 features for testing CDROM-drives can be found in
-/usr/src/linux/Documentation/cdrom/sbpcd, written by E.Moenkeberg.
+Documentation/cdrom/sbpcd, written by E.Moenkeberg.
 
 Werner Zimmermann
 Fachhochschule fuer Technik Esslingen
diff -up old-doc-2.5/Documentation/filesystems/udf.txt doc-2.5/Documentation/filesystems/udf.txt
--- old-doc-2.5/Documentation/filesystems/udf.txt	Fri Jan  9 17:25:40 2004
+++ doc-2.5/Documentation/filesystems/udf.txt	Fri Jan  9 18:12:08 2004
@@ -1,5 +1,5 @@
 *
-* ./Documentation/filesystems/udf.txt
+* Documentation/filesystems/udf.txt
 *
 UDF Filesystem version 0.9.5
 
diff -up old-doc-2.5/Documentation/computone.txt doc-2.5/Documentation/computone.txt
--- old-doc-2.5/Documentation/computone.txt	Fri Jan  9 17:25:37 2004
+++ doc-2.5/Documentation/computone.txt	Fri Jan  9 18:12:05 2004
@@ -302,7 +302,7 @@ shar archive to make it easier to extrac
 To create the ip2mkdev shell script change to a convenient directory (/tmp
 works just fine) and run the following command:
 
-	unshar /usr/src/linux/Documentation/computone.txt
+	unshar Documentation/computone.txt
 		(This file)
 
 You should now have a file ip2mkdev in your current working directory with
diff -up old-doc-2.5/Documentation/s390/3270.txt doc-2.5/Documentation/s390/3270.txt
--- old-doc-2.5/Documentation/s390/3270.txt	Fri Jan  9 17:25:40 2004
+++ doc-2.5/Documentation/s390/3270.txt	Fri Jan  9 18:12:08 2004
@@ -117,7 +117,7 @@ Here are the installation steps in detai
 
 	Then notify /sbin/init that /etc/inittab has changed, by issuing
 	the telinit command with the q operand:
-		cd /usr/src/linux/Documentation/s390
+		cd Documentation/s390
 		sh config3270.sh
 		sh /tmp/mkdev3270
 		telinit q
diff -up old-doc-2.5/Documentation/locks.txt doc-2.5/Documentation/locks.txt
--- old-doc-2.5/Documentation/locks.txt	Fri Jan  9 17:25:37 2004
+++ doc-2.5/Documentation/locks.txt	Fri Jan  9 18:12:04 2004
@@ -19,7 +19,7 @@ forever.
 
 This should not cause problems for anybody, since everybody using a
 2.1.x kernel should have updated their C library to a suitable version
-anyway (see the file "linux/Documentation/Changes".)
+anyway (see the file "Documentation/Changes".)
 
 1.2 Allow Mixed Locks Again
 ---------------------------
diff -up old-doc-2.5/Documentation/usb/URB.txt doc-2.5/Documentation/usb/URB.txt
--- old-doc-2.5/Documentation/usb/URB.txt	Fri Jan  9 17:25:41 2004
+++ doc-2.5/Documentation/usb/URB.txt	Fri Jan  9 18:12:09 2004
@@ -4,7 +4,7 @@ Again:   2002-Jul-06
     NOTE:
 
     The USB subsystem now has a substantial section in "The Linux Kernel API"
-    guide (in linux/Documentation/DocBook), generated from the current source
+    guide (in Documentation/DocBook), generated from the current source
     code.  This particular documentation file isn't particularly current or
     complete; don't rely on it except for a quick overview.
 
diff -up old-doc-2.5/Documentation/usb/usb-help.txt doc-2.5/Documentation/usb/usb-help.txt
--- old-doc-2.5/Documentation/usb/usb-help.txt	Fri Jan  9 17:25:41 2004
+++ doc-2.5/Documentation/usb/usb-help.txt	Fri Jan  9 18:12:09 2004
@@ -2,7 +2,7 @@ usb-help.txt
 2000-July-12
 
 For USB help other than the readme files that are located in
-linux/Documentation/usb/*, see the following:
+Documentation/usb/*, see the following:
 
 Linux-USB project:  http://www.linux-usb.org
   mirrors at        http://www.suse.cz/development/linux-usb/
diff -up old-doc-2.5/Documentation/scsi/scsi_mid_low_api.txt doc-2.5/Documentation/scsi/scsi_mid_low_api.txt
--- old-doc-2.5/Documentation/scsi/scsi_mid_low_api.txt	Fri Jan  9 17:25:42 2004
+++ doc-2.5/Documentation/scsi/scsi_mid_low_api.txt	Fri Jan  9 18:12:10 2004
@@ -40,7 +40,7 @@ This version of the document roughly mat
 Documentation
 =============
 There is a SCSI documentation directory within the kernel source tree, 
-typically /usr/src/linux/Documentation/scsi . Most documents are in plain
+typically Documentation/scsi . Most documents are in plain
 (i.e. ASCII) text. This file is named scsi_mid_low_api.txt and can be 
 found in that directory. A more recent copy of this document may be found
 at http://www.torque.net/scsi/scsi_mid_low_api.txt.gz . 
diff -up old-doc-2.5/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl doc-2.5/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl
--- old-doc-2.5/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl	Fri Jan  9 17:25:43 2004
+++ doc-2.5/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl	Fri Jan  9 18:12:11 2004
@@ -3623,7 +3623,7 @@ struct _snd_pcm_runtime {
 
         <para>
           More precise information can be found in
-        <filename>alsa-kernel/Documentation/sound/alsa/ControlNames.txt</filename>.
+        <filename>Documentation/sound/alsa/ControlNames.txt</filename>.
         </para>
       </section>
     </section>
diff -up old-doc-2.5/Documentation/sound/oss/INSTALL.awe doc-2.5/Documentation/sound/oss/INSTALL.awe
--- old-doc-2.5/Documentation/sound/oss/INSTALL.awe	Fri Jan  9 17:25:43 2004
+++ doc-2.5/Documentation/sound/oss/INSTALL.awe	Fri Jan  9 18:12:11 2004
@@ -114,7 +114,7 @@ See INSTALL.RH for more details.
 		# insmod awe_wave
 		(Be sure to load awe_wave after sb!)
 
-		See /usr/src/linux/Documentation/sound/oss/AWE32 for
+		See Documentation/sound/oss/AWE32 for
 		more details.
 
   9. (only for obsolete systems) If you don't have /dev/sequencer
diff -up old-doc-2.5/Documentation/sound/oss/PAS16 doc-2.5/Documentation/sound/oss/PAS16
--- old-doc-2.5/Documentation/sound/oss/PAS16	Fri Jan  9 16:20:14 2004
+++ doc-2.5/Documentation/sound/oss/PAS16	Fri Jan  9 18:12:11 2004
@@ -9,7 +9,7 @@ and others whose names I could not find.
 This documentation is relevant for the PAS16 driver (pas2_card.c and
 friends) under kernel version 2.3.99 and later.  If you are
 unfamiliar with configuring sound under Linux, please read the
-Sound-HOWTO, linux/Documentation/sound/oss/Introduction and other
+Sound-HOWTO, Documentation/sound/oss/Introduction and other
 relevant docs first.
 
 The following information is relevant information from README.OSS
@@ -60,7 +60,7 @@ With PAS16 you can use two audio device 
 
 The new stuff for 2.3.99 and later
 ============================================================================
-The following configuration options from linux/Documentation/Configure.help
+The following configuration options from Documentation/Configure.help
 are relevant to configuring the PAS16:
 
 Sound card support
diff -up old-doc-2.5/Documentation/sound/oss/Introduction doc-2.5/Documentation/sound/oss/Introduction
--- old-doc-2.5/Documentation/sound/oss/Introduction	Fri Jan  9 17:25:43 2004
+++ doc-2.5/Documentation/sound/oss/Introduction	Fri Jan  9 18:12:12 2004
@@ -24,7 +24,7 @@ History:
 ========
 0.1.0  11/20/1998  First version, draft
 1.0.0  11/1998     Alan Cox changes, incorporation in 2.2.0
-                   as /usr/src/linux/Documentation/sound/oss/Introduction
+                   as Documentation/sound/oss/Introduction
 1.1.0  6/30/1999   Second version, added notes on making the drivers,
                    added info on multiple sound cards of similar types,]
                    added more diagnostics info, added info about esd.
@@ -439,7 +439,7 @@ For More Information (RTFM):
 
 4)  OSS's WWW site at http://www.opensound.com.
 
-5)  All the files in linux/Documentation/sound.
+5)  All the files in Documentation/sound.
 
 6)  The comments and code in linux/drivers/sound.
 
diff -up old-doc-2.5/Documentation/digiepca.txt doc-2.5/Documentation/digiepca.txt
--- old-doc-2.5/Documentation/digiepca.txt	Fri Jan  9 16:24:12 2004
+++ doc-2.5/Documentation/digiepca.txt	Fri Jan  9 18:12:04 2004
@@ -60,7 +60,7 @@ Samples:
 Supporting Tools:
 -----------------
 Supporting tools include digiDload, digiConfig, buildPCI, and ditty.  See
-/usr/src/linux/Documentation/README.epca.dir/user.doc for more details.  Note,
+drivers/char/README.epca for more details.  Note,
 this driver REQUIRES that digiDload be executed prior to it being used. 
 Failure to do this will result in an ENODEV error.
 
diff -up old-doc-2.5/mm/swap.c doc-2.5/mm/swap.c
--- old-doc-2.5/mm/swap.c	Fri Jan  9 17:25:44 2004
+++ doc-2.5/mm/swap.c	Fri Jan  9 18:12:12 2004
@@ -7,7 +7,7 @@
 /*
  * This file contains the default values for the opereation of the
  * Linux VM subsystem. Fine-tuning documentation can be found in
- * linux/Documentation/sysctl/vm.txt.
+ * Documentation/sysctl/vm.txt.
  * Started 18.12.91
  * Swap aging added 23.2.95, Stephen Tweedie.
  * Buffermem limits added 12.3.98, Rik van Riel.
diff -up old-doc-2.5/fs/locks.c doc-2.5/fs/locks.c
--- old-doc-2.5/fs/locks.c	Fri Jan  9 17:25:46 2004
+++ doc-2.5/fs/locks.c	Fri Jan  9 18:12:15 2004
@@ -60,7 +60,7 @@
  *
  *  Initial implementation of mandatory locks. SunOS turned out to be
  *  a rotten model, so I implemented the "obvious" semantics.
- *  See 'linux/Documentation/mandatory.txt' for details.
+ *  See 'Documentation/mandatory.txt' for details.
  *  Andy Walker (andy@lysaker.kvaerner.no), April 06, 1996.
  *
  *  Don't allow mandatory locks on mmap()'ed files. Added simple functions to
diff -up old-doc-2.5/arch/alpha/kernel/srm_env.c doc-2.5/arch/alpha/kernel/srm_env.c
--- old-doc-2.5/arch/alpha/kernel/srm_env.c	Fri Jan  9 17:26:35 2004
+++ doc-2.5/arch/alpha/kernel/srm_env.c	Fri Jan  9 18:13:10 2004
@@ -5,7 +5,7 @@
  * Copyright (C) 2001-2002 Jan-Benedict Glaw <jbglaw@lug-owl.de>
  *
  * This driver is at all a modified version of Erik Mouw's
- * ./linux/Documentation/DocBook/procfs_example.c, so: thank
+ * Documentation/DocBook/procfs_example.c, so: thank
  * you, Erik! He can be reached via email at
  * <J.A.K.Mouw@its.tudelft.nl>. It is based on an idea
  * provided by DEC^WCompaq^WIntel's "Jumpstart" CD. They
diff -up old-doc-2.5/README doc-2.5/README
--- old-doc-2.5/README	Fri Jan  9 17:25:03 2004
+++ doc-2.5/README	Fri Jan  9 18:11:32 2004
@@ -35,7 +35,7 @@ DOCUMENTATION:
 
  - There are various README files in the Documentation/ subdirectory:
    these typically contain kernel-specific installation notes for some 
-   drivers for example. See ./Documentation/00-INDEX for a list of what
+   drivers for example. See Documentation/00-INDEX for a list of what
    is contained in each file.  Please read the Changes file, as it
    contains information about the problems, which may result by upgrading
    your kernel.
@@ -98,7 +98,7 @@ SOFTWARE REQUIREMENTS
 
    Compiling and running the 2.6.xx kernels requires up-to-date
    versions of various software packages.  Consult
-   ./Documentation/Changes for the minimum version numbers required
+   Documentation/Changes for the minimum version numbers required
    and how to get updates for these packages.  Beware that using
    excessively old versions of these packages can cause indirect
    errors that are very difficult to track down, so don't assume that
@@ -168,7 +168,7 @@ COMPILING the kernel:
    gcc 2.91.66 (egcs-1.1.2), and gcc 2.7.2.3 are known to miscompile
    some parts of the kernel, and are *no longer supported*.
    Also remember to upgrade your binutils package (for as/ld/nm and company)
-   if necessary. For more information, refer to ./Documentation/Changes.
+   if necessary. For more information, refer to Documentation/Changes.
 
    Please note that you can still run a.out user programs with this kernel.
 
diff -up old-doc-2.5/drivers/net/hamradio/scc.c doc-2.5/drivers/net/hamradio/scc.c
--- old-doc-2.5/drivers/net/hamradio/scc.c	Fri Jan  9 17:26:52 2004
+++ doc-2.5/drivers/net/hamradio/scc.c	Fri Jan  9 18:13:27 2004
@@ -7,7 +7,7 @@
  *            ------------------
  *
  * You can find a subset of the documentation in 
- * linux/Documentation/networking/z8530drv.txt.
+ * Documentation/networking/z8530drv.txt.
  */
 
 /*
diff -up old-doc-2.5/drivers/net/tlan.c doc-2.5/drivers/net/tlan.c
--- old-doc-2.5/drivers/net/tlan.c	Fri Jan  9 17:26:50 2004
+++ doc-2.5/drivers/net/tlan.c	Fri Jan  9 18:13:25 2004
@@ -212,7 +212,7 @@ MODULE_PARM_DESC(bbuf, "ThunderLAN use b
 /* Define this to enable Link beat monitoring */
 #undef MONITOR
 
-/* Turn on debugging. See linux/Documentation/networking/tlan.txt for details */
+/* Turn on debugging. See Documentation/networking/tlan.txt for details */
 static  int		debug;
 
 static	int		bbuf;
diff -up old-doc-2.5/drivers/char/specialix.c doc-2.5/drivers/char/specialix.c
--- old-doc-2.5/drivers/char/specialix.c	Fri Jan  9 17:27:05 2004
+++ doc-2.5/drivers/char/specialix.c	Fri Jan  9 18:13:41 2004
@@ -72,7 +72,7 @@
 /*
  * There is a bunch of documentation about the card, jumpers, config
  * settings, restrictions, cables, device names and numbers in
- * ../../Documentation/specialix.txt 
+ * Documentation/specialix.txt 
  */
 
 #include <linux/config.h>
diff -up old-doc-2.5/drivers/char/README.scc doc-2.5/drivers/char/README.scc
--- old-doc-2.5/drivers/char/README.scc	Fri Jan  9 17:27:04 2004
+++ doc-2.5/drivers/char/README.scc	Fri Jan  9 18:13:39 2004
@@ -2,4 +2,4 @@ The z8530drv is now a network device dri
 	../net/scc.c
 
 A subset of the documentation is in
-	../../Documentation/networking/z8530drv.txt
+	Documentation/networking/z8530drv.txt
diff -up old-doc-2.5/drivers/cdrom/sbpcd.c doc-2.5/drivers/cdrom/sbpcd.c
--- old-doc-2.5/drivers/cdrom/sbpcd.c	Fri Jan  9 17:27:20 2004
+++ doc-2.5/drivers/cdrom/sbpcd.c	Fri Jan  9 18:13:56 2004
@@ -5715,7 +5715,7 @@ int __init sbpcd_init(void)
 	
 	if (port_index>0)
           {
-            msg(DBG_INF, "You should read linux/Documentation/cdrom/sbpcd\n");
+            msg(DBG_INF, "You should read Documentation/cdrom/sbpcd\n");
             msg(DBG_INF, "and then configure sbpcd.h for your hardware.\n");
           }
 	check_datarate();
diff -up old-doc-2.5/drivers/cdrom/optcd.c doc-2.5/drivers/cdrom/optcd.c
--- old-doc-2.5/drivers/cdrom/optcd.c	Fri Jan  9 17:27:20 2004
+++ doc-2.5/drivers/cdrom/optcd.c	Fri Jan  9 18:13:55 2004
@@ -964,7 +964,7 @@ static int update_toc(void)
 #endif /* MULTISESSION */
 	if (disk_info.multi)
 		printk(KERN_WARNING "optcd: Multisession support experimental, "
-			"see linux/Documentation/cdrom/optcd\n");
+			"see Documentation/cdrom/optcd\n");
 
 	DEBUG((DEBUG_TOC, "exiting update_toc"));
 
diff -up old-doc-2.5/drivers/cdrom/sbpcd.h doc-2.5/drivers/cdrom/sbpcd.h
--- old-doc-2.5/drivers/cdrom/sbpcd.h	Fri Jan  9 17:27:20 2004
+++ doc-2.5/drivers/cdrom/sbpcd.h	Fri Jan  9 18:13:56 2004
@@ -5,7 +5,7 @@
 /*
  * Attention! This file contains user-serviceable parts!
  * I recommend to make use of it...
- * If you feel helpless, look into linux/Documentation/cdrom/sbpcd
+ * If you feel helpless, look into Documentation/cdrom/sbpcd
  * (good idea anyway, at least before mailing me).
  *
  * The definitions for the first controller can get overridden by
diff -up old-doc-2.5/drivers/cdrom/aztcd.c doc-2.5/drivers/cdrom/aztcd.c
--- old-doc-2.5/drivers/cdrom/aztcd.c	Fri Jan  9 17:27:20 2004
+++ doc-2.5/drivers/cdrom/aztcd.c	Fri Jan  9 18:13:55 2004
@@ -129,7 +129,7 @@
                 Werner Zimmermann, August 8, 1995
         V1.70   Multisession support now is completed, but there is still not 
                 enough testing done. If you can test it, please contact me. For
-                details please read /usr/src/linux/Documentation/cdrom/aztcd
+                details please read Documentation/cdrom/aztcd
                 Werner Zimmermann, August 19, 1995
         V1.80   Modification to suit the new kernel boot procedure introduced
                 with kernel 1.3.33. Will definitely not work with older kernels.
diff -up old-doc-2.5/drivers/block/floppy98.c doc-2.5/drivers/block/floppy98.c
--- old-doc-2.5/drivers/block/floppy98.c	Fri Jan  9 17:27:25 2004
+++ doc-2.5/drivers/block/floppy98.c	Fri Jan  9 18:14:00 2004
@@ -4226,7 +4226,7 @@ static int __init floppy_setup(char *str
 		printk("\n");
 	} else
 		DPRINT("botched floppy option\n");
-	DPRINT("Read linux/Documentation/floppy.txt\n");
+	DPRINT("Read Documentation/floppy.txt\n");
 	return 0;
 }
 
diff -up old-doc-2.5/drivers/block/floppy.c doc-2.5/drivers/block/floppy.c
--- old-doc-2.5/drivers/block/floppy.c	Fri Jan  9 17:27:23 2004
+++ doc-2.5/drivers/block/floppy.c	Fri Jan  9 18:13:59 2004
@@ -4200,7 +4200,7 @@ static int __init floppy_setup(char *str
 		printk("\n");
 	} else
 		DPRINT("botched floppy option\n");
-	DPRINT("Read linux/Documentation/floppy.txt\n");
+	DPRINT("Read Documentation/floppy.txt\n");
 	return 0;
 }
 
diff -up old-doc-2.5/drivers/isdn/hisax/l3_1tr6.c doc-2.5/drivers/isdn/hisax/l3_1tr6.c
--- old-doc-2.5/drivers/isdn/hisax/l3_1tr6.c	Fri Jan  9 17:27:31 2004
+++ doc-2.5/drivers/isdn/hisax/l3_1tr6.c	Fri Jan  9 18:14:07 2004
@@ -9,7 +9,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  */
 
diff -up old-doc-2.5/drivers/isdn/hisax/isdnl2.c doc-2.5/drivers/isdn/hisax/isdnl2.c
--- old-doc-2.5/drivers/isdn/hisax/isdnl2.c	Fri Jan  9 17:27:31 2004
+++ doc-2.5/drivers/isdn/hisax/isdnl2.c	Fri Jan  9 18:14:07 2004
@@ -8,7 +8,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  * Thanks to    Jan den Ouden
  *              Fritz Elfert
diff -up old-doc-2.5/drivers/isdn/hisax/elsa.c doc-2.5/drivers/isdn/hisax/elsa.c
--- old-doc-2.5/drivers/isdn/hisax/elsa.c	Fri Jan  9 17:27:33 2004
+++ doc-2.5/drivers/isdn/hisax/elsa.c	Fri Jan  9 18:14:08 2004
@@ -9,7 +9,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  * Thanks to    Elsa GmbH for documents and information
  *
diff -up old-doc-2.5/drivers/isdn/hisax/isdnl3.c doc-2.5/drivers/isdn/hisax/isdnl3.c
--- old-doc-2.5/drivers/isdn/hisax/isdnl3.c	Fri Jan  9 17:27:32 2004
+++ doc-2.5/drivers/isdn/hisax/isdnl3.c	Fri Jan  9 18:14:07 2004
@@ -8,7 +8,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  * Thanks to    Jan den Ouden
  *              Fritz Elfert
diff -up old-doc-2.5/drivers/isdn/hisax/tei.c doc-2.5/drivers/isdn/hisax/tei.c
--- old-doc-2.5/drivers/isdn/hisax/tei.c	Fri Jan  9 17:27:31 2004
+++ doc-2.5/drivers/isdn/hisax/tei.c	Fri Jan  9 18:14:07 2004
@@ -8,7 +8,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  * Thanks to    Jan den Ouden
  *              Fritz Elfert
diff -up old-doc-2.5/drivers/isdn/hisax/isac.c doc-2.5/drivers/isdn/hisax/isac.c
--- old-doc-2.5/drivers/isdn/hisax/isac.c	Fri Jan  9 17:27:33 2004
+++ doc-2.5/drivers/isdn/hisax/isac.c	Fri Jan  9 18:14:08 2004
@@ -9,7 +9,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  */
 
diff -up old-doc-2.5/drivers/isdn/hisax/config.c doc-2.5/drivers/isdn/hisax/config.c
--- old-doc-2.5/drivers/isdn/hisax/config.c	Fri Jan  9 17:27:31 2004
+++ doc-2.5/drivers/isdn/hisax/config.c	Fri Jan  9 18:14:07 2004
@@ -8,7 +8,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  * based on the teles driver from Jan den Ouden
  *
diff -up old-doc-2.5/drivers/isdn/hisax/l3dss1.c doc-2.5/drivers/isdn/hisax/l3dss1.c
--- old-doc-2.5/drivers/isdn/hisax/l3dss1.c	Fri Jan  9 17:27:32 2004
+++ doc-2.5/drivers/isdn/hisax/l3dss1.c	Fri Jan  9 18:14:08 2004
@@ -12,7 +12,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  * Thanks to    Jan den Ouden
  *              Fritz Elfert
diff -up old-doc-2.5/drivers/isdn/hisax/hfc_pci.c doc-2.5/drivers/isdn/hisax/hfc_pci.c
--- old-doc-2.5/drivers/isdn/hisax/hfc_pci.c	Fri Jan  9 17:27:32 2004
+++ doc-2.5/drivers/isdn/hisax/hfc_pci.c	Fri Jan  9 18:14:07 2004
@@ -11,7 +11,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  */
 
diff -up old-doc-2.5/drivers/isdn/hisax/callc.c doc-2.5/drivers/isdn/hisax/callc.c
--- old-doc-2.5/drivers/isdn/hisax/callc.c	Fri Jan  9 17:27:33 2004
+++ doc-2.5/drivers/isdn/hisax/callc.c	Fri Jan  9 18:14:08 2004
@@ -7,7 +7,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  * based on the teles driver from Jan den Ouden
  *
diff -up old-doc-2.5/drivers/isdn/hisax/diva.c doc-2.5/drivers/isdn/hisax/diva.c
--- old-doc-2.5/drivers/isdn/hisax/diva.c	Fri Jan  9 17:27:31 2004
+++ doc-2.5/drivers/isdn/hisax/diva.c	Fri Jan  9 18:14:07 2004
@@ -9,7 +9,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  * Thanks to Eicon Technology for documents and information
  *
diff -up old-doc-2.5/drivers/isdn/hisax/isdnl1.c doc-2.5/drivers/isdn/hisax/isdnl1.c
--- old-doc-2.5/drivers/isdn/hisax/isdnl1.c	Fri Jan  9 17:27:31 2004
+++ doc-2.5/drivers/isdn/hisax/isdnl1.c	Fri Jan  9 18:14:07 2004
@@ -10,7 +10,7 @@
  * of the GNU General Public License, incorporated herein by reference.
  *
  * For changes and modifications please read
- * ../../../Documentation/isdn/HiSax.cert
+ * Documentation/isdn/HiSax.cert
  *
  * Thanks to    Jan den Ouden
  *              Fritz Elfert
diff -up old-doc-2.5/drivers/isdn/i4l/isdn_x25iface.c doc-2.5/drivers/isdn/i4l/isdn_x25iface.c
--- old-doc-2.5/drivers/isdn/i4l/isdn_x25iface.c	Fri Jan  9 17:27:33 2004
+++ doc-2.5/drivers/isdn/i4l/isdn_x25iface.c	Fri Jan  9 18:14:09 2004
@@ -8,7 +8,7 @@
  * stuff needed to support the Linux X.25 PLP code on top of devices that
  * can provide a lab_b service using the concap_proto mechanism.
  * This module supports a network interface wich provides lapb_sematics
- * -- as defined in ../../Documentation/networking/x25-iface.txt -- to
+ * -- as defined in Documentation/networking/x25-iface.txt -- to
  * the upper layer and assumes that the lower layer provides a reliable
  * data link service by means of the concap_device_ops callbacks.
  *
@@ -275,7 +275,7 @@ int isdn_x25iface_disconn_ind(struct con
 }
 
 /* process a frame handed over to us from linux network layer. First byte
-   semantics as defined in ../../Documentation/networking/x25-iface.txt 
+   semantics as defined in Documentation/networking/x25-iface.txt 
    */
 int isdn_x25iface_xmit(struct concap_proto *cprot, struct sk_buff *skb)
 {
diff -up old-doc-2.5/drivers/usb/misc/tiglusb.c doc-2.5/drivers/usb/misc/tiglusb.c
--- old-doc-2.5/drivers/usb/misc/tiglusb.c	Fri Jan  9 17:27:42 2004
+++ doc-2.5/drivers/usb/misc/tiglusb.c	Fri Jan  9 18:14:16 2004
@@ -10,7 +10,7 @@
  *
  * Based on dabusb.c, printer.c & scanner.c
  *
- * Please see the file: linux/Documentation/usb/SilverLink.txt
+ * Please see the file: Documentation/usb/silverlink.txt
  * and the website at:  http://lpg.ticalc.org/prj_usb/
  * for more info.
  *
diff -up old-doc-2.5/drivers/usb/media/ov511.c doc-2.5/drivers/usb/media/ov511.c
--- old-doc-2.5/drivers/usb/media/ov511.c	Fri Jan  9 17:27:42 2004
+++ doc-2.5/drivers/usb/media/ov511.c	Fri Jan  9 18:14:16 2004
@@ -16,7 +16,7 @@
  * Based on the Linux CPiA driver written by Peter Pregler,
  * Scott J. Bertin and Johannes Erdfelt.
  * 
- * Please see the file: linux/Documentation/usb/ov511.txt 
+ * Please see the file: Documentation/usb/ov511.txt 
  * and the website at:  http://alpha.dyndns.org/ov511
  * for more info.
  *
diff -up old-doc-2.5/drivers/pcmcia/sa11xx_core.c doc-2.5/drivers/pcmcia/sa11xx_core.c
--- old-doc-2.5/drivers/pcmcia/sa11xx_core.c	Fri Jan  9 17:27:47 2004
+++ doc-2.5/drivers/pcmcia/sa11xx_core.c	Fri Jan  9 18:14:21 2004
@@ -30,7 +30,7 @@
     
 ======================================================================*/
 /*
- * Please see linux/Documentation/arm/SA1100/PCMCIA for more information
+ * Please see Documentation/arm/SA1100/PCMCIA for more information
  * on the low-level kernel interface.
  */
 
diff -up old-doc-2.5/drivers/pcmcia/sa11xx_core.h doc-2.5/drivers/pcmcia/sa11xx_core.h
--- old-doc-2.5/drivers/pcmcia/sa11xx_core.h	Fri Jan  9 17:27:47 2004
+++ doc-2.5/drivers/pcmcia/sa11xx_core.h	Fri Jan  9 18:14:21 2004
@@ -4,7 +4,7 @@
  * Copyright (C) 2000 John G Dorsey <john+@cs.cmu.edu>
  *
  * This file contains definitions for the low-level SA-1100 kernel PCMCIA
- * interface. Please see linux/Documentation/arm/SA1100/PCMCIA for details.
+ * interface. Please see Documentation/arm/SA1100/PCMCIA for details.
  */
 #ifndef _ASM_ARCH_PCMCIA
 #define _ASM_ARCH_PCMCIA
diff -up old-doc-2.5/drivers/pcmcia/sa1100_generic.c doc-2.5/drivers/pcmcia/sa1100_generic.c
--- old-doc-2.5/drivers/pcmcia/sa1100_generic.c	Fri Jan  9 17:27:47 2004
+++ doc-2.5/drivers/pcmcia/sa1100_generic.c	Fri Jan  9 18:14:20 2004
@@ -30,7 +30,7 @@
     
 ======================================================================*/
 /*
- * Please see linux/Documentation/arm/SA1100/PCMCIA for more information
+ * Please see Documentation/arm/SA1100/PCMCIA for more information
  * on the low-level kernel interface.
  */
 
diff -up old-doc-2.5/drivers/scsi/aha152x.c doc-2.5/drivers/scsi/aha152x.c
--- old-doc-2.5/drivers/scsi/aha152x.c	Fri Jan  9 17:27:49 2004
+++ doc-2.5/drivers/scsi/aha152x.c	Fri Jan  9 18:14:23 2004
@@ -1814,7 +1814,7 @@ static int aha152x_biosparam(struct scsi
 				       "aha152x: unable to verify geometry for disk with >1GB.\n"
 				       "         Using default translation. Please verify yourself.\n"
 				       "         Perhaps you need to enable extended translation in the driver.\n"
-				       "         See /usr/src/linux/Documentation/scsi/aha152x.txt for details.\n");
+				       "         See Documentation/scsi/aha152x.txt for details.\n");
 			}
 		} else {
 			info_array[0] = info[0];
diff -up old-doc-2.5/drivers/scsi/tmscsim.c doc-2.5/drivers/scsi/tmscsim.c
--- old-doc-2.5/drivers/scsi/tmscsim.c	Fri Jan  9 17:27:56 2004
+++ doc-2.5/drivers/scsi/tmscsim.c	Fri Jan  9 18:14:30 2004
@@ -1469,7 +1469,7 @@ void dc390_dumpinfo (PACB pACB, PDCB pDC
     DC390_write32 (DMA_ScsiBusCtrl, EN_INT_ON_PCI_ABORT);
     PDEVSET1; PCI_READ_CONFIG_WORD(PDEV, PCI_STATUS, &pstat);
     printk ("DC390: Register dump: PCI Status: %04x\n", pstat);
-    printk ("DC390: In case of driver trouble read linux/Documentation/scsi/tmscsim.txt\n");
+    printk ("DC390: In case of driver trouble read Documentation/scsi/tmscsim.txt\n");
 }
 
 
diff -up old-doc-2.5/sound/oss/via82cxxx_audio.c doc-2.5/sound/oss/via82cxxx_audio.c
--- old-doc-2.5/sound/oss/via82cxxx_audio.c	Fri Jan  9 17:28:10 2004
+++ doc-2.5/sound/oss/via82cxxx_audio.c	Fri Jan  9 18:14:44 2004
@@ -10,7 +10,7 @@
  * NO WARRANTY
  *
  * For a list of known bugs (errata) and documentation,
- * see via-audio.pdf in linux/Documentation/DocBook.
+ * see via-audio.pdf in Documentation/DocBook.
  * If this documentation does not exist, run "make pdfdocs".
  */
 
diff -up old-doc-2.5/sound/oss/vwsnd.c doc-2.5/sound/oss/vwsnd.c
--- old-doc-2.5/sound/oss/vwsnd.c	Fri Jan  9 17:28:09 2004
+++ doc-2.5/sound/oss/vwsnd.c	Fri Jan  9 18:14:42 2004
@@ -1,6 +1,6 @@
 /*
  * Sound driver for Silicon Graphics 320 and 540 Visual Workstations'
- * onboard audio.  See notes in ../../Documentation/sound/oss/vwsnd .
+ * onboard audio.  See notes in Documentation/sound/oss/vwsnd .
  *
  * Copyright 1999 Silicon Graphics, Inc.  All rights reserved.
  *
--- linux-2.6.6-rc2-mm1-full/arch/arm/Kconfig.old	2004-04-24 00:49:19.000000000 +0200
+++ linux-2.6.6-rc2-mm1-full/arch/arm/Kconfig	2004-04-24 00:49:38.000000000 +0200
@@ -343,7 +343,7 @@
 	help
 	  This enables the CPUfreq driver for ARM Integrator CPUs.
 
-	  For details, take a look at linux/Documentation/cpu-freq.
+	  For details, take a look at <file:Documentation/cpu-freq>.
 
 	  If in doubt, say Y.
 
--- linux-2.6.6-rc2-mm1-full/arch/ppc/Kconfig.old	2004-04-24 00:53:27.000000000 +0200
+++ linux-2.6.6-rc2-mm1-full/arch/ppc/Kconfig	2004-04-24 00:53:57.000000000 +0200
@@ -163,7 +163,7 @@
 	  fly. This is a nice method to save battery power on notebooks,
 	  because the lower the clock speed, the less power the CPU consumes.
 
-	  For more information, take a look at linux/Documentation/cpu-freq or
+	  For more information, take a look at <file:Documentation/cpu-freq> or
 	  at <http://www.brodo.de/cpufreq/>
 
 	  If in doubt, say N.
--- linux-2.6.6-rc2-mm1-full/arch/sparc64/Kconfig.old	2004-04-24 00:56:24.000000000 +0200
+++ linux-2.6.6-rc2-mm1-full/arch/sparc64/Kconfig	2004-04-24 00:56:54.000000000 +0200
@@ -139,7 +139,7 @@
 	  fly.  Currently there are only sparc64 drivers for UltraSPARC-III
 	  and UltraSPARC-IIe processors.
 
-	  For details, take a look at linux/Documentation/cpu-freq.
+	  For details, take a look at <file:Documentation/cpu-freq>.
 
 	  If in doubt, say N.
 
@@ -159,7 +159,7 @@
 	help
 	  This adds the CPUFreq driver for UltraSPARC-III processors.
 
-	  For details, take a look at linux/Documentation/cpu-freq.
+	  For details, take a look at <file:Documentation/cpu-freq>.
 
 	  If in doubt, say N.
 
@@ -169,7 +169,7 @@
 	help
 	  This adds the CPUFreq driver for UltraSPARC-IIe processors.
 
-	  For details, take a look at linux/Documentation/cpu-freq.
+	  For details, take a look at <file:Documentation/cpu-freq>.
 
 	  If in doubt, say N.
 
--- linux-2.6.6-rc2-mm1-full/drivers/ieee1394/dv1394.c.old	2004-04-24 00:59:20.000000000 +0200
+++ linux-2.6.6-rc2-mm1-full/drivers/ieee1394/dv1394.c	2004-04-24 00:59:40.000000000 +0200
@@ -1322,7 +1322,7 @@
 static int dv1394_fasync(int fd, struct file *file, int on)
 {
 	/* I just copied this code verbatim from Alan Cox's mouse driver example
-	   (linux/Documentation/DocBook/) */
+	   (Documentation/DocBook/) */
 
 	struct video_card *video = file_to_video_card(file);
 
--- old-doc-2.5/Documentation/dvb/ttusb-dec.txt	Fri Jan  9 17:25:37 2004
+++ doc-2.5/Documentation/dvb/ttusb-dec.txt	Fri Jan  9 18:12:05 2004
@@ -43,7 +43,7 @@ mv STB_PC_S.bin /etc/dvb/dec3000s.bin
 Hotplug Firmware Loading for 2.6 kernels
 ----------------------------------------
 For 2.6 kernels the firmware is loaded at the point that the driver module is
-loaded.  See linux/Documentation/dvb/firmware.txt for more information.
+loaded.  See Documentation/dvb/firmware.txt for more information.
 
 mv STB_PC_T.bin /usr/lib/hotplug/firmware/dvb-ttusb-dec-2000t-2.15a.fw
 mv STB_PC_S.bin /usr/lib/hotplug/firmware/dvb-ttusb-dec-3000s-2.15a.fw
