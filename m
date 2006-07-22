Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbWGVWcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWGVWcK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 18:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWGVWcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 18:32:09 -0400
Received: from cpe-74-70-38-78.nycap.res.rr.com ([74.70.38.78]:29706 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1751068AbWGVWcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 18:32:07 -0400
Date: Sat, 22 Jul 2006 18:30:55 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: "Randy Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 18-rc2] Fix typos in /Documentation : 'D'-'E'
Message-Id: <20060722183055.010ce010.kernel1@cyberdogtech.com>
In-Reply-To: <1153607151.24576@shark.he.net>
References: <1153607151.24576@shark.he.net>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Sat, 22 Jul 2006 18:31:02 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Sat, 22 Jul 2006 18:31:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jul 2006 15:25:51 -0700
"Randy Dunlap" <rdunlap@xenotime.net> wrote:

> 
> 
> > This patch fixes typos in various Documentation txts. This patch
> addresses some words starting with the letters 'D'-'E'.
> > 
> > The patch came in on the large side (+600 lines), so I'm placing the
> diff on the web for download rather than pasting it here.  Download:
> > http://www.cyberdogtech.com/download/doc3-de.diff
> 
> A 32 KB patch isn't considered terribly large for lkml.  For review
> purposes, we had rather see patches inline in email instead of as
> attachments or as URLs.  (Yes, I have posted URLs of patches when
> they were 200 KB, e.g.)
> 
> I posted a patch for many corrections to relayfs.txt a few days
> ago, including the change from you.
> 
> All of the corrections look good to me.
> 
> ---
> ~Randy

I was going by http://www.kernel.org/pub/linux/docs/lkml/#s4-1 which recommends +500 lines as "large".  I'll put the patch inline below for convenience.

----

This patch fixes typos in various Documentation txts. This patch addresses some words starting with the letters 'D'-'E'.

Signed-off-by: Matt LaPlante <kernel1@cyberdogtech.com>

diff -ru a/Documentation/aoe/todo.txt b/Documentation/aoe/todo.txt
--- a/Documentation/aoe/todo.txt	2006-07-22 12:50:42.000000000 -0400
+++ b/Documentation/aoe/todo.txt	2006-07-22 13:20:46.000000000 -0400
@@ -7,7 +7,7 @@
 deadlock under memory pressure.
 
 Because ATA over Ethernet is not fragmented by the kernel's IP code,
-the destructore member of the struct sk_buff is available to the aoe
+the destructor member of the struct sk_buff is available to the aoe
 driver.  By using a mempool for allocating all but the first few
 sk_buffs, and by registering a destructor, we should be able to
 efficiently allocate sk_buffs without introducing any potential for
diff -ru a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.txt
--- a/Documentation/block/biodoc.txt	2006-07-22 12:50:44.000000000 -0400
+++ b/Documentation/block/biodoc.txt	2006-07-22 13:36:06.000000000 -0400
@@ -1203,6 +1203,6 @@
 and Linus' comments - Jan 2001)
 9.2 Discussions about kiobuf and bh design on lkml between sct, linus, alan
 et al - Feb-March 2001 (many of the initial thoughts that led to bio were
-brought up in this discusion thread)
+brought up in this discussion thread)
 9.3 Discussions on mempool on lkml - Dec 2001.
 
diff -ru a/Documentation/cciss.txt b/Documentation/cciss.txt
--- a/Documentation/cciss.txt	2006-07-22 12:52:46.000000000 -0400
+++ b/Documentation/cciss.txt	2006-07-22 13:39:44.000000000 -0400
@@ -79,7 +79,7 @@
 the SCSI core may not yet be initialized (because the driver is a block 
 driver) and attempting to register it with the SCSI core in such a case 
 would cause a hang.  This is best done via an initialization script 
-(typically in /etc/init.d, but could vary depending on distibution). 
+(typically in /etc/init.d, but could vary depending on distribution). 
 For example:
 
 	for x in /proc/driver/cciss/cciss[0-9]*
diff -ru a/Documentation/cputopology.txt b/Documentation/cputopology.txt
--- a/Documentation/cputopology.txt	2006-07-22 12:50:51.000000000 -0400
+++ b/Documentation/cputopology.txt	2006-07-22 13:10:33.000000000 -0400
@@ -26,7 +26,7 @@
 The type of siblings is cpumask_t.
 
 To be consistent on all architectures, the 4 attributes should have
-deafult values if their values are unavailable. Below is the rule.
+default values if their values are unavailable. Below is the rule.
 1) physical_package_id: If cpu has no physical package id, -1 is the
 default value.
 2) core_id: If cpu doesn't support multi-core, its core id is 0.
diff -ru a/Documentation/devices.txt b/Documentation/devices.txt
--- a/Documentation/devices.txt	2006-07-22 12:50:50.000000000 -0400
+++ b/Documentation/devices.txt	2006-07-22 13:28:17.000000000 -0400
@@ -3202,7 +3202,7 @@
 pseudoterminals (PTYs).
 
 All terminal devices share a common set of capabilities known as line
-diciplines; these include the common terminal line dicipline as well
+disciplines; these include the common terminal line discipline as well
 as SLIP and PPP modes.
 
 All terminal devices are named similarly; this section explains the
@@ -3282,7 +3282,7 @@
 	Pseudoterminals (PTYs)
 
 Pseudoterminals, or PTYs, are used to create login sessions or provide
-other capabilities requiring a TTY line dicipline (including SLIP or
+other capabilities requiring a TTY line discipline (including SLIP or
 PPP capability) to arbitrary data-generation processes.	 Each PTY has
 a master side, named /dev/pty[p-za-e][0-9a-f], and a slave side, named
 /dev/tty[p-za-e][0-9a-f].  The kernel arbitrates the use of PTYs by
diff -ru a/Documentation/fb/sstfb.txt b/Documentation/fb/sstfb.txt
--- a/Documentation/fb/sstfb.txt	2006-07-22 12:52:26.000000000 -0400
+++ b/Documentation/fb/sstfb.txt	2006-07-22 13:37:27.000000000 -0400
@@ -48,12 +48,12 @@
 
 	Module insertion:
 	# insmod sstfb.o
-	  you should see some strange output frome the board: 
+	  you should see some strange output from the board: 
 	  a big blue square, a green and a red small squares and a vertical
-	  white rectangle. why ? the function's name is self explanatory :
+	  white rectangle. why? the function's name is self-explanatory:
 	  "sstfb_test()"...
 	  (if you don't have a second monitor, you'll have to plug your monitor
-	  directely to the 2D videocard to see what you're typing)
+	  directly to the 2D videocard to see what you're typing)
 	# con2fb /dev/fbx /dev/ttyx
 	  bind a tty to the new frame buffer. if you already have a frame
 	  buffer driver, the voodoo fb will likely be /dev/fb1. if not, 
@@ -95,11 +95,11 @@
 
 clipping=1	clipping	Enable or disable clipping.
 clipping=0	noclipping	With clipping enabled, all offscreen
-				reads and writes are disgarded.
+				reads and writes are discarded.
 				Default: enable clipping.
 
 gfxclk=x	gfxclk:x	Force graphic clock frequency (in MHz).
-				Be carefull with this option, it may be
+				Be careful with this option, it may be
 				DANGEROUS.
 				Default: auto 
 					50Mhz for Voodoo 1,
diff -ru a/Documentation/filesystems/dlmfs.txt b/Documentation/filesystems/dlmfs.txt
--- a/Documentation/filesystems/dlmfs.txt	2006-07-22 12:50:50.000000000 -0400
+++ b/Documentation/filesystems/dlmfs.txt	2006-07-22 14:14:03.000000000 -0400
@@ -68,7 +68,7 @@
 call. Userspace programs are assumed to handle their own local
 locking.
 
-Two levels of locks are supported - Shared Read, and Exlcusive.
+Two levels of locks are supported - Shared Read, and Exclusive.
 Also supported is a Trylock operation.
 
 For information on the libo2dlm interface, please see o2dlm.h,
diff -ru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	2006-07-22 12:50:50.000000000 -0400
+++ b/Documentation/filesystems/ntfs.txt	2006-07-22 13:09:27.000000000 -0400
@@ -390,7 +390,7 @@
 
 You have to use the "persistent-superblock 0" option for each raid-disk in the
 NTFS volume/stripe you are configuring in /etc/raidtab as the persistent
-superblock used by the MD driver would damange the NTFS volume.
+superblock used by the MD driver would damage the NTFS volume.
 
 Windows by default uses a stripe chunk size of 64k, so you probably want the
 "chunk-size 64k" option for each raid-disk, too.
diff -ru a/Documentation/filesystems/relayfs.txt b/Documentation/filesystems/relayfs.txt
--- a/Documentation/filesystems/relayfs.txt	2006-07-22 12:50:49.000000000 -0400
+++ b/Documentation/filesystems/relayfs.txt	2006-07-22 13:53:43.000000000 -0400
@@ -204,7 +204,7 @@
 In no-overwrite mode, writes will fail i.e. data will be lost, if the
 number of unconsumed sub-buffers equals the total number of
 sub-buffers in the channel.  It should be clear that if there is no
-consumer or if the consumer can't consume sub-buffers fast enought,
+consumer or if the consumer can't consume sub-buffers fast enough,
 data will be lost in either case; the only difference is whether data
 is lost from the beginning or the end of a buffer.
 
diff -ru a/Documentation/filesystems/sysfs.txt b/Documentation/filesystems/sysfs.txt
--- a/Documentation/filesystems/sysfs.txt	2006-07-22 12:50:49.000000000 -0400
+++ b/Documentation/filesystems/sysfs.txt	2006-07-22 13:33:33.000000000 -0400
@@ -238,7 +238,7 @@
 The sysfs directory arrangement exposes the relationship of kernel
 data structures. 
 
-The top level sysfs diretory looks like:
+The top level sysfs directory looks like:
 
 block/
 bus/
diff -ru a/Documentation/hrtimers.txt b/Documentation/hrtimers.txt
--- a/Documentation/hrtimers.txt	2006-07-22 12:50:47.000000000 -0400
+++ b/Documentation/hrtimers.txt	2006-07-22 13:30:19.000000000 -0400
@@ -10,7 +10,7 @@
 features into the existing timer framework, and after testing various
 such high-resolution timer implementations in practice, we came to the
 conclusion that the timer wheel code is fundamentally not suitable for
-such an approach. We initially didnt believe this ('there must be a way
+such an approach. We initially didn't believe this ('there must be a way
 to solve this'), and spent a considerable effort trying to integrate
 things into the timer wheel, but we failed. In hindsight, there are
 several reasons why such integration is hard/impossible:
diff -ru a/Documentation/input/atarikbd.txt b/Documentation/input/atarikbd.txt
--- a/Documentation/input/atarikbd.txt	2006-07-22 12:52:46.000000000 -0400
+++ b/Documentation/input/atarikbd.txt	2006-07-22 13:21:36.000000000 -0400
@@ -30,7 +30,7 @@
 The special codes 0xF6 through 0xFF are reserved for use as follows:
     0xF6            status report
     0xF7            absolute mouse position record
-    0xF8-0xFB       relative mouse position records(lsbs determind by
+    0xF8-0xFB       relative mouse position records (lsbs determined by
                      mouse button states)
     0xFC            time-of-day
     0xFD            joystick report (both sticks)
diff -ru a/Documentation/input/cs461x.txt b/Documentation/input/cs461x.txt
--- a/Documentation/input/cs461x.txt	2006-07-22 12:50:44.000000000 -0400
+++ b/Documentation/input/cs461x.txt	2006-07-22 14:16:27.000000000 -0400
@@ -27,7 +27,7 @@
 ISA or PnP ISA cards supported. AFAIK the ns558 have support for Crystal 
 ISA and PnP ISA series.
 
-The driver works witn ALSA drivers simultaneously. For exmple, the xracer
+The driver works with ALSA drivers simultaneously. For example, the xracer
 uses joystick as input device and PCM device as sound output in one time.
 There are no sound or input collisions detected. The source code have
 comments about them; but I've found the joystick can be initialized 
diff -ru a/Documentation/input/ff.txt b/Documentation/input/ff.txt
--- a/Documentation/input/ff.txt	2006-07-22 12:50:44.000000000 -0400
+++ b/Documentation/input/ff.txt	2006-07-22 13:24:58.000000000 -0400
@@ -68,7 +68,7 @@
 There is an utility called fftest that will allow you to test the driver.
 % fftest /dev/input/eventXX
 
-3. Instructions to the developper
+3. Instructions to the developer
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   All interactions are done using the event API. That is, you can use ioctl()
 and write() on /dev/input/eventXX.
diff -ru a/Documentation/input/iforce-protocol.txt b/Documentation/input/iforce-protocol.txt
--- a/Documentation/input/iforce-protocol.txt	2006-07-22 12:50:44.000000000 -0400
+++ b/Documentation/input/iforce-protocol.txt	2006-07-22 13:08:53.000000000 -0400
@@ -7,7 +7,7 @@
 send an email to: deneux@ifrance.com
 
 ** WARNING **
-I may not be held responsible for any dammage or harm caused if you try to
+I may not be held responsible for any damage or harm caused if you try to
 send data to your I-Force device based on what you read in this document.
 
 ** Preliminary Notes:
diff -ru a/Documentation/input/input.txt b/Documentation/input/input.txt
--- a/Documentation/input/input.txt	2006-07-22 12:50:44.000000000 -0400
+++ b/Documentation/input/input.txt	2006-07-22 13:41:44.000000000 -0400
@@ -154,7 +154,7 @@
 
 3.2 Event handlers
 ~~~~~~~~~~~~~~~~~~
-  Event handlers distrubite the events from the devices to userland and
+  Event handlers distribute the events from the devices to userland and
 kernel, as needed.
 
 3.2.1 keybdev
diff -ru a/Documentation/kobject.txt b/Documentation/kobject.txt
--- a/Documentation/kobject.txt	2006-07-22 12:50:50.000000000 -0400
+++ b/Documentation/kobject.txt	2006-07-22 13:15:44.000000000 -0400
@@ -51,7 +51,7 @@
 almost all complex data types share. kobjects are intended to be
 embedded in larger data structures and replace fields they duplicate. 
 
-1.2 Defintion
+1.2 Definition
 
 struct kobject {
 	char			name[KOBJ_NAME_LEN];
diff -ru a/Documentation/md.txt b/Documentation/md.txt
--- a/Documentation/md.txt	2006-07-22 12:52:26.000000000 -0400
+++ b/Documentation/md.txt	2006-07-22 14:29:49.000000000 -0400
@@ -62,7 +62,7 @@
 
 For this reason, md will normally refuse to start such an array.  This
 requires the sysadmin to take action to explicitly start the array
-desipite possible corruption.  This is normally done with
+despite possible corruption.  This is normally done with
    mdadm --assemble --force ....
 
 This option is not really available if the array has the root
@@ -221,8 +221,8 @@
    safe_mode_delay
      When an md array has seen no write requests for a certain period
      of time, it will be marked as 'clean'.  When another write
-     request arrive, the array is marked as 'dirty' before the write
-     commenses.  This is known as 'safe_mode'.
+     request arrives, the array is marked as 'dirty' before the write
+     commences.  This is known as 'safe_mode'.
      The 'certain period' is controlled by this file which stores the
      period as a number of seconds.  The default is 200msec (0.200).
      Writing a value of 0 disables safemode.
diff -ru a/Documentation/networking/gen_stats.txt b/Documentation/networking/gen_stats.txt
--- a/Documentation/networking/gen_stats.txt	2006-07-22 12:50:52.000000000 -0400
+++ b/Documentation/networking/gen_stats.txt	2006-07-22 14:09:26.000000000 -0400
@@ -103,8 +103,8 @@
    else
        failed
 
-From now on, everytime you dump my_rate_est_stats it will contain
-uptodate info.
+From now on, every time you dump my_rate_est_stats it will contain
+up-to-date info.
 
 Once you are done, call gen_kill_estimator(my_basicstats,
 my_rate_est_stats) Make sure that my_basicstats and my_rate_est_stats
diff -ru a/Documentation/networking/NAPI_HOWTO.txt b/Documentation/networking/NAPI_HOWTO.txt
--- a/Documentation/networking/NAPI_HOWTO.txt	2006-07-22 12:50:52.000000000 -0400
+++ b/Documentation/networking/NAPI_HOWTO.txt	2006-07-22 14:32:35.000000000 -0400
@@ -35,7 +35,7 @@
 packets out of the rx ring. Note from this that the lower the
 load the more we could clean up the rxring
 "Ndone" == is the converse of "Done". Note again, that the higher
-the load the more times we couldnt clean up the rxring.
+the load the more times we couldn't clean up the rxring.
 
 Observe that:
 when the NIC receives 890Kpackets/sec only 17 rx interrupts are generated. 
diff -ru a/Documentation/networking/pktgen.txt b/Documentation/networking/pktgen.txt
--- a/Documentation/networking/pktgen.txt	2006-07-22 12:52:26.000000000 -0400
+++ b/Documentation/networking/pktgen.txt	2006-07-22 14:16:59.000000000 -0400
@@ -131,7 +131,7 @@
 Example scripts
 ===============
 
-A collection of small tutorial scripts for pktgen is in expamples dir.
+A collection of small tutorial scripts for pktgen is in examples dir.
 
 pktgen.conf-1-1                  # 1 CPU 1 dev 
 pktgen.conf-1-2                  # 1 CPU 2 dev
diff -ru a/Documentation/networking/wan-router.txt b/Documentation/networking/wan-router.txt
--- a/Documentation/networking/wan-router.txt	2006-07-22 12:50:52.000000000 -0400
+++ b/Documentation/networking/wan-router.txt	2006-07-22 14:31:38.000000000 -0400
@@ -570,7 +570,7 @@
 
 				Option to COMPILE WANPIPE modules against the currently 
 				running kernel, thus no need for manual kernel and module
-				re-compilatin.
+				re-compilation.
 			
 			o Updates and Bug Fixes to wancfg utility.
 
diff -ru a/Documentation/nfsroot.txt b/Documentation/nfsroot.txt
--- a/Documentation/nfsroot.txt	2006-07-22 12:50:51.000000000 -0400
+++ b/Documentation/nfsroot.txt	2006-07-22 13:43:53.000000000 -0400
@@ -11,7 +11,7 @@
 In order to use a diskless system, such as an X-terminal or printer server
 for example, it is necessary for the root filesystem to be present on a
 non-disk device. This may be an initramfs (see Documentation/filesystems/
-ramfs-rootfs-initramfs.txt), a ramdisk (see Documenation/initrd.txt) or a
+ramfs-rootfs-initramfs.txt), a ramdisk (see Documentation/initrd.txt) or a
 filesystem mounted via NFS. The following text describes on how to use NFS
 for the root filesystem. For the rest of this text 'client' means the
 diskless system, and 'server' means the NFS server.
diff -ru a/Documentation/power/pci.txt b/Documentation/power/pci.txt
--- a/Documentation/power/pci.txt	2006-07-22 12:50:45.000000000 -0400
+++ b/Documentation/power/pci.txt	2006-07-22 13:19:13.000000000 -0400
@@ -326,7 +326,7 @@
 
 This is a typical implementation. Drivers can slightly change the order
 of the operations in the implementation, ignore some operations or add
-more deriver specific operations in it, but drivers should do something like
+more driver specific operations in it, but drivers should do something like
 this on the whole.
 
 5. Resources
diff -ru a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
--- a/Documentation/powerpc/booting-without-of.txt	2006-07-22 12:52:46.000000000 -0400
+++ b/Documentation/powerpc/booting-without-of.txt	2006-07-22 14:23:51.000000000 -0400
@@ -335,7 +335,7 @@
      "compact" format for the tree itself that is however not backward
      compatible. You should always generate a structure of the highest
      version defined at the time of your implementation. Currently
-     that is version 16, unless you explicitely aim at being backward
+     that is version 16, unless you explicitly aim at being backward
      compatible.
 
    - last_comp_version
diff -ru a/Documentation/rocket.txt b/Documentation/rocket.txt
--- a/Documentation/rocket.txt	2006-07-22 12:50:49.000000000 -0400
+++ b/Documentation/rocket.txt	2006-07-22 14:01:29.000000000 -0400
@@ -107,7 +107,7 @@
 software control.  The DIP switch settings for the I/O address must be
 set to the value of the first Rocketport cards.
 
-In order to destinguish each of the card from the others, each card
+In order to distinguish each of the card from the others, each card
 must have a unique board ID set on the dip switches.  The first
 Rocketport board must be set with the DIP switches corresponding to
 the first board, the second board must be set with the DIP switches
@@ -120,7 +120,7 @@
 RocketPort cards.  Below, you will find a list of commonly used I/O
 address ranges which may be in use by other devices in your system.
 On a Linux system, "cat /proc/ioports" will also be helpful in
-identifying what I/O addresses are being used by devics on your
+identifying what I/O addresses are being used by devices on your
 system.
 
 Remember, the FIRST RocketPort uses 68 I/O addresses.  So, if you set it
diff -ru a/Documentation/s390/cds.txt b/Documentation/s390/cds.txt
--- a/Documentation/s390/cds.txt	2006-07-22 12:52:26.000000000 -0400
+++ b/Documentation/s390/cds.txt	2006-07-22 13:23:41.000000000 -0400
@@ -433,7 +433,7 @@
 
 The device driver is allowed to issue the next ccw_device_start() call from
 within its interrupt handler already. It is not required to schedule a
-bottom-half, unless an non deterministicly long running error recovery procedure
+bottom-half, unless an non deterministically long running error recovery procedure
 or similar needs to be scheduled. During I/O processing the Linux/390 generic
 I/O device driver support has already obtained the IRQ lock, i.e. the handler
 must not try to obtain it again when calling ccw_device_start() or we end in a
diff -ru a/Documentation/s390/Debugging390.txt b/Documentation/s390/Debugging390.txt
--- a/Documentation/s390/Debugging390.txt	2006-07-22 12:52:46.000000000 -0400
+++ b/Documentation/s390/Debugging390.txt	2006-07-22 14:22:12.000000000 -0400
@@ -8,8 +8,8 @@
 Overview of Document:
 =====================
 This document is intended to give an good overview of how to debug 
-Linux for s/390 & z/Architecture it isn't intended as a complete reference & not a
-tutorial on the fundamentals of C & assembly, it dosen't go into
+Linux for s/390 & z/Architecture. It isn't intended as a complete reference & not a
+tutorial on the fundamentals of C & assembly. It doesn't go into
 390 IO in any detail. It is intended to complement the documents in the
 reference section below & any other worthwhile references you get.
 
@@ -354,7 +354,7 @@
 }
 
 i.e. just anding the current kernel stack pointer with the mask -8192.
-Thankfully because Linux dosen't have support for nested IO interrupts
+Thankfully because Linux doesn't have support for nested IO interrupts
 & our devices have large buffers can survive interrupts being shut for 
 short amounts of time we don't need a separate stack for interrupts.
 
@@ -394,7 +394,7 @@
 back-chain:
 This is a pointer to the stack pointer before entering a
 framed functions ( see frameless function ) prologue got by 
-deferencing the address of the current stack pointer,
+dereferencing the address of the current stack pointer,
  i.e. got by accessing the 32 bit value at the stack pointers
 current location.
 
@@ -724,7 +724,7 @@
 1) You can double check whether the files you expect to be included are the ones
 that are being included ( e.g. double check that you aren't going to the i386 asm directory ).
 2) Check that macro definitions aren't clashing with typedefs,
-3) Check that definitons aren't being used before they are being included.
+3) Check that definitions aren't being used before they are being included.
 4) Helps put the line emitting the error under the microscope if it contains macros.
 
 For convenience the Linux kernel's makefile will do preprocessing automatically for you
@@ -840,12 +840,11 @@
 
 A source/assembly mixed dump of the kernel can be done with the line
 objdump --source vmlinux > vmlinux.lst
-Also if the file isn't compiled -g this will output as much debugging information
-as it can ( e.g. function names ), however, this is very slow as it spends lots
-of time searching for debugging info, the following self explanitory line should be used 
-instead if the code isn't compiled -g.
+Also, if the file isn't compiled -g, this will output as much debugging information
+as it can (e.g. function names). This is very slow as it spends lots
+of time searching for debugging info. The following self explanatory line should be used 
+instead if the code isn't compiled -g, as it is much faster:
 objdump --disassemble-all --syms vmlinux > vmlinux.lst  
-as it is much faster
 
 As hard drive space is valuble most of us use the following approach.
 1) Look at the emitted psw on the console to find the crash address in the kernel.
@@ -1674,8 +1673,8 @@
 concurrently, you check how the IO went on by issuing a TEST SUBCHANNEL at each interrupt,
 from which you receive an Interruption response block (IRB). If you get channel & device end 
 status in the IRB without channel checks etc. your IO probably went okay. If you didn't you
-probably need a doctorto examine the IRB & extended status word etc.
-If an error occurs more sophistocated control units have a facitity known as
+probably need a doctor to examine the IRB & extended status word etc.
+If an error occurs, more sophistocated control units have a facitity known as
 concurrent sense this means that if an error occurs Extended sense information will
 be presented in the Extended status word in the IRB if not you have to issue a
 subsequent SENSE CCW command after the test subchannel. 
@@ -1916,7 +1915,7 @@
 --------
 info registers: displays registers other than floating point.
 info all-registers: displays floating points as well.
-disassemble: dissassembles
+disassemble: disassembles
 e.g.
 disassemble without parameters will disassemble the current function
 disassemble $pc $pc+10 
@@ -1935,7 +1934,7 @@
 
 info breakpoints: shows all current breakpoints
 
-info stack: shows stack back trace ( if this dosent work too well, I'll show you the
+info stack: shows stack back trace ( if this doesn't work too well, I'll show you the
 stacktrace by hand below ).
 
 info locals: displays local variables.
diff -ru a/Documentation/s390/s390dbf.txt b/Documentation/s390/s390dbf.txt
--- a/Documentation/s390/s390dbf.txt	2006-07-22 12:50:43.000000000 -0400
+++ b/Documentation/s390/s390dbf.txt	2006-07-22 14:19:08.000000000 -0400
@@ -468,7 +468,7 @@
 The raw view returns a bytestream as the debug areas are stored in memory.
 
 The sprintf view formats the debug entries in the same way as the sprintf
-function would do. The sprintf event/expection functions write to the
+function would do. The sprintf event/exception functions write to the
 debug entry a pointer to the format string (size = sizeof(long)) 
 and for each vararg a long value. So e.g. for a debug entry with a format 
 string plus two varargs one would need to allocate a (3 * sizeof(long)) 
diff -ru a/Documentation/scsi/ncr53c8xx.txt b/Documentation/scsi/ncr53c8xx.txt
--- a/Documentation/scsi/ncr53c8xx.txt	2006-07-22 12:52:26.000000000 -0400
+++ b/Documentation/scsi/ncr53c8xx.txt	2006-07-22 14:04:40.000000000 -0400
@@ -96,10 +96,10 @@
 It is now available as a bundle of 2 drivers:
 
 - ncr53c8xx generic driver that supports all the SYM53C8XX family including 
-  the ealiest 810 rev. 1, the latest 896 (2 channel LVD SCSI controller) and
+  the earliest 810 rev. 1, the latest 896 (2 channel LVD SCSI controller) and
   the new 895A (1 channel LVD SCSI controller).
 - sym53c8xx enhanced driver (a.k.a. 896 drivers) that drops support of oldest 
-  chips in order to gain advantage of new features, as LOAD/STORE intructions 
+  chips in order to gain advantage of new features, as LOAD/STORE instructions 
   available since the 810A and hardware phase mismatch available with the 
   896 and the 895A.
 
@@ -207,7 +207,7 @@
 SCRIPTS (avoids the phase mismatch interrupt that stops the SCSI processor 
 until the C code has saved the context of the transfer).
 Implementing this without using LOAD/STORE instructions would be painfull 
-and I did'nt even want to try it.
+and I didn't even want to try it.
 
 The 896 chip supports 64 bit PCI transactions and addressing, while the 
 895A supports 32 bit PCI transactions and 64 bit addressing.
diff -ru a/Documentation/scsi/scsi_eh.txt b/Documentation/scsi/scsi_eh.txt
--- a/Documentation/scsi/scsi_eh.txt	2006-07-22 12:50:43.000000000 -0400
+++ b/Documentation/scsi/scsi_eh.txt	2006-07-22 13:28:48.000000000 -0400
@@ -160,7 +160,7 @@
  - Fine-grained EH callbacks
 	LLDD can implement fine-grained EH callbacks and let SCSI
 	midlayer drive error handling and call appropriate callbacks.
-	This will be dicussed further in [2-1].
+	This will be discussed further in [2-1].
 
  - eh_strategy_handler() callback
 	This is one big callback which should perform whole error
diff -ru a/Documentation/scsi/tmscsim.txt b/Documentation/scsi/tmscsim.txt
--- a/Documentation/scsi/tmscsim.txt	2006-07-22 12:52:26.000000000 -0400
+++ b/Documentation/scsi/tmscsim.txt	2006-07-22 13:22:28.000000000 -0400
@@ -381,7 +381,7 @@
   replaced by the dev index of your scanner). You may try to reset your SCSI
   bus afterwards (echo "RESET" >/proc/scsi/tmscsim/?).
   The problem seems to be solved as of 2.0d18, thanks to Andreas Rick.
-* If there is a valid partition table, the driver will use it for determing
+* If there is a valid partition table, the driver will use it for determining
   the mapping. If there's none, a reasonable mapping (Symbios-like) will be
   assumed. Other operating systems may not like this mapping, though
   it's consistent with the BIOS' behaviour. Old DC390 drivers ignored the
diff -ru a/Documentation/sound/alsa/ALSA-Configuration.txt b/Documentation/sound/alsa/ALSA-Configuration.txt
--- a/Documentation/sound/alsa/ALSA-Configuration.txt	2006-07-22 12:52:46.000000000 -0400
+++ b/Documentation/sound/alsa/ALSA-Configuration.txt	2006-07-22 14:24:54.000000000 -0400
@@ -1234,8 +1234,8 @@
 
     Note: on some notebooks the buffer address cannot be detected
     automatically, or causes hang-up during initialization.
-    In such a case, specify the buffer top address explicity via
-    buffer_top option.
+    In such a case, specify the buffer top address explicitly via
+    the buffer_top option.
     For example,
       Sony F250: buffer_top=0x25a800
       Sony F270: buffer_top=0x272800
diff -ru a/Documentation/sound/alsa/Audiophile-Usb.txt b/Documentation/sound/alsa/Audiophile-Usb.txt
--- a/Documentation/sound/alsa/Audiophile-Usb.txt	2006-07-22 12:50:46.000000000 -0400
+++ b/Documentation/sound/alsa/Audiophile-Usb.txt	2006-07-22 13:12:25.000000000 -0400
@@ -126,7 +126,7 @@
    - Alsa driver default mode
    - maintains backward compatibility with setups that do not use this 
      parameter by not introducing any change
-   - results sometimes in corrupted sound as decribed earlier
+   - results sometimes in corrupted sound as described earlier
  * device_setup=0x01
    - 16bits 48kHz mode with Di disabled
    - Ai,Ao,Do can be used at the same time
diff -ru a/Documentation/sound/alsa/MIXART.txt b/Documentation/sound/alsa/MIXART.txt
--- a/Documentation/sound/alsa/MIXART.txt	2006-07-22 12:52:46.000000000 -0400
+++ b/Documentation/sound/alsa/MIXART.txt	2006-07-22 13:40:23.000000000 -0400
@@ -97,4 +97,4 @@
 =========
 
 Copyright (c) 2003 Digigram SA <alsa@digigram.com>
-Distributalbe under GPL.
+Distributable under GPL.
diff -ru a/Documentation/sound/alsa/Procfile.txt b/Documentation/sound/alsa/Procfile.txt
--- a/Documentation/sound/alsa/Procfile.txt	2006-07-22 12:50:47.000000000 -0400
+++ b/Documentation/sound/alsa/Procfile.txt	2006-07-22 13:19:57.000000000 -0400
@@ -71,7 +71,7 @@
 name and the received/transmitted bytes through the MIDI device.
 
 When the card is equipped with AC97 codecs, there are codec97#*
-subdirectories (desribed later).
+subdirectories (described later).
 
 When the OSS mixer emulation is enabled (and the module is loaded),
 oss_mixer file appears here, too.  This shows the current mapping of
diff -ru a/Documentation/usb/error-codes.txt b/Documentation/usb/error-codes.txt
--- a/Documentation/usb/error-codes.txt	2006-07-22 12:50:42.000000000 -0400
+++ b/Documentation/usb/error-codes.txt	2006-07-22 13:44:34.000000000 -0400
@@ -126,7 +126,7 @@
 			urb->transfer_flags.
 
 -ENODEV			Device was removed.  Often preceded by a burst of
-			other errors, since the hub driver does't detect
+			other errors, since the hub driver doesn't detect
 			device removal events immediately.
 
 -EXDEV			ISO transfer only partially completed
diff -ru a/Documentation/usb/mtouchusb.txt b/Documentation/usb/mtouchusb.txt
--- a/Documentation/usb/mtouchusb.txt	2006-07-22 12:50:42.000000000 -0400
+++ b/Documentation/usb/mtouchusb.txt	2006-07-22 13:34:50.000000000 -0400
@@ -63,7 +63,7 @@
 Implement a control urb again to handle requests to and from the device
 such as calibration, etc once/if it becomes available.
 
-DISCLAMER:
+DISCLAIMER:
 
 I am not a MicroTouch/3M employee, nor have I ever been.  3M does not support 
 this driver!  If you want touch drivers only supported within X, please go to:
diff -ru a/Documentation/video4linux/meye.txt b/Documentation/video4linux/meye.txt
--- a/Documentation/video4linux/meye.txt	2006-07-22 12:50:55.000000000 -0400
+++ b/Documentation/video4linux/meye.txt	2006-07-22 13:24:27.000000000 -0400
@@ -29,7 +29,7 @@
 
 The third one, present in recent (more or less last year) Picturebooks
 (C1M* models), is not supported. The manufacturer has given the specs
-to the developers under a NDA (which allows the develoment of a GPL
+to the developers under a NDA (which allows the development of a GPL
 driver however), but things are not moving very fast (see
 http://r-engine.sourceforge.net/) (PCI vendor/device is 0x10cf/0x2011).
 
diff -ru a/Documentation/video4linux/zr36120.txt b/Documentation/video4linux/zr36120.txt
--- a/Documentation/video4linux/zr36120.txt	2006-07-22 12:50:55.000000000 -0400
+++ b/Documentation/video4linux/zr36120.txt	2006-07-22 13:46:17.000000000 -0400
@@ -118,9 +118,9 @@
 response, and mail me if you got a working tvcard addition.
 
 PS. <TVCard editors behold!)
-    Dont forget to set video_input to the number of inputs
+    Don't forget to set video_input to the number of inputs
     you defined in the video_mux part of the tvcard definition.
-    Its a common error to add a channel but not incrementing
+    It's a common error to add a channel but not incrementing
     video_input and getting angry with me/v4l/linux/linus :(
 
 You are now ready to test the framegrabber with your favorite

