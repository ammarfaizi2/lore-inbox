Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030411AbWGZGkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbWGZGkU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 02:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030414AbWGZGkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 02:40:19 -0400
Received: from cpe-74-70-38-78.nycap.res.rr.com ([74.70.38.78]:24837 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1030411AbWGZGkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 02:40:17 -0400
Date: Wed, 26 Jul 2006 02:39:56 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org
Subject: [PATCH 18-rc2] Fix typos in /Documentation : 'N'-'P'
Message-Id: <20060726023956.2e72b9d5.kernel1@cyberdogtech.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Wed, 26 Jul 2006 02:39:59 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Wed, 26 Jul 2006 02:40:00 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes typos in various Documentation txts. The patch addresses some words starting with the letters 'N'-'P'.  

Signed-off-by: Matt LaPlante <kernel1@cyberdogtech.com>
--

diff -ru a/Documentation/arm/Samsung-S3C24XX/EB2410ITX.txt b/Documentation/arm/Samsung-S3C24XX/EB2410ITX.txt
--- a/Documentation/arm/Samsung-S3C24XX/EB2410ITX.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/arm/Samsung-S3C24XX/EB2410ITX.txt	2006-07-24 19:35:51.000000000 -0400
@@ -38,7 +38,7 @@
 ---
 
   The NAND and NOR support has been merged from the linux-mtd project.
-  Any prolbems, see http://www.linux-mtd.infradead.org/ for more
+  Any problems, see http://www.linux-mtd.infradead.org/ for more
   information or up-to-date versions of linux-mtd.
 
 
diff -ru a/Documentation/block/as-iosched.txt b/Documentation/block/as-iosched.txt
--- a/Documentation/block/as-iosched.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/block/as-iosched.txt	2006-07-24 19:35:51.000000000 -0400
@@ -99,8 +99,8 @@
 at a time during a write batch.  It is this characteristic that can make
 the anticipatory scheduler perform anomalously with controllers supporting
 TCQ, or with hardware striped RAID devices. Setting the antic_expire
-queue paramter (see below) to zero disables this behavior, and the anticipatory
-scheduler behaves essentially like the deadline scheduler.
+queue parameter (see below) to zero disables this behavior, and the 
+anticipatory scheduler behaves essentially like the deadline scheduler.
 
 When read anticipation is enabled (antic_expire is not zero), reads
 are dispatched to the disk controller one at a time.
diff -ru a/Documentation/block/barrier.txt b/Documentation/block/barrier.txt
--- a/Documentation/block/barrier.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/block/barrier.txt	2006-07-24 19:35:51.000000000 -0400
@@ -42,7 +42,7 @@
 of ii.  Just keeping issue order suffices.  Ancient SCSI
 controllers/drives and IDE drives are in this category.
 
-2. Forced flushing to physcial medium
+2. Forced flushing to physical medium
 
 Again, if you're not gonna do synchronization with disk drives (dang,
 it sounds even more appealing now!), the reason you use I/O barriers
diff -ru a/Documentation/cpu-freq/governors.txt b/Documentation/cpu-freq/governors.txt
--- a/Documentation/cpu-freq/governors.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/cpu-freq/governors.txt	2006-07-24 19:35:40.000000000 -0400
@@ -137,11 +137,11 @@
 If set to '1' then the frequency decreases as quickly as it increases,
 if set to '2' it decreases at half the rate of the increase.
 
-ignore_nice_load: this parameter takes a value of '0' or '1', when set
-to '0' (its default) then all processes are counted towards towards the
-'cpu utilisation' value.   When set to '1' then processes that are
+ignore_nice_load: this parameter takes a value of '0' or '1'. When
+set to '0' (its default), all processes are counted towards the
+'cpu utilisation' value.  When set to '1', the processes that are
 run with a 'nice' value will not count (and thus be ignored) in the
-overal usage calculation.  This is useful if you are running a CPU
+overall usage calculation.  This is useful if you are running a CPU
 intensive calculation on your laptop that you do not care how long it
 takes to complete as you can 'nice' it and prevent it from taking part
 in the deciding process of whether to increase your CPU frequency.
diff -ru a/Documentation/cpu-hotplug.txt b/Documentation/cpu-hotplug.txt
--- a/Documentation/cpu-hotplug.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/cpu-hotplug.txt	2006-07-24 19:35:40.000000000 -0400
@@ -251,7 +251,7 @@
 		return NOTIFY_OK;
 	}
 
-	static struct notifier_block foobar_cpu_notifer =
+	static struct notifier_block foobar_cpu_notifier =
 	{
 	   .notifier_call = foobar_cpu_callback,
 	};
diff -ru a/Documentation/dell_rbu.txt b/Documentation/dell_rbu.txt
--- a/Documentation/dell_rbu.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/dell_rbu.txt	2006-07-24 19:35:40.000000000 -0400
@@ -52,7 +52,7 @@
 In packet update mode the packet size has to be given before any packets can
 be downloaded. It is done as below
 echo XXXX > /sys/devices/platform/dell_rbu/packet_size
-In the packet update mechanism, the user neesd to create a new file having
+In the packet update mechanism, the user needs to create a new file having
 packets of data arranged back to back. It can be done as follows
 The user creates packets header, gets the chunk of the BIOS image and
 placs it next to the packetheader; now, the packetheader + BIOS image chunk
@@ -93,7 +93,7 @@
 NOTE:
 This driver requires a patch for firmware_class.c which has the modified
 request_firmware_nowait function.
-Also after updating the BIOS image an user mdoe application neeeds to execute
+Also after updating the BIOS image an user mode application needs to execute
 code which message the BIOS update request to the BIOS. So on the next reboot
 the BIOS knows about the new image downloaded and it updates it self.
 Also don't unload the rbu drive if the image has to be updated.
Only in b/Documentation: dell_rbu.txt.orig
diff -ru a/Documentation/devices.txt b/Documentation/devices.txt
--- a/Documentation/devices.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/devices.txt	2006-07-24 19:35:51.000000000 -0400
@@ -2005,7 +2005,7 @@
 116 char	Advanced Linux Sound Driver (ALSA)
 
 116 block       MicroMemory battery backed RAM adapter (NVRAM)
-                Supports 16 boards, 15 paritions each.
+                Supports 16 boards, 15 partitions each.
                 Requested by neilb at cse.unsw.edu.au.
 
 		 0 = /dev/umem/d0      Whole of first board
@@ -3091,7 +3091,7 @@
 		This major is reserved to assist the expansion to a
 		larger number space.  No device nodes with this major
 		should ever be created on the filesystem.
-		(This is probaly not true anymore, but I'll leave it
+		(This is probably not true anymore, but I'll leave it
 		for now /Torben)
 
 ---LARGE MAJORS!!!!!---
diff -ru a/Documentation/dvb/avermedia.txt b/Documentation/dvb/avermedia.txt
--- a/Documentation/dvb/avermedia.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/dvb/avermedia.txt	2006-07-24 19:35:51.000000000 -0400
@@ -45,9 +45,9 @@
    by  circuitry on the card and is often presented uncompressed.
    For  a PAL TV signal encoded at a resolution of 768x576 24-bit
    color pixels over 25 frames per second - a fair amount of data
-   is  generated and must be proceesed by the PC before it can be
+   is  generated and must be processed by the PC before it can be
    displayed  on the video monitor screen. Some Analogue TV cards
-   for  PC's  have  onboard  MPEG2  encoders which permit the raw
+   for  PCs  have  onboard  MPEG2  encoders  which permit the raw
    digital  data  stream  to be presented to the PC in an encoded
    and  compressed  form  -  similar  to the form that is used in
    Digital TV.
diff -ru a/Documentation/dvb/faq.txt b/Documentation/dvb/faq.txt
--- a/Documentation/dvb/faq.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/dvb/faq.txt	2006-07-24 19:35:51.000000000 -0400
@@ -5,7 +5,7 @@
 	It's not a bug, it's a feature. Because the frontends have
 	significant power requirements (and hence get very hot), they
 	are powered down if they are unused (i.e. if the frontend device
-	is closed). The dvb-core.o module paramter "dvb_shutdown_timeout"
+	is closed). The dvb-core.o module parameter "dvb_shutdown_timeout"
 	allow you to change the timeout (default 5 seconds). Setting the
 	timeout to 0 disables the timeout feature.
 
diff -ru a/Documentation/eisa.txt b/Documentation/eisa.txt
--- a/Documentation/eisa.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/eisa.txt	2006-07-24 19:35:40.000000000 -0400
@@ -84,7 +84,7 @@
 
 id_table	: an array of NULL terminated EISA id strings,
 		  followed by an empty string. Each string can
-		  optionnaly be paired with a driver-dependant value
+		  optionally be paired with a driver-dependant value
 		  (driver_data).
 
 driver		: a generic driver, such as described in
diff -ru a/Documentation/fb/sstfb.txt b/Documentation/fb/sstfb.txt
--- a/Documentation/fb/sstfb.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/fb/sstfb.txt	2006-07-24 19:35:40.000000000 -0400
@@ -72,8 +72,8 @@
 
 Kernel/Modules Options
 
-	You can pass some otions to sstfb module, and via the kernel command
-	line when the driver is compiled in :
+	You can pass some options to the sstfb module, or via the kernel 
+	command line when the driver is compiled in:
 	for module : insmod sstfb.o option1=value1 option2=value2 ...
 	in kernel :  video=sstfb:option1,option2:value2,option3 ...
 	
diff -ru a/Documentation/filesystems/befs.txt b/Documentation/filesystems/befs.txt
--- a/Documentation/filesystems/befs.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/filesystems/befs.txt	2006-07-24 19:35:40.000000000 -0400
@@ -22,7 +22,7 @@
 details.
 
 Original Author: Makoto Kato <m_kato@ga2.so-net.ne.jp>
-His orriginal code can still be found at:
+His original code can still be found at:
 <http://hp.vector.co.jp/authors/VA008030/bfs/>
 Does anyone know of a more current email address for Makoto? He doesn't
 respond to the address given above...
@@ -39,7 +39,7 @@
 ================
 Be, Inc said, "BeOS Filesystem is officially called BFS, not BeFS". 
 But Unixware Boot Filesystem is called bfs, too. And they are already in
-the kernel. Because of this nameing conflict, on Linux the BeOS
+the kernel. Because of this naming conflict, on Linux the BeOS
 filesystem is called befs.
 
 HOW TO INSTALL
diff -ru a/Documentation/filesystems/ext2.txt b/Documentation/filesystems/ext2.txt
--- a/Documentation/filesystems/ext2.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/filesystems/ext2.txt	2006-07-24 19:35:51.000000000 -0400
@@ -205,7 +205,7 @@
 
 In ext2, there is a mechanism for reserving a certain number of blocks
 for a particular user (normally the super-user).  This is intended to
-allow for the system to continue functioning even if non-priveleged users
+allow for the system to continue functioning even if non-privileged users
 fill up all the space available to them (this is independent of filesystem
 quotas).  It also keeps the filesystem from filling up entirely which
 helps combat fragmentation.
diff -ru a/Documentation/filesystems/spufs.txt b/Documentation/filesystems/spufs.txt
--- a/Documentation/filesystems/spufs.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/filesystems/spufs.txt	2006-07-24 19:35:40.000000000 -0400
@@ -359,7 +359,7 @@
        EFAULT npc is not a valid pointer or status is neither NULL nor a valid
               pointer.
 
-       EINTR  A signal occured while spu_run was in progress.  The  npc  value
+       EINTR  A signal occurred while spu_run was in progress.  The npc  value
               has  been updated to the new program counter value if necessary.
 
        EINVAL fd is not a file descriptor returned from spu_create(2).
diff -ru a/Documentation/hrtimers.txt b/Documentation/hrtimers.txt
--- a/Documentation/hrtimers.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/hrtimers.txt	2006-07-24 19:35:40.000000000 -0400
@@ -27,7 +27,7 @@
   high-res timers.
 
 - the unpredictable [O(N)] overhead of cascading leads to delays which
-  necessiate a more complex handling of high resolution timers, which
+  necessitate a more complex handling of high resolution timers, which
   in turn decreases robustness. Such a design still led to rather large
   timing inaccuracies. Cascading is a fundamental property of the timer
   wheel concept, it cannot be 'designed out' without unevitably
diff -ru a/Documentation/input/iforce-protocol.txt b/Documentation/input/iforce-protocol.txt
--- a/Documentation/input/iforce-protocol.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/input/iforce-protocol.txt	2006-07-24 19:35:51.000000000 -0400
@@ -97,7 +97,7 @@
 *** Attack and fade ***
 OP=  02
 LEN= 08
-00-01 Address where to store the parameteres
+00-01 Address where to store the parameters
 02-03 Duration of attack (little endian encoding, in ms)
 04 Level at end of attack. Signed byte.
 05-06 Duration of fade.
@@ -239,8 +239,9 @@
 3. Play the effect, and watch what happens on the spy screen.
 
 A few words about ComPortSpy:
-At first glance, this soft seems, hum, well... buggy. In fact, data appear with a few seconds latency. Personnaly, I restart it every time I play an effect.
-Remember it's free (as in free beer) and alpha!
+At first glance, this soft seems, hum, well... buggy. In fact, data appear with a few 
+seconds latency. Personally, I restart it every time I play an effect.  Remember it's 
+free (as in free beer) and alpha!
 
 ** URLS **
 Check www.immerse.com for Immersion Studio, and www.fcoder.com for ComPortSpy.
diff -ru a/Documentation/input/joystick-parport.txt b/Documentation/input/joystick-parport.txt
--- a/Documentation/input/joystick-parport.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/input/joystick-parport.txt	2006-07-24 19:35:51.000000000 -0400
@@ -465,8 +465,8 @@
 
   There are two options specific to PSX driver portion.  gamecon.psx_delay sets
 the command delay when talking to the controllers. The default of 25 should
-work but you can try lowering it for better performace. If your pads don't
-respond try raising it untill they work. Setting the type to 8 allows the
+work but you can try lowering it for better performance. If your pads don't
+respond try raising it until they work. Setting the type to 8 allows the
 driver to be used with Dance Dance Revolution or similar games. Arrow keys are
 registered as key presses instead of X and Y axes.
 
diff -ru a/Documentation/lockdep-design.txt b/Documentation/lockdep-design.txt
--- a/Documentation/lockdep-design.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/lockdep-design.txt	2006-07-24 19:35:40.000000000 -0400
@@ -148,7 +148,7 @@
 
 The validator achieves perfect, mathematical 'closure' (proof of locking
 correctness) in the sense that for every simple, standalone single-task
-locking sequence that occured at least once during the lifetime of the
+locking sequence that occurred at least once during the lifetime of the
 kernel, the validator proves it with a 100% certainty that no
 combination and timing of these locking sequences can cause any class of
 lock related deadlock. [*]
diff -ru a/Documentation/md.txt b/Documentation/md.txt
--- a/Documentation/md.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/md.txt	2006-07-24 19:35:51.000000000 -0400
@@ -337,7 +337,7 @@
         This gives the role that the device has in the array.  It will
 	either be 'none' if the device is not active in the array
         (i.e. is a spare or has failed) or an integer less than the
-	'raid_disks' number for the array indicating which possition
+	'raid_disks' number for the array indicating which position
 	it currently fills.  This can only be set while assembling an
 	array.  A device for which this is set is assumed to be working.
 
@@ -360,7 +360,7 @@
 
     rdNN
 
-where 'NN' is the possition in the array, starting from 0.
+where 'NN' is the position in the array, starting from 0.
 So for a 3 drive array there will be rd0, rd1, rd2.
 These are symbolic links to the appropriate 'dev-XXX' entry.
 Thus, for example,
diff -ru a/Documentation/networking/gen_stats.txt b/Documentation/networking/gen_stats.txt
--- a/Documentation/networking/gen_stats.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/networking/gen_stats.txt	2006-07-24 19:35:40.000000000 -0400
@@ -79,8 +79,8 @@
 
 0) Prepare an estimator attribute. Most likely this would be in user
    space. The value of this TLV should contain a tc_estimator structure.
-   As usual, such a TLV nees to be 32 bit aligned and therefore the
-   length needs to be appropriately set etc. The estimator interval
+   As usual, such a TLV needs to be 32 bit aligned and therefore the
+   length needs to be appropriately set, etc. The estimator interval
    and ewma log need to be converted to the appropriate values.
    tc_estimator.c::tc_setup_estimator() is advisable to be used as the
    conversion routine. It does a few clever things. It takes a time
diff -ru a/Documentation/networking/packet_mmap.txt b/Documentation/networking/packet_mmap.txt
--- a/Documentation/networking/packet_mmap.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/networking/packet_mmap.txt	2006-07-24 19:35:40.000000000 -0400
@@ -278,7 +278,7 @@
 All memory allocations are not freed until the socket is closed. The memory 
 allocations are done with GFP_KERNEL priority, this basically means that 
 the allocation can wait and swap other process' memory in order to allocate 
-the nececessary memory, so normally limits can be reached.
+the necessary memory, so normally limits can be reached.
 
  Other constraints
 -------------------
diff -ru a/Documentation/networking/sk98lin.txt b/Documentation/networking/sk98lin.txt
--- a/Documentation/networking/sk98lin.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/networking/sk98lin.txt	2006-07-24 19:35:51.000000000 -0400
@@ -180,7 +180,7 @@
 1. Insert a line of the form :
    options sk98lin ...
    For "...", the same syntax is required as described for the command
-   line paramaters of modprobe below.
+   line parameters of modprobe below.
 2. To activate the new parameters, either reboot your computer
    or 
    unload and reload the driver.
@@ -364,9 +364,9 @@
 Values:       30...40000 (interrupts per second)
 Default:      2000
 
-This parameter is only used, if either static or dynamic interrupt moderation
-is used on a network adapter card. Using this paramter if no moderation is
-applied, will lead to no action performed.
+This parameter is only used if either static or dynamic interrupt moderation
+is used on a network adapter card. Using this parameter if no moderation is
+applied will lead to no action performed.
 
 This parameter determines the length of any interrupt moderation interval. 
 Assuming that static interrupt moderation is to be used, an 'IntsPerSec' 
diff -ru a/Documentation/networking/vortex.txt b/Documentation/networking/vortex.txt
--- a/Documentation/networking/vortex.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/networking/vortex.txt	2006-07-24 19:35:40.000000000 -0400
@@ -359,13 +359,13 @@
 
    Eliminate some variables: try different cards, different
    computers, different cables, different ports on the switch/hub,
-   different versions of the kernel or ofthe driver, etc.
+   different versions of the kernel or of the driver, etc.
 
 - OK, it's a driver problem.
 
    You need to generate a report.  Typically this is an email to the
    maintainer and/or linux-net@vger.kernel.org.  The maintainer's
-   email address will be inthe driver source or in the MAINTAINERS file.
+   email address will be in the driver source or in the MAINTAINERS file.
 
 - The contents of your report will vary a lot depending upon the
   problem.  If it's a kernel crash then you should refer to the
diff -ru a/Documentation/networking/wan-router.txt b/Documentation/networking/wan-router.txt
--- a/Documentation/networking/wan-router.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/networking/wan-router.txt	2006-07-24 19:35:51.000000000 -0400
@@ -214,7 +214,7 @@
 /usr/local/wanrouter/patches/kdrivers:
 	Sources of the latest WANPIPE device drivers.
 	These are used to UPGRADE the linux kernel to the newest
-	version if the kernel source has already been pathced with
+	version if the kernel source has already been patched with
 	WANPIPE drivers.
 
 /usr/local/wanrouter/samples:
@@ -438,7 +438,7 @@
 				  2.2.X kernels only
 
 				o Secured the driver UDP debugging calls
-					- All illegal netowrk debugging calls are reported to
+					- All illegal network debugging calls are reported to
 					  the log.
 					- Defined a set of allowed commands, all other denied.
 					
@@ -451,7 +451,7 @@
 
 				o Keyboard Led Monitor/Debugger
 					- A new utilty /usr/sbin/wpkbdmon uses keyboard leds
-					  to convey operatinal statistic information of the 
+					  to convey operational statistic information of the 
 					  Sangoma WANPIPE cards.
 					NUM_LOCK    = Line State  (On=connected,    Off=disconnected)
 					CAPS_LOCK   = Tx data     (On=transmitting, Off=no tx data)
@@ -470,7 +470,7 @@
 				o Fixed the Frame Relay and Chdlc network interfaces so they are
 				  compatible with libpcap libraries.  Meaning, tcpdump, snort,
 				  ethereal, and all other packet sniffers and debuggers work on
-				  all WANPIPE netowrk interfaces.
+				  all WANPIPE network interfaces.
 					- Set the network interface encoding type to ARPHRD_PPP.
 					  This tell the sniffers that data obtained from the
 					  network interface is in pure IP format.
diff -ru a/Documentation/power/devices.txt b/Documentation/power/devices.txt
--- a/Documentation/power/devices.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/power/devices.txt	2006-07-24 19:35:51.000000000 -0400
@@ -193,7 +193,7 @@
 once on suspending kernel, once on resuming kernel. event = FREEZE,
 flags = DURING_SUSPEND or DURING_RESUME
 
-Device detach requested from /sys -- deinitialize device; proably same as
+Device detach requested from /sys -- deinitialize device; probably same as
 SYSTEM_SHUTDOWN, I do not understand this one too much. probably event
 = FREEZE, flags = DEV_DETACH.
 
diff -ru a/Documentation/power/userland-swsusp.txt b/Documentation/power/userland-swsusp.txt
--- a/Documentation/power/userland-swsusp.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/power/userland-swsusp.txt	2006-07-24 19:35:51.000000000 -0400
@@ -91,7 +91,7 @@
 still frozen when the device is being closed).
 
 Currently it is assumed that the userland utilities reading/writing the
-snapshot image from/to the kernel will use a swap parition, called the resume
+snapshot image from/to the kernel will use a swap partition, called the resume
 partition, as storage space.  However, this is not really required, as they
 can use, for example, a special (blank) suspend partition or a file on a partition
 that is unmounted before SNAPSHOT_ATOMIC_SNAPSHOT and mounted afterwards.
diff -ru a/Documentation/power/video.txt b/Documentation/power/video.txt
--- a/Documentation/power/video.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/power/video.txt	2006-07-24 19:35:40.000000000 -0400
@@ -16,7 +16,7 @@
 that.
 
 We either have to run video BIOS during early resume, or interpret it
-using vbetool later, or maybe nothing is neccessary on particular
+using vbetool later, or maybe nothing is necessary on particular
 system because video state is preserved. Unfortunately different
 methods work on different systems, and no known method suits all of
 them.
diff -ru a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
--- a/Documentation/powerpc/booting-without-of.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/powerpc/booting-without-of.txt	2006-07-24 19:35:51.000000000 -0400
@@ -630,12 +630,11 @@
 prom_parse.c file of the recent kernels for your bus type.
 
 The "reg" property only defines addresses and sizes (if #size-cells
-is
-non-0) within a given bus. In order to translate addresses upward
+is non-0) within a given bus. In order to translate addresses upward
 (that is into parent bus addresses, and possibly into cpu physical
 addresses), all busses must contain a "ranges" property. If the
 "ranges" property is missing at a given level, it's assumed that
-translation isn't possible. The format of the "ranges" proprety for a
+translation isn't possible. The format of the "ranges" property for a
 bus is a list of:
 
 	bus address, parent bus address, size
diff -ru a/Documentation/s390/cds.txt b/Documentation/s390/cds.txt
--- a/Documentation/s390/cds.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/s390/cds.txt	2006-07-24 19:35:51.000000000 -0400
@@ -177,11 +177,11 @@
 The function is meant to be called with an irq handler in place; that is,
 at earliest during set_online() processing.
 
-While the request is procesed synchronously, the device interrupt
+While the request is processed synchronously, the device interrupt
 handler is called for final ending status. In case of error situations the
 interrupt handler may recover appropriately. The device irq handler can
 recognize the corresponding interrupts by the interruption parameter be
-0x00524443.The ccw_device must not be locked prior to calling read_dev_chars().
+0x00524443. The ccw_device must not be locked prior to calling read_dev_chars().
 
 The function may be called enabled or disabled.
 
diff -ru a/Documentation/s390/crypto/crypto-API.txt b/Documentation/s390/crypto/crypto-API.txt
--- a/Documentation/s390/crypto/crypto-API.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/s390/crypto/crypto-API.txt	2006-07-24 19:35:51.000000000 -0400
@@ -61,9 +61,9 @@
 		-> when the sha1 algorithm is requested through the crypto API
 		(which has a module autoloader) the z990 module will be loaded.
 
-TBD:	a userspace module probin mechanism
+TBD:	a userspace module probing mechanism
 	something like 'probe sha1 sha1_z990 sha1' in modprobe.conf
-	-> try module sha1_z990, if it fails to load load standard module sha1
+	-> try module sha1_z990, if it fails to load standard module sha1
 	the 'probe' statement is currently not supported in modprobe.conf
 
 
diff -ru a/Documentation/s390/Debugging390.txt b/Documentation/s390/Debugging390.txt
--- a/Documentation/s390/Debugging390.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/s390/Debugging390.txt	2006-07-24 19:35:51.000000000 -0400
@@ -366,8 +366,8 @@
 Overview:
 ---------
 This is the code that gcc produces at the top & the bottom of
-each function, it usually is fairly consistent & similar from 
-function to function & if you know its layout you can probalby
+each function. It usually is fairly consistent & similar from 
+function to function & if you know its layout you can probably
 make some headway in finding the ultimate cause of a problem
 after a crash without a source level debugger.
 
@@ -1704,7 +1704,7 @@
 IOP's can use one or more links ( known as channel paths ) to talk to each 
 IO device. It first checks for path availability & chooses an available one,
 then starts ( & sometimes terminates IO ).
-There are two types of channel path ESCON & the Paralell IO interface.
+There are two types of channel path ESCON & the Parallel IO interface.
 
 IO devices are attached to control units, control units provide the
 logic to interface the channel paths & channel path IO protocols to 
@@ -1743,11 +1743,11 @@
 
 The 390 IO systems come in 2 flavours the current 390 machines support both
 
-The Older 360 & 370 Interface,sometimes called the paralell I/O interface,
+The Older 360 & 370 Interface, sometimes called the Parallel I/O interface,
 sometimes called Bus-and Tag & sometimes Original Equipment Manufacturers
 Interface (OEMI).
 
-This byte wide paralell channel path/bus has parity & data on the "Bus" cable 
+This byte wide Parallel channel path/bus has parity & data on the "Bus" cable 
 & control lines on the "Tag" cable. These can operate in byte multiplex mode for
 sharing between several slow devices or burst mode & monopolize the channel for the
 whole burst. Upto 256 devices can be addressed  on one of these cables. These cables are
@@ -1777,7 +1777,7 @@
 DASD's direct access storage devices ( otherwise known as hard disks ).
 Tape Drives.
 CTC ( Channel to Channel Adapters ),
-ESCON or Paralell Cables used as a very high speed serial link
+ESCON or Parallel Cables used as a very high speed serial link
 between 2 machines. We use 2 cables under linux to do a bi-directional serial link.
 
 
@@ -1803,8 +1803,8 @@
 OSA  7C14 ON OSA   7C14 SUBCHANNEL = 0002
 OSA  7C15 ON OSA   7C15 SUBCHANNEL = 0003
 
-If you have a guest with certain priviliges you may be able to see devices
-which don't belong to you to avoid this do add the option V.
+If you have a guest with certain privileges you may be able to see devices
+which don't belong to you. To avoid this, add the option V.
 e.g.
 Q V OSA
 
Only in b/Documentation/s390: Debugging390.txt.orig
diff -ru a/Documentation/s390/s390dbf.txt b/Documentation/s390/s390dbf.txt
--- a/Documentation/s390/s390dbf.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/s390/s390dbf.txt	2006-07-24 19:35:51.000000000 -0400
@@ -83,8 +83,8 @@
 It is also possible to deactivate the debug feature globally for every
 debug log. You can change the behavior using  2 sysctl parameters in
 /proc/sys/s390dbf:
-There are currently 2 possible triggers, which stop the  debug feature
-globally. The first possbility is to use the "debug_active" sysctl. If
+There are currently 2 possible triggers, which stop the debug feature
+globally. The first possibility is to use the "debug_active" sysctl. If
 set to 1 the debug feature is running. If "debug_active" is set to 0 the
 debug feature is turned off.
 The second trigger which stops the debug feature is an kernel oops.
diff -ru a/Documentation/scsi/aic79xx.txt b/Documentation/scsi/aic79xx.txt
--- a/Documentation/scsi/aic79xx.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/scsi/aic79xx.txt	2006-07-24 19:35:40.000000000 -0400
@@ -94,7 +94,7 @@
         - Add support for scsi_report_device_reset() found in
           2.5.X kernels.
         - Add 7901B support.
-        - Simplify handling of the packtized lun Rev A workaround.
+        - Simplify handling of the packetized lun Rev A workaround.
         - Correct and simplify handling of the ignore wide residue
           message.  The previous code would fail to report a residual
           if the transaction data length was even and we received
diff -ru a/Documentation/scsi/dc395x.txt b/Documentation/scsi/dc395x.txt
--- a/Documentation/scsi/dc395x.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/scsi/dc395x.txt	2006-07-24 19:35:40.000000000 -0400
@@ -20,7 +20,7 @@
 ----------
 The driver uses the settings from the EEPROM set in the SCSI BIOS 
 setup. If there is no EEPROM, the driver uses default values.
-Both can be overriden by command line parameters (module or kernel
+Both can be overridden by command line parameters (module or kernel
 parameters).
 
 The following parameters are available:
diff -ru a/Documentation/scsi/ibmmca.txt b/Documentation/scsi/ibmmca.txt
--- a/Documentation/scsi/ibmmca.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/scsi/ibmmca.txt	2006-07-24 19:35:51.000000000 -0400
@@ -1086,7 +1086,7 @@
    
      Q: "Reset SCSI-devices at boottime" halts the system at boottime, why?
      A: This is only tested with the IBM SCSI Adapter w/cache. It is not
-        yet prooved to run on other adapters, however you may be lucky.
+        yet proven to run on other adapters, however you may be lucky.
 	In version 3.1d this has been hugely improved and should work better,
 	now. Normally you really won't need to activate this flag in the
 	kernel configuration, as all post 1989 SCSI-devices should accept
diff -ru a/Documentation/scsi/ncr53c8xx.txt b/Documentation/scsi/ncr53c8xx.txt
--- a/Documentation/scsi/ncr53c8xx.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/scsi/ncr53c8xx.txt	2006-07-24 19:38:14.000000000 -0400
@@ -206,7 +206,7 @@
 The 896 and the 895A allows handling of the phase mismatch context from 
 SCRIPTS (avoids the phase mismatch interrupt that stops the SCSI processor 
 until the C code has saved the context of the transfer).
-Implementing this without using LOAD/STORE instructions would be painfull 
+Implementing this without using LOAD/STORE instructions would be painful 
 and I did'nt even want to try it.
 
 The 896 chip supports 64 bit PCI transactions and addressing, while the 
@@ -631,8 +631,8 @@
 
 A boot setup command for the ncr53c8xx (sym53c8xx) driver begins with the 
 driver name "ncr53c8xx="(sym53c8xx). The kernel syntax parser then expects 
-an optionnal list of integers separated with comma followed by an optional 
-list of  comma-separated strings. Example of boot setup command under lilo 
+an optional list of integers separated with comma followed by an optional 
+list of comma-separated strings. Example of boot setup command under lilo 
 prompt:
 
 lilo: linux root=/dev/hda2 ncr53c8xx=tags:4,sync:10,debug:0x200
@@ -899,7 +899,7 @@
     ncr53c8xx=safe:y,mpar:y
     ncr53c8xx=safe:y
 
-My personnal system works flawlessly with the following equivalent setup:
+My personal system works flawlessly with the following equivalent setup:
 
    ncr53c8xx=mpar:y,spar:y,disc:y,specf:1,fsn:n,ultra:2,fsn:n,revprob:n,verb:1\
              tags:32,sync:12,debug:0,burst:7,led:1,wide:1,settle:2,diff:0,irqm:0
Only in b/Documentation/scsi: ncr53c8xx.txt.orig
Only in b/Documentation/scsi: ncr53c8xx.txt.rej
diff -ru a/Documentation/scsi/NinjaSCSI.txt b/Documentation/scsi/NinjaSCSI.txt
--- a/Documentation/scsi/NinjaSCSI.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/scsi/NinjaSCSI.txt	2006-07-24 19:35:51.000000000 -0400
@@ -59,7 +59,7 @@
 ...
 $ make
 
-[5] Copy nsp_cs.o to suitable plase, like /lib/modules/<Kernel version>/pcmcia/ .
+[5] Copy nsp_cs.o to a suitable place, like /lib/modules/<Kernel version>/pcmcia/ .
 
 [6] Add these lines to /etc/pcmcia/config .
     If you yse pcmcia-cs-3.1.8 or later, we can use "nsp_cs.conf" file.
diff -ru a/Documentation/scsi/scsi-changer.txt b/Documentation/scsi/scsi-changer.txt
--- a/Documentation/scsi/scsi-changer.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/scsi/scsi-changer.txt	2006-07-24 19:35:51.000000000 -0400
@@ -31,7 +31,7 @@
   media transport - this one shuffles around the media, i.e. the
                     transport arm.  Also known as "picker".
   storage         - a slot which can hold a media.
-  import/export   - the same as above, but is accessable from outside,
+  import/export   - the same as above, but is accessible from outside,
                     i.e. there the operator (you !) can use this to
                     fill in and remove media from the changer.
 		    Sometimes named "mailslot".
diff -ru a/Documentation/sound/alsa/CMIPCI.txt b/Documentation/sound/alsa/CMIPCI.txt
--- a/Documentation/sound/alsa/CMIPCI.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/sound/alsa/CMIPCI.txt	2006-07-24 19:35:51.000000000 -0400
@@ -76,7 +76,7 @@
 
 	% aplay -Dsurround51 sixchannels.wav
 
-For programmin the 4/6 channel playback, you need to specify the PCM
+For programming the 4/6 channel playback, you need to specify the PCM
 channels as you like and set the format S16LE.  For example, for playback
 with 4 channels,
 
diff -ru a/Documentation/sparc/sbus_drivers.txt b/Documentation/sparc/sbus_drivers.txt
--- a/Documentation/sparc/sbus_drivers.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/sparc/sbus_drivers.txt	2006-07-24 19:35:51.000000000 -0400
@@ -25,8 +25,8 @@
 used members of this structure, and their typical usage,
 will be detailed below.
 
-	Here is a piece of skeleton code for perofming a device
-probe in an SBUS driverunder Linux:
+	Here is a piece of skeleton code for performing a device
+probe in an SBUS driver under Linux:
 
 	static int __devinit mydevice_probe_one(struct sbus_dev *sdev)
 	{
diff -ru a/Documentation/uml/UserModeLinux-HOWTO.txt b/Documentation/uml/UserModeLinux-HOWTO.txt
--- a/Documentation/uml/UserModeLinux-HOWTO.txt	2006-06-17 21:49:35.000000000 -0400
+++ b/Documentation/uml/UserModeLinux-HOWTO.txt	2006-07-24 19:35:40.000000000 -0400
@@ -2058,7 +2058,7 @@
   there are multiple COWs associated with a backing file, a -d merge of
   one of them will invalidate all of the others.  However, it is
   convenient if you're short of disk space, and it should also be
-  noticably faster than a non-destructive merge.
+  noticeably faster than a non-destructive merge.
 
 
 
diff -ru a/Documentation/usb/usb-serial.txt b/Documentation/usb/usb-serial.txt
--- a/Documentation/usb/usb-serial.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/usb/usb-serial.txt	2006-07-24 19:35:51.000000000 -0400
@@ -277,7 +277,7 @@
   work under SMP with the uhci driver.
 
   The driver is generally working, though we still have a few more ioctls
-  to implement and final testing and debugging to do.  The paralled port
+  to implement and final testing and debugging to do.  The parallel port
   on the USB 2 is supported as a serial to parallel converter; in other
   words, it appears as another USB serial port on Linux, even though
   physically it is really a parallel port.  The Digi Acceleport USB 8
diff -ru a/Documentation/video4linux/cx2341x/fw-encoder-api.txt b/Documentation/video4linux/cx2341x/fw-encoder-api.txt
--- a/Documentation/video4linux/cx2341x/fw-encoder-api.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/video4linux/cx2341x/fw-encoder-api.txt	2006-07-24 19:35:40.000000000 -0400
@@ -280,7 +280,7 @@
 Param[1]
 	Unknown, but leaving this to 0 seems to work best. Indications are that
 	this might have to do with USB support, although passing anything but 0
-	onl breaks things.
+	only breaks things.
 
 -------------------------------------------------------------------------------
 
diff -ru a/Documentation/video4linux/w9968cf.txt b/Documentation/video4linux/w9968cf.txt
--- a/Documentation/video4linux/w9968cf.txt	2006-07-16 22:07:04.000000000 -0400
+++ b/Documentation/video4linux/w9968cf.txt	2006-07-24 19:35:51.000000000 -0400
@@ -15,7 +15,7 @@
 5.  Supported devices
 6.  Module dependencies
 7.  Module loading
-8.  Module paramaters
+8.  Module parameters
 9.  Contact information
 10. Credits
 

