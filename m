Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751293AbWHAPOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWHAPOo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 11:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWHAPOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 11:14:44 -0400
Received: from cpe-74-70-38-78.nycap.res.rr.com ([74.70.38.78]:44560 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1751293AbWHAPOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 11:14:42 -0400
Date: Tue, 1 Aug 2006 11:14:20 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org
Subject: [PATCH 18-rc3] Fix typos in /Documentation : 'S'
Message-Id: <20060801111420.048fe2a6.kernel1@cyberdogtech.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Tue, 01 Aug 2006 11:14:32 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Tue, 01 Aug 2006 11:14:34 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes typos in various Documentation txts. The patch addresses some words starting with the letter 'S'.  

Signed-off-by: Matt LaPlante <kernel1@cyberdogtech.com>
--

diff -ru a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.txt
--- a/Documentation/block/biodoc.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/block/biodoc.txt	2006-08-01 10:59:45.000000000 -0400
@@ -890,7 +890,7 @@
 
   Kvec i/o:
 
-  Ben LaHaise's aio code uses a slighly different structure instead
+  Ben LaHaise's aio code uses a slightly different structure instead
   of kiobufs, called a kvec_cb. This contains an array of <page, offset, len>
   tuples (very much like the networking code), together with a callback function
   and data pointer. This is embedded into a brw_cb structure when passed
@@ -988,7 +988,7 @@
 				for a queue.
 
 4.2 Request flows seen by I/O schedulers
-All requests seens by I/O schedulers strictly follow one of the following three
+All requests seen by I/O schedulers strictly follow one of the following three
 flows.
 
  set_req_fn ->
diff -ru a/Documentation/cpu-freq/cpufreq-stats.txt b/Documentation/cpu-freq/cpufreq-stats.txt
--- a/Documentation/cpu-freq/cpufreq-stats.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/cpu-freq/cpufreq-stats.txt	2006-08-01 10:59:45.000000000 -0400
@@ -1,5 +1,5 @@
 
-     CPU frequency and voltage scaling statictics in the Linux(TM) kernel
+     CPU frequency and voltage scaling statistics in the Linux(TM) kernel
 
 
              L i n u x    c p u f r e q - s t a t s   d r i v e r
@@ -18,8 +18,8 @@
 1. Introduction
 
 cpufreq-stats is a driver that provices CPU frequency statistics for each CPU.
-This statistics is provided in /sysfs as a bunch of read_only interfaces. This
-interface (when configured) will appear in a seperate directory under cpufreq
+These statistics are provided in /sysfs as a bunch of read_only interfaces. This
+interface (when configured) will appear in a separate directory under cpufreq
 in /sysfs (<sysfs root>/devices/system/cpu/cpuX/cpufreq/stats/) for each CPU.
 Various statistics will form read_only files under this directory.
 
@@ -115,7 +115,7 @@
 
 "CPU frequency translation statistics details" (CONFIG_CPU_FREQ_STAT_DETAILS)
 provides fine grained cpufreq stats by trans_table. The reason for having a
-seperate config option for trans_table is:
+separate config option for trans_table is:
 - trans_table goes against the traditional /sysfs rule of one value per
   interface. It provides a whole bunch of value in a 2 dimensional matrix
   form.
diff -ru a/Documentation/dvb/cards.txt b/Documentation/dvb/cards.txt
--- a/Documentation/dvb/cards.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/dvb/cards.txt	2006-08-01 10:59:45.000000000 -0400
@@ -5,7 +5,7 @@
   frontends (i.e. tuner / demodulator units) used, usually without
   changing the product name, revision number or specs. Some cards
   are also available in versions with different frontends for
-  DVB-S/DVB-C/DVB-T. Thus the frontend drivers are listed seperately.
+  DVB-S/DVB-C/DVB-T. Thus the frontend drivers are listed separately.
 
   Note 1: There is no guarantee that every frontend driver works
   out of the box with every card, because of different wiring.
diff -ru a/Documentation/fb/sstfb.txt b/Documentation/fb/sstfb.txt
--- a/Documentation/fb/sstfb.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/fb/sstfb.txt	2006-08-01 10:59:45.000000000 -0400
@@ -137,23 +137,23 @@
 	- The driver is 16 bpp only, 24/32 won't work.
 	- The driver is not your_favorite_toy-safe. this includes SMP...
           [Actually from inspection it seems to be safe - Alan]
-	- when using XFree86 FBdev (X over fbdev) you may see strange color
+	- When using XFree86 FBdev (X over fbdev) you may see strange color
 	patterns at the border of your windows (the pixels lose the lowest
-	byte -> basicaly the blue component nd some of the green) . I'm unable
+	byte -> basically the blue component and some of the green). I'm unable
 	to reproduce this with XFree86-3.3, but one of the testers has this
-	problem with XFree86-4. apparently recent Xfree86-4.x solve this
+	problem with XFree86-4. Apparently recent Xfree86-4.x solve this
 	problem.
 	- I didn't really test changing the palette, so you may find some weird
 	things when playing with that.
-	- Sometimes the driver will not recognise the DAC , and the
-        initialisation will fail. this is specificaly true for
-	voodoo 2 boards , but it should be solved in recent versions. please
-	contact me .
-	- the 24/32 is not likely to work anytime soon , knowing that the
-	hardware does ... unusual thigs in 24/32 bpp
-	- When used with anther video board, current limitations of linux
-	console subsystem can cause some troubles, specificaly, you should
-	disable software scrollback , as it can oops badly ...
+	- Sometimes the driver will not recognise the DAC, and the
+        initialisation will fail. This is specifically true for
+	voodoo 2 boards, but it should be solved in recent versions. Please
+	contact me.
+	- The 24/32 is not likely to work anytime soon, knowing that the
+	hardware does ... unusual things in 24/32 bpp.
+	- When used with another video board, current limitations of the linux
+	console subsystem can cause some troubles, specifically, you should
+	disable software scrollback, as it can oops badly ...
 
 Todo
 
diff -ru a/Documentation/filesystems/configfs/configfs.txt b/Documentation/filesystems/configfs/configfs.txt
--- a/Documentation/filesystems/configfs/configfs.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/filesystems/configfs/configfs.txt	2006-08-01 10:59:45.000000000 -0400
@@ -254,7 +254,7 @@
 
 Finally, when userspace calls rmdir(2) on the item or group,
 ct_group_ops->drop_item() is called.  As a config_group is also a
-config_item, it is not necessary for a seperate drop_group() method.
+config_item, it is not necessary for a separate drop_group() method.
 The subsystem must config_item_put() the reference that was initialized
 upon item allocation.  If a subsystem has no work to do, it may omit
 the ct_group_ops->drop_item() method, and configfs will call
diff -ru a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
--- a/Documentation/filesystems/proc.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/filesystems/proc.txt	2006-08-01 10:59:45.000000000 -0400
@@ -1249,7 +1249,7 @@
 		address space are refused. Used for a typical system. It
 		ensures a seriously wild allocation fails while allowing
 		overcommit to reduce swap usage.  root is allowed to
-		allocate slighly more memory in this mode. This is the
+		allocate slightly more memory in this mode. This is the
 		default.
 
 1	-	Always overcommit. Appropriate for some scientific
@@ -1851,7 +1851,7 @@
 
 Maximum queue length of the delayed proxy arp timer. (see proxy_delay).
 
-app_solcit
+app_solicit
 ----------
 
 Determines the  number of requests to send to the user level ARP daemon. Use 0
diff -ru a/Documentation/hrtimers.txt b/Documentation/hrtimers.txt
--- a/Documentation/hrtimers.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/hrtimers.txt	2006-08-01 10:59:45.000000000 -0400
@@ -58,7 +58,7 @@
 The primary users of precision timers are user-space applications that
 utilize nanosleep, posix-timers and itimer interfaces. Also, in-kernel
 users like drivers and subsystems which require precise timed events
-(e.g. multimedia) can benefit from the availability of a seperate
+(e.g. multimedia) can benefit from the availability of a separate
 high-resolution timer subsystem as well.
 
 While this subsystem does not offer high-resolution clock sources just
@@ -68,7 +68,7 @@
 with other potential users for precise timers gives another reason to
 separate the "timeout" and "precise timer" subsystems.
 
-Another potential benefit is that such a seperation allows even more
+Another potential benefit is that such a separation allows even more
 special-purpose optimization of the existing timer wheel for the low
 resolution and low precision use cases - once the precision-sensitive
 APIs are separated from the timer wheel and are migrated over to
@@ -96,8 +96,8 @@
 a separate list is used to give the expiry code fast access to the
 queued timers, without having to walk the rbtree.
 
-(This seperate list is also useful for later when we'll introduce
-high-resolution clocks, where we need seperate pending and expired
+(This separate list is also useful for later when we'll introduce
+high-resolution clocks, where we need separate pending and expired
 queues while keeping the time-order intact.)
 
 Time-ordered enqueueing is not purely for the purposes of
diff -ru a/Documentation/input/ff.txt b/Documentation/input/ff.txt
--- a/Documentation/input/ff.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/input/ff.txt	2006-08-01 10:59:45.000000000 -0400
@@ -88,7 +88,7 @@
 following bits:
 - FF_X		has an X axis (usually joysticks)
 - FF_Y		has an Y axis (usually joysticks)
-- FF_WHEEL	has a wheel (usually sterring wheels)
+- FF_WHEEL	has a wheel (usually steering wheels)
 - FF_CONSTANT	can render constant force effects
 - FF_PERIODIC	can render periodic effects (sine, triangle, square...)
 - FF_RAMP       can render ramp effects
diff -ru a/Documentation/input/yealink.txt b/Documentation/input/yealink.txt
--- a/Documentation/input/yealink.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/input/yealink.txt	2006-08-01 10:59:45.000000000 -0400
@@ -87,7 +87,7 @@
 
 
 Format description:
-  From a user space perspective the world is seperated in "digits" and "icons".
+  From a userspace perspective the world is separated into "digits" and "icons".
   A digit can have a character set, an icon can only be ON or OFF.
 
   Format specifier
diff -ru a/Documentation/kbuild/kconfig-language.txt b/Documentation/kbuild/kconfig-language.txt
--- a/Documentation/kbuild/kconfig-language.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/kbuild/kconfig-language.txt	2006-08-01 10:59:45.000000000 -0400
@@ -110,7 +110,7 @@
   the indentation level, this means it ends at the first line which has
   a smaller indentation than the first line of the help text.
   "---help---" and "help" do not differ in behaviour, "---help---" is
-  used to help visually seperate configuration logic from help within
+  used to help visually separate configuration logic from help within
   the file as an aid to developers.
 
 
@@ -226,7 +226,7 @@
 	"menuconfig" <symbol>
 	<config options>
 
-This is similiar to the simple config entry above, but it also gives a
+This is similar to the simple config entry above, but it also gives a
 hint to front ends, that all suboptions should be displayed as a
 separate list of options.
 
diff -ru a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
--- a/Documentation/kbuild/makefiles.txt	2006-07-30 15:57:21.000000000 -0400
+++ b/Documentation/kbuild/makefiles.txt	2006-08-01 10:59:45.000000000 -0400
@@ -435,8 +435,8 @@
 	and $(cflags-y) will be assigned the values -a32 and -m32.
 
     cc-option-align
-	gcc version >= 3.0 shifted type of options used to speify
-	alignment of functions, loops etc. $(cc-option-align) whrn used
+	gcc version >= 3.0 shifted the type of options used to specify
+	alignment of functions, loops etc. $(cc-option-align) when used
 	as prefix to the align options will select the right prefix:
 	gcc < 3.00
 		cc-option-align = -malign
diff -ru a/Documentation/networking/slicecom.txt b/Documentation/networking/slicecom.txt
--- a/Documentation/networking/slicecom.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/networking/slicecom.txt	2006-08-01 10:59:45.000000000 -0400
@@ -262,7 +262,7 @@
 //	initialised.
 // AUXP - Auxiliary Pattern Indication - 01010101.. received.
 // LFA  - Loss of Frame Alignment - no frame sync received.
-// RRA  - Receive Remote Alarm - the remote end's OK, but singnals error cond.
+// RRA  - Receive Remote Alarm - the remote end's OK, but signals error cond.
 // LMFA - Loss of CRC4 Multiframe Alignment - no CRC4 multiframe sync.
 // NMF  - No Multiframe alignment Found after 400 msec - no such alarm using
 //	no-crc4 or crc4 framing, see below.
@@ -364,6 +364,6 @@
 
 	# echo >lbireg 0x1d 0x21
 
-		- Swithing the loop off:
+		- Switching the loop off:
 
 	# echo >lbireg 0x1d 0x00
diff -ru a/Documentation/networking/smctr.txt b/Documentation/networking/smctr.txt
--- a/Documentation/networking/smctr.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/networking/smctr.txt	2006-08-01 10:59:45.000000000 -0400
@@ -11,7 +11,7 @@
 in the kernel configuration. A choice for SMC Token Ring adapters will
 appear. This drives supports all SMC ISA/MCA adapters. Choose this
 option. I personally recommend compiling the driver as a module (M), but if you
-you would like to compile it staticly answer Y instead.
+you would like to compile it statically answer Y instead.
 
 This driver supports multiple adapters without the need to load multiple copies
 of the driver. You should be able to load up to 7 adapters without any kernel
diff -ru a/Documentation/networking/tms380tr.txt b/Documentation/networking/tms380tr.txt
--- a/Documentation/networking/tms380tr.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/networking/tms380tr.txt	2006-08-01 10:59:45.000000000 -0400
@@ -24,7 +24,7 @@
 in the kernel configuration. A choice for SysKonnect Token Ring adapters will
 appear. This drives supports all SysKonnect ISA and PCI adapters. Choose this
 option. I personally recommend compiling the driver as a module (M), but if you
-you would like to compile it staticly answer Y instead.
+you would like to compile it statically answer Y instead.
 
 This driver supports multiple adapters without the need to load multiple copies
 of the driver. You should be able to load up to 7 adapters without any kernel
diff -ru a/Documentation/networking/wan-router.txt b/Documentation/networking/wan-router.txt
--- a/Documentation/networking/wan-router.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/networking/wan-router.txt	2006-08-01 10:59:45.000000000 -0400
@@ -349,7 +349,7 @@
 				Streaming HDLC API has been taken out.  
 				 Available as a patch.                 
 
-2.0.6   Aug 17, 1999		Increased debugging in statup scripts
+2.0.6   Aug 17, 1999		Increased debugging in startup scripts
 				Fixed insallation bugs from 2.0.5
 				Kernel patch works for both 2.2.10 and 2.2.11 kernels.
 				There is no functional difference between the two packages         
diff -ru a/Documentation/power/tricks.txt b/Documentation/power/tricks.txt
--- a/Documentation/power/tricks.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/power/tricks.txt	2006-08-01 10:59:45.000000000 -0400
@@ -9,7 +9,7 @@
 
 * turn off APIC and preempt
 
-* use ext2. At least it has working fsck. [If something seemes to go
+* use ext2. At least it has working fsck. [If something seems to go
   wrong, force fsck when you have a chance]
 
 * turn off modules
diff -ru a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
--- a/Documentation/powerpc/booting-without-of.txt	2006-07-30 15:57:21.000000000 -0400
+++ b/Documentation/powerpc/booting-without-of.txt	2006-08-01 11:01:23.000000000 -0400
@@ -550,11 +550,11 @@
      * [child nodes if any]
      * token OF_DT_END_NODE (that is 0x00000002)
 
-So the node content can be summmarised as a start token, a full path,
-a list of properties, a list of child node and an end token. Every
+So the node content can be summarised as a start token, a full path,
+a list of properties, a list of child nodes, and an end token. Every
 child node is a full node structure itself as defined above.
 
-4) Device tree 'strings" block
+4) Device tree "strings" block
 
 In order to save space, property names, which are generally redundant,
 are stored separately in the "strings" block. This block is simply the
diff -ru a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
--- a/Documentation/RCU/whatisRCU.txt	2006-07-30 15:57:21.000000000 -0400
+++ b/Documentation/RCU/whatisRCU.txt	2006-08-01 10:59:45.000000000 -0400
@@ -582,7 +582,7 @@
 and release a global reader-writer lock.  The synchronize_rcu()
 primitive write-acquires this same lock, then immediately releases
 it.  This means that once synchronize_rcu() exits, all RCU read-side
-critical sections that were in progress before synchonize_rcu() was
+critical sections that were in progress before synchronize_rcu() was
 called are guaranteed to have completed -- there is no way that
 synchronize_rcu() would have been able to write-acquire the lock
 otherwise.
diff -ru a/Documentation/rocket.txt b/Documentation/rocket.txt
--- a/Documentation/rocket.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/rocket.txt	2006-08-01 10:59:45.000000000 -0400
@@ -97,7 +97,7 @@
 requires a 68-byte contiguous block of I/O addresses, starting at one
 of the following: 0x100h, 0x140h, 0x180h, 0x200h, 0x240h, 0x280h,
 0x300h, 0x340h, 0x380h.  This I/O address must be reflected in the DIP
-switiches of *all* of the Rocketport cards.
+switches of *all* of the Rocketport cards.
 
 The second, third, and fourth RocketPort cards require a 64-byte
 contiguous block of I/O addresses, starting at one of the following
diff -ru a/Documentation/s390/Debugging390.txt b/Documentation/s390/Debugging390.txt
--- a/Documentation/s390/Debugging390.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/s390/Debugging390.txt	2006-08-01 11:07:18.000000000 -0400
@@ -317,9 +317,9 @@
 defined in linux/include/linux/sched.h
 The S390 on initialisation & resuming of a process on a cpu sets
 the __LC_KERNEL_STACK variable in the spare prefix area for this cpu
-( which we use for per processor globals).
+(which we use for per-processor globals).
 
-The kernel stack pointer is intimately tied with the task stucture for
+The kernel stack pointer is intimately tied with the task structure for
 each processor as follows.
 
                       s/390
@@ -974,8 +974,9 @@
 
 Example 3
 ---------
-Getting sophistocated
-telnetd crashes on & I don't know why
+Getting sophisticated
+telnetd crashes & I don't know why
+
 Steps
 -----
 1) Replace the following line in /etc/inetd.conf
@@ -1673,11 +1674,11 @@
 channel is idle & the second for device end ( secondary status ) sometimes you get both
 concurrently, you check how the IO went on by issuing a TEST SUBCHANNEL at each interrupt,
 from which you receive an Interruption response block (IRB). If you get channel & device end 
-status in the IRB without channel checks etc. your IO probably went okay. If you didn't you
-probably need a doctorto examine the IRB & extended status word etc.
-If an error occurs more sophistocated control units have a facitity known as
-concurrent sense this means that if an error occurs Extended sense information will
-be presented in the Extended status word in the IRB if not you have to issue a
+status in the IRB without channel checks etc., your IO probably went okay. If you didn't, you
+probably need a doctor to examine the IRB & extended status word, etc.
+If an error occurs, more sophisticated control units have a facility known as
+concurrent sense.  This means that if an error occurs, Extended sense information will
+be presented in the Extended status word in the IRB. If not, you have to issue a
 subsequent SENSE CCW command after the test subchannel. 
 
 
@@ -1837,7 +1838,7 @@
 RECEIVE / LOG TXT A1 ( replace
 8)
 filel & press F11 to look at it
-You should see someting like.
+You should see something like:
 
 00020942' SSCH  B2334000    0048813C    CC 0    SCH 0000    DEV 7C08
           CPA 000FFDF0   PARM 00E2C9C4    KEY 0  FPI C0  LPM 80
@@ -2051,7 +2052,7 @@
 
 directory:
 Adds directories to be searched for source if gdb cannot find the source.
-(note it is a bit sensititive about slashes ) 
+(note it is a bit sensitive about slashes) 
 e.g. To add the root of the filesystem to the searchpath do
 directory //
 
diff -ru a/Documentation/s390/monreader.txt b/Documentation/s390/monreader.txt
--- a/Documentation/s390/monreader.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/s390/monreader.txt	2006-08-01 10:59:45.000000000 -0400
@@ -83,7 +83,7 @@
 
 NOTE:
 -----
-This API provides no interface to control the *MONITOR service, e.g. specifiy
+This API provides no interface to control the *MONITOR service, e.g. specify
 which data should be collected. This can be done by the CP command MONITOR
 (Class E privileged), see "CP Command and Utility Reference".
 
diff -ru a/Documentation/scsi/aacraid.txt b/Documentation/scsi/aacraid.txt
--- a/Documentation/scsi/aacraid.txt	2006-07-30 15:57:21.000000000 -0400
+++ b/Documentation/scsi/aacraid.txt	2006-08-01 10:59:45.000000000 -0400
@@ -4,7 +4,7 @@
 -------------------------
 The aacraid driver adds support for Adaptec (http://www.adaptec.com)
 RAID controllers. This is a major rewrite from the original
-Adaptec supplied driver. It has signficantly cleaned up both the code
+Adaptec supplied driver. It has significantly cleaned up both the code
 and the running binary size (the module is less than half the size of
 the original).
 
diff -ru a/Documentation/scsi/aic79xx.txt b/Documentation/scsi/aic79xx.txt
--- a/Documentation/scsi/aic79xx.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/scsi/aic79xx.txt	2006-08-01 10:59:45.000000000 -0400
@@ -81,7 +81,7 @@
           an SDTR with an offset of 0 to be sure the target
           knows we are async.  This works around a firmware defect
           in the Quantum Atlas 10K.
-        - Implement controller susupend and resume.
+        - Implement controller suspend and resume.
         - Clear PCI error state during driver attach so that we
           don't disable memory mapped I/O due to a stray write
           by some other driver probe that occurred before we
diff -ru a/Documentation/scsi/aic7xxx_old.txt b/Documentation/scsi/aic7xxx_old.txt
--- a/Documentation/scsi/aic7xxx_old.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/scsi/aic7xxx_old.txt	2006-08-01 10:59:45.000000000 -0400
@@ -241,7 +241,7 @@
         that instead of dumping the register contents on the card, this
 	option dumps the contents of the sequencer program RAM.  This gives
 	the ability to verify that the instructions downloaded to the
-	card's sequencer are indeed what they are suppossed to be.  Again,
+	card's sequencer are indeed what they are supposed to be.  Again,
 	unless you have documentation to tell you how to interpret these
 	numbers, then it is totally useless.
 	
diff -ru a/Documentation/scsi/ibmmca.txt b/Documentation/scsi/ibmmca.txt
--- a/Documentation/scsi/ibmmca.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/scsi/ibmmca.txt	2006-08-01 11:12:12.000000000 -0400
@@ -309,9 +309,9 @@
    2.6 Abort & Reset Commands
    --------------------------
    These are implemented with busy waiting for interrupt to arrive.
-   ibmmca_reset() and ibmmca_abort() do not work sufficently well
-   up to now and need still a lot of development work. But, this seems
-   to be even a problem with other SCSI-low level drivers, too. However,
+   ibmmca_reset() and ibmmca_abort() do not work sufficiently well
+   up to now and need still a lot of development work. This seems
+   to be a problem with other low-level SCSI drivers too, however
    this should be no excuse.
 
    2.7 Disk Geometry
@@ -684,8 +684,8 @@
       not like sending commands to non-existing SCSI-devices and will react
       with a command error as a sign of protest. While this error is not
       present on IBM SCSI Adapter w/cache, it appears on IBM Integrated SCSI
-      Adapters. Therefore, I implemented a workarround to forgive those 
-      adapters their protests, but it is marked up in the statisctis, so
+      Adapters. Therefore, I implemented a workaround to forgive those 
+      adapters their protests, but it is marked up in the statistics, so
       after a successful boot, you can see in /proc/scsi/ibmmca/<host_number>
       how often the command errors have been forgiven to the SCSI-subsystem.
       If the number is bigger than 0, you have a SCSI subsystem of older
@@ -778,15 +778,15 @@
 	 not accept this, as they stick quite near to ANSI-SCSI and report
 	 a COMMAND_ERROR message which causes the driver to panic. The main
 	 problem was located around the INQUIRY command. Now, for all the
-	 mentioned commands, the buffersize, sent to the adapter is at 
+	 mentioned commands, the buffersize sent to the adapter is at 
 	 maximum 255 which seems to be a quite reasonable solution. 
-	 TEST_UNIT_READY gets a buffersize of 0 to make sure, that no 
+	 TEST_UNIT_READY gets a buffersize of 0 to make sure that no 
 	 data is transferred in order to avoid any possible command failure.
-      2) On unsuccessful TEST_UNIT_READY, the midlevel-driver has to send
-         a REQUEST_SENSE in order to see, where the problem is located. This
+      2) On unsuccessful TEST_UNIT_READY, the mid-level driver has to send
+         a REQUEST_SENSE in order to see where the problem is located. This
 	 REQUEST_SENSE may have various length in its answer-buffer. IBM
-	 SCSI-subsystems report a command failure, if the returned buffersize
-	 is different from the sent buffersize, but this can be supressed by
+	 SCSI-subsystems report a command failure if the returned buffersize
+	 is different from the sent buffersize, but this can be suppressed by
 	 a special bit, which is now done and problems seem to be solved.
    2) Code adaption to all kernel-releases. Now, the 3.2 code compiles on 
       2.0.x, 2.1.x, 2.2.x and 2.3.x kernel releases without any code-changes.
@@ -1156,7 +1156,7 @@
         Guide) what has to be done for reset, we still share the bad shape of
 	the reset functions with all other low level SCSI-drivers. 
 	Astonishingly, reset works in most cases quite ok, but the harddisks
-	won't run in synchonous mode anymore after a reset, until you reboot.
+	won't run in synchronous mode anymore after a reset, until you reboot.
      Q: Why does my XXX w/Cache adapter not use read-prefetch?
      A: Ok, that is not completely possible. If a cache is present, the 
         adapter tries to use it internally. Explicitly, one can use the cache
diff -ru a/Documentation/scsi/ncr53c8xx.txt b/Documentation/scsi/ncr53c8xx.txt
--- a/Documentation/scsi/ncr53c8xx.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/scsi/ncr53c8xx.txt	2006-08-01 10:59:45.000000000 -0400
@@ -70,7 +70,7 @@
 15. SCSI problem troubleshooting
       15.1 Problem tracking
       15.2 Understanding hardware error reports
-16. Synchonous transfer negotiation tables
+16. Synchronous transfer negotiation tables
       16.1 Synchronous timings for 53C875 and 53C860 Ultra-SCSI controllers
       16.2 Synchronous timings for fast SCSI-2 53C8XX controllers
 17. Serial NVRAM support (by Richard Waltham)
@@ -1382,7 +1382,7 @@
 You are not required to decode and understand them, unless you want to help 
 maintain the driver code.
 
-16. Synchonous transfer negotiation tables
+16. Synchronous transfer negotiation tables
 
 Tables below have been created by calling the routine the driver uses
 for synchronisation negotiation timing calculation and chip setting.
diff -ru a/Documentation/scsi/st.txt b/Documentation/scsi/st.txt
--- a/Documentation/scsi/st.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/scsi/st.txt	2006-08-01 10:59:45.000000000 -0400
@@ -369,7 +369,7 @@
 		the device dependent address. It is recommended to set
 		this flag unless there are tapes using the device
 		dependent (from the old times) (global)
-	     MT_ST_SYSV sets the SYSV sematics (mode)
+	     MT_ST_SYSV sets the SYSV semantics (mode)
 	     MT_ST_NOWAIT enables immediate mode (i.e., don't wait for
 	        the command to finish) for some commands (e.g., rewind)
 	     MT_ST_DEBUGGING debugging (global; debugging must be
diff -ru a/Documentation/scsi/sym53c8xx_2.txt b/Documentation/scsi/sym53c8xx_2.txt
--- a/Documentation/scsi/sym53c8xx_2.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/scsi/sym53c8xx_2.txt	2006-08-01 10:59:45.000000000 -0400
@@ -67,7 +67,7 @@
 Other drivers files are intended not to depend on the Operating System 
 on which the driver is used.
 
-The history of this driver can be summerized as follows:
+The history of this driver can be summarized as follows:
 
 1993: ncr driver written for 386bsd and FreeBSD by:
           Wolfgang Stanglmeier        <wolf@cologne.de>
diff -ru a/Documentation/sound/alsa/CMIPCI.txt b/Documentation/sound/alsa/CMIPCI.txt
--- a/Documentation/sound/alsa/CMIPCI.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/sound/alsa/CMIPCI.txt	2006-08-01 10:59:45.000000000 -0400
@@ -16,11 +16,11 @@
 card#0) for front and 4/6ch playbacks, while the second PCM device
 (hw:0,1) is assigned to the second DAC for rear playback.
 
-There are slight difference between two DACs.
+There are slight differences between the two DACs:
 
 - The first DAC supports U8 and S16LE formats, while the second DAC
   supports only S16LE.
-- The seconde DAC supports only two channel stereo.
+- The second DAC supports only two channel stereo.
 
 Please note that the CM8x38 DAC doesn't support continuous playback
 rate but only fixed rates: 5512, 8000, 11025, 16000, 22050, 32000,
diff -ru a/Documentation/sound/alsa/MIXART.txt b/Documentation/sound/alsa/MIXART.txt
--- a/Documentation/sound/alsa/MIXART.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/sound/alsa/MIXART.txt	2006-08-01 10:59:45.000000000 -0400
@@ -39,7 +39,7 @@
 substreams performing hardware mixing. This could be changed to a
 maximum of 24 substreams if wished.
 Mono files will be played on the left and right channel. Each channel
-can be muted for each stream to use 8 analog/digital outputs seperately.
+can be muted for each stream to use 8 analog/digital outputs separately.
 
 Capture
 -------
diff -ru a/Documentation/sound/alsa/Procfile.txt b/Documentation/sound/alsa/Procfile.txt
--- a/Documentation/sound/alsa/Procfile.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/sound/alsa/Procfile.txt	2006-08-01 10:59:45.000000000 -0400
@@ -161,12 +161,12 @@
 	Lists the currently available ALSA sequencer drivers.
 
 seq/clients
-	Shows the list of currently available sequencer clinets and
+	Shows the list of currently available sequencer clients and
 	ports.  The connection status and the running status are shown
 	in this file, too.
 
 seq/queues
-	Lists the currently allocated/running sequener queues.
+	Lists the currently allocated/running sequencer queues.
 
 seq/timer
 	Lists the currently allocated/running sequencer timers.
diff -ru a/Documentation/usb/mtouchusb.txt b/Documentation/usb/mtouchusb.txt
--- a/Documentation/usb/mtouchusb.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/usb/mtouchusb.txt	2006-08-01 10:59:45.000000000 -0400
@@ -11,7 +11,7 @@
    Changed reset from standard USB dev reset to vendor reset
    Changed data sent to host from compensated to raw coordinates
    Eliminated vendor/product module params
-   Performed multiple successfull tests with an EXII-5010UC
+   Performed multiple successful tests with an EXII-5010UC
 
 SUPPORTED HARDWARE:
 
diff -ru a/Documentation/usb/URB.txt b/Documentation/usb/URB.txt
--- a/Documentation/usb/URB.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/usb/URB.txt	2006-08-01 10:59:45.000000000 -0400
@@ -184,7 +184,7 @@
 Note that even when an error (or unlink) is reported, data may have been
 transferred.  That's because USB transfers are packetized; it might take
 sixteen packets to transfer your 1KByte buffer, and ten of them might
-have transferred succesfully before the completion was called.
+have transferred successfully before the completion was called.
 
 
 NOTE:  ***** WARNING *****

