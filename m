Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751637AbWJFCHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbWJFCHo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 22:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbWJFCHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 22:07:44 -0400
Received: from cpe-74-70-38-78.nycap.res.rr.com ([74.70.38.78]:33549 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1751637AbWJFCHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 22:07:43 -0400
Date: Thu, 5 Oct 2006 22:06:33 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org
Subject: [PATCH 19-rc1]  Fix typos in /Documentation : 'T''
Message-Id: <20061005220633.62dd8ab0.kernel1@cyberdogtech.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Thu, 05 Oct 2006 22:06:41 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Thu, 05 Oct 2006 22:06:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes typos in various Documentation txts. The patch addresses some words starting with the letter 'T'.  

Signed-off-by: Matt LaPlante <kernel1@cyberdogtech.com>
--

diff -ru a/Documentation/accounting/taskstats.txt b/Documentation/accounting/taskstats.txt
--- a/Documentation/accounting/taskstats.txt	2006-09-19 23:42:06.000000000 -0400
+++ b/Documentation/accounting/taskstats.txt	2006-10-05 22:03:01.000000000 -0400
@@ -96,9 +96,9 @@
 a pid/tgid will be followed by some stats.
 
 b) TASKSTATS_TYPE_PID/TGID: attribute whose payload is the pid/tgid whose stats
-is being returned.
+are being returned.
 
-c) TASKSTATS_TYPE_STATS: attribute with a struct taskstsats as payload. The
+c) TASKSTATS_TYPE_STATS: attribute with a struct taskstats as payload. The
 same structure is used for both per-pid and per-tgid stats.
 
 3. New message sent by kernel whenever a task exits. The payload consists of a
Only in b/Documentation: devices.txt.orig
Only in b/Documentation: devices.txt.rej
diff -ru a/Documentation/DMA-ISA-LPC.txt b/Documentation/DMA-ISA-LPC.txt
--- a/Documentation/DMA-ISA-LPC.txt	2006-09-19 23:42:06.000000000 -0400
+++ b/Documentation/DMA-ISA-LPC.txt	2006-10-05 21:40:21.000000000 -0400
@@ -110,7 +110,7 @@
 
 Once the DMA transfer is finished (or timed out) you should disable
 the channel again. You should also check get_dma_residue() to make
-sure that all data has been transfered.
+sure that all data has been transferred.
 
 Example:
 
diff -ru a/Documentation/filesystems/fuse.txt b/Documentation/filesystems/fuse.txt
--- a/Documentation/filesystems/fuse.txt	2006-09-19 23:42:06.000000000 -0400
+++ b/Documentation/filesystems/fuse.txt	2006-10-05 21:40:21.000000000 -0400
@@ -111,7 +111,7 @@
 
  'waiting'
 
-  The number of requests which are waiting to be transfered to
+  The number of requests which are waiting to be transferred to
   userspace or being processed by the filesystem daemon.  If there is
   no filesystem activity and 'waiting' is non-zero, then the
   filesystem is hung or deadlocked.
@@ -136,7 +136,7 @@
 
   2) If the request is not yet sent to userspace AND the signal is not
      fatal, then an 'interrupted' flag is set for the request.  When
-     the request has been successfully transfered to userspace and
+     the request has been successfully transferred to userspace and
      this flag is set, an INTERRUPT request is queued.
 
   3) If the request is already sent to userspace, then an INTERRUPT
diff -ru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	2006-10-05 21:35:31.000000000 -0400
+++ b/Documentation/filesystems/ntfs.txt	2006-10-05 21:40:21.000000000 -0400
@@ -337,7 +337,7 @@
 this (note all values are in 512-byte sectors):
 
 --- cut here ---
-# Ofs Size   Raid   Log  Number Region Should Number Source  Start Taget  Start
+# Ofs Size   Raid   Log  Number Region Should Number Source  Start Target Start
 # in  of the type   type of log size   sync?  of     Device  in    Device in
 # vol volume		 params		     mirrors	     Device	  Device
 0    2056320 mirror core 2	16     nosync 2	   /dev/hda1 0   /dev/hdb1 0
diff -ru a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
--- a/Documentation/filesystems/proc.txt	2006-10-05 21:35:31.000000000 -0400
+++ b/Documentation/filesystems/proc.txt	2006-10-05 21:40:21.000000000 -0400
@@ -1538,10 +1538,10 @@
 tcp_ecn
 -------
 
-This file controls the use of the ECN bit in the IPv4 headers, this is a new
+This file controls the use of the ECN bit in the IPv4 headers. This is a new
 feature about Explicit Congestion Notification, but some routers and firewalls
-block trafic that has this bit set, so it could be necessary to echo 0 to
-/proc/sys/net/ipv4/tcp_ecn, if you want to talk to this sites. For more info
+block traffic that has this bit set, so it could be necessary to echo 0 to
+/proc/sys/net/ipv4/tcp_ecn if you want to talk to these sites. For more info
 you could read RFC2481.
 
 tcp_retrans_collapse
Only in b/Documentation/filesystems: proc.txt.orig
Only in b/Documentation/kbuild: makefiles.txt.rej
diff -ru a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
--- a/Documentation/memory-barriers.txt	2006-10-05 21:35:31.000000000 -0400
+++ b/Documentation/memory-barriers.txt	2006-10-05 21:40:28.000000000 -0400
@@ -212,7 +212,7 @@
 
 	STORE *X = c, d = LOAD *X
 
-     (Loads and stores overlap if they are targetted at overlapping pieces of
+     (Loads and stores overlap if they are targeted at overlapping pieces of
      memory).
 
 And there are a number of things that _must_ or _must_not_ be assumed:
diff -ru a/Documentation/networking/cs89x0.txt b/Documentation/networking/cs89x0.txt
--- a/Documentation/networking/cs89x0.txt	2006-10-05 21:35:31.000000000 -0400
+++ b/Documentation/networking/cs89x0.txt	2006-10-05 21:40:28.000000000 -0400
@@ -248,7 +248,7 @@
    with device probing.  To avoid this behaviour, add one
    to the `io=' module parameter.  This doesn't actually change
    the I/O address, but it is a flag to tell the driver
-   topartially initialise the hardware before trying to
+   to partially initialise the hardware before trying to
    identify the card.  This could be dangerous if you are
    not sure that there is a cs89x0 card at the provided address.
 
diff -ru a/Documentation/networking/iphase.txt b/Documentation/networking/iphase.txt
--- a/Documentation/networking/iphase.txt	2006-09-19 23:42:06.000000000 -0400
+++ b/Documentation/networking/iphase.txt	2006-10-05 21:40:28.000000000 -0400
@@ -81,7 +81,7 @@
     1M. The RAM size decides the number of buffers and buffer size. The default 
     size and number of buffers are set as following: 
 
-          Totol    Rx RAM   Tx RAM   Rx Buf   Tx Buf   Rx buf   Tx buf
+          Total    Rx RAM   Tx RAM   Rx Buf   Tx Buf   Rx buf   Tx buf
          RAM size   size     size     size     size      cnt      cnt
          --------  ------   ------   ------   ------   ------   ------
            128K      64K      64K      10K      10K       6        6
diff -ru a/Documentation/networking/NAPI_HOWTO.txt b/Documentation/networking/NAPI_HOWTO.txt
--- a/Documentation/networking/NAPI_HOWTO.txt	2006-10-05 21:35:31.000000000 -0400
+++ b/Documentation/networking/NAPI_HOWTO.txt	2006-10-05 21:40:28.000000000 -0400
@@ -95,8 +95,8 @@
 		Move all to dev->poll()
 
 C) Ability to detect new work correctly.
-NAPI works by shutting down event interrupts when theres work and
-turning them on when theres none. 
+NAPI works by shutting down event interrupts when there's work and
+turning them on when there's none. 
 New packets might show up in the small window while interrupts were being 
 re-enabled (refer to appendix 2).  A packet might sneak in during the period 
 we are enabling interrupts. We only get to know about such a packet when the 
@@ -114,7 +114,7 @@
 only one CPU can pick the initial interrupt and hence the initial
 netif_rx_schedule(dev);
 - The core layer invokes devices to send packets in a round robin format.
-This implies receive is totaly lockless because of the guarantee only that 
+This implies receive is totally lockless because of the guarantee that only 
 one CPU is executing it.
 -  contention can only be the result of some other CPU accessing the rx
 ring. This happens only in close() and suspend() (when these methods
@@ -510,7 +510,7 @@
 			an interrupt will be generated */
                         goto done;
 	}
-	/* done! at least thats what it looks like ;->
+	/* done! at least that's what it looks like ;->
 	if new packets came in after our last check on status bits
 	they'll be caught by the while check and we go back and clear them 
 	since we havent exceeded our quota */
@@ -678,10 +678,10 @@
 CSR5 bit of interest is only the rx status. 
 If you look at the last if statement: 
 you just finished grabbing all the packets from the rx ring .. you check if
-status bit says theres more packets just in ... it says none; you then
+status bit says there are more packets just in ... it says none; you then
 enable rx interrupts again; if a new packet just came in during this check,
 we are counting that CSR5 will be set in that small window of opportunity
-and that by re-enabling interrupts, we would actually triger an interrupt
+and that by re-enabling interrupts, we would actually trigger an interrupt
 to register the new packet for processing.
 
 [The above description nay be very verbose, if you have better wording 
diff -ru a/Documentation/networking/pktgen.txt b/Documentation/networking/pktgen.txt
--- a/Documentation/networking/pktgen.txt	2006-10-05 21:35:31.000000000 -0400
+++ b/Documentation/networking/pktgen.txt	2006-10-05 21:40:28.000000000 -0400
@@ -116,7 +116,7 @@
 					 there must be no spaces between the
 					 arguments. Leading zeros are required.
 					 Do not set the bottom of stack bit,
-					 thats done automatically. If you do
+					 that's done automatically. If you do
 					 set the bottom of stack bit, that
 					 indicates that you want to randomly
 					 generate that address and the flag
Only in b/Documentation/networking: pktgen.txt.orig
diff -ru a/Documentation/networking/proc_net_tcp.txt b/Documentation/networking/proc_net_tcp.txt
--- a/Documentation/networking/proc_net_tcp.txt	2006-09-19 23:42:06.000000000 -0400
+++ b/Documentation/networking/proc_net_tcp.txt	2006-10-05 21:40:28.000000000 -0400
@@ -25,7 +25,7 @@
 
    1000        0 54165785 4 cd1e6040 25 4 27 3 -1
     |          |    |     |    |     |  | |  | |--> slow start size threshold, 
-    |          |    |     |    |     |  | |  |      or -1 if the treshold
+    |          |    |     |    |     |  | |  |      or -1 if the threshold
     |          |    |     |    |     |  | |  |      is >= 0xFFFF
     |          |    |     |    |     |  | |  |----> sending congestion window
     |          |    |     |    |     |  | |-------> (ack.quick<<1)|ack.pingpong
diff -ru a/Documentation/s390/cds.txt b/Documentation/s390/cds.txt
--- a/Documentation/s390/cds.txt	2006-10-05 21:35:31.000000000 -0400
+++ b/Documentation/s390/cds.txt	2006-10-05 21:40:28.000000000 -0400
@@ -342,7 +342,7 @@
 The ccw_device_start() function returns :
 
       0 - successful completion or request successfully initiated
--EBUSY  - The device is currently processing a previous I/O request, or ther is
+-EBUSY  - The device is currently processing a previous I/O request, or there is
           a status pending at the device.
 -ENODEV - cdev is invalid, the device is not operational or the ccw_device is
           not online.
diff -ru a/Documentation/s390/crypto/crypto-API.txt b/Documentation/s390/crypto/crypto-API.txt
--- a/Documentation/s390/crypto/crypto-API.txt	2006-10-05 21:35:31.000000000 -0400
+++ b/Documentation/s390/crypto/crypto-API.txt	2006-10-05 21:40:28.000000000 -0400
@@ -75,8 +75,8 @@
 
 - SHA1 Digest Algorithm [sha1 -> sha1_z990]
 - DES Encrypt/Decrypt Algorithm (64bit key) [des -> des_z990]
-- Tripple DES Encrypt/Decrypt Algorithm (128bit key) [des3_ede128 -> des_z990]
-- Tripple DES Encrypt/Decrypt Algorithm (192bit key) [des3_ede -> des_z990]
+- Triple DES Encrypt/Decrypt Algorithm (128bit key) [des3_ede128 -> des_z990]
+- Triple DES Encrypt/Decrypt Algorithm (192bit key) [des3_ede -> des_z990]
 
 In order to load, for example, the sha1_z990 module when the sha1 algorithm is
 requested (see 3.2.) add 'alias sha1 sha1_z990' to /etc/modprobe.conf.
diff -ru a/Documentation/scsi/aic79xx.txt b/Documentation/scsi/aic79xx.txt
--- a/Documentation/scsi/aic79xx.txt	2006-10-05 21:35:31.000000000 -0400
+++ b/Documentation/scsi/aic79xx.txt	2006-10-05 21:40:28.000000000 -0400
@@ -127,7 +127,7 @@
         - Correct a reference to free'ed memory during controller
           shutdown.
         - Reset the bus on an SE->LVD change.  This is required
-          to reset our transcievers.
+          to reset our transceivers.
 
    1.3.5 (March 24th, 2003)
         - Fix a few register window mode bugs.
diff -ru a/Documentation/scsi/aic7xxx_old.txt b/Documentation/scsi/aic7xxx_old.txt
--- a/Documentation/scsi/aic7xxx_old.txt	2006-10-05 21:35:31.000000000 -0400
+++ b/Documentation/scsi/aic7xxx_old.txt	2006-10-05 21:40:28.000000000 -0400
@@ -436,7 +436,7 @@
     the commas to periods, insmod won't interpret this as more than one
     string and write junk into our binary image.  I consider it a bug in
     the insmod program that even if you wrap your string in quotes (quotes
-    that pass the shell mind you and that insmod sees) it still treates
+    that pass the shell mind you and that insmod sees) it still treats
     a comma inside of those quotes as starting a new variable, resulting
     in memory scribbles if you don't switch the commas to periods.
 
diff -ru a/Documentation/scsi/ibmmca.txt b/Documentation/scsi/ibmmca.txt
--- a/Documentation/scsi/ibmmca.txt	2006-10-05 21:35:31.000000000 -0400
+++ b/Documentation/scsi/ibmmca.txt	2006-10-05 21:40:28.000000000 -0400
@@ -920,7 +920,7 @@
       completed in such a way, that they are now completely conform to the
       demands in the technical description of IBM. Main candidates were the
       DEVICE_INQUIRY, REQUEST_SENSE and DEVICE_CAPACITY commands. They must
-      be tranferred by bypassing the internal command buffer of the adapter
+      be transferred by bypassing the internal command buffer of the adapter
       or else the response can be a random result. GET_POS_INFO would be more
       safe in usage, if one could use the SUPRESS_EXCEPTION_SHORT, but this
       is not allowed by the technical references of IBM. (Sorry, folks, the
diff -ru a/Documentation/scsi/libsas.txt b/Documentation/scsi/libsas.txt
--- a/Documentation/scsi/libsas.txt	2006-10-05 21:35:31.000000000 -0400
+++ b/Documentation/scsi/libsas.txt	2006-10-05 21:53:02.000000000 -0400
@@ -393,7 +393,7 @@
 	task_proto -- _one_ of enum sas_proto
 	scatter -- pointer to scatter gather list array
 	num_scatter -- number of elements in scatter
-	total_xfer_len -- total number of bytes expected to be transfered
+	total_xfer_len -- total number of bytes expected to be transferred
 	data_dir -- PCI_DMA_...
 	task_done -- callback when the task has finished execution
 };
diff -ru a/Documentation/scsi/st.txt b/Documentation/scsi/st.txt
--- a/Documentation/scsi/st.txt	2006-10-05 21:35:31.000000000 -0400
+++ b/Documentation/scsi/st.txt	2006-10-05 21:40:28.000000000 -0400
@@ -261,7 +261,7 @@
 used instead of the equal mark. The definition is prepended by the
 string st=. Here is an example:
 
-	st=buffer_kbs:64,write_threhold_kbs:60
+	st=buffer_kbs:64,write_threshold_kbs:60
 
 The following syntax used by the old kernel versions is also supported:
 
diff -ru a/Documentation/sharedsubtree.txt b/Documentation/sharedsubtree.txt
--- a/Documentation/sharedsubtree.txt	2006-09-19 23:42:06.000000000 -0400
+++ b/Documentation/sharedsubtree.txt	2006-10-05 21:40:28.000000000 -0400
@@ -942,13 +942,13 @@
 	->mnt_slave
 	->mnt_master
 
-	->mnt_share links togather all the mount to/from which this vfsmount
+	->mnt_share links together all the mount to/from which this vfsmount
 		send/receives propagation events.
 
 	->mnt_slave_list links all the mounts to which this vfsmount propagates
 		to.
 
-	->mnt_slave links togather all the slaves that its master vfsmount
+	->mnt_slave links together all the slaves that its master vfsmount
 		propagates to.
 
 	->mnt_master points to the master vfsmount from which this vfsmount
diff -ru a/Documentation/sound/alsa/ALSA-Configuration.txt b/Documentation/sound/alsa/ALSA-Configuration.txt
--- a/Documentation/sound/alsa/ALSA-Configuration.txt	2006-10-05 21:35:31.000000000 -0400
+++ b/Documentation/sound/alsa/ALSA-Configuration.txt	2006-10-05 21:40:28.000000000 -0400
@@ -955,7 +955,7 @@
 		  dmx6fire, dsp24, dsp24_value, dsp24_71, ez8,
 		  phase88, mediastation
     omni	- Omni I/O support for MidiMan M-Audio Delta44/66
-    cs8427_timeout - reset timeout for the CS8427 chip (S/PDIF transciever)
+    cs8427_timeout - reset timeout for the CS8427 chip (S/PDIF transceiver)
                      in msec resolution, default value is 500 (0.5 sec)
 
     This module supports multiple cards and autoprobe. Note: The consumer part
Only in b/Documentation/sound/alsa: ALSA-Configuration.txt.orig
diff -ru a/Documentation/usb/rio.txt b/Documentation/usb/rio.txt
--- a/Documentation/usb/rio.txt	2006-09-19 23:42:06.000000000 -0400
+++ b/Documentation/usb/rio.txt	2006-10-05 21:40:28.000000000 -0400
@@ -24,10 +24,10 @@
 inconsequential.
 
 It seems that the Rio has a problem when sending .mp3 with low batteries.
-I suggest when the batteries are low and want to transfer stuff that you
+I suggest when the batteries are low and you want to transfer stuff that you
 replace it with a fresh one. In my case, what happened is I lost two 16kb
 blocks (they are no longer usable to store information to it). But I don't
-know if thats normal or not. It could simply be a problem with the flash 
+know if that's normal or not; it could simply be a problem with the flash 
 memory.
 
 In an extreme case, I left my Rio playing overnight and the batteries wore 
diff -ru a/Documentation/usb/usb-serial.txt b/Documentation/usb/usb-serial.txt
--- a/Documentation/usb/usb-serial.txt	2006-10-05 21:35:31.000000000 -0400
+++ b/Documentation/usb/usb-serial.txt	2006-10-05 21:40:28.000000000 -0400
@@ -175,7 +175,7 @@
   
   Current status:
     The USA-18X, USA-28X, USA-19, USA-19W and USA-49W are supported and
-    have been pretty throughly tested at various baud rates with 8-N-1
+    have been pretty thoroughly tested at various baud rates with 8-N-1
     character settings.  Other character lengths and parity setups are
     presently untested.
 
@@ -253,7 +253,7 @@
 	together without hacking the adapter to set the line high.
 
 	The driver is smp safe.  Performance with the driver is rather low when using
-	it for transfering files.  This is being worked on, but I would be willing to
+	it for transferring files.  This is being worked on, but I would be willing to
 	accept patches.  An urb queue or packet buffer would likely fit the bill here.
 
 	If you have any questions, problems, patches, feature requests, etc. you can
Only in b/Documentation/usb: usb-serial.txt.orig
diff -ru a/Documentation/video4linux/zr36120.txt b/Documentation/video4linux/zr36120.txt
--- a/Documentation/video4linux/zr36120.txt	2006-10-05 21:35:31.000000000 -0400
+++ b/Documentation/video4linux/zr36120.txt	2006-10-05 21:51:04.000000000 -0400
@@ -144,11 +144,11 @@
 
 The driver is capable of overlaying a video image in screen, and
 even capable of grabbing frames. It uses the BIGPHYSAREA patch
-to allocate lots of large memory blocks when tis patch is
+to allocate lots of large memory blocks when this patch is
 found in the kernel, but it doesn't need it.
 The consequence is that, when loading the driver as a module,
 the module may tell you it's out of memory, but 'free' says
-otherwise. The reason is simple; the modules wants its memory
+otherwise. The reason is simple; the module wants its memory
 contiguous, not fragmented, and after a long uptime there
 probably isn't a fragment of memory large enough...
 
diff -ru a/Documentation/watchdog/watchdog-api.txt b/Documentation/watchdog/watchdog-api.txt
--- a/Documentation/watchdog/watchdog-api.txt	2006-10-05 21:35:31.000000000 -0400
+++ b/Documentation/watchdog/watchdog-api.txt	2006-10-05 21:40:28.000000000 -0400
@@ -214,7 +214,7 @@
 
 Finally the SETOPTIONS ioctl can be used to control some aspects of
 the cards operation; right now the pcwd driver is the only one
-supporting thiss ioctl.
+supporting this ioctl.
 
     int options = 0;
     ioctl(fd, WDIOC_SETOPTIONS, options);

