Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbVKTEHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVKTEHg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 23:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVKTEHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 23:07:36 -0500
Received: from xenotime.net ([66.160.160.81]:53656 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751114AbVKTEHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 23:07:35 -0500
Date: Sat, 19 Nov 2005 20:07:53 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, davem@davemloft.net, gregkh <greg@kroah.com>
Subject: kernel Doc/ URL corrections
Message-Id: <20051119200753.0eda47d0.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Correct lots of URLs in Documentation/
Also a few minor whitespace cleanups and typo/spello fixes.
Sadly there are still a lot of bad URLs remaining.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 Documentation/arm/VFP/release-notes.txt |    2 
 Documentation/dvb/faq.txt               |    1 
 Documentation/filesystems/affs.txt      |    2 
 Documentation/filesystems/ext2.txt      |    3 -
 Documentation/floppy.txt                |   10 +--
 Documentation/input/iforce-protocol.txt |    1 
 Documentation/ioctl-number.txt          |    2 
 Documentation/kernel-docs.txt           |   60 ++++++++++++----------
 Documentation/mca.txt                   |    2 
 Documentation/networking/driver.txt     |    5 -
 Documentation/networking/iphase.txt     |    2 
 Documentation/networking/irda.txt       |    8 --
 Documentation/networking/ray_cs.txt     |    3 -
 Documentation/networking/vortex.txt     |   28 +++++-----
 Documentation/power/pci.txt             |    2 
 Documentation/scsi/ibmmca.txt           |    4 -
 Documentation/usb/ibmcam.txt            |    4 -
 Documentation/usb/ov511.txt             |    4 -
 Documentation/usb/rio.txt               |    6 +-
 Documentation/video4linux/zr36120.txt   |    7 +-
 20 files changed, 79 insertions(+), 77 deletions(-)

diff -Naurp linux-2615-rc1-g6/Documentation/arm/VFP/release-notes.txt~docco_urls linux-2615-rc1-g6/Documentation/arm/VFP/release-notes.txt
--- linux-2615-rc1-g6/Documentation/arm/VFP/release-notes.txt~docco_urls	2005-10-27 17:02:08.000000000 -0700
+++ linux-2615-rc1-g6/Documentation/arm/VFP/release-notes.txt	2005-11-19 16:59:08.000000000 -0800
@@ -12,7 +12,7 @@ This release has been validated against 
 John R. Hauser using the TestFloat-2a test suite.  Details of this
 library and test suite can be found at:
 
-   http://www.cs.berkeley.edu/~jhauser/arithmetic/SoftFloat.html
+   http://www.jhauser.us/arithmetic/SoftFloat.html
 
 The operations which have been tested with this package are:
 
diff -Naurp linux-2615-rc1-g6/Documentation/dvb/faq.txt~docco_urls linux-2615-rc1-g6/Documentation/dvb/faq.txt
--- linux-2615-rc1-g6/Documentation/dvb/faq.txt~docco_urls	2005-10-27 17:02:08.000000000 -0700
+++ linux-2615-rc1-g6/Documentation/dvb/faq.txt	2005-11-19 17:00:08.000000000 -0800
@@ -60,7 +60,6 @@ Some very frequently asked questions abo
 		Metzler Bros. DVB development; alternate drivers and
 		DVB utilities, include dvb-mpegtools and tuxzap.
 
-	http://www.linuxstb.org/
 	http://sourceforge.net/projects/dvbtools/
 		Dave Chapman's dvbtools package, including
 		dvbstream and dvbtune
diff -Naurp linux-2615-rc1-g6/Documentation/filesystems/affs.txt~docco_urls linux-2615-rc1-g6/Documentation/filesystems/affs.txt
--- linux-2615-rc1-g6/Documentation/filesystems/affs.txt~docco_urls	2005-10-27 17:02:08.000000000 -0700
+++ linux-2615-rc1-g6/Documentation/filesystems/affs.txt	2005-11-19 17:00:51.000000000 -0800
@@ -216,4 +216,4 @@ due to an incompatibility with the Amiga
 
 If you are interested in an Amiga Emulator for Linux, look at
 
-http://www-users.informatik.rwth-aachen.de/~crux/uae.html
+http://www.freiburg.linux.de/~uae/
diff -Naurp linux-2615-rc1-g6/Documentation/filesystems/ext2.txt~docco_urls linux-2615-rc1-g6/Documentation/filesystems/ext2.txt
--- linux-2615-rc1-g6/Documentation/filesystems/ext2.txt~docco_urls	2005-11-18 21:23:58.000000000 -0800
+++ linux-2615-rc1-g6/Documentation/filesystems/ext2.txt	2005-11-19 17:12:13.000000000 -0800
@@ -369,9 +369,8 @@ The kernel source	file:/usr/src/linux/fs
 e2fsprogs (e2fsck)	http://e2fsprogs.sourceforge.net/
 Design & Implementation	http://e2fsprogs.sourceforge.net/ext2intro.html
 Journaling (ext3)	ftp://ftp.uk.linux.org/pub/linux/sct/fs/jfs/
-Hashed Directories	http://kernelnewbies.org/~phillips/htree/
 Filesystem Resizing	http://ext2resize.sourceforge.net/
-Compression (*)		http://www.netspace.net.au/~reiter/e2compr/
+Compression (*)		http://e2compr.sourceforge.net/
 
 Implementations for:
 Windows 95/98/NT/2000	http://uranus.it.swin.edu.au/~jn/linux/Explore2fs.htm
diff -Naurp linux-2615-rc1-g6/Documentation/input/iforce-protocol.txt~docco_urls linux-2615-rc1-g6/Documentation/input/iforce-protocol.txt
--- linux-2615-rc1-g6/Documentation/input/iforce-protocol.txt~docco_urls	2005-10-27 17:02:08.000000000 -0700
+++ linux-2615-rc1-g6/Documentation/input/iforce-protocol.txt	2005-11-19 17:29:39.000000000 -0800
@@ -247,7 +247,6 @@ Check www.immerse.com for Immersion Stud
 
 ** Author of this document **
 Johann Deneux <deneux@ifrance.com>
-Home page at http://www.esil.univ-mrs.fr/~jdeneux/projects/ff/
 
 Additions by Vojtech Pavlik.
 
diff -Naurp linux-2615-rc1-g6/Documentation/networking/driver.txt~docco_urls linux-2615-rc1-g6/Documentation/networking/driver.txt
--- linux-2615-rc1-g6/Documentation/networking/driver.txt~docco_urls	2005-10-27 17:02:08.000000000 -0700
+++ linux-2615-rc1-g6/Documentation/networking/driver.txt	2005-11-19 19:17:10.000000000 -0800
@@ -1,7 +1,4 @@
-Documents about softnet driver issues in general can be found
-at:
-
-	http://www.firstfloor.org/~andi/softnet/
+Document about softnet driver issues
 
 Transmit path guidelines:
 
diff -Naurp linux-2615-rc1-g6/Documentation/networking/iphase.txt~docco_urls linux-2615-rc1-g6/Documentation/networking/iphase.txt
--- linux-2615-rc1-g6/Documentation/networking/iphase.txt~docco_urls	2005-10-27 17:02:08.000000000 -0700
+++ linux-2615-rc1-g6/Documentation/networking/iphase.txt	2005-11-19 19:18:19.000000000 -0800
@@ -22,7 +22,7 @@ The features and limitations of this dri
     - All variants of Interphase ATM PCI (i)Chip adapter cards are supported, 
       including x575 (OC3, control memory 128K , 512K and packet memory 128K, 
       512K and 1M), x525 (UTP25) and x531 (DS3 and E3). See 
-           http://www.iphase.com/products/ClassSheet.cfm?ClassID=ATM 
+      http://www.iphase.com/site/iphase-web/?epi_menuItemID=e196f04b4b3b40502f150882e21046a0
       for details.
     - Only x86 platforms are supported.
     - SMP is supported.
diff -Naurp linux-2615-rc1-g6/Documentation/networking/irda.txt~docco_urls linux-2615-rc1-g6/Documentation/networking/irda.txt
--- linux-2615-rc1-g6/Documentation/networking/irda.txt~docco_urls	2005-10-27 17:02:08.000000000 -0700
+++ linux-2615-rc1-g6/Documentation/networking/irda.txt	2005-11-19 19:19:58.000000000 -0800
@@ -3,12 +3,8 @@ of the IrDA Utilities. More detailed inf
 programs can be found on http://irda.sourceforge.net/
 
 For more information about how to use the IrDA protocol stack, see the
-Linux Infared HOWTO (http://www.tuxmobil.org/Infrared-HOWTO/Infrared-HOWTO.html)
-by Werner Heuser <wehe@tuxmobil.org>
+Linux Infrared HOWTO by Werner Heuser <wehe@tuxmobil.org>:
+<http://www.tuxmobil.org/Infrared-HOWTO/Infrared-HOWTO.html>
 
 There is an active mailing list for discussing Linux-IrDA matters called
     irda-users@lists.sourceforge.net
-
-
-
-
diff -Naurp linux-2615-rc1-g6/Documentation/networking/ray_cs.txt~docco_urls linux-2615-rc1-g6/Documentation/networking/ray_cs.txt
--- linux-2615-rc1-g6/Documentation/networking/ray_cs.txt~docco_urls	2005-10-27 17:02:08.000000000 -0700
+++ linux-2615-rc1-g6/Documentation/networking/ray_cs.txt	2005-11-19 19:25:54.000000000 -0800
@@ -29,8 +29,7 @@ with nondefault parameters, they can be 
 will find them all.
 
 Information on card services is available at:
-	ftp://hyper.stanford.edu/pub/pcmcia/doc
-        http://hyper.stanford.edu/HyperNews/get/pcmcia/home.html
+	http://pcmcia-cs.sourceforge.net/
 
 
 Card services user programs are still required for PCMCIA devices.
diff -Naurp linux-2615-rc1-g6/Documentation/networking/vortex.txt~docco_urls linux-2615-rc1-g6/Documentation/networking/vortex.txt
--- linux-2615-rc1-g6/Documentation/networking/vortex.txt~docco_urls	2005-10-27 17:02:08.000000000 -0700
+++ linux-2615-rc1-g6/Documentation/networking/vortex.txt	2005-11-19 19:37:21.000000000 -0800
@@ -11,7 +11,7 @@ The driver was written by Donald Becker 
 Don is no longer the prime maintainer of this version of the driver. 
 Please report problems to one or more of:
 
-  Andrew Morton <andrewm@uow.edu.au>
+  Andrew Morton <akpm@osdl.org>
   Netdev mailing list <netdev@vger.kernel.org>
   Linux kernel mailing list <linux-kernel@vger.kernel.org>
 
@@ -274,24 +274,24 @@ Details of the device driver implementat
 
 Additional documentation is available at Don Becker's Linux Drivers site:
 
-  http://www.scyld.com/network/vortex.html
+     http://www.scyld.com/vortex.html
 
 Donald Becker's driver development site:
 
-     http://www.scyld.com/network
+     http://www.scyld.com/network.html
 
 Donald's vortex-diag program is useful for inspecting the NIC's state:
 
-     http://www.scyld.com/diag/#pci-diags
+     http://www.scyld.com/ethercard_diag.html
 
 Donald's mii-diag program may be used for inspecting and manipulating
 the NIC's Media Independent Interface subsystem:
 
-     http://www.scyld.com/diag/#mii-diag
+     http://www.scyld.com/ethercard_diag.html#mii-diag
 
 Donald's wake-on-LAN page:
 
-     http://www.scyld.com/expert/wake-on-lan.html
+     http://www.scyld.com/wakeonlan.html
 
 3Com's documentation for many NICs, including the ones supported by
 this driver is available at 
@@ -305,7 +305,7 @@ this driver is available at 
 Driver updates and a detailed changelog for the modifications which
 were made for the 2.3/2,4 series kernel is available at
 
-     http://www.uow.edu.au/~andrewm/linux/#3c59x-2.3
+     http://www.zip.com.au/~akpm/linux/#3c59x-bc
 
 
 Autonegotiation notes
@@ -434,8 +434,8 @@ steps you should take:
          send all logs to the maintainer.
 
       3) Download you card's diagnostic tool from Donald
-         Backer's website http://www.scyld.com/diag.  Download
-         mii-diag.c as well.  Build these.
+         Becker's website <http://www.scyld.com/ethercard_diag.html>.
+         Download mii-diag.c as well.  Build these.
 
          a) Run 'vortex-diag -aaee' and 'mii-diag -v' when the card is
             working correctly.  Save the output.
@@ -443,8 +443,8 @@ steps you should take:
          b) Run the above commands when the card is malfunctioning.  Send
             both sets of output.
 
-Finally, please be patient and be prepared to do some work.  You may end up working on
-this problem for a week or more as the maintainer asks more questions, asks for more
-tests, asks for patches to be applied, etc.  At the end of it all, the problem may even
-remain unresolved.
-
+Finally, please be patient and be prepared to do some work.  You may
+end up working on this problem for a week or more as the maintainer
+asks more questions, asks for more tests, asks for patches to be
+applied, etc.  At the end of it all, the problem may even remain
+unresolved.
diff -Naurp linux-2615-rc1-g6/Documentation/power/pci.txt~docco_urls linux-2615-rc1-g6/Documentation/power/pci.txt
--- linux-2615-rc1-g6/Documentation/power/pci.txt~docco_urls	2005-10-27 17:02:08.000000000 -0700
+++ linux-2615-rc1-g6/Documentation/power/pci.txt	2005-11-19 19:37:56.000000000 -0800
@@ -335,5 +335,5 @@ this on the whole.
 PCI Local Bus Specification 
 PCI Bus Power Management Interface Specification
 
-  http://pcisig.org
+  http://www.pcisig.com
 
diff -Naurp linux-2615-rc1-g6/Documentation/scsi/ibmmca.txt~docco_urls linux-2615-rc1-g6/Documentation/scsi/ibmmca.txt
--- linux-2615-rc1-g6/Documentation/scsi/ibmmca.txt~docco_urls	2005-10-27 17:02:08.000000000 -0700
+++ linux-2615-rc1-g6/Documentation/scsi/ibmmca.txt	2005-11-19 19:40:03.000000000 -0800
@@ -1108,7 +1108,7 @@
      A: You have to activate MCA bus support, first.
      Q: Where can I find the latest info about this driver?
      A: See the file MAINTAINERS for the current WWW-address, which offers
-        updates, info and Q/A lists. At this files' origin, the webaddress
+        updates, info and Q/A lists. At this file's origin, the webaddress
 	was: http://www.uni-mainz.de/~langm000/linux.html
      Q: My SCSI-adapter is not recognized by the driver, what can I do?
      A: Just force it to be recognized by kernel parameters. See section 5.1.
@@ -1248,7 +1248,7 @@
    --------------------
    The address of the IBM SCSI-subsystem supporting WWW-page is:
    
-        http://www.uni-mainz.de/~langm000/linux.html
+        http://www.staff.uni-mainz.de/mlang/linux.html
 	
    Here you can find info about the background of this driver, patches,
    troubleshooting support, news and a bugreport form. Please check that
diff -Naurp linux-2615-rc1-g6/Documentation/usb/ibmcam.txt~docco_urls linux-2615-rc1-g6/Documentation/usb/ibmcam.txt
--- linux-2615-rc1-g6/Documentation/usb/ibmcam.txt~docco_urls	2005-10-27 17:02:08.000000000 -0700
+++ linux-2615-rc1-g6/Documentation/usb/ibmcam.txt	2005-11-19 19:47:28.000000000 -0800
@@ -28,8 +28,8 @@ SUPPORTED CAMERAS:
 Xirlink "C-It" camera, also known as "IBM PC Camera".
 The device uses proprietary ASIC (and compression method);
 it is manufactured by Xirlink. See http://www.xirlink.com/
-http://www.ibmpccamera.com or http://www.c-itnow.com/ for
-details and pictures.
+(renamed to http://www.veo.com), http://www.ibmpccamera.com,
+or http://www.c-itnow.com/ for details and pictures.
 
 This very chipset ("X Chip", as marked at the factory)
 is used in several other cameras, and they are supported
diff -Naurp linux-2615-rc1-g6/Documentation/usb/ov511.txt~docco_urls linux-2615-rc1-g6/Documentation/usb/ov511.txt
--- linux-2615-rc1-g6/Documentation/usb/ov511.txt~docco_urls	2005-10-27 17:02:08.000000000 -0700
+++ linux-2615-rc1-g6/Documentation/usb/ov511.txt	2005-11-19 19:50:10.000000000 -0800
@@ -22,8 +22,8 @@ WHAT YOU NEED:
   http://www.ovt.com/omniusbp.html
 
 - A Video4Linux compatible frame grabber program (I recommend vidcat and xawtv)
-    vidcat is part of the w3cam package:  http://www.hdk-berlin.de/~rasca/w3cam/
-    xawtv is available at:  http://www.in-berlin.de/User/kraxel/xawtv.html
+    vidcat is part of the w3cam package:  http://mpx.freeshell.net/
+    xawtv is available at:  http://linux.bytesex.org/xawtv/
 
 HOW TO USE IT:
 
diff -Naurp linux-2615-rc1-g6/Documentation/usb/rio.txt~docco_urls linux-2615-rc1-g6/Documentation/usb/rio.txt
--- linux-2615-rc1-g6/Documentation/usb/rio.txt~docco_urls	2005-10-27 17:02:08.000000000 -0700
+++ linux-2615-rc1-g6/Documentation/usb/rio.txt	2005-11-19 19:52:29.000000000 -0800
@@ -46,9 +46,9 @@ Contact information:
 --------------------
 
    The main page for the project is hosted at sourceforge.net in the following
-   address: http://rio500.sourceforge.net You can also go to the sourceforge
-   project page at: http://sourceforge.net/project/?group_id=1944 There is 
-   also a mailing list: rio500-users@lists.sourceforge.net
+   URL: <http://rio500.sourceforge.net>. You can also go to the project's
+   sourceforge home page at: <http://sourceforge.net/projects/rio500/>.
+   There is also a mailing list: rio500-users@lists.sourceforge.net
 
 Authors:
 -------
diff -Naurp linux-2615-rc1-g6/Documentation/video4linux/zr36120.txt~docco_urls linux-2615-rc1-g6/Documentation/video4linux/zr36120.txt
--- linux-2615-rc1-g6/Documentation/video4linux/zr36120.txt~docco_urls	2005-10-27 17:02:08.000000000 -0700
+++ linux-2615-rc1-g6/Documentation/video4linux/zr36120.txt	2005-11-19 19:56:21.000000000 -0800
@@ -76,8 +76,11 @@ activates the GRAB bit. A few ms later t
 the zoran starts to work on a new and freshly broadcasted frame....
 
 For pointers I used the specs of both chips. Below are the URLs:
-	http://www.zoran.com/ftp/download/devices/pci/ZR36120/36120data.pdf
-	http://www-us.semiconductor.philips.com/acrobat/datasheets/SAA_7110_A_1.pdf
+  http://www.zoran.com/ftp/download/devices/pci/ZR36120/36120data.pdf
+  http://www-us.semiconductor.philips.com/acrobat/datasheets/SAA_7110_A_1.pdf
+Some alternatives for the Philips SAA 7110 datasheet are:
+  http://www.datasheetcatalog.com/datasheets_pdf/S/A/A/7/SAA7110.shtml
+  http://www.datasheetarchive.com/search.php?search=SAA7110&sType=part
 
 The documentation has very little on absolute numbers or timings
 needed for the various modes/resolutions, but there are other
diff -Naurp linux-2615-rc1-g6/Documentation/floppy.txt~docco_urls linux-2615-rc1-g6/Documentation/floppy.txt
--- linux-2615-rc1-g6/Documentation/floppy.txt~docco_urls	2005-10-27 17:02:08.000000000 -0700
+++ linux-2615-rc1-g6/Documentation/floppy.txt	2005-11-19 17:20:33.000000000 -0800
@@ -4,7 +4,7 @@ FAQ list:
 =========
 
  A FAQ list may be found in the fdutils package (see below), and also
-at http://fdutils.linux.lu/FAQ.html
+at <http://fdutils.linux.lu/faq.html>.
 
 
 LILO configuration options (Thinkpad users, read this)
@@ -217,10 +217,10 @@ It also contains additional documentatio
 The latest version can be found at fdutils homepage:
  http://fdutils.linux.lu
 
-The fdutils-5.4 release can be found at:
- http://fdutils.linux.lu/fdutils-5.4.src.tar.gz
- http://www.tux.org/pub/knaff/fdutils/fdutils-5.4.src.tar.gz
- ftp://metalab.unc.edu/pub/Linux/utils/disk-management/fdutils-5.4.src.tar.gz
+The fdutils releases can be found at:
+ http://fdutils.linux.lu/download.html
+ http://www.tux.org/pub/knaff/fdutils/
+ ftp://metalab.unc.edu/pub/Linux/utils/disk-management/
 
 Reporting problems about the floppy driver
 ==========================================
diff -Naurp linux-2615-rc1-g6/Documentation/mca.txt~docco_urls linux-2615-rc1-g6/Documentation/mca.txt
--- linux-2615-rc1-g6/Documentation/mca.txt~docco_urls	2005-10-27 17:02:08.000000000 -0700
+++ linux-2615-rc1-g6/Documentation/mca.txt	2005-11-19 19:09:58.000000000 -0800
@@ -252,7 +252,7 @@ their names here, but I don't have a lis
 home page (URL below) for a perpetually out-of-date list.
 
 =====================================================================
-MCA Linux Home Page: http://glycerine.itsmm.uni.edu/mca/
+MCA Linux Home Page: http://www.dgmicro.com/mca/
 
 Christophe Beauregard
 chrisb@truespectra.com
diff -Naurp linux-2615-rc1-g6/Documentation/ioctl-number.txt~docco_urls linux-2615-rc1-g6/Documentation/ioctl-number.txt
--- linux-2615-rc1-g6/Documentation/ioctl-number.txt~docco_urls	2005-11-18 21:23:58.000000000 -0800
+++ linux-2615-rc1-g6/Documentation/ioctl-number.txt	2005-11-19 17:26:46.000000000 -0800
@@ -133,7 +133,7 @@ Code	Seq#	Include File		Comments
 'l'	00-3F	linux/tcfs_fs.h		transparent cryptographic file system
 					<http://mikonos.dia.unisa.it/tcfs>
 'l'	40-7F	linux/udf_fs_i.h	in development:
-					<http://www.trylinux.com/projects/udf/>
+					<http://sourceforge.net/projects/linux-udf/>
 'm'	all	linux/mtio.h		conflict!
 'm'	all	linux/soundcard.h	conflict!
 'm'	all	linux/synclink.h	conflict!
diff -Naurp linux-2615-rc1-g6/Documentation/kernel-docs.txt~docco_urls linux-2615-rc1-g6/Documentation/kernel-docs.txt
--- linux-2615-rc1-g6/Documentation/kernel-docs.txt~docco_urls	2005-10-27 17:02:08.000000000 -0700
+++ linux-2615-rc1-g6/Documentation/kernel-docs.txt	2005-11-19 19:08:09.000000000 -0800
@@ -196,7 +196,7 @@
        
      * Title: "Writing Linux Device Drivers"
        Author: Michael K. Johnson.
-       URL: http://people.redhat.com/johnsonm/devices.html
+       URL: http://users.evitech.fi/~tk/rtos/writing_linux_device_d.html
        Keywords: files, VFS, file operations, kernel interface, character
        vs block devices, I/O access, hardware interrupts, DMA, access to
        user memory, memory allocation, timers.
@@ -284,7 +284,7 @@
        
      * Title: "Linux Kernel Module Programming Guide"
        Author: Ori Pomerantz.
-       URL: http://www.tldp.org/LDP/lkmpg/mpg.html
+       URL: http://tldp.org/LDP/lkmpg/2.6/html/index.html
        Keywords: modules, GPL book, /proc, ioctls, system calls,
        interrupt handlers .
        Description: Very nice 92 pages GPL book on the topic of modules
@@ -292,7 +292,7 @@
        
      * Title: "Device File System (devfs) Overview"
        Author: Richard Gooch.
-       URL: http://www.atnf.csiro.au/~rgooch/linux/docs/devfs.txt
+       URL: http://www.atnf.csiro.au/people/rgooch/linux/docs/devfs.html
        Keywords: filesystem, /dev, devfs, dynamic devices, major/minor
        allocation, device management.
        Description: Document describing Richard Gooch's controversial
@@ -316,9 +316,8 @@
        
      * Title: "The Kernel Hacking HOWTO"
        Author: Various Talented People, and Rusty.
-       URL:
-       http://www.lisoleg.net/doc/Kernel-Hacking-HOWTO/kernel-hacking-HOW
-       TO.html
+       Location: in kernel tree, Documentation/DocBook/kernel-hacking/
+       (must be built as "make {htmldocs | psdocs | pdfdocs})
        Keywords: HOWTO, kernel contexts, deadlock, locking, modules,
        symbols, return conventions.
        Description: From the Introduction: "Please understand that I
@@ -332,13 +331,13 @@
        originally written for the 2.3 kernels, but nearly all of it
        applies to 2.2 too; 2.0 is slightly different".
        
-     * Title: "ALSA 0.5.0 Developer documentation"
-       Author: Stephan 'Jumpy' Bartels .
-       URL: http://www.math.TU-Berlin.de/~sbartels/alsa/
+     * Title: "Writing an ALSA Driver"
+       Author: Takashi Iwai <tiwai@suse.de>
+       URL: http://www.alsa-project.org/~iwai/writing-an-alsa-driver/index.html
        Keywords: ALSA, sound, soundcard, driver, lowlevel, hardware.
        Description: Advanced Linux Sound Architecture for developers,
-       both at kernel and user-level sides. Work in progress. ALSA is
-       supposed to be Linux's next generation sound architecture.
+       both at kernel and user-level sides. ALSA is the Linux kernel
+       sound architecture in the 2.6 kernel version.
        
      * Title: "Programming Guide for Linux USB Device Drivers"
        Author: Detlef Fliegl.
@@ -369,8 +368,8 @@
        filesystems, IPC and Networking Code.
        
      * Title: "Linux Kernel Mailing List Glossary"
-       Author: John Levon.
-       URL: http://www.movement.uklinux.net/glossary.html
+       Author: various
+       URL: http://kernelnewbies.org/glossary/
        Keywords: glossary, terms, linux-kernel.
        Description: From the introduction: "This glossary is intended as
        a brief description of some of the acronyms and terms you may hear
@@ -378,9 +377,8 @@
        
      * Title: "Linux Kernel Locking HOWTO"
        Author: Various Talented People, and Rusty.
-       URL:
-       http://netfilter.kernelnotes.org/unreliable-guides/kernel-locking-
-       HOWTO.html
+       Location: in kernel tree, Documentation/DocBook/kernel-locking/
+       (must be built as "make {htmldocs | psdocs | pdfdocs})
        Keywords: locks, locking, spinlock, semaphore, atomic, race
        condition, bottom halves, tasklets, softirqs.
        Description: The title says it all: document describing the
@@ -490,7 +488,7 @@
        
      * Title: "Get those boards talking under Linux."
        Author: Alex Ivchenko.
-       URL: http://www.ednmag.com/ednmag/reg/2000/06222000/13df2.htm
+       URL: http://www.edn.com/article/CA46968.html
        Keywords: data-acquisition boards, drivers, modules, interrupts,
        memory allocation.
        Description: Article written for people wishing to make their data
@@ -498,7 +496,7 @@
        overview on writing drivers, from the naming of functions to
        interrupt handling.
        Notes: Two-parts article. Part II is at
-       http://www.ednmag.com/ednmag/reg/2000/07062000/14df.htm
+       URL: http://www.edn.com/article/CA46998.html
        
      * Title: "Linux PCMCIA Programmer's Guide"
        Author: David Hinds.
@@ -529,7 +527,7 @@
        definitive guide for hackers, virus coders and system
        administrators."
        Author: pragmatic/THC.
-       URL: http://packetstorm.securify.com/groups/thc/LKM_HACKING.html
+       URL: http://packetstormsecurity.org/docs/hack/LKM_HACKING.html
        Keywords: syscalls, intercept, hide, abuse, symbol table.
        Description: Interesting paper on how to abuse the Linux kernel in
        order to intercept and modify syscalls, make
@@ -537,8 +535,7 @@
        write kernel modules based virus... and solutions for admins to
        avoid all those abuses.
        Notes: For 2.0.x kernels. Gives guidances to port it to 2.2.x
-       kernels. Also available in txt format at
-       http://www.blacknemesis.org/hacking/txt/cllkm.txt
+       kernels.
        
      BOOKS: (Not on-line)
    
@@ -557,7 +554,17 @@
        ISBN: 0-59600-008-1
        Notes: Further information in
        http://www.oreilly.com/catalog/linuxdrive2/
-       
+
+     * Title: "Linux Device Drivers, 3nd Edition"
+       Authors: Jonathan Corbet, Alessandro Rubini, and Greg Kroah-Hartman
+       Publisher: O'Reilly & Associates.
+       Date: 2005.
+       Pages: 636.
+       ISBN: 0-596-00590-3
+       Notes: Further information in
+       http://www.oreilly.com/catalog/linuxdrive3/
+       PDF format, URL: http://lwn.net/Kernel/LDD3/
+
      * Title: "Linux Kernel Internals"
        Author: Michael Beck.
        Publisher: Addison-Wesley.
@@ -766,12 +773,15 @@
        documents, FAQs...
        
      * Name: "linux-kernel mailing list archives and search engines"
+       URL: http://vger.kernel.org/vger-lists.html
        URL: http://www.uwsg.indiana.edu/hypermail/linux/kernel/index.html
-       URL: http://www.kernelnotes.org/lnxlists/linux-kernel/
-       URL: http://www.geocrawler.com
+       URL: http://marc.theaimsgroup.com/?l=linux-kernel
+       URL: http://groups.google.com/group/mlist.linux.kernel
+       URL: http://www.cs.helsinki.fi/linux/linux-kernel/
+       URL: http://www.lib.uaa.alaska.edu/linux-kernel/
        Keywords: linux-kernel, archives, search.
        Description: Some of the linux-kernel mailing list archivers. If
        you have a better/another one, please let me know.
      _________________________________________________________________
    
-   Document last updated on Thu Jun 28 15:09:39 CEST 2001
+   Document last updated on Sat 2005-NOV-19


---
