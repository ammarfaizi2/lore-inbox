Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751403AbWGKBIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWGKBIW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 21:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWGKBIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 21:08:22 -0400
Received: from cpe-72-226-39-15.nycap.res.rr.com ([72.226.39.15]:1287 "EHLO
	mail.cyberdogtech.com") by vger.kernel.org with ESMTP
	id S1751403AbWGKBIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 21:08:21 -0400
Date: Mon, 10 Jul 2006 21:07:55 -0400
From: Matt LaPlante <kernel1@cyberdogtech.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 18-rc1] Fix typos in /Documentation : 'A'
Message-Id: <20060710210755.abb2af5d.kernel1@cyberdogtech.com>
In-Reply-To: <20060710103433.37420ae2.rdunlap@xenotime.net>
References: <20060710130549.ed48127a.kernel1@cyberdogtech.com>
	<20060710103433.37420ae2.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Processed: mail.cyberdogtech.com, Mon, 10 Jul 2006 21:08:07 -0400
	(not processed: message from valid local sender)
X-Return-Path: kernel1@cyberdogtech.com
X-Envelope-From: kernel1@cyberdogtech.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-MDAV-Processed: mail.cyberdogtech.com, Mon, 10 Jul 2006 21:08:07 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 10:34:33 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> On Mon, 10 Jul 2006 13:05:49 -0400 Matt LaPlante wrote:
> 
> > This patch fixes typos in various Documentation txts. This patch addresses some words starting with the letter 'A'.
> > 
> > Signed-off-by: Matt LaPlante <kernel1@cyberdogtech.com>
> 
> Hi,
> Looks mostly good.  I think it would be OK to fix other typos
> on the same lines as the patches... see below.

The updated patch below fixes two of the three issues you mentioned.  I don't know what you'd want done with the dead URL, that file doesn't have a whole lot else in it, and I don’t know what the new URL would be.  

I agree fixing other typos is a worthy cause, though currently I haven't really made any changes other than spelling for a couple reasons:

1- I'm detecting the spelling errors by scripting with aspell and custom wordlists.  This method doesn't reveal grammatical errors often, and I'm not reading much of the actual documents except to get context for the spelling errors.  (I _am_ making all changes manually, not scripting the actual corrections).

2- Spelling errors are really hard to dispute (except for some nationality issues)...things are either spelled wrong or right.  I would be more hesitant to change actual grammar where I could also unwittingly change the meaning of a technical document (which I often don't have indepth knowledge of to begin with).

I'll certainly be willing to more thoroughly read through and correct the docs later on (and I'm sure I could learn quite a bit in the process).  I thought this round of tackling the most obvious errors assisted by scripting would be a good way to get acquainted with the patching process.

-- 
Matt LaPlante
--

diff -ru a/Documentation/arm/Samsung-S3C24XX/GPIO.txt b/Documentation/arm/Samsung-S3C24XX/GPIO.txt
--- a/Documentation/arm/Samsung-S3C24XX/GPIO.txt	2006-07-08 14:12:28.000000000 -0400
+++ b/Documentation/arm/Samsung-S3C24XX/GPIO.txt	2006-07-10 12:25:46.000000000 -0400
@@ -24,7 +24,7 @@
   header include/asm-arm/arch-s3c2410/hardware.h which can be
   included by #include <asm/arch/hardware.h>
 
-  A useful ammount of documentation can be found in the hardware
+  A useful amount of documentation can be found in the hardware
   header on how the GPIO functions (and others) work.
 
   Whilst a number of these functions do make some checks on what
diff -ru a/Documentation/arm/Samsung-S3C24XX/Overview.txt b/Documentation/arm/Samsung-S3C24XX/Overview.txt
--- a/Documentation/arm/Samsung-S3C24XX/Overview.txt	2006-07-08 14:13:34.000000000 -0400
+++ b/Documentation/arm/Samsung-S3C24XX/Overview.txt	2006-07-10 12:05:53.000000000 -0400
@@ -80,7 +80,7 @@
 Adding New Machines
 -------------------
 
-  The archicture has been designed to support as many machines as can
+  The architecture has been designed to support as many machines as can
   be configured for it in one kernel build, and any future additions
   should keep this in mind before altering items outside of their own
   machine files.
diff -ru a/Documentation/dell_rbu.txt b/Documentation/dell_rbu.txt
--- a/Documentation/dell_rbu.txt	2006-07-08 14:12:34.000000000 -0400
+++ b/Documentation/dell_rbu.txt	2006-07-10 12:04:50.000000000 -0400
@@ -4,7 +4,7 @@
 
 Scope:
 This document discusses the functionality of the rbu driver only.
-It does not cover the support needed from aplications to enable the BIOS to
+It does not cover the support needed from applications to enable the BIOS to
 update itself with the image downloaded in to the memory.
 
 Overview:
diff -ru a/Documentation/eisa.txt b/Documentation/eisa.txt
--- a/Documentation/eisa.txt	2006-07-08 14:12:41.000000000 -0400
+++ b/Documentation/eisa.txt	2006-07-10 12:22:18.000000000 -0400
@@ -18,7 +18,7 @@
 
     - The bus code implements most of the generic code. It is shared
     among all the architectures that the EISA code runs on. It
-    implements bus probing (detecting EISA cards avaible on the bus),
+    implements bus probing (detecting EISA cards available on the bus),
     allocates I/O resources, allows fancy naming through sysfs, and
     offers interfaces for driver to register.
 
diff -ru a/Documentation/fb/sstfb.txt b/Documentation/fb/sstfb.txt
--- a/Documentation/fb/sstfb.txt	2006-07-08 14:12:27.000000000 -0400
+++ b/Documentation/fb/sstfb.txt	2006-07-10 12:14:50.000000000 -0400
@@ -161,7 +161,7 @@
 	- Buy more coffee.
 	- test/port to other arch.
 	- try to add panning using tweeks with front and back buffer .
-	- try to implement accel on voodoo2 , this board can actualy do a 
+	- try to implement accel on voodoo2, this board can actually do a 
 	  lot in 2D even if it was sold as a 3D only board ...
 
 ghoz.
diff -ru a/Documentation/filesystems/configfs/configfs.txt b/Documentation/filesystems/configfs/configfs.txt
--- a/Documentation/filesystems/configfs/configfs.txt	2006-07-08 14:12:35.000000000 -0400
+++ b/Documentation/filesystems/configfs/configfs.txt	2006-07-10 12:24:46.000000000 -0400
@@ -406,7 +406,7 @@
 
 Far better would be an explicit action notifying the subsystem that the
 config_item is ready to go.  More importantly, an explicit action allows
-the subsystem to provide feedback as to whether the attibutes are
+the subsystem to provide feedback as to whether the attributes are
 initialized in a way that makes sense.  configfs provides this as
 committable items.
 
diff -ru a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
--- a/Documentation/filesystems/proc.txt	2006-07-08 14:12:35.000000000 -0400
+++ b/Documentation/filesystems/proc.txt	2006-07-10 12:26:46.000000000 -0400
@@ -408,7 +408,7 @@
               this memory, making it slower to access than lowmem.
     LowTotal:
      LowFree: Lowmem is memory which can be used for everything that
-              highmem can be used for, but it is also availble for the
+              highmem can be used for, but it is also available for the
               kernel's use for its own data structures.  Among many
               other things, it is where everything from the Slab is
               allocated.  Bad things happen when you're out of lowmem.
diff -ru a/Documentation/ia64/fsys.txt b/Documentation/ia64/fsys.txt
--- a/Documentation/ia64/fsys.txt	2006-07-08 14:12:29.000000000 -0400
+++ b/Documentation/ia64/fsys.txt	2006-07-10 12:07:10.000000000 -0400
@@ -165,7 +165,7 @@
 * Signal handling
 
 The delivery of (asynchronous) signals must be delayed until fsys-mode
-is exited.  This is acomplished with the help of the lower-privilege
+is exited.  This is accomplished with the help of the lower-privilege
 transfer trap: arch/ia64/kernel/process.c:do_notify_resume_user()
 checks whether the interrupted task was in fsys-mode and, if so, sets
 PSR.lp and returns immediately.  When fsys-mode is exited via the
diff -ru a/Documentation/input/atarikbd.txt b/Documentation/input/atarikbd.txt
--- a/Documentation/input/atarikbd.txt	2006-07-08 14:12:34.000000000 -0400
+++ b/Documentation/input/atarikbd.txt	2006-07-10 12:21:29.000000000 -0400
@@ -10,7 +10,7 @@
 The ikbd processor also maintains a time-of-day clock with one second
 resolution.
 The ikbd has been designed to be general enough that it can be used with a
-ariety of new computer products. Product variations in a number of
+variety of new computer products. Product variations in a number of
 keyswitches, mouse resolution, etc. can be accommodated.
 The ikbd communicates with the main processor over a high speed bi-directional
 serial interface. It can function in a variety of modes to facilitate
diff -ru a/Documentation/IPMI.txt b/Documentation/IPMI.txt
--- a/Documentation/IPMI.txt	2006-07-08 14:13:34.000000000 -0400
+++ b/Documentation/IPMI.txt	2006-07-10 11:58:20.000000000 -0400
@@ -462,7 +462,7 @@
 message as a block write to the I2C bus and waits for a response.
 This action can be detrimental to some I2C devices. It is highly recommended
 that the known I2c address be given to the SMBus driver in the smb_addr
-parameter. The default adrress range will not be used when a smb_addr
+parameter. The default address range will not be used when a smb_addr
 parameter is provided.
 
 When compiled into the kernel, the addresses can be specified on the
diff -ru a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
--- a/Documentation/kbuild/makefiles.txt	2006-07-08 14:13:34.000000000 -0400
+++ b/Documentation/kbuild/makefiles.txt	2006-07-10 12:18:46.000000000 -0400
@@ -1053,7 +1053,7 @@
 		#Makefile
 		export CPPFLAGS_vmlinux.lds += -P -C -U$(ARCH)
 		
-	The assigment to $(always) is used to tell kbuild to build the
+	The assignment to $(always) is used to tell kbuild to build the
 	target: vmlinux.lds.
 	The assignment to $(CPPFLAGS_vmlinux.lds) tell kbuild to use the
 	specified options when building the target vmlinux.lds.
diff -ru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	2006-07-08 14:13:34.000000000 -0400
+++ b/Documentation/kernel-parameters.txt	2006-07-10 12:23:45.000000000 -0400
@@ -348,9 +348,9 @@
 
 	clock=		[BUGS=IA-32, HW] gettimeofday clocksource override.
 			[Deprecated]
-			Forces specified clocksource (if avaliable) to be used
+			Forces specified clocksource (if available) to be used
 			when calculating gettimeofday(). If specified
-			clocksource is not avalible, it defaults to PIT.
+			clocksource is not available, it defaults to PIT.
 			Format: { pit | tsc | cyclone | pmtmr }
 
 	disable_8254_timer
diff -ru a/Documentation/keys.txt b/Documentation/keys.txt
--- a/Documentation/keys.txt	2006-07-08 14:13:34.000000000 -0400
+++ b/Documentation/keys.txt	2006-07-10 12:20:53.000000000 -0400
@@ -708,7 +708,7 @@
 
      If the specified key is 0, then any assumed authority will be divested.
 
-     The assumed authorititive key is inherited across fork and exec.
+     The assumed authoritative key is inherited across fork and exec.
 
 
 ===============
diff -ru a/Documentation/laptop-mode.txt b/Documentation/laptop-mode.txt
--- a/Documentation/laptop-mode.txt	2006-07-08 14:12:36.000000000 -0400
+++ b/Documentation/laptop-mode.txt	2006-07-10 12:15:40.000000000 -0400
@@ -152,7 +152,7 @@
 DO_REMOUNTS:
 
 The control script automatically remounts any mounted journaled filesystems
-with approriate commit interval options. When this option is set to 0, this
+with appropriate commit interval options. When this option is set to 0, this
 feature is disabled.
 
 DO_REMOUNT_NOATIME:
diff -ru a/Documentation/mca.txt b/Documentation/mca.txt
--- a/Documentation/mca.txt	2006-07-08 14:12:35.000000000 -0400
+++ b/Documentation/mca.txt	2006-07-10 12:06:30.000000000 -0400
@@ -177,7 +177,7 @@
 	with clones that have a different adapter id than the original
 	NE/2.
 
-6) Future Domain MCS-600/700, OEM'd IBM Fast SCSI Aapter/A and
+6) Future Domain MCS-600/700, OEM'd IBM Fast SCSI Adapter/A and
    Reply Sound Blaster/SCSI (SCSI part)
 	Better support for these cards than the driver for ISA.
    Supports multiple cards with IRQ sharing.
diff -ru a/Documentation/md.txt b/Documentation/md.txt
--- a/Documentation/md.txt	2006-07-08 14:13:34.000000000 -0400
+++ b/Documentation/md.txt	2006-07-10 12:20:20.000000000 -0400
@@ -174,7 +174,7 @@
      raid levels that involve striping (1,4,5,6,10). The address space
      of the array is conceptually divided into chunks and consecutive
      chunks are striped onto neighbouring devices.
-     The size should be atleast PAGE_SIZE (4k) and should be a power
+     The size should be at least PAGE_SIZE (4k) and should be a power
      of 2.  This can only be set while assembling an array
 
   component_size
diff -ru a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
--- a/Documentation/memory-barriers.txt	2006-07-08 14:13:34.000000000 -0400
+++ b/Documentation/memory-barriers.txt	2006-07-10 12:14:11.000000000 -0400
@@ -1916,7 +1916,7 @@
 access depends on a read, not all do, so it may not be relied on.
 
 Other CPUs may also have split caches, but must coordinate between the various
-cachelets for normal memory accesss.  The semantics of the Alpha removes the
+cachelets for normal memory accesses.  The semantics of the Alpha removes the
 need for coordination in absence of memory barriers.
 
 
diff -ru a/Documentation/networking/3c509.txt b/Documentation/networking/3c509.txt
--- a/Documentation/networking/3c509.txt	2006-07-08 14:12:40.000000000 -0400
+++ b/Documentation/networking/3c509.txt	2006-07-10 12:08:12.000000000 -0400
@@ -126,7 +126,7 @@
 or impossible in normal operation. Possible causes of this error report are:
  
    - a "green" mode enabled that slows the processor down when there is no
-     keyboard activitiy. 
+     keyboard activity. 
 
    - some other device or device driver hogging the bus or disabling interrupts.
      Check /proc/interrupts for excessive interrupt counts. The timer tick
diff -ru a/Documentation/networking/cxgb.txt b/Documentation/networking/cxgb.txt
--- a/Documentation/networking/cxgb.txt	2006-07-08 14:12:41.000000000 -0400
+++ b/Documentation/networking/cxgb.txt	2006-07-10 12:01:13.000000000 -0400
@@ -56,7 +56,7 @@
 
       ethtool -C eth0 rx-usecs 100
 
-  You may also provide a timer latency value while disabling adpative-rx:
+  You may also provide a timer latency value while disabling adaptive-rx:
 
       ethtool -C <interface> adaptive-rx off rx-usecs <microseconds>
 
diff -ru a/Documentation/networking/dl2k.txt b/Documentation/networking/dl2k.txt
--- a/Documentation/networking/dl2k.txt	2006-07-08 14:12:41.000000000 -0400
+++ b/Documentation/networking/dl2k.txt	2006-07-10 12:08:51.000000000 -0400
@@ -173,7 +173,7 @@
 
 Parameter Description
 =====================
-You can install this driver without any addtional parameter. However, if you
+You can install this driver without any additional parameter. However, if you
 are going to have extensive functions then it is necessary to set extra
 parameter. Below is a list of the command line parameters supported by the
 Linux device
diff -ru a/Documentation/networking/dmfe.txt b/Documentation/networking/dmfe.txt
--- a/Documentation/networking/dmfe.txt	2006-07-08 14:12:40.000000000 -0400
+++ b/Documentation/networking/dmfe.txt	2006-07-10 11:59:02.000000000 -0400
@@ -34,7 +34,7 @@
 
 	ifconfig eth0 172.22.3.18
                       ^^^^^^^^^^^
-		     Your IP Adress
+		     Your IP Address
 
 Then you may have to modify the default routing table with command :
 
diff -ru a/Documentation/networking/operstates.txt b/Documentation/networking/operstates.txt
--- a/Documentation/networking/operstates.txt	2006-07-08 14:12:40.000000000 -0400
+++ b/Documentation/networking/operstates.txt	2006-07-10 12:00:33.000000000 -0400
@@ -2,7 +2,7 @@
 1. Introduction
 
 Linux distinguishes between administrative and operational state of an
-interface. Admininstrative state is the result of "ip link set dev
+interface. Administrative state is the result of "ip link set dev
 <dev> up or down" and reflects whether the administrator wants to use
 the device for traffic.
 
diff -ru a/Documentation/networking/packet_mmap.txt b/Documentation/networking/packet_mmap.txt
--- a/Documentation/networking/packet_mmap.txt	2006-07-08 14:12:40.000000000 -0400
+++ b/Documentation/networking/packet_mmap.txt	2006-07-10 12:09:43.000000000 -0400
@@ -296,7 +296,7 @@
    - struct tpacket_hdr
    - pad to TPACKET_ALIGNMENT=16
    - struct sockaddr_ll
-   - Gap, chosen so that packet data (Start+tp_net) alignes to 
+   - Gap, chosen so that packet data (Start+tp_net) aligns to 
      TPACKET_ALIGNMENT=16
    - Start+tp_mac: [ Optional MAC header ]
    - Start+tp_net: Packet data, aligned to TPACKET_ALIGNMENT=16.
diff -ru a/Documentation/networking/pktgen.txt b/Documentation/networking/pktgen.txt
--- a/Documentation/networking/pktgen.txt	2006-07-08 14:13:34.000000000 -0400
+++ b/Documentation/networking/pktgen.txt	2006-07-10 12:19:44.000000000 -0400
@@ -7,7 +7,7 @@
 
 Enable CONFIG_NET_PKTGEN to compile and build pktgen.o either in kernel
 or as module. Module is preferred. insmod pktgen if needed. Once running
-pktgen creates a thread on each CPU where each thread has affinty it's CPU.
+pktgen creates a thread on each CPU where each thread has affinity to its CPU.
 Monitoring and controlling is done via /proc. Easiest to select a suitable 
 a sample script and configure.
 
@@ -32,7 +32,7 @@
 Stopped: eth1 
 Result: OK: max_before_softirq=10000
 
-Most important the devices assigend to thread. Note! A device can only belong 
+Most important the devices assigned to thread. Note! A device can only belong 
 to one thread.
 
 
diff -ru a/Documentation/s390/cds.txt b/Documentation/s390/cds.txt
--- a/Documentation/s390/cds.txt	2006-07-08 14:12:29.000000000 -0400
+++ b/Documentation/s390/cds.txt	2006-07-10 12:29:59.000000000 -0400
@@ -348,7 +348,7 @@
           not online.
 
 When the I/O request completes, the CDS first level interrupt handler will
-accumalate the status in a struct irb and then call the device interrupt handler.
+accumulate the status in a struct irb and then call the device interrupt handler.
 The intparm field will contain the value the device driver has associated with a 
 particular I/O request. If a pending device status was recognized, 
 intparm will be set to 0 (zero). This may happen during I/O initiation or delayed
diff -ru a/Documentation/s390/Debugging390.txt b/Documentation/s390/Debugging390.txt
--- a/Documentation/s390/Debugging390.txt	2006-07-08 14:12:29.000000000 -0400
+++ b/Documentation/s390/Debugging390.txt	2006-07-10 12:16:27.000000000 -0400
@@ -188,7 +188,7 @@
 are used by the processor itself for holding such information as exception indications & 
 entry points for exceptions.
 Bytes after 0xc00 hex are used by linux for per processor globals on s/390 & z/Architecture 
-( there is a gap on z/Architecure too currently between 0xc00 & 1000 which linux uses ).
+( there is a gap on z/Architecture too currently between 0xc00 & 1000 which linux uses ).
 The closest thing to this on traditional architectures is the interrupt
 vector table. This is a good thing & does simplify some of the kernel coding
 however it means that we now cannot catch stray NULL pointers in the
@@ -861,7 +861,7 @@
 6) rm /arch/s390/kernel/signal.o
 7) make /arch/s390/kernel/signal.o
 8) watch the gcc command line emitted
-9) type it in again or alernatively cut & paste it on the console adding the -g option.
+9) type it in again or alternatively cut & paste it on the console adding the -g option.
 10) objdump --source arch/s390/kernel/signal.o > signal.lst
 This will output the source & the assembly intermixed, as the snippet below shows
 This will unfortunately output addresses which aren't the same
diff -ru a/Documentation/s390/driver-model.txt b/Documentation/s390/driver-model.txt
--- a/Documentation/s390/driver-model.txt	2006-07-08 14:12:29.000000000 -0400
+++ b/Documentation/s390/driver-model.txt	2006-07-10 12:24:22.000000000 -0400
@@ -262,7 +262,7 @@
 -----------
 
 The netiucv driver creates an attribute 'connection' under
-bus/iucv/drivers/netiucv. Piping to this attibute creates a new netiucv
+bus/iucv/drivers/netiucv. Piping to this attribute creates a new netiucv
 connection to the specified host.
 
 Netiucv connections show up under devices/iucv/ as "netiucv<ifnum>". The interface
diff -ru a/Documentation/scsi/ncr53c8xx.txt b/Documentation/scsi/ncr53c8xx.txt
--- a/Documentation/scsi/ncr53c8xx.txt	2006-07-08 14:12:29.000000000 -0400
+++ b/Documentation/scsi/ncr53c8xx.txt	2006-07-10 12:27:19.000000000 -0400
@@ -1151,7 +1151,7 @@
 
 New driver versions are made available separately in order to allow testing 
 changes and new features prior to including them into the linux kernel 
-distribution. The following URL provides informations on latest avalaible 
+distribution. The following URL provides information on latest available 
 patches: 
 
       ftp://ftp.tux.org/pub/people/gerard-roudier/README
diff -ru a/Documentation/scsi/ppa.txt b/Documentation/scsi/ppa.txt
--- a/Documentation/scsi/ppa.txt	2006-07-08 14:13:34.000000000 -0400
+++ b/Documentation/scsi/ppa.txt	2006-07-10 12:07:39.000000000 -0400
@@ -3,7 +3,7 @@
 General Iomega ZIP drive page for Linux:
 http://www.torque.net/~campbell/
 
-Driver achive for old drivers:
+Driver archive for old drivers:
 http://www.torque.net/~campbell/ppa/
 
 Linux Parport page (parallel port)
diff -ru a/Documentation/scsi/tmscsim.txt b/Documentation/scsi/tmscsim.txt
--- a/Documentation/scsi/tmscsim.txt	2006-07-08 14:13:34.000000000 -0400
+++ b/Documentation/scsi/tmscsim.txt	2006-07-10 12:02:43.000000000 -0400
@@ -27,7 +27,7 @@
 scsi = SCSI driver, m = AMD (?) as opposed to w for the DC390W/U/F
 (NCR53c8X5, X=2/7) driver. Yes, there was also a driver for the latter,
 tmscsiw, which supported DC390W/U/F adapters. It's not maintained any more,
-as the ncr53c8xx is perfectly supporting these adpaters since some time.
+as the ncr53c8xx is perfectly supporting these adapters since some time.
 
 The driver first appeared in April 1996, exclusively supported the DC390 
 and has been enhanced since then in various steps. In May 1998 support for 
diff -ru a/Documentation/sysctl/kernel.txt b/Documentation/sysctl/kernel.txt
--- a/Documentation/sysctl/kernel.txt	2006-07-08 14:12:39.000000000 -0400
+++ b/Documentation/sysctl/kernel.txt	2006-07-10 11:59:55.000000000 -0400
@@ -325,7 +325,7 @@
 	readable by root only. This allows the end user to remove
 	such a dump but not access it directly. For security reasons
 	core dumps in this mode will not overwrite one another or
-	other files. This mode is appropriate when adminstrators are
+	other files. This mode is appropriate when administrators are
 	attempting to debug problems in a normal environment.
 
 ==============================================================

