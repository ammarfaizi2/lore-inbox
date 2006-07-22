Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750957AbWGVQ62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750957AbWGVQ62 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 12:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWGVQ62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 12:58:28 -0400
Received: from cpe-74-70-38-78.nycap.res.rr.com ([74.70.38.78]:7433 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1750957AbWGVQ61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 12:58:27 -0400
Date: Sat, 22 Jul 2006 12:57:45 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org
Subject: [PATCH 18-rc2] Fix typos in /Documentation : 'B'-'C'
Message-Id: <20060722125745.8cca07e3.kernel1@cyberdogtech.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Sat, 22 Jul 2006 12:57:51 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Sat, 22 Jul 2006 12:57:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes typos in various Documentation txts. This patch addresses some words starting with the letters 'B'-'C'.  There are also a few grammar fixes thrown in for Randy. ;)

Signed-off-by: Matt LaPlante <kernel1@cyberdogtech.com>
--

diff -ru a/Documentation/block/barrier.txt b/Documentation/block/barrier.txt
--- a/Documentation/block/barrier.txt	2006-07-10 13:00:28.000000000 -0400
+++ b/Documentation/block/barrier.txt	2006-07-11 01:37:47.000000000 -0400
@@ -25,7 +25,7 @@
 i. For devices which have queue depth greater than 1 (TCQ devices) and
 support ordered tags, block layer can just issue the barrier as an
 ordered request and the lower level driver, controller and drive
-itself are responsible for making sure that the ordering contraint is
+itself are responsible for making sure that the ordering constraint is
 met.  Most modern SCSI controllers/drives should support this.
 
 NOTE: SCSI ordered tag isn't currently used due to limitation in the
diff -ru a/Documentation/cciss.txt b/Documentation/cciss.txt
--- a/Documentation/cciss.txt	2006-07-10 13:00:28.000000000 -0400
+++ b/Documentation/cciss.txt	2006-07-11 01:39:43.000000000 -0400
@@ -151,7 +151,7 @@
 implements the first two of these actions, aborting the command, and
 resetting the device.  Additionally, most tape drives will not oblige 
 in aborting commands, and sometimes it appears they will not even 
-obey a reset coommand, though in most circumstances they will.  In
+obey a reset command, though in most circumstances they will.  In
 the case that the command cannot be aborted and the device cannot be 
 reset, the device will be set offline.
 
diff -ru a/Documentation/dell_rbu.txt b/Documentation/dell_rbu.txt
--- a/Documentation/dell_rbu.txt	2006-07-10 13:07:02.000000000 -0400
+++ b/Documentation/dell_rbu.txt	2006-07-11 01:21:07.000000000 -0400
@@ -41,7 +41,7 @@
 These update mechanism depends upon the BIOS currently running on the system.
 Most of the Dell systems support a monolithic update where the BIOS image is
 copied to a single contiguous block of physical memory.
-In case of packet mechanism the single memory can be broken in smaller chuks
+In case of packet mechanism the single memory can be broken in smaller chunks
 of contiguous memory and the BIOS image is scattered in these packets.
 
 By default the driver uses monolithic memory for the update type. This can be
diff -ru a/Documentation/dvb/faq.txt b/Documentation/dvb/faq.txt
--- a/Documentation/dvb/faq.txt	2006-07-10 13:00:27.000000000 -0400
+++ b/Documentation/dvb/faq.txt	2006-07-11 01:24:34.000000000 -0400
@@ -138,7 +138,7 @@
 
 	- v4l2-common: common functions for Video4Linux-2 drivers
 
-	- v4l1-compat: backward compatiblity layer for Video4Linux-1 legacy
+	- v4l1-compat: backward compatibility layer for Video4Linux-1 legacy
 	  applications
 
 	- dvb-core: DVB core module. This provides you with the
diff -ru a/Documentation/filesystems/befs.txt b/Documentation/filesystems/befs.txt
--- a/Documentation/filesystems/befs.txt	2006-07-10 13:00:28.000000000 -0400
+++ b/Documentation/filesystems/befs.txt	2006-07-11 01:32:59.000000000 -0400
@@ -57,7 +57,7 @@
 figure it out yourself (it shouldn't be hard), or mail the maintainer 
 (Will Dyson <will_dyson@pobox.com>) for help.
 
-step 2.  Configuretion & make kernel
+step 2.  Configuration & make kernel
 
 The linux kernel has many compile-time options. Most of them are beyond the
 scope of this document. I suggest the Kernel-HOWTO document as a good general
diff -ru a/Documentation/filesystems/configfs/configfs.txt b/Documentation/filesystems/configfs/configfs.txt
--- a/Documentation/filesystems/configfs/configfs.txt	2006-07-10 13:07:02.000000000 -0400
+++ b/Documentation/filesystems/configfs/configfs.txt	2006-07-11 01:32:06.000000000 -0400
@@ -1,5 +1,5 @@
 
-configfs - Userspace-driven kernel object configuation.
+configfs - Userspace-driven kernel object configuration.
 
 Joel Becker <joel.becker@oracle.com>
 
diff -ru a/Documentation/input/atarikbd.txt b/Documentation/input/atarikbd.txt
--- a/Documentation/input/atarikbd.txt	2006-07-10 13:07:02.000000000 -0400
+++ b/Documentation/input/atarikbd.txt	2006-07-11 01:21:57.000000000 -0400
@@ -522,7 +522,7 @@
             0x20        ; memory access
             { data }    ; 6 data bytes starting at ADR
 
-This comand permits the host to read from the ikbd controller memory.
+This command permits the host to read from the ikbd controller memory.
 
 9.26 CONTROLLER EXECUTE
 
diff -ru a/Documentation/input/yealink.txt b/Documentation/input/yealink.txt
--- a/Documentation/input/yealink.txt	2006-07-10 13:00:28.000000000 -0400
+++ b/Documentation/input/yealink.txt	2006-07-11 01:14:53.000000000 -0400
@@ -93,7 +93,7 @@
   Format specifier
     '8' :  Generic 7 segment digit with individual addressable segments
 
-    Reduced capabillity 7 segm digit, when segments are hard wired together.
+    Reduced capability 7 segm digit, when segments are hard wired together.
     '1' : 2 segments digit only able to produce a 1.
     'e' : Most significant day of the month digit,
           able to produce at least 1 2 3.
diff -ru a/Documentation/IPMI.txt b/Documentation/IPMI.txt
--- a/Documentation/IPMI.txt	2006-07-10 13:07:02.000000000 -0400
+++ b/Documentation/IPMI.txt	2006-07-11 01:26:29.000000000 -0400
@@ -457,7 +457,7 @@
 Setting smb_dbg_probe to 1 will enable debugging of the probing and
 detection process for BMCs on the SMBusses.
 
-Discovering the IPMI compilant BMC on the SMBus can cause devices
+Discovering the IPMI compliant BMC on the SMBus can cause devices
 on the I2C bus to fail. The SMBus driver writes a "Get Device ID" IPMI
 message as a block write to the I2C bus and waits for a response.
 This action can be detrimental to some I2C devices. It is highly recommended
diff -ru a/Documentation/networking/dl2k.txt b/Documentation/networking/dl2k.txt
--- a/Documentation/networking/dl2k.txt	2006-07-10 13:07:03.000000000 -0400
+++ b/Documentation/networking/dl2k.txt	2006-07-11 01:07:46.000000000 -0400
@@ -222,7 +222,7 @@
 				  reach timeout of n * 640 nano seconds. 
 				  Set proper rx_coalesce and rx_timeout can 
 				  reduce congestion collapse and overload which
-				  has been a bottlenect for high speed network.
+				  has been a bottleneck for high speed network.
 				  
 				  For example, rx_coalesce=10 rx_timeout=800.
 				  that is, hardware assert only 1 interrupt 
diff -ru a/Documentation/networking/packet_mmap.txt b/Documentation/networking/packet_mmap.txt
--- a/Documentation/networking/packet_mmap.txt	2006-07-10 13:07:03.000000000 -0400
+++ b/Documentation/networking/packet_mmap.txt	2006-07-11 01:18:35.000000000 -0400
@@ -66,7 +66,7 @@
 
 [setup]     socket() -------> creation of the capture socket
             setsockopt() ---> allocation of the circular buffer (ring)
-            mmap() ---------> maping of the allocated buffer to the
+            mmap() ---------> mapping of the allocated buffer to the
                               user process
 
 [capture]   poll() ---------> to wait for incoming packets
@@ -93,7 +93,7 @@
 is done by a simple call to close(fd).
 
 Next I will describe PACKET_MMAP settings and it's constraints,
-also the maping of the circular buffer in the user process and 
+also the mapping of the circular buffer in the user process and 
 the use of this buffer.
 
 --------------------------------------------------------------------------------
@@ -153,8 +153,8 @@
 
 A frame can be of any size with the only condition it can fit in a block. A block
 can only hold an integer number of frames, or in other words, a frame cannot 
-be spawn accross two blocks so there are some datails you have to take into 
-account when choosing the frame_size. See "Maping and use of the circular 
+be spawned accross two blocks, so there are some details you have to take into 
+account when choosing the frame_size. See "Mapping and use of the circular 
 buffer (ring)".
 
 
@@ -262,7 +262,7 @@
 	<pagesize> = 4096 bytes
 	<max-order> = 11
 
-and a value for <frame size> of 2048 byteas. These parameters will yield
+and a value for <frame size> of 2048 bytes. These parameters will yield
 
 	<block number> = 131072/4 = 32768 blocks
 	<block size> = 4096 << 11 = 8 MiB.
@@ -311,14 +311,14 @@
    tp_frame_size must be a multiple of TPACKET_ALIGNMENT
    tp_frame_nr   must be exactly frames_per_block*tp_block_nr
 
-Note that tp_block_size should be choosed to be a power of two or there will
+Note that tp_block_size should be chosen to be a power of two or there will
 be a waste of memory.
 
 --------------------------------------------------------------------------------
-+ Maping and use of the circular buffer (ring)
++ Mapping and use of the circular buffer (ring)
 --------------------------------------------------------------------------------
 
-The maping of the buffer in the user process is done with the conventional 
+The mapping of the buffer in the user process is done with the conventional 
 mmap function. Even the circular buffer is compound of several physically
 discontiguous blocks of memory, they are contiguous to the user space, hence
 just one call to mmap is needed:
diff -ru a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
--- a/Documentation/powerpc/booting-without-of.txt	2006-07-10 13:01:44.000000000 -0400
+++ b/Documentation/powerpc/booting-without-of.txt	2006-07-11 01:47:20.000000000 -0400
@@ -732,12 +732,12 @@
       that typically get driven by the same platform code in the
       kernel, you would use a different "model" property but put a
       value in "compatible". The kernel doesn't directly use that
-      value (see /chosen/linux,platform for how the kernel choses a
+      value (see /chosen/linux,platform for how the kernel chooses a
       platform type) but it is generally useful.
 
   The root node is also generally where you add additional properties
   specific to your board like the serial number if any, that sort of
-  thing. it is recommended that if you add any "custom" property whose
+  thing. It is recommended that if you add any "custom" property whose
   name may clash with standard defined ones, you prefix them with your
   vendor name and a comma.
 
@@ -817,7 +817,7 @@
       your board. It's a list of addresses/sizes concatenated
       together, with the number of cells of each defined by the
       #address-cells and #size-cells of the root node. For example,
-      with both of these properties beeing 2 like in the example given
+      with both of these properties being 2 like in the example given
       earlier, a 970 based machine with 6Gb of RAM could typically
       have a "reg" property here that looks like:
 
@@ -970,7 +970,7 @@
      - "asm": assembly language file. This is a file that can be
        sourced by gas to generate a device-tree "blob". That file can
        then simply be added to your Makefile. Additionally, the
-       assembly file exports some symbols that can be use
+       assembly file exports some symbols that can be used.
 
 
 The syntax of the dtc tool is
@@ -984,10 +984,10 @@
 currently version 3 but that may change in the future to version 16.
 
 Additionally, dtc performs various sanity checks on the tree, like the
-uniqueness of linux,phandle properties, validity of strings, etc...
+uniqueness of linux, phandle properties, validity of strings, etc...
 
 The format of the .dts "source" file is "C" like, supports C and C++
-style commments.
+style comments.
 
 / {
 }
diff -ru a/Documentation/s390/Debugging390.txt b/Documentation/s390/Debugging390.txt
--- a/Documentation/s390/Debugging390.txt	2006-07-10 13:07:03.000000000 -0400
+++ b/Documentation/s390/Debugging390.txt	2006-07-11 01:42:13.000000000 -0400
@@ -163,7 +163,7 @@
                 1         1        64 bit
 
 32             1=31 bit addressing mode 0=24 bit addressing mode (for backward 
-               compatibility ), linux always runs with this bit set to 1
+               compatibility), linux always runs with this bit set to 1
 
 33-64          Instruction address.
       33-63    Reserved must be 0
@@ -239,7 +239,7 @@
 
 On 390 our limitations & strengths make us slightly different.
 For backward compatibility we are only allowed use 31 bits (2GB)
-of our 32 bit addresses,however, we use entirely separate address 
+of our 32 bit addresses, however, we use entirely separate address 
 spaces for the user & kernel.
 
 This means we can support 2GB of non Extended RAM on s/390, & more
@@ -1311,7 +1311,7 @@
 
 An alternative way of finding the STD of a currently running process 
 is to do the following, ( this method is more complex but
-could be quite convient if you aren't updating the kernel much &
+could be quite convenient if you aren't updating the kernel much &
 so your kernel structures will stay constant for a reasonable period of
 time ).
 
@@ -2045,13 +2045,13 @@
 list:
 e.g.
 list lists current function source
-list 1,10 list first 10 lines of curret file.
+list 1,10 list first 10 lines of current file.
 list test.c:1,10
 
 
 directory:
 Adds directories to be searched for source if gdb cannot find the source.
-(note it is a bit sensititive about slashes ) 
+(note it is a bit sensititive about slashes) 
 e.g. To add the root of the filesystem to the searchpath do
 directory //
 
@@ -2123,9 +2123,9 @@
 
 Disassembling instructions without debug info
 ---------------------------------------------
-gdb typically compains if there is a lack of debugging
-symbols in  the disassemble command with 
-"No function contains specified address." to get around
+gdb typically complains if there is a lack of debugging
+symbols in the disassemble command with 
+"No function contains specified address." To get around
 this do 
 x/<number lines to disassemble>xi <address>
 e.g.
diff -ru a/Documentation/scsi/aic7xxx.txt b/Documentation/scsi/aic7xxx.txt
--- a/Documentation/scsi/aic7xxx.txt	2006-07-10 13:00:28.000000000 -0400
+++ b/Documentation/scsi/aic7xxx.txt	2006-07-11 01:41:18.000000000 -0400
@@ -160,7 +160,7 @@
 
    6.2.34 (May 5th, 2003)
         - Fix locking regression instroduced in 6.2.29 that
-          could cuase a lock order reversal between the io_request_lock
+          could cause a lock order reversal between the io_request_lock
           and our per-softc lock.  This was only possible on RH9,
           SuSE, and kernel.org 2.4.X kernels.
 
diff -ru a/Documentation/scsi/dpti.txt b/Documentation/scsi/dpti.txt
--- a/Documentation/scsi/dpti.txt	2006-07-10 13:00:28.000000000 -0400
+++ b/Documentation/scsi/dpti.txt	2006-07-11 01:29:23.000000000 -0400
@@ -48,7 +48,7 @@
  *      Implemented suggestions from Alan Cox
  *      Added calculation of resid for sg layer
  *      Better error handling
- *         Added checking underflow condtions 
+ *         Added checking underflow conditions 
  *         Added DATAPROTECT checking
  *         Changed error return codes
  *         Fixed pointer bug in bus reset routine
diff -ru a/Documentation/sound/alsa/ALSA-Configuration.txt b/Documentation/sound/alsa/ALSA-Configuration.txt
--- a/Documentation/sound/alsa/ALSA-Configuration.txt	2006-07-10 13:01:56.000000000 -0400
+++ b/Documentation/sound/alsa/ALSA-Configuration.txt	2006-07-11 01:30:50.000000000 -0400
@@ -843,7 +843,7 @@
 	  3stack-dig	ditto with SPDIF
 	  laptop	3-jack with hp-jack automute
 	  laptop-dig	ditto with SPDIF
-	  auto		auto-confgi reading BIOS (default)
+	  auto		auto-config reading BIOS (default)
 
 	STAC7661(?)
 	  vaio		Setup for VAIO FE550G/SZ110
diff -ru a/Documentation/sound/alsa/MIXART.txt b/Documentation/sound/alsa/MIXART.txt
--- a/Documentation/sound/alsa/MIXART.txt	2006-07-10 13:00:28.000000000 -0400
+++ b/Documentation/sound/alsa/MIXART.txt	2006-07-11 01:33:48.000000000 -0400
@@ -31,7 +31,7 @@
 Formats
 -------
 U8, S16_LE, S16_BE, S24_3LE, S24_3BE, FLOAT_LE, FLOAT_BE
-Sample rates : 8000 - 48000 Hz continously
+Sample rates : 8000 - 48000 Hz continuously
 
 Playback
 --------
diff -ru a/Documentation/uml/UserModeLinux-HOWTO.txt b/Documentation/uml/UserModeLinux-HOWTO.txt
--- a/Documentation/uml/UserModeLinux-HOWTO.txt	2006-07-10 13:00:27.000000000 -0400
+++ b/Documentation/uml/UserModeLinux-HOWTO.txt	2006-07-11 01:28:50.000000000 -0400
@@ -1047,7 +1047,7 @@
 
   Note that the IP address you assign to the host end of the tap device
   must be different than the IP you assign to the eth device inside UML.
-  If you are short on IPs and don't want to comsume two per UML, then
+  If you are short on IPs and don't want to consume two per UML, then
   you can reuse the host's eth IP address for the host ends of the tap
   devices.  Internally, the UMLs must still get unique IPs for their eth
   devices.  You can also give the UMLs non-routable IPs (192.168.x.x or
diff -ru a/Documentation/video4linux/cx2341x/fw-decoder-api.txt b/Documentation/video4linux/cx2341x/fw-decoder-api.txt
--- a/Documentation/video4linux/cx2341x/fw-decoder-api.txt	2006-07-10 13:01:56.000000000 -0400
+++ b/Documentation/video4linux/cx2341x/fw-decoder-api.txt	2006-07-11 01:29:53.000000000 -0400
@@ -102,7 +102,7 @@
 Name 	CX2341X_DEC_GET_XFER_INFO
 Enum 	9/0x09
 Description
-	This API call may be used to detect an end of stream condtion.
+	This API call may be used to detect an end of stream condition.
 Result[0]
 	Stream type
 Result[1]
diff -ru a/Documentation/video4linux/sn9c102.txt b/Documentation/video4linux/sn9c102.txt
--- a/Documentation/video4linux/sn9c102.txt	2006-07-10 13:01:56.000000000 -0400
+++ b/Documentation/video4linux/sn9c102.txt	2006-07-11 01:12:53.000000000 -0400
@@ -60,7 +60,7 @@
 development of this project, despite several requests for enough detailed
 specifications of the register tables, compression engine and video data format
 of the above chips. Nevertheless, these informations are no longer necessary,
-becouse all the aspects related to these chips are known and have been
+because all the aspects related to these chips are known and have been
 described in detail in this documentation.
 
 The driver relies on the Video4Linux2 and USB core modules. It has been

