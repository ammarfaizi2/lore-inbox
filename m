Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161081AbWHAGu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161081AbWHAGu4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 02:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161220AbWHAGu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 02:50:56 -0400
Received: from cpe-74-70-38-78.nycap.res.rr.com ([74.70.38.78]:48142 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1161081AbWHAGuz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 02:50:55 -0400
Date: Tue, 1 Aug 2006 02:49:43 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 18-rc3] Fix typos in /Documentation : 'Q'-'R'
Message-Id: <20060801024943.e962ca21.kernel1@cyberdogtech.com>
In-Reply-To: <20060730203728.f3fbdd95.rdunlap@xenotime.net>
References: <20060730181224.c1b69798.kernel1@cyberdogtech.com>
	<20060730203728.f3fbdd95.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Spam-Processed: mail.cyberdogtech.com, Tue, 01 Aug 2006 02:49:55 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Tue, 01 Aug 2006 02:49:55 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jul 2006 20:37:28 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> On Sun, 30 Jul 2006 18:12:24 -0400 Matt LaPlante wrote:
> 
> > This patch fixes typos in various Documentation txts. The patch addresses some words starting with the letters 'Q'-'R'.  
> 
> > diff -ru a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.txt
> > --- a/Documentation/block/biodoc.txt	2006-06-17 21:49:35.000000000 -0400
> > +++ b/Documentation/block/biodoc.txt	2006-07-30 18:11:04.000000000 -0400
> > @@ -783,7 +783,7 @@
> >  
> >  	blk_queue_invalidate_tags(request_queue_t *q)
> >  
> > -	Clear the internal block tag queue and readd all the pending requests
> > +	Clear the internal block tag queue and read all the pending requests
> 
> I think that is probably re-add.
> 
> >  	to the request queue. The driver will receive them again on the
> >  	next request_fn run, just like it did the first time it encountered
> >  	them.
> 
> > diff -ru a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> > --- a/Documentation/powerpc/booting-without-of.txt	2006-07-30 15:57:21.000000000 -0400
> > +++ b/Documentation/powerpc/booting-without-of.txt	2006-07-30 18:11:05.000000000 -0400
> > @@ -1069,7 +1069,7 @@
> >      around. It contains no internal offsets or pointers for this
> >      purpose.
> >  
> > -  - An example of code for iterating nodes & retreiving properties
> > +  - An example of code for iterating nodes & retrieving properties
> >      directly from the flattened tree format can be found in the kernel
> >      file arch/ppc64/kernel/prom.c, look at scan_flat_dt() function,
> >      it's usage in early_init_devtree(), and the corresponding various
>        its
> 
> Thanks more.
> ---
> ~Randy

Updated below...

-- 
Matt
--

diff -ru a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.txt
--- a/Documentation/block/biodoc.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/block/biodoc.txt	2006-08-01 02:47:48.000000000 -0400
@@ -783,7 +783,7 @@
 
 	blk_queue_invalidate_tags(request_queue_t *q)
 
-	Clear the internal block tag queue and readd all the pending requests
+	Clear the internal block tag queue and re-add all the pending requests
 	to the request queue. The driver will receive them again on the
 	next request_fn run, just like it did the first time it encountered
 	them.
diff -ru a/Documentation/driver-model/driver.txt b/Documentation/driver-model/driver.txt
--- a/Documentation/driver-model/driver.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/driver-model/driver.txt	2006-08-01 02:46:55.000000000 -0400
@@ -178,7 +178,7 @@
 
 A driver's probe() may return a negative errno value to indicate that
 the driver did not bind to this device, in which case it should have
-released all reasources it allocated.
+released all resources it allocated.
 
 	int 	(*remove)	(struct device * dev);
 
diff -ru a/Documentation/filesystems/befs.txt b/Documentation/filesystems/befs.txt
--- a/Documentation/filesystems/befs.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/filesystems/befs.txt	2006-08-01 02:46:55.000000000 -0400
@@ -7,7 +7,7 @@
 Make sure you understand that this is alpha software.  This means that the
 implementation is neither complete nor well-tested. 
 
-I DISCLAIM ALL RESPONSIBILTY FOR ANY POSSIBLE BAD EFFECTS OF THIS CODE!
+I DISCLAIM ALL RESPONSIBILITY FOR ANY POSSIBLE BAD EFFECTS OF THIS CODE!
 
 LICENSE
 =====
diff -ru a/Documentation/filesystems/configfs/configfs.txt b/Documentation/filesystems/configfs/configfs.txt
--- a/Documentation/filesystems/configfs/configfs.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/filesystems/configfs/configfs.txt	2006-08-01 02:46:55.000000000 -0400
@@ -422,7 +422,7 @@
 "pending" directory does allow mkdir(2) and rmdir(2).  An item is
 created in the "pending" directory.  Its attributes can be modified at
 will.  Userspace commits the item by renaming it into the "live"
-directory.  At this point, the subsystem recieves the ->commit_item()
+directory.  At this point, the subsystem receives the ->commit_item()
 callback.  If all required attributes are filled to satisfaction, the
 method returns zero and the item is moved to the "live" directory.
 
diff -ru a/Documentation/filesystems/relayfs.txt b/Documentation/filesystems/relayfs.txt
--- a/Documentation/filesystems/relayfs.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/filesystems/relayfs.txt	2006-08-01 02:46:55.000000000 -0400
@@ -244,7 +244,7 @@
 the callback returns 0 to indicate that the buffer switch should not
 occur yet i.e. until the consumer has had a chance to read the current
 set of ready sub-buffers.  For the relay_buf_full() function to make
-sense, the consumer is reponsible for notifying relayfs when
+sense, the consumer is responsible for notifying relayfs when
 sub-buffers have been consumed via relay_subbufs_consumed().  Any
 subsequent attempts to write into the buffer will again invoke the
 subbuf_start() callback with the same parameters; only when the
diff -ru a/Documentation/ibm-acpi.txt b/Documentation/ibm-acpi.txt
--- a/Documentation/ibm-acpi.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/ibm-acpi.txt	2006-08-01 02:46:55.000000000 -0400
@@ -450,7 +450,7 @@
 
 No commands can be written to this file.
 
-EXPERIMENTAL: Embedded controller reigster dump -- /proc/acpi/ibm/ecdump
+EXPERIMENTAL: Embedded controller register dump -- /proc/acpi/ibm/ecdump
 ------------------------------------------------------------------------
 
 This feature is marked EXPERIMENTAL because the implementation
diff -ru a/Documentation/ide.txt b/Documentation/ide.txt
--- a/Documentation/ide.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/ide.txt	2006-08-01 02:46:55.000000000 -0400
@@ -281,7 +281,7 @@
 
  "idex=serialize"	: do not overlap operations on idex. Please note
 			  that you will have to specify this option for
-			  both the respecitve primary and secondary channel
+			  both the respective primary and secondary channel
 			  to take effect.
 
  "idex=four"		: four drives on idex and ide(x^1) share same ports
diff -ru a/Documentation/input/amijoy.txt b/Documentation/input/amijoy.txt
--- a/Documentation/input/amijoy.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/input/amijoy.txt	2006-08-01 02:46:55.000000000 -0400
@@ -79,10 +79,10 @@
 JOY1DAT   Y7  Y6  Y5  Y4  Y3  Y2  Y1  Y0     X7  X6  X5  X4  X3  X2  X1  X0
 
         0=LEFT CONTROLLER PAIR, 1=RIGHT CONTROLLER PAIR.
-        (4 counters total).The bit usage for both left and right
+        (4 counters total). The bit usage for both left and right
         addresses is shown below. Each 6 bit counter (Y7-Y2,X7-X2) is
         clocked by 2 of the signals input from the mouse serial
-        stream. Starting with first bit recived:
+        stream. Starting with first bit received:
 
          +-------------------+-----------------------------------------+
          | Serial | Bit Name | Description                             |
diff -ru a/Documentation/input/atarikbd.txt b/Documentation/input/atarikbd.txt
--- a/Documentation/input/atarikbd.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/input/atarikbd.txt	2006-08-01 02:46:55.000000000 -0400
@@ -84,7 +84,7 @@
 4.2 Absolute Position reporting
 
 The ikbd can also maintain absolute mouse position. Commands exist for
-reseting the mouse position, setting X/Y scaling, and interrogating the
+resetting the mouse position, setting X/Y scaling, and interrogating the
 current mouse position.
 
 4.3 Mouse Cursor Key Mode
diff -ru a/Documentation/input/iforce-protocol.txt b/Documentation/input/iforce-protocol.txt
--- a/Documentation/input/iforce-protocol.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/input/iforce-protocol.txt	2006-08-01 02:46:55.000000000 -0400
@@ -151,7 +151,7 @@
 Query command. Length varies according to the query type.
 The general format of this packet is:
 ff 01 QUERY [INDEX] CHECKSUM
-reponses are of the same form:
+responses are of the same form:
 FF LEN QUERY VALUE_QUERIED CHECKSUM2
 where LEN = 1 + length(VALUE_QUERIED)
 
diff -ru a/Documentation/input/joystick-parport.txt b/Documentation/input/joystick-parport.txt
--- a/Documentation/input/joystick-parport.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/input/joystick-parport.txt	2006-08-01 02:46:55.000000000 -0400
@@ -456,8 +456,8 @@
 	  8  | Sony PSX DDR controller
 	  9  | SNES mouse
 
-  The exact type of the PSX controller type is autoprobed when used so
-hot swapping should work (but is not recomended).
+  The exact type of the PSX controller type is autoprobed when used, so
+hot swapping should work (but is not recommended).
 
   Should you want to use more than one of parallel ports at once, you can use
 gamecon.map2 and gamecon.map3 as additional command line parameters for two
diff -ru a/Documentation/kbuild/modules.txt b/Documentation/kbuild/modules.txt
--- a/Documentation/kbuild/modules.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/kbuild/modules.txt	2006-08-01 02:46:55.000000000 -0400
@@ -387,7 +387,7 @@
 
 
 	kbuild knows how to handle .o files located in another directory -
-	although this is NOT reccommended practice. The syntax is to specify
+	although this is NOT recommended practice. The syntax is to specify
 	the directory relative to the directory where the Kbuild file is
 	located.
 
diff -ru a/Documentation/md.txt b/Documentation/md.txt
--- a/Documentation/md.txt	2006-07-30 15:57:21.000000000 -0400
+++ b/Documentation/md.txt	2006-08-01 02:46:55.000000000 -0400
@@ -314,8 +314,8 @@
 			 This applies only to raid1 arrays.
 	      spare    - device is working, but not a full member.
 			 This includes spares that are in the process
-			 of being recoverred to
-	This list make grow in future.
+			 of being recovered to
+	This list may grow in future.
 	This can be written to.
 	Writing "faulty"  simulates a failure on the device.
 	Writing "remove" removes the device from the array.
diff -ru a/Documentation/MSI-HOWTO.txt b/Documentation/MSI-HOWTO.txt
--- a/Documentation/MSI-HOWTO.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/MSI-HOWTO.txt	2006-08-01 02:46:55.000000000 -0400
@@ -267,7 +267,7 @@
 	vector reserved to avoid the case where some MSI-X capable
 	drivers may attempt to claim all available vector resources.
 
-z =	The number of MSI-X capable devices pupulated in the system.
+z =	The number of MSI-X capable devices populated in the system.
 	This policy ensures that maximum (x - y) is distributed
 	evenly among MSI-X capable devices.
 
diff -ru a/Documentation/networking/driver.txt b/Documentation/networking/driver.txt
--- a/Documentation/networking/driver.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/networking/driver.txt	2006-08-01 02:46:55.000000000 -0400
@@ -37,7 +37,7 @@
 		...
 	}
 
-   And then at the end of your TX reclaimation event handling:
+   And then at the end of your TX reclamation event handling:
 
 	if (netif_queue_stopped(dp->dev) &&
             TX_BUFFS_AVAIL(dp) > (MAX_SKB_FRAGS + 1))
diff -ru a/Documentation/networking/ip-sysctl.txt b/Documentation/networking/ip-sysctl.txt
--- a/Documentation/networking/ip-sysctl.txt	2006-07-30 15:57:21.000000000 -0400
+++ b/Documentation/networking/ip-sysctl.txt	2006-08-01 02:46:55.000000000 -0400
@@ -454,7 +454,7 @@
 
 	Note that if no primary address exists for the interface selected,
 	then the primary address of the first non-loopback interface that
-	has one will be used regarldess of this setting.
+	has one will be used regardless of this setting.
 
 	Default: 0
 
diff -ru a/Documentation/networking/netif-msg.txt b/Documentation/networking/netif-msg.txt
--- a/Documentation/networking/netif-msg.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/networking/netif-msg.txt	2006-08-01 02:46:55.000000000 -0400
@@ -40,7 +40,7 @@
    Per-interface rather than per-driver message level setting.
    More selective control over the type of messages emitted.
 
- The netif_msg recommandation adds these features with only a minor
+ The netif_msg recommendation adds these features with only a minor
  complexity and code size increase.
 
  The recommendation is the following points
diff -ru a/Documentation/networking/slicecom.txt b/Documentation/networking/slicecom.txt
--- a/Documentation/networking/slicecom.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/networking/slicecom.txt	2006-08-01 02:46:55.000000000 -0400
@@ -89,7 +89,7 @@
 
 -	-	no frame-sync, no signal received, or signal SNAFU.
 -	on	"Everything is OK"
-on	on	Recepion is ok, but the remote end sends Remote Alarm
+on	on	Reception is ok, but the remote end sends Remote Alarm
 on	-	The interface is unconfigured
 
 -----------------------------------------------------------------
@@ -257,7 +257,7 @@
 // No alarms - Everything OK
 //
 // LOS  - Loss Of Signal - No signal sensed on the input
-// AIS  - Alarm Indication Signal - The remot side sends '11111111'-s, 
+// AIS  - Alarm Indication Signal - The remote side sends '11111111'-s, 
 //	it tells, that there's an error condition, or it's not
 //	initialised.
 // AUXP - Auxiliary Pattern Indication - 01010101.. received.
diff -ru a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
--- a/Documentation/powerpc/booting-without-of.txt	2006-07-30 15:57:21.000000000 -0400
+++ b/Documentation/powerpc/booting-without-of.txt	2006-08-01 02:50:03.000000000 -0400
@@ -245,7 +245,7 @@
 ---------
 
    The kernel is entered with r3 pointing to an area of memory that is
-   roughtly described in include/asm-powerpc/prom.h by the structure
+   roughly described in include/asm-powerpc/prom.h by the structure
    boot_param_header:
 
 struct boot_param_header {
@@ -1069,13 +1069,13 @@
     around. It contains no internal offsets or pointers for this
     purpose.
 
-  - An example of code for iterating nodes & retreiving properties
+  - An example of code for iterating nodes & retrieving properties
     directly from the flattened tree format can be found in the kernel
     file arch/ppc64/kernel/prom.c, look at scan_flat_dt() function,
-    it's usage in early_init_devtree(), and the corresponding various
+    its usage in early_init_devtree(), and the corresponding various
     early_init_dt_scan_*() callbacks. That code can be re-used in a
     GPL bootloader, and as the author of that code, I would be happy
-    do discuss possible free licencing to any vendor who wishes to
+    to discuss possible free licencing to any vendor who wishes to
     integrate all or part of this code into a non-GPL bootloader.
 
 
diff -ru a/Documentation/powerpc/eeh-pci-error-recovery.txt b/Documentation/powerpc/eeh-pci-error-recovery.txt
--- a/Documentation/powerpc/eeh-pci-error-recovery.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/powerpc/eeh-pci-error-recovery.txt	2006-08-01 02:46:55.000000000 -0400
@@ -90,7 +90,7 @@
 this is the case. If so, then the device driver should put itself
 into a consistent state (given that it won't be able to complete any
 pending work) and start recovery of the card.  Recovery normally
-would consist of reseting the PCI device (holding the PCI #RST
+would consist of resetting the PCI device (holding the PCI #RST
 line high for two seconds), followed by setting up the device
 config space (the base address registers (BAR's), latency timer,
 cache line size, interrupt line, and so on).  This is followed by a
diff -ru a/Documentation/s390/cds.txt b/Documentation/s390/cds.txt
--- a/Documentation/s390/cds.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/s390/cds.txt	2006-08-01 02:46:55.000000000 -0400
@@ -133,7 +133,7 @@
 In order not to introduce a new I/O concept to the common Linux code,
 Linux/390 preserves the IRQ concept and semantically maps the ESA/390
 subchannels to Linux as IRQs. This allows Linux/390 to support up to 64k
-different IRQs, uniquely representig a single device each.
+different IRQs, uniquely representing a single device each.
 
 Up to kernel 2.4, Linux/390 used to provide interfaces via the IRQ (subchannel).
 For internal use of the common I/O layer, these are still there. However, 
diff -ru a/Documentation/s390/driver-model.txt b/Documentation/s390/driver-model.txt
--- a/Documentation/s390/driver-model.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/s390/driver-model.txt	2006-08-01 02:46:55.000000000 -0400
@@ -157,7 +157,7 @@
 	* In online state, device detached (CIO_GONE) or last path gone
 	  (CIO_NO_PATH). The driver must return !0 to keep the device; for
 	  return code 0, the device will be deleted as usual (also when no
-	  notify function is registerd). If the driver wants to keep the
+	  notify function is registered). If the driver wants to keep the
 	  device, it is moved into disconnected state.
 	* In disconnected state, device operational again (CIO_OPER). The
 	  common I/O layer performs some sanity checks on device number and
diff -ru a/Documentation/scsi/NinjaSCSI.txt b/Documentation/scsi/NinjaSCSI.txt
--- a/Documentation/scsi/NinjaSCSI.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/scsi/NinjaSCSI.txt	2006-08-01 02:46:55.000000000 -0400
@@ -36,18 +36,18 @@
   product info: "IO DATA", "CBSC16       ", "1"
 
 
-[2] Get Linux kernel source, and extract it to /usr/src.
-    Because NinjaSCSI driver requiers some SCSI header files in Linux kernel
-    source.
-    I recomend rebuilding your kernel. This eliminate some versioning problem.
+[2] Get the Linux kernel source, and extract it to /usr/src.
+    Because the NinjaSCSI driver requires some SCSI header files in Linux 
+    kernel source, I recommend rebuilding your kernel; this eliminates 
+    some versioning problems.
 $ cd /usr/src
 $ tar -zxvf linux-x.x.x.tar.gz
 $ cd linux
 $ make config
 ...
 
-[3] If you use this driver with Kernel 2.2, Unpack pcmcia-cs in some directory
-    and make & install. This driver requies pcmcia-cs header file.
+[3] If you use this driver with Kernel 2.2, unpack pcmcia-cs in some directory
+    and make & install. This driver requires the pcmcia-cs header file.
 $ cd /usr/src
 $ tar zxvf cs-pcmcia-cs-3.x.x.tar.gz
 ...
diff -ru a/Documentation/sound/alsa/Procfile.txt b/Documentation/sound/alsa/Procfile.txt
--- a/Documentation/sound/alsa/Procfile.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/sound/alsa/Procfile.txt	2006-08-01 02:46:55.000000000 -0400
@@ -182,10 +182,10 @@
 mode.  This will give you the kernel messages when and where xrun
 happened.
 
-If it's really a bug, report it with the following information
+If it's really a bug, report it with the following information:
 
   - the name of the driver/card, show in /proc/asound/cards
-  - the reigster dump, if available (e.g. card*/cmipci)
+  - the register dump, if available (e.g. card*/cmipci)
 
 when it's a PCM problem,
 
diff -ru a/Documentation/sparc/sbus_drivers.txt b/Documentation/sparc/sbus_drivers.txt
--- a/Documentation/sparc/sbus_drivers.txt	2006-07-30 15:57:21.000000000 -0400
+++ b/Documentation/sparc/sbus_drivers.txt	2006-08-01 02:46:55.000000000 -0400
@@ -98,7 +98,7 @@
 
 	Any memory allocated, registers mapped, IRQs registered,
 etc. must be undone by your .remove method so that all resources
-of your device are relased by the time it returns.
+of your device are released by the time it returns.
 
 	You should _NOT_ use the for_each_sbus(), for_each_sbusdev(),
 and for_all_sbusdev() interfaces.  They are deprecated, will be
diff -ru a/Documentation/uml/UserModeLinux-HOWTO.txt b/Documentation/uml/UserModeLinux-HOWTO.txt
--- a/Documentation/uml/UserModeLinux-HOWTO.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/uml/UserModeLinux-HOWTO.txt	2006-08-01 02:46:55.000000000 -0400
@@ -3953,9 +3953,9 @@
 
   1133..55..  UUMMLL ddooeessnn''tt wwoorrkk wwhheenn //ttmmpp iiss aann NNFFSS ffiilleessyysstteemm
 
-  This seems to be a similar situation with the resierfs problem above.
+  This seems to be a similar situation with the ReiserFS problem above.
   Some versions of NFS seems not to handle mmap correctly, which UML
-  depends on.  The workaround is have /tmp be non-NFS directory.
+  depends on.  The workaround is have /tmp be a non-NFS directory.
 
 
   1133..66..  UUMMLL hhaannggss oonn bboooott wwhheenn ccoommppiilleedd wwiitthh ggpprrooff ssuuppppoorrtt
diff -ru a/Documentation/video4linux/cx88/hauppauge-wintv-cx88-ir.txt b/Documentation/video4linux/cx88/hauppauge-wintv-cx88-ir.txt
--- a/Documentation/video4linux/cx88/hauppauge-wintv-cx88-ir.txt	2006-07-30 15:57:21.000000000 -0400
+++ b/Documentation/video4linux/cx88/hauppauge-wintv-cx88-ir.txt	2006-08-01 02:46:55.000000000 -0400
@@ -30,7 +30,7 @@
 GP_SAMPLE register is at 0x35C058
 
 Bits are then right shifted into the GP_SAMPLE register at the specified
-rate; you get an interrupt when a full DWORD is recieved.
+rate; you get an interrupt when a full DWORD is received.
 You need to recover the actual RC5 bits out of the (oversampled) IR sensor
 bits. (Hint: look for the 0/1and 1/0 crossings of the RC5 bi-phase data)  An
 actual raw RC5 code will span 2-3 DWORDS, depending on the actual alignment.
diff -ru a/Documentation/video4linux/hauppauge-wintv-cx88-ir.txt b/Documentation/video4linux/hauppauge-wintv-cx88-ir.txt
--- a/Documentation/video4linux/hauppauge-wintv-cx88-ir.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/video4linux/hauppauge-wintv-cx88-ir.txt	2006-08-01 02:46:55.000000000 -0400
@@ -30,7 +30,7 @@
 GP_SAMPLE register is at 0x35C058
 
 Bits are then right shifted into the GP_SAMPLE register at the specified
-rate; you get an interrupt when a full DWORD is recieved.
+rate; you get an interrupt when a full DWORD is received.
 You need to recover the actual RC5 bits out of the (oversampled) IR sensor
 bits. (Hint: look for the 0/1and 1/0 crossings of the RC5 bi-phase data)  An
 actual raw RC5 code will span 2-3 DWORDS, depending on the actual alignment.
diff -ru a/Documentation/x86_64/boot-options.txt b/Documentation/x86_64/boot-options.txt
--- a/Documentation/x86_64/boot-options.txt	2006-07-30 15:57:21.000000000 -0400
+++ b/Documentation/x86_64/boot-options.txt	2006-08-01 02:46:55.000000000 -0400
@@ -109,7 +109,7 @@
 Rebooting
 
    reboot=b[ios] | t[riple] | k[bd] [, [w]arm | [c]old]
-   bios	  Use the CPU reboto vector for warm reset
+   bios	  Use the CPU reboot vector for warm reset
    warm   Don't set the cold reboot flag
    cold   Set the cold reboot flag
    triple Force a triple fault (init)

