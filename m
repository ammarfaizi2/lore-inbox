Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161345AbWJLCBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161345AbWJLCBQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 22:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161352AbWJLCBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 22:01:16 -0400
Received: from cpe-74-70-38-78.nycap.res.rr.com ([74.70.38.78]:62218 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1161345AbWJLCBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 22:01:14 -0400
Date: Wed, 11 Oct 2006 22:00:40 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org, device@lanana.org
Subject: Re: [PATCH 19-rc1]  Fix typos in /Documentation : Misc
Message-Id: <20061011220040.55e74a9e.kernel1@cyberdogtech.com>
In-Reply-To: <20061010210601.f693fafd.rdunlap@xenotime.net>
References: <20061010211938.3f53262c.kernel1@cyberdogtech.com>
	<20061010210601.f693fafd.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mail.cyberdogtech.com, Wed, 11 Oct 2006 22:00:51 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Wed, 11 Oct 2006 22:00:51 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 21:06:01 -0700
Randy Dunlap <rdunlap@xenotime.net> wrote:

> On Tue, 10 Oct 2006 21:19:38 -0400 Matt LaPlante wrote:
> 
> > This patch fixes typos in various Documentation txts. The patch addresses some misc words.  
> 
> Lots of good stuff.  Plus a few comments below.
> 
>[snip]
> 
> ---
> ~Randy

Fixed version below...

-- 
Matt
--

diff -ru a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.txt
--- a/Documentation/block/biodoc.txt	2006-10-06 21:28:14.000000000 -0400
+++ b/Documentation/block/biodoc.txt	2006-10-11 21:46:16.000000000 -0400
@@ -183,7 +183,7 @@
 modified to accomplish a direct page -> bus translation, without requiring
 a virtual address mapping (unlike the earlier scheme of virtual address
 -> bus translation). So this works uniformly for high-memory pages (which
-do not have a correponding kernel virtual address space mapping) and
+do not have a corresponding kernel virtual address space mapping) and
 low-memory pages.
 
 Note: Please refer to DMA-mapping.txt for a discussion on PCI high mem DMA
@@ -1013,7 +1013,7 @@
 i. Binary tree
 AS and deadline i/o schedulers use red black binary trees for disk position
 sorting and searching, and a fifo linked list for time-based searching. This
-gives good scalability and good availablility of information. Requests are
+gives good scalability and good availability of information. Requests are
 almost always dispatched in disk sort order, so a cache is kept of the next
 request in sort order to prevent binary tree lookups.
 
diff -ru a/Documentation/cpu-freq/cpufreq-nforce2.txt b/Documentation/cpu-freq/cpufreq-nforce2.txt
--- a/Documentation/cpu-freq/cpufreq-nforce2.txt	2006-09-19 23:42:06.000000000 -0400
+++ b/Documentation/cpu-freq/cpufreq-nforce2.txt	2006-10-11 21:46:16.000000000 -0400
@@ -1,7 +1,7 @@
 
-The cpufreq-nforce2 driver changes the FSB on nVidia nForce2 plattforms.
+The cpufreq-nforce2 driver changes the FSB on nVidia nForce2 platforms.
 
-This works better than on other plattforms, because the FSB of the CPU
+This works better than on other platforms, because the FSB of the CPU
 can be controlled independently from the PCI/AGP clock.
 
 The module has two options:
diff -ru a/Documentation/cpu-hotplug.txt b/Documentation/cpu-hotplug.txt
--- a/Documentation/cpu-hotplug.txt	2006-09-19 23:42:06.000000000 -0400
+++ b/Documentation/cpu-hotplug.txt	2006-10-11 21:46:16.000000000 -0400
@@ -54,8 +54,8 @@
 
 ia64 and x86_64 use the number of disabled local apics in ACPI tables MADT
 to determine the number of potentially hot-pluggable cpus. The implementation
-should only rely on this to count the #of cpus, but *MUST* not rely on the
-apicid values in those tables for disabled apics. In the event BIOS doesnt
+should only rely on this to count the # of cpus, but *MUST* not rely on the
+apicid values in those tables for disabled apics. In the event BIOS doesn't
 mark such hot-pluggable cpus as disabled entries, one could use this
 parameter "additional_cpus=x" to represent those cpus in the cpu_possible_map.
 
diff -ru a/Documentation/devices.txt b/Documentation/devices.txt
--- a/Documentation/devices.txt	2006-10-06 21:28:14.000000000 -0400
+++ b/Documentation/devices.txt	2006-10-11 21:46:16.000000000 -0400
@@ -92,7 +92,7 @@
 		  7 = /dev/full		Returns ENOSPC on write
 		  8 = /dev/random	Nondeterministic random number gen.
 		  9 = /dev/urandom	Faster, less secure random number gen.
-		 10 = /dev/aio		Asyncronous I/O notification interface
+		 10 = /dev/aio		Asynchronous I/O notification interface
 		 11 = /dev/kmsg		Writes to this come out as printk's
   1 block	RAM disk
 		  0 = /dev/ram0		First RAM disk
@@ -1093,7 +1093,7 @@
 
  55 char	DSP56001 digital signal processor
 		  0 = /dev/dsp56k	First DSP56001
- 55 block	Mylex DAC960 PCI RAID controller; eigth controller
+ 55 block	Mylex DAC960 PCI RAID controller; eighth controller
 		  0 = /dev/rd/c7d0	First disk, whole disk
 		  8 = /dev/rd/c7d1	Second disk, whole disk
 		    ...
@@ -1456,7 +1456,7 @@
 		  1 = /dev/cum1		Callout device for ttyM1
 		    ...
 
- 79 block	Compaq Intelligent Drive Array, eigth controller
+ 79 block	Compaq Intelligent Drive Array, eighth controller
 		  0 = /dev/ida/c7d0	First logical drive whole disk
 		 16 = /dev/ida/c7d1	Second logical drive whole disk
 		    ...
@@ -1900,7 +1900,7 @@
 		  1 = /dev/av1		Second A/V card
 		    ...
 
-111 block	Compaq Next Generation Drive Array, eigth controller
+111 block	Compaq Next Generation Drive Array, eighth controller
 		  0 = /dev/cciss/c7d0	First logical drive, whole disk
 		 16 = /dev/cciss/c7d1	Second logical drive, whole disk
 		    ...
diff -ru a/Documentation/driver-model/porting.txt b/Documentation/driver-model/porting.txt
--- a/Documentation/driver-model/porting.txt	2006-09-19 23:42:06.000000000 -0400
+++ b/Documentation/driver-model/porting.txt	2006-10-11 21:46:16.000000000 -0400
@@ -92,7 +92,7 @@
 describing the relationship the device has to other entities. 
 
 
-- Embedd a struct device in the bus-specific device type. 
+- Embed a struct device in the bus-specific device type. 
 
 
 struct pci_dev {
diff -ru a/Documentation/filesystems/ntfs.txt b/Documentation/filesystems/ntfs.txt
--- a/Documentation/filesystems/ntfs.txt	2006-10-06 21:28:15.000000000 -0400
+++ b/Documentation/filesystems/ntfs.txt	2006-10-11 21:46:16.000000000 -0400
@@ -599,7 +599,7 @@
 	- Major bug fixes for reading files and volumes in corner cases which
 	  were being hit by Windows 2k/XP users.
 2.1.2:
-	- Major bug fixes aleviating the hangs in statfs experienced by some
+	- Major bug fixes alleviating the hangs in statfs experienced by some
 	  users.
 2.1.1:
 	- Update handling of compressed files so people no longer get the
diff -ru a/Documentation/fujitsu/frv/gdbstub.txt b/Documentation/fujitsu/frv/gdbstub.txt
--- a/Documentation/fujitsu/frv/gdbstub.txt	2006-09-19 23:42:06.000000000 -0400
+++ b/Documentation/fujitsu/frv/gdbstub.txt	2006-10-11 21:46:16.000000000 -0400
@@ -59,7 +59,7 @@
 Then build as usual, download to the board and execute. Note that if
 "Immediate activation" was selected, then the kernel will wait for GDB to
 attach. If not, then the kernel will boot immediately and GDB will have to
-interupt it or wait for an exception to occur if before doing anything with
+interrupt it or wait for an exception to occur before doing anything with
 the kernel.
 
 
diff -ru a/Documentation/fujitsu/frv/kernel-ABI.txt b/Documentation/fujitsu/frv/kernel-ABI.txt
--- a/Documentation/fujitsu/frv/kernel-ABI.txt	2006-09-19 23:42:06.000000000 -0400
+++ b/Documentation/fujitsu/frv/kernel-ABI.txt	2006-10-11 21:46:16.000000000 -0400
@@ -156,7 +156,7 @@
 almost completely self-contained. The only external code used is the
 sprintf family of functions.
 
-Futhermore, break.S is so complicated because single-step mode does not
+Furthermore, break.S is so complicated because single-step mode does not
 switch off on entry to an exception. That means unless manually disabled,
 single-stepping will blithely go on stepping into things like interrupts.
 See gdbstub.txt for more information.
diff -ru a/Documentation/input/amijoy.txt b/Documentation/input/amijoy.txt
--- a/Documentation/input/amijoy.txt	2006-10-06 21:28:15.000000000 -0400
+++ b/Documentation/input/amijoy.txt	2006-10-11 21:46:16.000000000 -0400
@@ -91,8 +91,8 @@
          |   1    | M0HQ     | JOY0DAT Horizontal Clock (quadrature)   |
          |   2    | M0V      | JOY0DAT Vertical Clock                  |
          |   3    | M0VQ     | JOY0DAT Vertical Clock  (quadrature)    |
-         |   4    | M1V      | JOY1DAT Horizontall Clock               |
-         |   5    | M1VQ     | JOY1DAT Horizontall Clock (quadrature)  |
+         |   4    | M1V      | JOY1DAT Horizontal Clock                |
+         |   5    | M1VQ     | JOY1DAT Horizontal Clock (quadrature)   |
          |   6    | M1V      | JOY1DAT Vertical Clock                  |
          |   7    | M1VQ     | JOY1DAT Vertical Clock (quadrature)     |
          +--------+----------+-----------------------------------------+
diff -ru a/Documentation/input/atarikbd.txt b/Documentation/input/atarikbd.txt
--- a/Documentation/input/atarikbd.txt	2006-10-06 21:28:15.000000000 -0400
+++ b/Documentation/input/atarikbd.txt	2006-10-11 21:46:16.000000000 -0400
@@ -277,8 +277,8 @@
 9.7 SET MOUSE SCALE
 
     0x0C
-    X                   ; horizontal mouse ticks per internel X
-    Y                   ; vertical mouse ticks per internel Y
+    X                   ; horizontal mouse ticks per internal X
+    Y                   ; vertical mouse ticks per internal Y
 
 This command sets the scale factor for the ABSOLUTE MOUSE POSITIONING mode.
 In this mode, the specified number of mouse phase changes ('clicks') must
@@ -323,7 +323,7 @@
     0x0F
 
 This command makes the origin of the Y axis to be at the bottom of the
-logical coordinate system internel to the ikbd for all relative or absolute
+logical coordinate system internal to the ikbd for all relative or absolute
 mouse motion. This causes mouse motion toward the user to be negative in sign
 and away from the user to be positive.
 
@@ -597,8 +597,8 @@
 
 10. SCAN CODES
 
-The key scan codes return by the ikbd are chosen to simplify the
-implementaion of GSX.
+The key scan codes returned by the ikbd are chosen to simplify the
+implementation of GSX.
 
 GSX Standard Keyboard Mapping.
 
diff -ru a/Documentation/input/iforce-protocol.txt b/Documentation/input/iforce-protocol.txt
--- a/Documentation/input/iforce-protocol.txt	2006-09-19 23:42:06.000000000 -0400
+++ b/Documentation/input/iforce-protocol.txt	2006-10-11 21:52:26.000000000 -0400
@@ -7,7 +7,7 @@
 send an email to: deneux@ifrance.com
 
 ** WARNING **
-I may not be held responsible for any dammage or harm caused if you try to
+I may not be held responsible for any damage or harm caused if you try to
 send data to your I-Force device based on what you read in this document.
 
 ** Preliminary Notes:
@@ -157,7 +157,7 @@
 
 **** Query ram size ****
 QUERY = 42 ('B'uffer size)
-The device should reply with the same packet plus two additionnal bytes
+The device should reply with the same packet plus two additional bytes
 containing the size of the memory:
 ff 03 42 03 e8 CS would mean that the device has 1000 bytes of ram available.
 
diff -ru a/Documentation/input/yealink.txt b/Documentation/input/yealink.txt
--- a/Documentation/input/yealink.txt	2006-10-06 21:28:15.000000000 -0400
+++ b/Documentation/input/yealink.txt	2006-10-11 21:46:16.000000000 -0400
@@ -134,7 +134,7 @@
   888888888888
   Linux Rocks!
 
-Writing to /sys/../lineX will set the coresponding LCD line.
+Writing to /sys/../lineX will set the corresponding LCD line.
  - Excess characters are ignored.
  - If less characters are written than allowed, the remaining digits are
    unchanged.
diff -ru a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
--- a/Documentation/kbuild/makefiles.txt	2006-10-06 21:28:15.000000000 -0400
+++ b/Documentation/kbuild/makefiles.txt	2006-10-11 21:46:16.000000000 -0400
@@ -227,9 +227,9 @@
 	be included in a library, lib.a.
 	All objects listed with lib-y are combined in a single
 	library for that directory.
-	Objects that are listed in obj-y and additionaly listed in
-	lib-y will not be included in the library, since they will anyway
-	be accessible.
+	Objects that are listed in obj-y and additionally listed in
+	lib-y will not be included in the library, since they will
+	be accessible anyway.
 	For consistency, objects listed in lib-m will be included in lib.a.
 
 	Note that the same kbuild makefile may list files to be built-in
@@ -535,7 +535,7 @@
 	Host programs can be made up based on composite objects.
 	The syntax used to define composite objects for host programs is
 	similar to the syntax used for kernel objects.
-	$(<executeable>-objs) lists all objects used to link the final
+	$(<executable>-objs) lists all objects used to link the final
 	executable.
 
 	Example:
@@ -1022,7 +1022,7 @@
 	In this example, there are two possible targets, requiring different
 	options to the linker. The linker options are specified using the
 	LDFLAGS_$@ syntax - one for each potential target.
-	$(targets) are assinged all potential targets, by which kbuild knows
+	$(targets) are assigned all potential targets, by which kbuild knows
 	the targets and will:
 		1) check for commandline changes
 		2) delete target during make clean
diff -ru a/Documentation/keys.txt b/Documentation/keys.txt
--- a/Documentation/keys.txt	2006-10-06 21:28:15.000000000 -0400
+++ b/Documentation/keys.txt	2006-10-11 21:46:16.000000000 -0400
@@ -304,7 +304,7 @@
 	R	Revoked
 	D	Dead
 	Q	Contributes to user's quota
-	U	Under contruction by callback to userspace
+	U	Under construction by callback to userspace
 	N	Negative key
 
      This file must be enabled at kernel configuration time as it allows anyone
diff -ru a/Documentation/laptop-mode.txt b/Documentation/laptop-mode.txt
--- a/Documentation/laptop-mode.txt	2006-10-06 21:28:15.000000000 -0400
+++ b/Documentation/laptop-mode.txt	2006-10-11 21:46:16.000000000 -0400
@@ -121,7 +121,7 @@
 MAX_AGE:
 
 Maximum time, in seconds, of hard drive spindown time that you are
-confortable with. Worst case, it's possible that you could lose this
+comfortable with. Worst case, it's possible that you could lose this
 amount of work if your battery fails while you're in laptop mode.
 
 MINIMUM_BATTERY_MINUTES:
@@ -235,7 +235,7 @@
 
 --------------------CONFIG FILE BEGIN-------------------------------------------
 # Maximum time, in seconds, of hard drive spindown time that you are
-# confortable with. Worst case, it's possible that you could lose this
+# comfortable with. Worst case, it's possible that you could lose this
 # amount of work if your battery fails you while in laptop mode.
 #MAX_AGE=600
 
@@ -350,7 +350,7 @@
 # set defaults instead:
 
 # Maximum time, in seconds, of hard drive spindown time that you are
-# confortable with. Worst case, it's possible that you could lose this
+# comfortable with. Worst case, it's possible that you could lose this
 # amount of work if your battery fails you while in laptop mode.
 MAX_AGE=${MAX_AGE:-'600'}
 
diff -ru a/Documentation/networking/cs89x0.txt b/Documentation/networking/cs89x0.txt
--- a/Documentation/networking/cs89x0.txt	2006-10-06 21:28:15.000000000 -0400
+++ b/Documentation/networking/cs89x0.txt	2006-10-11 21:46:16.000000000 -0400
@@ -620,8 +620,8 @@
                                                 12       Mouse (PS/2)                              
 Memory Address  Device                          13       Math Coprocessor
 --------------  ---------------------           14       Hard Disk controller
-A000-BFFF	EGA Graphics Adpater
-A000-C7FF	VGA Graphics Adpater
+A000-BFFF	EGA Graphics Adapter
+A000-C7FF	VGA Graphics Adapter
 B000-BFFF	Mono Graphics Adapter
 B800-BFFF	Color Graphics Adapter
 E000-FFFF	AT BIOS
diff -ru a/Documentation/networking/NAPI_HOWTO.txt b/Documentation/networking/NAPI_HOWTO.txt
--- a/Documentation/networking/NAPI_HOWTO.txt	2006-10-06 21:28:15.000000000 -0400
+++ b/Documentation/networking/NAPI_HOWTO.txt	2006-10-11 21:56:28.000000000 -0400
@@ -535,11 +535,11 @@
         * 1. it can race with disabling irqs in irq handler (which are done to 
 	* schedule polls)
         * 2. it can race with dis/enabling irqs in other poll threads
-        * 3. if an irq raised after the begining of the outer  beginning 
-        * loop(marked in the code above), it will be immediately
+        * 3. if an irq raised after the beginning of the outer beginning 
+        * loop (marked in the code above), it will be immediately
         * triggered here.
         *
-        * Summarizing: the logic may results in some redundant irqs both
+        * Summarizing: the logic may result in some redundant irqs both
         * due to races in masking and due to too late acking of already
         * processed irqs. The good news: no events are ever lost.
         */
diff -ru a/Documentation/networking/packet_mmap.txt b/Documentation/networking/packet_mmap.txt
--- a/Documentation/networking/packet_mmap.txt	2006-10-06 21:28:15.000000000 -0400
+++ b/Documentation/networking/packet_mmap.txt	2006-10-11 21:46:16.000000000 -0400
@@ -284,7 +284,7 @@
 -------------------
 
 If you check the source code you will see that what I draw here as a frame
-is not only the link level frame. At the begining of each frame there is a 
+is not only the link level frame. At the beginning of each frame there is a 
 header called struct tpacket_hdr used in PACKET_MMAP to hold link level's frame
 meta information like timestamp. So what we draw here a frame it's really 
 the following (from include/linux/if_packet.h):
diff -ru a/Documentation/networking/pktgen.txt b/Documentation/networking/pktgen.txt
--- a/Documentation/networking/pktgen.txt	2006-10-06 21:28:15.000000000 -0400
+++ b/Documentation/networking/pktgen.txt	2006-10-11 21:46:16.000000000 -0400
@@ -63,8 +63,8 @@
 Result: OK: 13101142(c12220741+d880401) usec, 10000000 (60byte,0frags)
   763292pps 390Mb/sec (390805504bps) errors: 39664
 
-Confguring threads and devices
-==============================
+Configuring threads and devices
+================================
 This is done via the /proc interface easiest done via pgset in the scripts
 
 Examples:
diff -ru a/Documentation/networking/wan-router.txt b/Documentation/networking/wan-router.txt
--- a/Documentation/networking/wan-router.txt	2006-10-06 21:28:15.000000000 -0400
+++ b/Documentation/networking/wan-router.txt	2006-10-11 21:46:16.000000000 -0400
@@ -444,7 +444,7 @@
 					
 				o Cpipemon
 					- Added set FT1 commands to the cpipemon. Thus CSU/DSU
-					  configuraiton can be performed using cpipemon.
+					  configuration can be performed using cpipemon.
 					  All systems that cannot run cfgft1 GUI utility should
 					  use cpipemon to configure the on board CSU/DSU.
 
@@ -464,7 +464,7 @@
 					- Appropriate number of devices are dynamically loaded 
 					  based on the number of Sangoma cards found.
 
-					  Note: The kernel configuraiton option 
+					  Note: The kernel configuration option 
 						CONFIG_WANPIPE_CARDS has been taken out.
 					
 				o Fixed the Frame Relay and Chdlc network interfaces so they are
diff -ru a/Documentation/power/pci.txt b/Documentation/power/pci.txt
--- a/Documentation/power/pci.txt	2006-10-06 21:28:15.000000000 -0400
+++ b/Documentation/power/pci.txt	2006-10-11 21:46:16.000000000 -0400
@@ -153,7 +153,7 @@
 	events, which is implicit if it doesn't even support it in the first
 	place).
 
-	Note that the PMC Register in the device's PM Capabilties has a bitmask
+	Note that the PMC Register in the device's PM Capabilities has a bitmask
 	of the states it supports generating PME# from. D3hot is bit 3 and
 	D3cold is bit 4. So, while a value of 4 as the state may not seem
 	semantically correct, it is. 
@@ -268,7 +268,7 @@
 some non-standard way of generating a wake event on sleep.)
 
 Bits 15:11 of the PMC (Power Mgmt Capabilities) Register in a device's
-PM Capabilties describe what power states the device supports generating a 
+PM Capabilities describe what power states the device supports generating a 
 wake event from:
 
 +------------------+
diff -ru a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
--- a/Documentation/power/swsusp.txt	2006-10-06 21:28:15.000000000 -0400
+++ b/Documentation/power/swsusp.txt	2006-10-11 21:46:16.000000000 -0400
@@ -153,7 +153,7 @@
 
 If the thread is needed for writing the image to storage, you should
 instead set the PF_NOFREEZE process flag when creating the thread (and
-be very carefull).
+be very careful).
 
 
 Q: What is the difference between "platform", "shutdown" and
diff -ru a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
--- a/Documentation/powerpc/booting-without-of.txt	2006-10-06 21:28:15.000000000 -0400
+++ b/Documentation/powerpc/booting-without-of.txt	2006-10-11 22:00:10.000000000 -0400
@@ -33,13 +33,13 @@
                          - Change version 16 format to always align
                            property data to 4 bytes. Since tokens are
                            already aligned, that means no specific
-                           required alignement between property size
+                           required alignment between property size
                            and property data. The old style variable
                            alignment would make it impossible to do
                            "simple" insertion of properties using
                            memove (thanks Milton for
                            noticing). Updated kernel patch as well
-			 - Correct a few more alignement constraints
+			 - Correct a few more alignment constraints
 			 - Add a chapter about the device-tree
                            compiler and the textural representation of
                            the tree that can be "compiled" by dtc.
@@ -854,7 +854,7 @@
       console device if any. Typically, if you have serial devices on
       your board, you may want to put the full path to the one set as
       the default console in the firmware here, for the kernel to pick
-      it up as it's own default console. If you look at the funciton
+      it up as its own default console. If you look at the function
       set_preferred_console() in arch/ppc64/kernel/setup.c, you'll see
       that the kernel tries to find out the default console and has
       knowledge of various types like 8250 serial ports. You may want
@@ -1124,7 +1124,7 @@
 	- interrupt-parent : contains the phandle of the interrupt
           controller which handles interrupts for this device
 	- interrupts : a list of tuples representing the interrupt
-          number and the interrupt sense and level for each interupt
+          number and the interrupt sense and level for each interrupt
           for this device.
 
 This information is used by the kernel to build the interrupt table
diff -ru a/Documentation/robust-futexes.txt b/Documentation/robust-futexes.txt
--- a/Documentation/robust-futexes.txt	2006-09-19 23:42:06.000000000 -0400
+++ b/Documentation/robust-futexes.txt	2006-10-11 21:46:16.000000000 -0400
@@ -181,7 +181,7 @@
 So there is virtually zero overhead for tasks not using robust futexes,
 and even for robust futex users, there is only one extra syscall per
 thread lifetime, and the cleanup operation, if it happens, is fast and
-straightforward. The kernel doesnt have any internal distinction between
+straightforward. The kernel doesn't have any internal distinction between
 robust and normal futexes.
 
 If a futex is found to be held at exit time, the kernel sets the
diff -ru a/Documentation/s390/cds.txt b/Documentation/s390/cds.txt
--- a/Documentation/s390/cds.txt	2006-10-06 21:28:15.000000000 -0400
+++ b/Documentation/s390/cds.txt	2006-10-11 21:46:16.000000000 -0400
@@ -454,7 +454,7 @@
 case all I/O interruptions are presented to the device driver until final
 status is recognized.
 
-If a device is able to recover from asynchronosly presented I/O errors, it can
+If a device is able to recover from asynchronously presented I/O errors, it can
 perform overlapping I/O using the DOIO_EARLY_NOTIFICATION flag. While some
 devices always report channel-end and device-end together, with a single
 interrupt, others present primary status (channel-end) when the channel is
diff -ru a/Documentation/s390/Debugging390.txt b/Documentation/s390/Debugging390.txt
--- a/Documentation/s390/Debugging390.txt	2006-10-06 21:28:15.000000000 -0400
+++ b/Documentation/s390/Debugging390.txt	2006-10-11 21:59:20.000000000 -0400
@@ -502,8 +502,8 @@
 ------
 1) The only requirement is that registers which are used
 by the callee are saved, e.g. the compiler is perfectly
-capible of using r11 for purposes other than a frame a
-frame pointer if a frame pointer is not needed.
+capable of using r11 for purposes other than a frame pointer if 
+a frame pointer is not needed.
 2) In functions with variable arguments e.g. printf the calling procedure 
 is identical to one without variable arguments & the same number of 
 parameters. However, the prologue of this function is somewhat more
@@ -1037,12 +1037,12 @@
 
 Performance Debugging
 =====================
-gcc is capible of compiling in profiling code just add the -p option
-to the CFLAGS, this obviously affects program size & performance.
+gcc is capable of compiling in profiling code; just add the -p option
+to the CFLAGS (this obviously affects program size & performance).
 This can be used by the gprof gnu profiling tool or the
-gcov the gnu code coverage tool ( code coverage is a means of testing
+gcov gnu code coverage tool (code coverage is a means of testing
 code quality by checking if all the code in an executable in exercised by
-a tester ).
+a tester).
 
 
 Using top to find out where processes are sleeping in the kernel
diff -ru a/Documentation/scsi/aic79xx.txt b/Documentation/scsi/aic79xx.txt
--- a/Documentation/scsi/aic79xx.txt	2006-10-06 21:28:16.000000000 -0400
+++ b/Documentation/scsi/aic79xx.txt	2006-10-11 21:46:16.000000000 -0400
@@ -169,7 +169,7 @@
    1.3.0 (January 21st, 2003)
         - Full regression testing for all U320 products completed.
         - Added abort and target/lun reset error recovery handler and
-          interrupt coalessing.
+          interrupt coalescing.
 
    1.2.0 (November 14th, 2002)
         - Added support for Domain Validation
diff -ru a/Documentation/scsi/aic7xxx_old.txt b/Documentation/scsi/aic7xxx_old.txt
--- a/Documentation/scsi/aic7xxx_old.txt	2006-10-06 21:28:16.000000000 -0400
+++ b/Documentation/scsi/aic7xxx_old.txt	2006-10-11 21:46:16.000000000 -0400
@@ -256,7 +256,7 @@
 	      En/Disable High Byte LVD Termination
 
 	The upper 2 bits that deal with LVD termination only apply to Ultra2
-	controllers.  Futhermore, due to the current Ultra2 controller
+	controllers.  Furthermore, due to the current Ultra2 controller
 	designs, these bits are tied together such that setting either bit
 	enables both low and high byte LVD termination.  It is not possible
 	to only set high or low byte LVD termination in this manner.  This is
diff -ru a/Documentation/scsi/ibmmca.txt b/Documentation/scsi/ibmmca.txt
--- a/Documentation/scsi/ibmmca.txt	2006-10-06 21:28:16.000000000 -0400
+++ b/Documentation/scsi/ibmmca.txt	2006-10-11 21:46:16.000000000 -0400
@@ -710,8 +710,8 @@
       of troubles with some controllers and after I wanted to apply some
       extensions, it jumped out in the same situation, on my w/cache, as like 
       on D. Weinehalls' Model 56, having integrated SCSI. This gave me the 
-      descissive hint to move the code-part out and declare it global. Now,
-      it seems to work by far much better an more stable. Let us see, what
+      decisive hint to move the code-part out and declare it global. Now
+      it seems to work far better and more stable. Let us see what
       the world thinks of it...
    3) By the way, only Sony DAT-drives seem to show density code 0x13. A
       test with a HP drive gave right results, so the problem is vendor-
@@ -822,10 +822,10 @@
    A long period of collecting bugreports from all corners of the world
    now lead to the following corrections to the code:
    1) SCSI-2 F/W support crashed with a COMMAND ERROR. The reason for this 
-      was, that it is possible to disbale Fast-SCSI for the external bus.
-      The feature-control command, where this crash appeared regularly tried
+      was that it is possible to disable Fast-SCSI for the external bus.
+      The feature-control command, where this crash appeared regularly, tried
       to set the maximum speed of 10MHz synchronous transfer speed and that
-      reports a COMMAND ERROR, if external bus Fast-SCSI is disabled. Now,
+      reports a COMMAND ERROR if external bus Fast-SCSI is disabled. Now,
       the feature-command probes down from maximum speed until the adapter 
       stops to complain, which is at the same time the maximum possible
       speed selected in the reference program. So, F/W external can run at
diff -ru a/Documentation/scsi/in2000.txt b/Documentation/scsi/in2000.txt
--- a/Documentation/scsi/in2000.txt	2006-09-19 23:42:06.000000000 -0400
+++ b/Documentation/scsi/in2000.txt	2006-10-11 21:46:16.000000000 -0400
@@ -24,7 +24,7 @@
 UPDATE NEWS: version 1.31 - 6 Jul 97
 
    Fixed a bug that caused incorrect SCSI status bytes to be
-   returned from commands sent to LUN's greater than 0. This
+   returned from commands sent to LUNs greater than 0. This
    means that CDROM changers work now! Fixed a bug in the
    handling of command-line arguments when loaded as a module.
    Also put all the header data in in2000.h where it belongs.
diff -ru a/Documentation/scsi/scsi-changer.txt b/Documentation/scsi/scsi-changer.txt
--- a/Documentation/scsi/scsi-changer.txt	2006-10-06 21:28:16.000000000 -0400
+++ b/Documentation/scsi/scsi-changer.txt	2006-10-11 21:46:16.000000000 -0400
@@ -88,7 +88,7 @@
 device [ try "dmesg" if you don't see anything ] and should show up in
 /proc/devices. If not....  some changers use ID ? / LUN 0 for the
 device and ID ? / LUN 1 for the robot mechanism. But Linux does *not*
-look for LUN's other than 0 as default, becauce there are to many
+look for LUNs other than 0 as default, because there are too many
 broken devices. So you can try:
 
   1) echo "scsi add-single-device 0 0 ID 1" > /proc/scsi/scsi
@@ -107,7 +107,7 @@
 strings then.
 
 You can display these messages with the dmesg command (or check the
-logfiles).  If you email me some question becauce of a problem with the
+logfiles).  If you email me some question because of a problem with the
 driver, please include these messages.
 
 
diff -ru a/Documentation/scsi/scsi_eh.txt b/Documentation/scsi/scsi_eh.txt
--- a/Documentation/scsi/scsi_eh.txt	2006-10-06 21:28:16.000000000 -0400
+++ b/Documentation/scsi/scsi_eh.txt	2006-10-11 21:46:16.000000000 -0400
@@ -75,7 +75,7 @@
 
  - otherwise
 	scsi_eh_scmd_add(scmd, 0) is invoked for the command.  See
-	[1-3] for details of this funciton.
+	[1-3] for details of this function.
 
 
 [1-2-2] Completing a scmd w/ timeout
diff -ru a/Documentation/scsi/sym53c8xx_2.txt b/Documentation/scsi/sym53c8xx_2.txt
--- a/Documentation/scsi/sym53c8xx_2.txt	2006-10-06 21:28:16.000000000 -0400
+++ b/Documentation/scsi/sym53c8xx_2.txt	2006-10-11 21:46:16.000000000 -0400
@@ -609,7 +609,7 @@
 be sure I will receive it.  Obviously, a bug in the driver code is
 possible.
 
-  My cyrrent email address: Gerard Roudier <groudier@free.fr>
+  My current email address: Gerard Roudier <groudier@free.fr>
 
 Allowing disconnections is important if you use several devices on
 your SCSI bus but often causes problems with buggy devices.
diff -ru a/Documentation/stable_kernel_rules.txt b/Documentation/stable_kernel_rules.txt
--- a/Documentation/stable_kernel_rules.txt	2006-10-06 21:28:16.000000000 -0400
+++ b/Documentation/stable_kernel_rules.txt	2006-10-11 21:46:16.000000000 -0400
@@ -50,7 +50,7 @@
    Contact the kernel security team for more details on this procedure.
 
 
-Review committe:
+Review committee:
 
  - This is made up of a number of kernel developers who have volunteered for
    this task, and a few that haven't.
diff -ru a/Documentation/sysctl/fs.txt b/Documentation/sysctl/fs.txt
--- a/Documentation/sysctl/fs.txt	2006-09-19 23:42:06.000000000 -0400
+++ b/Documentation/sysctl/fs.txt	2006-10-11 21:46:16.000000000 -0400
@@ -146,7 +146,7 @@
 	readable by root only. This allows the end user to remove
 	such a dump but not access it directly. For security reasons
 	core dumps in this mode will not overwrite one another or
-	other files. This mode is appropriate when adminstrators are
+	other files. This mode is appropriate when administrators are
 	attempting to debug problems in a normal environment.
 
 ==============================================================
diff -ru a/Documentation/sysctl/vm.txt b/Documentation/sysctl/vm.txt
--- a/Documentation/sysctl/vm.txt	2006-10-06 21:28:16.000000000 -0400
+++ b/Documentation/sysctl/vm.txt	2006-10-11 21:59:39.000000000 -0400
@@ -129,7 +129,7 @@
 
 zone_reclaim_mode:
 
-Zone_reclaim_mode allows to set more or less agressive approaches to
+Zone_reclaim_mode allows someone to set more or less aggressive approaches to
 reclaim memory when a zone runs out of memory. If it is set to zero then no
 zone reclaim occurs. Allocations will be satisfied from other zones / nodes
 in the system.
diff -ru a/Documentation/usb/hiddev.txt b/Documentation/usb/hiddev.txt
--- a/Documentation/usb/hiddev.txt	2006-10-06 21:28:16.000000000 -0400
+++ b/Documentation/usb/hiddev.txt	2006-10-11 21:46:16.000000000 -0400
@@ -8,7 +8,7 @@
 examples for this are power devices (especially uninterruptable power
 supplies) and monitor control on higher end monitors.
 
-To support these disparite requirements, the Linux USB system provides
+To support these disparate requirements, the Linux USB system provides
 HID events to two separate interfaces:
 * the input subsystem, which converts HID events into normal input
 device interfaces (such as keyboard, mouse and joystick) and a
diff -ru a/Documentation/usb/usb-serial.txt b/Documentation/usb/usb-serial.txt
--- a/Documentation/usb/usb-serial.txt	2006-10-06 21:28:16.000000000 -0400
+++ b/Documentation/usb/usb-serial.txt	2006-10-11 21:46:16.000000000 -0400
@@ -297,7 +297,7 @@
       Parity       N,E,O,M,S
       Handshake    None, Software (XON/XOFF), Hardware (CTSRTS,CTSDTR)*
       Break        Set and clear
-      Line contrl  Input/Output query and control **
+      Line control Input/Output query and control **
 
       *  Hardware input flow control is only enabled for firmware
          levels above 2.06.  Read source code comments describing Belkin
@@ -309,7 +309,7 @@
          automatic hardware flow control.
 
   TO DO List:
-    -- Add true modem contol line query capability.  Currently tracks the
+    -- Add true modem control line query capability.  Currently tracks the
        states reported by the interrupt and the states requested.
     -- Add error reporting back to application for UART error conditions.
     -- Add support for flush ioctls.

