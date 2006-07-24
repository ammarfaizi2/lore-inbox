Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbWGXX3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbWGXX3F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 19:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWGXX3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 19:29:05 -0400
Received: from cpe-74-70-38-78.nycap.res.rr.com ([74.70.38.78]:35592 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S932324AbWGXX3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 19:29:04 -0400
Date: Mon, 24 Jul 2006 19:27:47 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org
Subject: [PATCH 18-rc2] Fix typos in /Documentation : 'H'-'M'
Message-Id: <20060724192747.da3a9235.kernel1@cyberdogtech.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Mon, 24 Jul 2006 19:28:00 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Mon, 24 Jul 2006 19:28:00 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes typos in various Documentation txts. The patch addresses some words starting with the letters 'H'-'M'.  

Signed-off-by: Matt LaPlante <kernel1@cyberdogtech.com>
--

diff -ru a/Documentation/arm/Samsung-S3C24XX/S3C2412.txt b/Documentation/arm/Samsung-S3C24XX/S3C2412.txt
--- a/Documentation/arm/Samsung-S3C24XX/S3C2412.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/arm/Samsung-S3C24XX/S3C2412.txt	2006-07-24 19:05:38.000000000 -0400
@@ -80,7 +80,7 @@
 Watchdog
 --------
 
-  The watchdog harware is the same as the S3C2410, and is supported by
+  The watchdog hardware is the same as the S3C2410, and is supported by
   the s3c2410_wdt driver.
 
 
diff -ru a/Documentation/block/deadline-iosched.txt b/Documentation/block/deadline-iosched.txt
--- a/Documentation/block/deadline-iosched.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/block/deadline-iosched.txt	2006-07-24 19:05:48.000000000 -0400
@@ -27,7 +27,7 @@
 service time for a request. As we focus mainly on read latencies, this is
 tunable. When a read request first enters the io scheduler, it is assigned
 a deadline that is the current time + the read_expire value in units of
-miliseconds.
+milliseconds.
 
 
 write_expire	(in ms)
diff -ru a/Documentation/cpu-freq/governors.txt b/Documentation/cpu-freq/governors.txt
--- a/Documentation/cpu-freq/governors.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/cpu-freq/governors.txt	2006-07-24 19:05:38.000000000 -0400
@@ -57,7 +57,7 @@
 
 Basically, it's the following flow graph:
 
-CPU can be set to switch independetly	 |	   CPU can only be set
+CPU can be set to switch independently	 |	   CPU can only be set
       within specific "limits"		 |       to specific frequencies
 
                                  "CPUfreq policy"
diff -ru a/Documentation/dell_rbu.txt b/Documentation/dell_rbu.txt
--- a/Documentation/dell_rbu.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/dell_rbu.txt	2006-07-24 19:05:48.000000000 -0400
@@ -16,8 +16,8 @@
 Libsmbios can also be used to update BIOS on Dell systems go to
 http://linux.dell.com/libsmbios/ for details.
 
-Dell_RBU driver supports BIOS update using the monilothic image and packetized
-image methods. In case of moniolithic the driver allocates a contiguous chunk
+Dell_RBU driver supports BIOS update using the monolithic image and packetized
+image methods. In case of monolithic the driver allocates a contiguous chunk
 of physical pages having the BIOS image. In case of packetized the app
 using the driver breaks the image in to packets of fixed sizes and the driver
 would place each packet in contiguous physical memory. The driver also
diff -ru a/Documentation/driver-model/class.txt b/Documentation/driver-model/class.txt
--- a/Documentation/driver-model/class.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/driver-model/class.txt	2006-07-24 19:05:38.000000000 -0400
@@ -12,7 +12,7 @@
 
 Each device class defines a set of semantics and a programming interface
 that devices of that class adhere to. Device drivers are the
-implemention of that programming interface for a particular device on
+implementation of that programming interface for a particular device on
 a particular bus. 
 
 Device classes are agnostic with respect to what bus a device resides
diff -ru a/Documentation/dvb/ci.txt b/Documentation/dvb/ci.txt
--- a/Documentation/dvb/ci.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/dvb/ci.txt	2006-07-24 19:05:38.000000000 -0400
@@ -32,7 +32,7 @@
 	  descrambler to function,
 	  eg: $ ca_zap channels.conf "TMC"
 
-	(d) Hopeflly Enjoy your favourite subscribed channel as you do with
+	(d) Hopefully enjoy your favourite subscribed channel as you do with
 	  a FTA card.
 
 (3) Currently ca_zap, and dst_test, both are meant for demonstration
@@ -65,7 +65,7 @@
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 With the High Level CI approach any new card with almost any random
 architecture can be implemented with this style, the definitions
-insidethe switch statement can be easily adapted for any card, thereby
+inside the switch statement can be easily adapted for any card, thereby
 eliminating the need for any additional ioctls.
 
 The disadvantage is that the driver/hardware has to manage the rest. For
diff -ru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/filesystems/ntfs.txt	2006-07-24 19:05:48.000000000 -0400
@@ -13,7 +13,7 @@
 - Using NTFS volume and stripe sets
   - The Device-Mapper driver
   - The Software RAID / MD driver
-  - Limitiations when using the MD driver
+  - Limitations when using the MD driver
 - ChangeLog
 
 
@@ -43,7 +43,7 @@
 at http://linux-ntfs.sourceforge.net/
 
 The web site has a lot of additional information, such as a comprehensive
-FAQ, documentation on the NTFS on-disk format, informaiton on the Linux-NTFS
+FAQ, documentation on the NTFS on-disk format, information on the Linux-NTFS
 userspace utilities, etc.
 
 
@@ -383,7 +383,7 @@
 appropriately (see man 5 raidtab).
 
 Linear volume sets, i.e. linear raid, as well as stripe sets, i.e. raid level
-0, have been tested and work fine (though see section "Limitiations when using
+0, have been tested and work fine (though see section "Limitations when using
 the MD driver with NTFS volumes" especially if you want to use linear raid).
 Even though untested, there is no reason why mirrors, i.e. raid level 1, and
 stripes with parity, i.e. raid level 5, should not work, too.
@@ -435,7 +435,7 @@
 ntfs volume.
 
 
-Limitiations when using the Software RAID / MD driver
+Limitations when using the Software RAID / MD driver
 -----------------------------------------------------
 
 Using the md driver will not work properly if any of your NTFS partitions have
diff -ru a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
--- a/Documentation/filesystems/proc.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/filesystems/proc.txt	2006-07-24 19:05:38.000000000 -0400
@@ -1582,7 +1582,7 @@
 default is  to  use  the  BSD  compatible interpretation of the urgent pointer
 pointing to the first byte after the urgent data. The RFC793 interpretation is
 to have  it  point  to  the last byte of urgent data. Enabling this option may
-lead to interoperatibility problems. Disabled by default.
+lead to interoperability problems. Disabled by default.
 
 tcp_syncookies
 --------------
diff -ru a/Documentation/input/atarikbd.txt b/Documentation/input/atarikbd.txt
--- a/Documentation/input/atarikbd.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/input/atarikbd.txt	2006-07-24 19:05:38.000000000 -0400
@@ -406,7 +406,7 @@
 9.18 SET JOYSTICK MONITORING
 
     0x17
-    rate                ; time between samples in hundreths of a second
+    rate                ; time between samples in hundredths of a second
     Returns: (in packets of two as long as in mode)
             %000000xy   ; where y is JOYSTICK1 Fire button
                         ; and x is JOYSTICK0 Fire button
diff -ru a/Documentation/input/gameport-programming.txt b/Documentation/input/gameport-programming.txt
--- a/Documentation/input/gameport-programming.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/input/gameport-programming.txt	2006-07-24 19:05:48.000000000 -0400
@@ -19,7 +19,7 @@
 
 If your hardware supports more than one io address, and your driver can
 choose which one program the hardware to, starting from the more exotic
-addresses is preferred, because the likelyhood of clashing with the standard
+addresses is preferred, because the likelihood of clashing with the standard
 0x201 address is smaller.
 
 Eg. if your driver supports addresses 0x200, 0x208, 0x210 and 0x218, then
diff -ru a/Documentation/input/input.txt b/Documentation/input/input.txt
--- a/Documentation/input/input.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/input/input.txt	2006-07-24 19:05:48.000000000 -0400
@@ -279,7 +279,7 @@
 };
 
   'time' is the timestamp, it returns the time at which the event happened.
-Type is for example EV_REL for relative momement, REL_KEY for a keypress or
+Type is for example EV_REL for relative moment, REL_KEY for a keypress or
 release. More types are defined in include/linux/input.h.
 
   'code' is event code, for example REL_X or KEY_BACKSPACE, again a complete
diff -ru a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
--- a/Documentation/kbuild/makefiles.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/kbuild/makefiles.txt	2006-07-24 19:05:38.000000000 -0400
@@ -666,7 +666,7 @@
 be deleted. Kbuild will assume files to be in same relative directory as the
 Makefile except if an absolute path is specified (path starting with '/').
 
-To delete a directory hirachy use:
+To delete a directory hierarchy use:
 	Example:
 		#scripts/package/Makefile
 		clean-dirs := $(objtree)/debian/
diff -ru a/Documentation/keys.txt b/Documentation/keys.txt
--- a/Documentation/keys.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/keys.txt	2006-07-24 19:05:48.000000000 -0400
@@ -715,7 +715,7 @@
 KERNEL SERVICES
 ===============
 
-The kernel services for key managment are fairly simple to deal with. They can
+The kernel services for key management are fairly simple to deal with. They can
 be broken down into two areas: keys and key types.
 
 Dealing with keys is fairly straightforward. Firstly, the kernel service
diff -ru a/Documentation/lockdep-design.txt b/Documentation/lockdep-design.txt
--- a/Documentation/lockdep-design.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/lockdep-design.txt	2006-07-24 19:05:38.000000000 -0400
@@ -111,7 +111,7 @@
 (defined by the properties of the hierarchy), and the kernel grabs the
 locks in this fixed order on each of the objects.
 
-An example of such an object hieararchy that results in "nested locking"
+An example of such an object hierarchy that results in "nested locking"
 is that of a "whole disk" block-dev object and a "partition" block-dev
 object; the partition is "part of" the whole device and as long as one
 always takes the whole disk lock as a higher lock than the partition
@@ -140,7 +140,7 @@
 separate (sub)class for the purposes of validation.
 
 Note: When changing code to use the _nested() primitives, be careful and
-check really thoroughly that the hiearchy is correctly mapped; otherwise
+check really thoroughly that the hierarchy is correctly mapped; otherwise
 you can get false positives or false negatives.
 
 Proof of 100% correctness:
diff -ru a/Documentation/networking/cs89x0.txt b/Documentation/networking/cs89x0.txt
--- a/Documentation/networking/cs89x0.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/networking/cs89x0.txt	2006-07-24 19:05:48.000000000 -0400
@@ -227,7 +227,7 @@
 * media=rj45           - specify media type
    or media=bnc
    or media=aui
-   or medai=auto
+   or media=auto
 * duplex=full          - specify forced half/full/autonegotiate duplex
    or duplex=half
    or duplex=auto
diff -ru a/Documentation/networking/ip-sysctl.txt b/Documentation/networking/ip-sysctl.txt
--- a/Documentation/networking/ip-sysctl.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/networking/ip-sysctl.txt	2006-07-24 19:05:38.000000000 -0400
@@ -743,7 +743,7 @@
 			    disabled if accept_ra is disabled.
 
 accept_ra_pinfo - BOOLEAN
-	Learn Prefix Inforamtion in Router Advertisement.
+	Learn Prefix Information in Router Advertisement.
 
 	Functional default: enabled if accept_ra is enabled.
 			    disabled if accept_ra is disabled.
diff -ru a/Documentation/networking/packet_mmap.txt b/Documentation/networking/packet_mmap.txt
--- a/Documentation/networking/packet_mmap.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/networking/packet_mmap.txt	2006-07-24 19:05:48.000000000 -0400
@@ -215,8 +215,8 @@
      block #1
 
 
-kmalloc allocates any number of bytes of phisically contiguous memory from 
-a pool of pre-determined sizes. This pool of memory is mantained by the slab 
+kmalloc allocates any number of bytes of physically contiguous memory from 
+a pool of pre-determined sizes. This pool of memory is maintained by the slab 
 allocator which is at the end the responsible for doing the allocation and 
 hence which imposes the maximum memory that kmalloc can allocate. 
 
diff -ru a/Documentation/networking/pktgen.txt b/Documentation/networking/pktgen.txt
--- a/Documentation/networking/pktgen.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/networking/pktgen.txt	2006-07-24 19:05:48.000000000 -0400
@@ -18,7 +18,7 @@
 root       130  0.3  0.0     0    0 ?        SW    2003 509:50 [pktgen/1]
 
 
-For montoring and control pktgen creates:
+For monitoring and control pktgen creates:
 	/proc/net/pktgen/pgctrl
 	/proc/net/pktgen/kpktgend_X
         /proc/net/pktgen/ethX
diff -ru a/Documentation/networking/sk98lin.txt b/Documentation/networking/sk98lin.txt
--- a/Documentation/networking/sk98lin.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/networking/sk98lin.txt	2006-07-24 19:05:48.000000000 -0400
@@ -320,7 +320,7 @@
 Values:       None, Static, Dynamic
 Default:      None
 
-Interrupt moderation is employed to limit the maxmimum number of interrupts
+Interrupt moderation is employed to limit the maximum number of interrupts
 the driver has to serve. That is, one or more interrupts (which indicate any
 transmit or receive packet to be processed) are queued until the driver 
 processes them. When queued interrupts are to be served, is determined by the
diff -ru a/Documentation/networking/wan-router.txt b/Documentation/networking/wan-router.txt
--- a/Documentation/networking/wan-router.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/networking/wan-router.txt	2006-07-24 19:05:48.000000000 -0400
@@ -148,7 +148,7 @@
 		for async connections.
 
 	o Added the PPPCONFIG utility
-		Used to configure the PPPD dameon for the
+		Used to configure the PPPD daemon for the
 		WANPIPE Async PPP and standard serial port.
 		The wancfg calls the pppconfig to configure
 		the pppd.
@@ -350,7 +350,7 @@
 				 Available as a patch.                 
 
 2.0.6   Aug 17, 1999		Increased debugging in statup scripts
-				Fixed insallation bugs from 2.0.5
+				Fixed installation bugs from 2.0.5
 				Kernel patch works for both 2.2.10 and 2.2.11 kernels.
 				There is no functional difference between the two packages         
 
@@ -434,7 +434,7 @@
 				  change. 
 	  
 beta1-2.1.5 	Nov 15 2000
-				o Fixed the MulitPort PPP Support for kernels 2.2.16 and above.
+				o Fixed the MultiPort PPP Support for kernels 2.2.16 and above.
 				  2.2.X kernels only
 
 				o Secured the driver UDP debugging calls
diff -ru a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
--- a/Documentation/power/swsusp.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/power/swsusp.txt	2006-07-24 19:05:48.000000000 -0400
@@ -175,8 +175,8 @@
 Q: I do not understand why you have such strong objections to idea of
 selective suspend.
 
-A: Do selective suspend during runtime power managment, that's okay. But
-its useless for suspend-to-disk. (And I do not see how you could use
+A: Do selective suspend during runtime power management, that's okay. But
+it's useless for suspend-to-disk. (And I do not see how you could use
 it for suspend-to-ram, I hope you do not want that).
 
 Lets see, so you suggest to
@@ -211,7 +211,7 @@
 For devices like disk it does matter, you do not want to spindown for
 FREEZE.
 
-Q: After resuming, system is paging heavilly, leading to very bad interactivity.
+Q: After resuming, system is paging heavily, leading to very bad interactivity.
 
 A: Try running
 
diff -ru a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
--- a/Documentation/powerpc/booting-without-of.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/powerpc/booting-without-of.txt	2006-07-24 19:05:48.000000000 -0400
@@ -145,7 +145,7 @@
                 in case you are entering the kernel with MMU enabled
                 and a non-1:1 mapping.
 
-                r5 : NULL (as to differenciate with method a)
+                r5 : NULL (as to differentiate with method a)
 
         Note about SMP entry: Either your firmware puts your other
         CPUs in some sleep loop or spin loop in ROM where you can get
@@ -418,9 +418,9 @@
 format definition (as it is in Open Firmware). Version 0x10 makes it
 optional as it can generate it from the unit name defined below.
 
-There is also a "unit name" that is used to differenciate nodes with
+There is also a "unit name" that is used to differentiate nodes with
 the same name at the same level, it is usually made of the node
-name's, the "@" sign, and a "unit address", which definition is
+names, the "@" sign, and a "unit address", which definition is
 specific to the bus type the node sits on.
 
 The unit name doesn't exist as a property per-se but is included in
diff -ru a/Documentation/rpc-cache.txt b/Documentation/rpc-cache.txt
--- a/Documentation/rpc-cache.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/rpc-cache.txt	2006-07-24 19:05:48.000000000 -0400
@@ -24,7 +24,7 @@
    - general cache lookup with correct locking
    - supporting 'NEGATIVE' as well as positive entries
    - allowing an EXPIRED time on cache items, and removing
-     items after they expire, and are no longe in-use.
+     items after they expire, and are no longer in-use.
    - making requests to user-space to fill in cache entries
    - allowing user-space to directly set entries in the cache
    - delaying RPC requests that depend on as-yet incomplete
diff -ru a/Documentation/s390/cds.txt b/Documentation/s390/cds.txt
--- a/Documentation/s390/cds.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/s390/cds.txt	2006-07-24 19:05:38.000000000 -0400
@@ -325,7 +325,7 @@
 
 CCW_FLAG_DC        - data chaining
 CCW_FLAG_CC        - command chaining
-CCW_FLAG_SLI       - suppress incorrct length
+CCW_FLAG_SLI       - suppress incorrect length
 CCW_FLAG_SKIP      - skip
 CCW_FLAG_PCI       - PCI
 CCW_FLAG_IDA       - indirect addressing
diff -ru a/Documentation/s390/Debugging390.txt b/Documentation/s390/Debugging390.txt
--- a/Documentation/s390/Debugging390.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/s390/Debugging390.txt	2006-07-24 19:05:38.000000000 -0400
@@ -913,8 +913,8 @@
 strace ping -c 1 127.0.0.1  
 & then look at the man pages for each of the syscalls below,
 ( In fact this is sometimes easier than looking at some spagetti
-source which conditionally compiles for several architectures )
-Not everything that it throws out needs to make sense immeadiately
+source which conditionally compiles for several architectures ).
+Not everything that it throws out needs to make sense immediately.
 
 Just looking quickly you can see that it is making up a RAW socket
 for the ICMP protocol.
@@ -2316,7 +2316,7 @@
 /proc/1/mem is the current running processes memory which you
 can read & write to like a file.
 strace uses this sometimes as it is a bit faster than the
-rather inefficent ptrace interface for peeking at DATA.
+rather inefficient ptrace interface for peeking at DATA.
 
 
 cat status 
@@ -2446,7 +2446,7 @@
 + RELSTATUS=release
 + MACHTYPE=i586-pc-linux-gnu   
 
-perl -d <scriptname> runs the perlscript in a fully intercative debugger
+perl -d <scriptname> runs the perlscript in a fully interactive debugger
 <like gdb>.
 Type 'h' in the debugger for help.
 
Only in b/Documentation/s390: Debugging390.txt.orig
diff -ru a/Documentation/sched-coding.txt b/Documentation/sched-coding.txt
--- a/Documentation/sched-coding.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/sched-coding.txt	2006-07-24 19:05:38.000000000 -0400
@@ -15,7 +15,7 @@
 void load_balance(runqueue_t *this_rq, int idle)
 	Attempts to pull tasks from one cpu to another to balance cpu usage,
 	if needed.  This method is called explicitly if the runqueues are
-	inbalanced or periodically by the timer tick.  Prior to calling,
+	imbalanced or periodically by the timer tick.  Prior to calling,
 	the current runqueue must be locked and interrupts disabled.
 
 void schedule()
diff -ru a/Documentation/sched-design.txt b/Documentation/sched-design.txt
--- a/Documentation/sched-design.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/sched-design.txt	2006-07-24 19:05:48.000000000 -0400
@@ -93,7 +93,7 @@
 Design
 ======
 
-the core of the new scheduler are the following mechanizms:
+The core of the new scheduler are the following mechanisms:
 
  - *two*, priority-ordered 'priority arrays' per CPU. There is an 'active'
    array and an 'expired' array. The active array contains all tasks that
diff -ru a/Documentation/scsi/ibmmca.txt b/Documentation/scsi/ibmmca.txt
--- a/Documentation/scsi/ibmmca.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/scsi/ibmmca.txt	2006-07-24 19:05:48.000000000 -0400
@@ -229,7 +229,7 @@
 
    In a second step of the driver development, the following improvement has
    been applied: The first approach limited the number of devices to 7, far
-   fewer than the 15 that it could usem then it just maped ldn -> 
+   fewer than the 15 that it could use, then it just mapped ldn -> 
    (ldn/8,ldn%8) for pun,lun.  We ended up with a real mishmash of puns
    and luns, but it all seemed to work.
 
@@ -254,12 +254,12 @@
    device to be existant, but it has no ldn assigned, it gets a ldn out of 7 
    to 14. The numbers are assigned in cyclic order. Therefore it takes 8 
    dynamical reassignments on the SCSI-devices, until a certain device 
-   loses its ldn again. This assures, that dynamical remapping is avoided 
+   loses its ldn again. This assures that dynamical remapping is avoided 
    during intense I/O between up to 15 SCSI-devices (means pun,lun 
-   combinations). A further advantage of this method is, that people who
+   combinations). A further advantage of this method is that people who
    build their kernel without probing on all luns will get what they expect,
    because the driver just won't assign everything with lun>0 when 
-   multpile lun probing is inactive.
+   multiple lun probing is inactive.
  
    2.4 SCSI-Device Order
    ---------------------
@@ -1104,7 +1104,7 @@
 	The parameter 'normal' sets the new industry standard, starting
 	from pun 0, scanning up to pun 6. This allows you to change your 
 	opinion still after having already compiled the kernel.
-     Q: Why I cannot find the IBM MCA SCSI support in the config menue?
+     Q: Why I cannot find the IBM MCA SCSI support in the config menu?
      A: You have to activate MCA bus support, first.
      Q: Where can I find the latest info about this driver?
      A: See the file MAINTAINERS for the current WWW-address, which offers
diff -ru a/Documentation/scsi/megaraid.txt b/Documentation/scsi/megaraid.txt
--- a/Documentation/scsi/megaraid.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/scsi/megaraid.txt	2006-07-24 19:05:38.000000000 -0400
@@ -4,11 +4,11 @@
 Overview:
 --------
 
-Different classes of controllers from LSI Logic, accept and respond to the
+Different classes of controllers from LSI Logic accept and respond to the
 user applications in a similar way. They understand the same firmware control
 commands. Furthermore, the applications also can treat different classes of
 the controllers uniformly. Hence it is logical to have a single module that
-interefaces with the applications on one side and all the low level drivers
+interfaces with the applications on one side and all the low level drivers
 on the other.
 
 The advantages, though obvious, are listed for completeness:
diff -ru a/Documentation/scsi/ncr53c8xx.txt b/Documentation/scsi/ncr53c8xx.txt
--- a/Documentation/scsi/ncr53c8xx.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/scsi/ncr53c8xx.txt	2006-07-24 19:05:38.000000000 -0400
@@ -778,7 +778,7 @@
   Some scsi boards use a 875 (ultra wide) and only supply narrow connectors.
   If you have connected a wide device with a 50 pins to 68 pins cable 
   converter, any accepted wide negotiation will break further data transfers.
-  In such a case, using "wide:0" in the bootup command will be helpfull. 
+  In such a case, using "wide:0" in the bootup command will be helpful. 
 
 10.2.14 Differential mode
         diff:0	never set up diff mode
diff -ru a/Documentation/scsi/NinjaSCSI.txt b/Documentation/scsi/NinjaSCSI.txt
--- a/Documentation/scsi/NinjaSCSI.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/scsi/NinjaSCSI.txt	2006-07-24 19:05:48.000000000 -0400
@@ -24,7 +24,7 @@
     You can also use "cardctl" program (this program is in pcmcia-cs source
     code) to get more info.
 
-# cat /var/log/messgaes
+# cat /var/log/messages
 ...
 Jan  2 03:45:06 lindberg cardmgr[78]: unsupported card in socket 1
 Jan  2 03:45:06 lindberg cardmgr[78]:   product info: "WBT", "NinjaSCSI-3", "R1.0"
diff -ru a/Documentation/scsi/scsi_eh.txt b/Documentation/scsi/scsi_eh.txt
--- a/Documentation/scsi/scsi_eh.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/scsi/scsi_eh.txt	2006-07-24 19:05:38.000000000 -0400
@@ -194,7 +194,7 @@
 again.
 
  To achieve these goals, EH performs recovery actions with increasing
-severity.  Some actions are performed by issueing SCSI commands and
+severity.  Some actions are performed by issuing SCSI commands and
 others are performed by invoking one of the following fine-grained
 hostt EH callbacks.  Callbacks may be omitted and omitted ones are
 considered to fail always.
diff -ru a/Documentation/scsi/sym53c8xx_2.txt b/Documentation/scsi/sym53c8xx_2.txt
--- a/Documentation/scsi/sym53c8xx_2.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/scsi/sym53c8xx_2.txt	2006-07-24 19:05:48.000000000 -0400
@@ -684,7 +684,7 @@
           Contains the setting of timing values for both asynchronous and 
           synchronous data transfers. 
 Field I : SCNTL4 Scsi Control Register 4
-          Only meaninful for 53C1010 Ultra3 controllers.
+          Only meaningful for 53C1010 Ultra3 controllers.
 
 Understanding Fields J, K, L and dumps requires to have good knowledge of 
 SCSI standards, chip cores functionnals and internal driver data structures.
diff -ru a/Documentation/sh/kgdb.txt b/Documentation/sh/kgdb.txt
--- a/Documentation/sh/kgdb.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/sh/kgdb.txt	2006-07-24 19:05:48.000000000 -0400
@@ -69,7 +69,7 @@
 
   kgdb=halt
 
-Boot the TARGET machinem, which will appear to hang. 
+Boot the TARGET machine, which will appear to hang. 
 
 On your DEVELOPMENT machine, cd to the source directory and run the gdb
 program.  (This is likely to be a cross GDB which runs on your host but
diff -ru a/Documentation/sound/alsa/ALSA-Configuration.txt b/Documentation/sound/alsa/ALSA-Configuration.txt
--- a/Documentation/sound/alsa/ALSA-Configuration.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/sound/alsa/ALSA-Configuration.txt	2006-07-24 19:05:48.000000000 -0400
@@ -1853,7 +1853,7 @@
 # OSS/Free portion
 alias sound-slot-0 snd-interwave
 alias sound-slot-1 snd-ens1371
------ /etc/moprobe.conf
+----- /etc/modprobe.conf
 
 In this example, the interwave card is always loaded as the first card
 (index 0) and ens1371 as the second (index 1).
diff -ru a/Documentation/usb/mtouchusb.txt b/Documentation/usb/mtouchusb.txt
--- a/Documentation/usb/mtouchusb.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/usb/mtouchusb.txt	2006-07-24 19:05:38.000000000 -0400
@@ -38,7 +38,7 @@
 drivers.  Although 3M produces a binary only driver available for
 download, I persist in updating this driver since I would like to use the
 touchscreen for embedded apps using QTEmbedded, DirectFB, etc. So I feel the
-logical choice is to use Linux Imput.
+logical choice is to use Linux Input.
 
 Currently there is no way to calibrate the device via this driver.  Even if
 the device could be calibrated, the driver pulls to raw coordinate data from
diff -ru a/Documentation/video4linux/cx2341x/fw-osd-api.txt b/Documentation/video4linux/cx2341x/fw-osd-api.txt
--- a/Documentation/video4linux/cx2341x/fw-osd-api.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/video4linux/cx2341x/fw-osd-api.txt	2006-07-24 19:05:38.000000000 -0400
@@ -97,7 +97,7 @@
 Result[1]
 	top left vertical offset
 Result[2]
-	bottom right hotizontal offset
+	bottom right horizontal offset
 Result[3]
 	bottom right vertical offset
 
diff -ru a/Documentation/video4linux/et61x251.txt b/Documentation/video4linux/et61x251.txt
--- a/Documentation/video4linux/et61x251.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/video4linux/et61x251.txt	2006-07-24 19:05:48.000000000 -0400
@@ -80,7 +80,7 @@
   high compression quality (see also "Notes for V4L2 application developers"
   paragraph);
 - full support for the capabilities of every possible image sensors that can
-  be connected to the ET61X[12]51 bridges, including, for istance, red, green,
+  be connected to the ET61X[12]51 bridges, including, for instance, red, green,
   blue and global gain adjustments and exposure control (see "Supported
   devices" paragraph for details);
 - use of default color settings for sunlight conditions;
diff -ru a/Documentation/video4linux/sn9c102.txt b/Documentation/video4linux/sn9c102.txt
--- a/Documentation/video4linux/sn9c102.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/video4linux/sn9c102.txt	2006-07-24 19:05:48.000000000 -0400
@@ -85,7 +85,7 @@
   high compression quality (see also "Notes for V4L2 application developers"
   and "Video frame formats" paragraphs);
 - full support for the capabilities of many of the possible image sensors that
-  can be connected to the SN9C10x bridges, including, for istance, red, green,
+  can be connected to the SN9C10x bridges, including, for instance, red, green,
   blue and global gain adjustments and exposure (see "Supported devices"
   paragraph for details);
 - use of default color settings for sunlight conditions;
diff -ru a/Documentation/watchdog/watchdog-api.txt b/Documentation/watchdog/watchdog-api.txt
--- a/Documentation/watchdog/watchdog-api.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/watchdog/watchdog-api.txt	2006-07-24 19:05:48.000000000 -0400
@@ -45,7 +45,7 @@
 some of the drivers support the configuration option "Disable watchdog
 shutdown on close", CONFIG_WATCHDOG_NOWAYOUT.  If it is set to Y when
 compiling the kernel, there is no way of disabling the watchdog once
-it has been started.  So, if the watchdog dameon crashes, the system
+it has been started.  So, if the watchdog daemon crashes, the system
 will reboot after the timeout has passed.
 
 Some other drivers will not disable the watchdog, unless a specific


