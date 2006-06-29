Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWF2LlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWF2LlG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbWF2LlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:41:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:42470 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750930AbWF2LlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:41:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=IzpvElHq2yyongyIuNPnhqCcS1Y4atAWy4swXwtbPJNYQSH78EtsoZnf8DXeisB32gzLNM3wUA35QRqsPGjIcwQdXQ8h5ySRiGChpN9jlU+i4nzM7YOzyzgwm4rEpdSazS0luqXVYYcNpRktiQWgQLOYhoNFm5l4VgRDDv5bTWo=
Date: Thu, 29 Jun 2006 13:40:02 +0200
From: Paolo Ornati <ornati@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: trivial@kernel.org, Paolo Ornati <ornati@fastwebnet.it>
Subject: [PATCH] Documentation: remove duplicate cleanups
Message-ID: <20060629134002.1b06257c@localhost>
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Ornati <ornati@fastwebnet.it>

Remove every (hopefully) duplicated word under Documentation/.

Examples:
	"and and" --> "and"
	"in in" --> "in"
	...

Signed-off-by: Paolo Ornati <ornati@fastwebnet.it>
---
 ABI/obsolete/devfs                             |    2 +-
 DMA-mapping.txt                                |    2 +-
 DocBook/journal-api.tmpl                       |    4 ++--
 DocBook/libata.tmpl                            |    2 +-
 DocBook/usb.tmpl                               |    2 +-
 DocBook/videobook.tmpl                         |    2 +-
 RCU/whatisRCU.txt                              |    2 +-
 README.DAC960                                  |    4 ++--
 block/as-iosched.txt                           |    2 +-
 block/biodoc.txt                               |    2 +-
 cpu-freq/governors.txt                         |    2 +-
 driver-model/overview.txt                      |    2 +-
 exception.txt                                  |    2 +-
 fb/fbcon.txt                                   |    4 ++--
 filesystems/coda.txt                           |    2 +-
 filesystems/directory-locking                  |    2 +-
 filesystems/files.txt                          |    2 +-
 filesystems/relayfs.txt                        |    2 +-
 filesystems/spufs.txt                          |    2 +-
 filesystems/tmpfs.txt                          |    2 +-
 filesystems/vfat.txt                           |    2 +-
 filesystems/vfs.txt                            |    2 +-
 fujitsu/frv/mmu-layout.txt                     |    2 +-
 ia64/efirtc.txt                                |    2 +-
 ia64/mca.txt                                   |    4 ++--
 input/input-programming.txt                    |    2 +-
 input/input.txt                                |    2 +-
 isdn/INTERFACE.fax                             |    2 +-
 isdn/README.hysdn                              |    2 +-
 kbuild/makefiles.txt                           |    2 +-
 kdump/kdump.txt                                |    2 +-
 kernel-parameters.txt                          |    2 +-
 keys.txt                                       |    2 +-
 m68k/kernel-options.txt                        |    2 +-
 memory-barriers.txt                            |    4 ++--
 networking/arcnet.txt                          |    2 +-
 networking/bonding.txt                         |    2 +-
 networking/cs89x0.txt                          |    2 +-
 networking/decnet.txt                          |    2 +-
 networking/e1000.txt                           |    2 +-
 networking/pt.txt                              |    2 +-
 networking/s2io.txt                            |    2 +-
 networking/sk98lin.txt                         |    2 +-
 networking/smctr.txt                           |    2 +-
 networking/tms380tr.txt                        |    2 +-
 nommu-mmap.txt                                 |    2 +-
 pci-error-recovery.txt                         |    2 +-
 power/swsusp.txt                               |    2 +-
 prio_tree.txt                                  |    2 +-
 rpc-cache.txt                                  |    2 +-
 rt-mutex-design.txt                            |    2 +-
 s390/Debugging390.txt                          |    9 ++++-----
 s390/crypto/crypto-API.txt                     |    2 +-
 s390/s390dbf.txt                               |    4 ++--
 scsi/ChangeLog.1992-1997                       |    2 +-
 scsi/scsi_mid_low_api.txt                      |    2 +-
 scsi/st.txt                                    |    2 +-
 sh/new-machine.txt                             |    2 +-
 sound/alsa/DocBook/writing-an-alsa-driver.tmpl |    2 +-
 sound/oss/AWE32                                |    2 +-
 sound/oss/solo1                                |    2 +-
 sound/oss/ultrasound                           |    2 +-
 sound/oss/vwsnd                                |    2 +-
 spi/pxa2xx                                     |    6 +++---
 spi/spi-summary                                |    4 ++--
 unshare.txt                                    |    2 +-
 usb/error-codes.txt                            |    2 +-
 usb/hiddev.txt                                 |    2 +-
 usb/usb-serial.txt                             |    4 ++--
 video4linux/README.pvrusb2                     |    2 +-
 video4linux/Zoran                              |    2 +-
 vm/numa                                        |    2 +-
 72 files changed, 85 insertions(+), 86 deletions(-)

diff --git a/Documentation/ABI/obsolete/devfs b/Documentation/ABI/obsolete/devfs
index b8b8739..ba666a8 100644
--- a/Documentation/ABI/obsolete/devfs
+++ b/Documentation/ABI/obsolete/devfs
@@ -6,7 +6,7 @@ Description:
 	races, contains a naming policy within the kernel that is
 	against the LSB, and can be replaced by using udev.
 	The files fs/devfs/*, include/linux/devfs_fs*.h will be removed,
-	along with the the assorted devfs function calls throughout the
+	along with the assorted devfs function calls throughout the
 	kernel tree.
 
 Users:
diff --git a/Documentation/DMA-mapping.txt b/Documentation/DMA-mapping.txt
index 7c71769..a77a0b6 100644
--- a/Documentation/DMA-mapping.txt
+++ b/Documentation/DMA-mapping.txt
@@ -107,7 +107,7 @@ The query is performed via a call to pci
 
 	int pci_set_dma_mask(struct pci_dev *pdev, u64 device_mask);
 
-The query for consistent allocations is performed via a a call to
+The query for consistent allocations is performed via a call to
 pci_set_consistent_dma_mask():
 
 	int pci_set_consistent_dma_mask(struct pci_dev *pdev, u64 device_mask);
diff --git a/Documentation/DocBook/journal-api.tmpl b/Documentation/DocBook/journal-api.tmpl
index 2077f9a..7937c98 100644
--- a/Documentation/DocBook/journal-api.tmpl
+++ b/Documentation/DocBook/journal-api.tmpl
@@ -184,8 +184,8 @@ journal_start() so you can deadlock here
 <para>
 Try to reserve the right number of blocks the first time. ;-). This will
 be the maximum number of blocks you are going to touch in this transaction.
-I advise having a look at at least ext3_jbd.h to see the basis on which 
-ext3 uses to make these decisions.
+I advise having a look at least ext3_jbd.h to see the basis on which ext3
+uses to make these decisions.
 </para>
 
 <para>
diff --git a/Documentation/DocBook/libata.tmpl b/Documentation/DocBook/libata.tmpl
index e97c323..75676ac 100644
--- a/Documentation/DocBook/libata.tmpl
+++ b/Documentation/DocBook/libata.tmpl
@@ -1400,7 +1400,7 @@ and other resources, etc.
 	<listitem>
 	<para>
 	When it's known that HBA is in ready state but ATA/ATAPI
-	device in in unknown state, reset only device.
+	device in unknown state, reset only device.
 	</para>
 	</listitem>
 
diff --git a/Documentation/DocBook/usb.tmpl b/Documentation/DocBook/usb.tmpl
index 320af25..ae3ecd9 100644
--- a/Documentation/DocBook/usb.tmpl
+++ b/Documentation/DocBook/usb.tmpl
@@ -740,7 +740,7 @@ usbdev_ioctl (int fd, int ifno, unsigned
 		<title>Synchronous I/O Support</title>
 
 		<para>Synchronous requests involve the kernel blocking
-		until until the user mode request completes, either by
+		until the user mode request completes, either by
 		finishing successfully or by reporting an error.
 		In most cases this is the simplest way to use usbfs,
 		although as noted above it does prevent performing I/O
diff --git a/Documentation/DocBook/videobook.tmpl b/Documentation/DocBook/videobook.tmpl
index fdff984..d19ccee 100644
--- a/Documentation/DocBook/videobook.tmpl
+++ b/Documentation/DocBook/videobook.tmpl
@@ -322,7 +322,7 @@ static int radio_ioctl(struct video_devi
 				</entry>
 	</row><row>
         <entry>type</entry><entry>This reports the capabilities of the device, and
-                        matches the field we filled in in the struct
+                        matches the field we filled in the struct
                         video_device when registering.</entry>
     </row>
     </tbody>
diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
index 4f41a60..d9992aa 100644
--- a/Documentation/RCU/whatisRCU.txt
+++ b/Documentation/RCU/whatisRCU.txt
@@ -749,7 +749,7 @@ Or, for those who prefer a side-by-side 
 
 Either way, the differences are quite small.  Read-side locking moves
 to rcu_read_lock() and rcu_read_unlock, update-side locking moves from
-from a reader-writer lock to a simple spinlock, and a synchronize_rcu()
+a reader-writer lock to a simple spinlock, and a synchronize_rcu()
 precedes the kfree().
 
 However, there is one potential catch: the read-side and update-side
diff --git a/Documentation/README.DAC960 b/Documentation/README.DAC960
index 98ea617..02c8a80 100644
--- a/Documentation/README.DAC960
+++ b/Documentation/README.DAC960
@@ -410,7 +410,7 @@ commands are:
 
 	       EXAMPLE I - DRIVE FAILURE WITHOUT A STANDBY DRIVE
 
-The following annotated logs demonstrate the controller configuration and and
+The following annotated logs demonstrate the controller configuration and
 online status monitoring capabilities of the Linux DAC960 Driver.  The test
 configuration comprises 6 1GB Quantum Atlas I disk drives on two channels of a
 DAC960PJ controller.  The physical drives are configured into a single drive
@@ -582,7 +582,7 @@ OK
 
 		EXAMPLE II - DRIVE FAILURE WITH A STANDBY DRIVE
 
-The following annotated logs demonstrate the controller configuration and and
+The following annotated logs demonstrate the controller configuration and
 online status monitoring capabilities of the Linux DAC960 Driver.  The test
 configuration comprises 6 1GB Quantum Atlas I disk drives on two channels of a
 DAC960PJ controller.  The physical drives are configured into a single drive
diff --git a/Documentation/block/as-iosched.txt b/Documentation/block/as-iosched.txt
index 6f47332..ed24cdd 100644
--- a/Documentation/block/as-iosched.txt
+++ b/Documentation/block/as-iosched.txt
@@ -111,7 +111,7 @@ or if the next request in the queue is "
 just completed request, it is dispatched immediately.  Otherwise,
 statistics (average think time, average seek distance) on the process
 that submitted the just completed request are examined.  If it seems
-likely that that process will submit another request soon, and that
+likely that process will submit another request soon, and that
 request is likely to be near the just completed request, then the IO
 scheduler will stop dispatching more read requests for up time (antic_expire)
 milliseconds, hoping that process will submit a new request near the one
diff --git a/Documentation/block/biodoc.txt b/Documentation/block/biodoc.txt
index f989a9e..9593ed9 100644
--- a/Documentation/block/biodoc.txt
+++ b/Documentation/block/biodoc.txt
@@ -135,7 +135,7 @@ Some new queue property settings:
 		Sets two variables that limit the size of the request.
 
 		- The request queue's max_sectors, which is a soft size in
-		in units of 512 byte sectors, and could be dynamically varied
+		units of 512 byte sectors, and could be dynamically varied
 		by the core kernel.
 
 		- The request queue's max_hw_sectors, which is a hard limit
diff --git a/Documentation/cpu-freq/governors.txt b/Documentation/cpu-freq/governors.txt
index f4b8dc4..3679da4 100644
--- a/Documentation/cpu-freq/governors.txt
+++ b/Documentation/cpu-freq/governors.txt
@@ -138,7 +138,7 @@ If set to '1' then the frequency decreas
 if set to '2' it decreases at half the rate of the increase.
 
 ignore_nice_load: this parameter takes a value of '0' or '1', when set
-to '0' (its default) then all processes are counted towards towards the
+to '0' (its default) then all processes are counted towards the
 'cpu utilisation' value.   When set to '1' then processes that are
 run with a 'nice' value will not count (and thus be ignored) in the
 overal usage calculation.  This is useful if you are running a CPU
diff --git a/Documentation/driver-model/overview.txt b/Documentation/driver-model/overview.txt
index 2050c9f..5f35566 100644
--- a/Documentation/driver-model/overview.txt
+++ b/Documentation/driver-model/overview.txt
@@ -57,7 +57,7 @@ the two.
 
 The PCI bus layer freely accesses the fields of struct device. It knows about
 the structure of struct pci_dev, and it should know the structure of struct
-device. Individual PCI device drivers that have been converted the the current
+device. Individual PCI device drivers that have been converted the current
 driver model generally do not and should not touch the fields of struct device,
 unless there is a strong compelling reason to do so.
 
diff --git a/Documentation/exception.txt b/Documentation/exception.txt
index 3cb39ad..75aaa6e 100644
--- a/Documentation/exception.txt
+++ b/Documentation/exception.txt
@@ -10,7 +10,7 @@ int verify_area(int type, const void * a
 function (which has since been replaced by access_ok()).
 
 This function verified that the memory area starting at address 
-addr and of size size was accessible for the operation specified 
+addr and of size was accessible for the operation specified
 in type (read or write). To do this, verify_read had to look up the 
 virtual memory area (vma) that contained the address addr. In the 
 normal case (correctly working program), this test was successful. 
diff --git a/Documentation/fb/fbcon.txt b/Documentation/fb/fbcon.txt
index f373df1..4a9739a 100644
--- a/Documentation/fb/fbcon.txt
+++ b/Documentation/fb/fbcon.txt
@@ -150,7 +150,7 @@ C. Boot options
 
 C. Attaching, Detaching and Unloading
 
-Before going on on how to attach, detach and unload the framebuffer console, an
+Before going on how to attach, detach and unload the framebuffer console, an
 illustration of the dependencies may help.
 
 The console layer, as with most subsystems, needs a driver that interfaces with
@@ -163,7 +163,7 @@ from the console layer before unloading 
 unloaded if it is still bound to the console layer. (See
 Documentation/console/console.txt for more information).
 
-This is more complicated in the case of the the framebuffer console (fbcon),
+This is more complicated in the case of the framebuffer console (fbcon),
 because fbcon is an intermediate layer between the console and the drivers:
 
 console ---> fbcon ---> fbdev drivers ---> hardware
diff --git a/Documentation/filesystems/coda.txt b/Documentation/filesystems/coda.txt
index 6131135..6853849 100644
--- a/Documentation/filesystems/coda.txt
+++ b/Documentation/filesystems/coda.txt
@@ -602,7 +602,7 @@ kernel support.
 
 
   DDeessccrriippttiioonn This call is made to determine the ViceFid and filetype of
-  a directory entry.  The directory entry requested carries name name
+  a directory entry.  The directory entry requested carries name
   and Venus will search the directory identified by cfs_lookup_in.VFid.
   The result may indicate that the name does not exist, or that
   difficulty was encountered in finding it (e.g. due to disconnection).
diff --git a/Documentation/filesystems/directory-locking b/Documentation/filesystems/directory-locking
index 34380d4..d7099a9 100644
--- a/Documentation/filesystems/directory-locking
+++ b/Documentation/filesystems/directory-locking
@@ -82,7 +82,7 @@ (see above).
 
 	Consider the object blocking the cross-directory rename.  One
 of its descendents is locked by cross-directory rename (otherwise we
-would again have an infinite set of of contended objects).  But that
+would again have an infinite set of contended objects).  But that
 means that cross-directory rename is taking locks out of order.  Due
 to (2) the order hadn't changed since we had acquired filesystem lock.
 But locking rules for cross-directory rename guarantee that we do not
diff --git a/Documentation/filesystems/files.txt b/Documentation/filesystems/files.txt
index 8c206f4..133e213 100644
--- a/Documentation/filesystems/files.txt
+++ b/Documentation/filesystems/files.txt
@@ -55,7 +55,7 @@ the fdtable structure -
 2. Reading of the fdtable as described above must be protected
    by rcu_read_lock()/rcu_read_unlock().
 
-3. For any update to the the fd table, files->file_lock must
+3. For any update to the fd table, files->file_lock must
    be held.
 
 4. To look up the file structure given an fd, a reader
diff --git a/Documentation/filesystems/relayfs.txt b/Documentation/filesystems/relayfs.txt
index 5832377..4e2dbba 100644
--- a/Documentation/filesystems/relayfs.txt
+++ b/Documentation/filesystems/relayfs.txt
@@ -28,7 +28,7 @@ Semantics
 
 Each relayfs channel has one buffer per CPU, each buffer has one or
 more sub-buffers. Messages are written to the first sub-buffer until
-it is too full to contain a new message, in which case it it is
+it is too full to contain a new message, in which case it is
 written to the next (if available).  Messages are never split across
 sub-buffers.  At this point, userspace can be notified so it empties
 the first sub-buffer, while the kernel continues writing to the next.
diff --git a/Documentation/filesystems/spufs.txt b/Documentation/filesystems/spufs.txt
index 8edc395..f74b906 100644
--- a/Documentation/filesystems/spufs.txt
+++ b/Documentation/filesystems/spufs.txt
@@ -105,7 +105,7 @@ FILES
 
 
    /wbox
-       The CPU to SPU communation mailbox. It is write-only can can be written
+       The CPU to SPU communation mailbox. It is write-only can be written
        in  units  of  32  bits. If the mailbox is full, write() will block and
        poll can be used to wait for it becoming  empty  again.   The  possible
        operations  on  an open wbox file are: write(2) If a count smaller than
diff --git a/Documentation/filesystems/tmpfs.txt b/Documentation/filesystems/tmpfs.txt
index 1773106..28ff82b 100644
--- a/Documentation/filesystems/tmpfs.txt
+++ b/Documentation/filesystems/tmpfs.txt
@@ -63,7 +63,7 @@ size:      The limit of allocated bytes 
 nr_blocks: The same as size, but in blocks of PAGE_CACHE_SIZE.
 nr_inodes: The maximum number of inodes for this instance. The default
            is half of the number of your physical RAM pages, or (on a
-           a machine with highmem) the number of lowmem RAM pages,
+           machine with highmem) the number of lowmem RAM pages,
            whichever is the lower.
 
 These parameters accept a suffix k, m or g for kilo, mega and giga and
diff --git a/Documentation/filesystems/vfat.txt b/Documentation/filesystems/vfat.txt
index 2001abb..069cb10 100644
--- a/Documentation/filesystems/vfat.txt
+++ b/Documentation/filesystems/vfat.txt
@@ -35,7 +35,7 @@ iocharset=name -- Character set to use f
 		 you should consider the following option instead.
 
 utf8=<bool>   -- UTF-8 is the filesystem safe version of Unicode that
-		 is used by the console.  It can be be enabled for the
+		 is used by the console.  It can be enabled for the
 		 filesystem with this option. If 'uni_xlate' gets set,
 		 UTF-8 gets disabled.
 
diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index 9d3aed6..5e00dd5 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -410,7 +410,7 @@ otherwise noted.
 
   put_link: called by the VFS to release resources allocated by
   	follow_link().  The cookie returned by follow_link() is passed
-  	to to this method as the last parameter.  It is used by
+  	to this method as the last parameter.  It is used by
   	filesystems such as NFS where page cache is not stable
   	(i.e. page that was installed when the symbolic link walk
   	started might not be in the page cache at the end of the
diff --git a/Documentation/fujitsu/frv/mmu-layout.txt b/Documentation/fujitsu/frv/mmu-layout.txt
index 11dcc56..db10250 100644
--- a/Documentation/fujitsu/frv/mmu-layout.txt
+++ b/Documentation/fujitsu/frv/mmu-layout.txt
@@ -233,7 +233,7 @@ related kernel services:
      (*) __debug_mmu.iamr[]
      (*) __debug_mmu.damr[]
 
-	 These receive the current IAMR and DAMR contents. These can be viewed with with the _amr
+	 These receive the current IAMR and DAMR contents. These can be viewed with the _amr
 	 GDB macro:
 
 		(gdb) _amr
diff --git a/Documentation/ia64/efirtc.txt b/Documentation/ia64/efirtc.txt
index ede2c1e..057e6be 100644
--- a/Documentation/ia64/efirtc.txt
+++ b/Documentation/ia64/efirtc.txt
@@ -26,7 +26,7 @@ to initialize the system view of the tim
 Because we wanted to minimize the impact on existing user-level apps using
 the CMOS clock, we decided to expose an API that was very similar to the one
 used today with the legacy RTC driver (driver/char/rtc.c). However, because 
-EFI provides a simpler services, not all all ioctl() are available. Also
+EFI provides a simpler services, not all ioctl() are available. Also
 new ioctl()s have been introduced for things that EFI provides but not the 
 legacy.
 
diff --git a/Documentation/ia64/mca.txt b/Documentation/ia64/mca.txt
index a71cc6a..f097c60 100644
--- a/Documentation/ia64/mca.txt
+++ b/Documentation/ia64/mca.txt
@@ -12,7 +12,7 @@ by locks is indeterminate, including lin
 ---
 
 The complicated ia64 MCA process.  All of this is mandated by Intel's
-specification for ia64 SAL, error recovery and and unwind, it is not as
+specification for ia64 SAL, error recovery and unwind, it is not as
 if we have a choice here.
 
 * MCA occurs on one cpu, usually due to a double bit memory error.
@@ -94,7 +94,7 @@ if we have a choice here.
 
 INIT is less complicated than MCA.  Pressing the nmi button or using
 the equivalent command on the management console sends INIT to all
-cpus.  SAL picks one one of the cpus as the monarch and the rest are
+cpus.  SAL picks one of the cpus as the monarch and the rest are
 slaves.  All the OS INIT handlers are entered at approximately the same
 time.  The OS monarch prints the state of all tasks and returns, after
 which the slaves return and the system resumes.
diff --git a/Documentation/input/input-programming.txt b/Documentation/input/input-programming.txt
index 180e068..1185f00 100644
--- a/Documentation/input/input-programming.txt
+++ b/Documentation/input/input-programming.txt
@@ -100,7 +100,7 @@ Then there is the
 
 call to tell those who receive the events that we've sent a complete report.
 This doesn't seem important in the one button case, but is quite important
-for for example mouse movement, where you don't want the X and Y values
+for example mouse movement, where you don't want the X and Y values
 to be interpreted separately, because that'd result in a different movement.
 
 1.2 dev->open() and dev->close()
diff --git a/Documentation/input/input.txt b/Documentation/input/input.txt
index 47137e7..9a6654d 100644
--- a/Documentation/input/input.txt
+++ b/Documentation/input/input.txt
@@ -230,7 +230,7 @@ generated in the kernel straight to the 
 API is still evolving, but should be useable now. It's described in
 section 5. 
 
-  This should be the way for GPM and X to get keyboard and mouse mouse
+  This should be the way for GPM and X to get keyboard and mouse
 events. It allows for multihead in X without any specific multihead
 kernel support. The event codes are the same on all architectures and
 are hardware independent.
diff --git a/Documentation/isdn/INTERFACE.fax b/Documentation/isdn/INTERFACE.fax
index 7e57313..9c8c6d9 100644
--- a/Documentation/isdn/INTERFACE.fax
+++ b/Documentation/isdn/INTERFACE.fax
@@ -26,7 +26,7 @@ Structure T30_s description:
   If the HL-driver receives ISDN_CMD_FAXCMD, all needed information
   is in this struct set by the LL.
   To signal information to the LL, the HL-driver has to set the 
-  the parameters and use ISDN_STAT_FAXIND.
+  parameters and use ISDN_STAT_FAXIND.
   (Please refer to INTERFACE)
 
 Structure T30_s:
diff --git a/Documentation/isdn/README.hysdn b/Documentation/isdn/README.hysdn
index 56cc59d..a9a72b7 100644
--- a/Documentation/isdn/README.hysdn
+++ b/Documentation/isdn/README.hysdn
@@ -1,6 +1,6 @@
 $Id: README.hysdn,v 1.3.6.1 2001/02/10 14:41:19 kai Exp $
 The hysdn driver has been written by
-by Werner Cornelius (werner@isdn4linux.de or werner@titro.de) 
+Werner Cornelius (werner@isdn4linux.de or werner@titro.de)
 for Hypercope GmbH Aachen Germany. Hypercope agreed to publish this driver
 under the GNU General Public License.
 
diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 14ef386..8a62e4d 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -402,7 +402,7 @@ more details, with real examples.
 		#arch/sh/Makefile
 		cflags-y += $(call as-option,-Wa$(comma)-isa=$(isa-y),)
 
-	In the above example cflags-y will be assinged the the option
+	In the above example cflags-y will be assinged the option
 	-Wa$(comma)-isa=$(isa-y) if it is supported by $(CC).
 	The second argument is optional, and if supplied will be used
 	if first argument is not supported.
diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index 08bafa8..99f2d4d 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -249,7 +249,7 @@ If die() is called, and it happens to be
 is called inside interrupt context or die() is called and panic_on_oops is set,
 the system will boot into the dump-capture kernel.
 
-On powererpc systems when a soft-reset is generated, die() is called by all cpus and the system system will boot into the dump-capture kernel.
+On powererpc systems when a soft-reset is generated, die() is called by all cpus and the system will boot into the dump-capture kernel.
 
 For testing purposes, you can trigger a crash by using "ALT-SysRq-c",
 "echo c > /proc/sysrq-trigger or write a module to force the panic.
diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 0d189c9..9adc500 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -106,7 +106,7 @@ Do not modify the syntax of boot loader 
 need or coordination with <Documentation/i386/boot.txt>.
 
 Note that ALL kernel parameters listed below are CASE SENSITIVE, and that
-a trailing = on the name of any parameter states that that parameter will
+a trailing = on the name of any parameter states that parameter will
 be entered as an environment variable, whereas its absence indicates that
 it will appear as a kernel argument readable via /proc/cmdline by programs
 running once the system is up.
diff --git a/Documentation/keys.txt b/Documentation/keys.txt
index 61c0fad..027f5a5 100644
--- a/Documentation/keys.txt
+++ b/Documentation/keys.txt
@@ -671,7 +671,7 @@ The keyctl syscall functions are:
 
      Note that this setting is inherited across fork/exec.
 
-     [1] The default default is: the thread keyring if there is one, otherwise
+     [1] The default is: the thread keyring if there is one, otherwise
      the process keyring if there is one, otherwise the session keyring if
      there is one, otherwise the user default session keyring.
 
diff --git a/Documentation/m68k/kernel-options.txt b/Documentation/m68k/kernel-options.txt
index d5d3f06..1c41db2 100644
--- a/Documentation/m68k/kernel-options.txt
+++ b/Documentation/m68k/kernel-options.txt
@@ -415,7 +415,7 @@ switch to another mode once Linux has st
 
   The first 3 parameters of this sub-option should be obvious: <xres>,
 <yres> and <depth> give the dimensions of the screen and the number of
-planes (depth). The depth is is the logarithm to base 2 of the number
+planes (depth). The depth is the logarithm to base 2 of the number
 of colors possible. (Or, the other way round: The number of colors is
 2^depth).
 
diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index cf0d541..bd6cdaa 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -670,7 +670,7 @@ effectively random order, despite the wr
 
 
 In the above example, CPU 2 perceives that B is 7, despite the load of *C
-(which would be B) coming after the the LOAD of C.
+(which would be B) coming after the LOAD of C.
 
 If, however, a data dependency barrier were to be placed between the load of C
 and the load of *C (ie: B) on CPU 2:
@@ -1790,7 +1790,7 @@ CACHE COHERENCY
 ---------------
 
 Life isn't quite as simple as it may appear above, however: for while the
-caches are expected to be coherent, there's no guarantee that that coherency
+caches are expected to be coherent, there's no guarantee that coherency
 will be ordered.  This means that whilst changes made on one CPU will
 eventually become visible on all CPUs, there's no guarantee that they will
 become apparent in the same order on those other CPUs.
diff --git a/Documentation/networking/arcnet.txt b/Documentation/networking/arcnet.txt
index 770fc41..9ec7402 100644
--- a/Documentation/networking/arcnet.txt
+++ b/Documentation/networking/arcnet.txt
@@ -400,7 +400,7 @@ can set up your network then:
    	ifconfig arc0 insight
    	route add insight arc0
    	route add freedom arc0	/* I would use the subnet here (like I said
-					to to in "single protocol" above),
+					to in "single protocol" above),
    					but the rest of the subnet
    					unfortunately lies across the PPP
    					link on freedom, which confuses
diff --git a/Documentation/networking/bonding.txt b/Documentation/networking/bonding.txt
index afac780..abd86a8 100644
--- a/Documentation/networking/bonding.txt
+++ b/Documentation/networking/bonding.txt
@@ -964,7 +964,7 @@ Changing a Bond's Configuration
 files located in /sys/class/net/<bond name>/bonding
 
 	The names of these files correspond directly with the command-
-line parameters described elsewhere in in this file, and, with the
+line parameters described elsewhere in this file, and, with the
 exception of arp_ip_target, they accept the same values.  To see the
 current setting, simply cat the appropriate file.
 
diff --git a/Documentation/networking/cs89x0.txt b/Documentation/networking/cs89x0.txt
index 188beb7..8c2adbe 100644
--- a/Documentation/networking/cs89x0.txt
+++ b/Documentation/networking/cs89x0.txt
@@ -684,7 +684,7 @@ ethernet@crystal.cirrus.com) and request
 software-update notification.
 
 Cirrus Logic maintains a web page at http://www.cirrus.com with the
-the latest drivers and technical publications.
+latest drivers and technical publications.
 
 
 6.4 Current maintainer
diff --git a/Documentation/networking/decnet.txt b/Documentation/networking/decnet.txt
index e6c39c5..badb748 100644
--- a/Documentation/networking/decnet.txt
+++ b/Documentation/networking/decnet.txt
@@ -82,7 +82,7 @@ ethernet address of your ethernet card h
 address of the node in order for it to be autoconfigured (and then appear in
 /proc/net/decnet_dev). There is a utility available at the above
 FTP sites called dn2ethaddr which can compute the correct ethernet
-address to use. The address can be set by ifconfig either before at
+address to use. The address can be set by ifconfig either before or
 at the time the device is brought up. If you are using RedHat you can
 add the line:
 
diff --git a/Documentation/networking/e1000.txt b/Documentation/networking/e1000.txt
index 71fe15a..5c0a5cc 100644
--- a/Documentation/networking/e1000.txt
+++ b/Documentation/networking/e1000.txt
@@ -350,7 +350,7 @@ Additional Configurations
 
   As an example, if you install the e1000 driver for two PRO/1000 adapters
   (eth0 and eth1) and set the speed and duplex to 10full and 100half, add
-  the following to modules.conf or or modprobe.conf:
+  the following to modules.conf or modprobe.conf:
 
        alias eth0 e1000
        alias eth1 e1000
diff --git a/Documentation/networking/pt.txt b/Documentation/networking/pt.txt
index 72e888c..368dd9e 100644
--- a/Documentation/networking/pt.txt
+++ b/Documentation/networking/pt.txt
@@ -25,7 +25,7 @@ recompile it. 
 
 The driver is not real good at the moment for finding the card.  You can
 'help' it by changing the order of the potential addresses in the structure
-found in the pt_init() function so the address of where the card is is put
+found in the pt_init() function so the address of where the card is put
 first.
 
 After compiling, you have to get them going, they are pretty well like any
diff --git a/Documentation/networking/s2io.txt b/Documentation/networking/s2io.txt
index bd528ff..4bde53e 100644
--- a/Documentation/networking/s2io.txt
+++ b/Documentation/networking/s2io.txt
@@ -126,7 +126,7 @@ However, you may want to set PCI latency
 #setpci -d 17d5:* LATENCY_TIMER=f8
 For detailed description of the PCI registers, please see Xframe User Guide.
 b. Use 2-buffer mode. This results in large performance boost on
-on certain platforms(eg. SGI Altix, IBM xSeries).
+certain platforms(eg. SGI Altix, IBM xSeries).
 c. Ensure Receive Checksum offload is enabled. Use "ethtool -K ethX" command to 
 set/verify this option.
 d. Enable NAPI feature(in kernel configuration Device Drivers ---> Network 
diff --git a/Documentation/networking/sk98lin.txt b/Documentation/networking/sk98lin.txt
index 7837c53..fbccdff 100644
--- a/Documentation/networking/sk98lin.txt
+++ b/Documentation/networking/sk98lin.txt
@@ -497,7 +497,7 @@ Solution: In /proc/pci search for the fo
           www.syskonnect.com
           
           Some COMPAQ machines have problems dealing with PCI under Linux.
-          Linux. This problem is described in the 'PCI howto' document
+          This problem is described in the 'PCI howto' document
           (included in some distributions or available from the
           web, e.g. at 'www.linux.org'). 
 
diff --git a/Documentation/networking/smctr.txt b/Documentation/networking/smctr.txt
index 4c866f5..42e30f1 100644
--- a/Documentation/networking/smctr.txt
+++ b/Documentation/networking/smctr.txt
@@ -11,7 +11,7 @@ This driver is rather simple to use. Sel
 in the kernel configuration. A choice for SMC Token Ring adapters will
 appear. This drives supports all SMC ISA/MCA adapters. Choose this
 option. I personally recommend compiling the driver as a module (M), but if you
-you would like to compile it staticly answer Y instead.
+would like to compile it staticly answer Y instead.
 
 This driver supports multiple adapters without the need to load multiple copies
 of the driver. You should be able to load up to 7 adapters without any kernel
diff --git a/Documentation/networking/tms380tr.txt b/Documentation/networking/tms380tr.txt
index 179e527..f319eb1 100644
--- a/Documentation/networking/tms380tr.txt
+++ b/Documentation/networking/tms380tr.txt
@@ -24,7 +24,7 @@ This driver is rather simple to use. Sel
 in the kernel configuration. A choice for SysKonnect Token Ring adapters will
 appear. This drives supports all SysKonnect ISA and PCI adapters. Choose this
 option. I personally recommend compiling the driver as a module (M), but if you
-you would like to compile it staticly answer Y instead.
+would like to compile it staticly answer Y instead.
 
 This driver supports multiple adapters without the need to load multiple copies
 of the driver. You should be able to load up to 7 adapters without any kernel
diff --git a/Documentation/nommu-mmap.txt b/Documentation/nommu-mmap.txt
index b88ebe4..a4686f5 100644
--- a/Documentation/nommu-mmap.txt
+++ b/Documentation/nommu-mmap.txt
@@ -47,7 +47,7 @@ and it's also much more restricted in th
            appropriate mapping protection capabilities. Ramfs, romfs, cramfs
            and mtd might all permit this.
 
-	 - If the backing device device can't or won't permit direct sharing,
+	 - If the backing device can't or won't permit direct sharing,
            but does have the BDI_CAP_MAP_COPY capability, then a copy of the
            appropriate bit of the file will be read into a contiguous bit of
            memory and any extraneous space beyond the EOF will be cleared
diff --git a/Documentation/pci-error-recovery.txt b/Documentation/pci-error-recovery.txt
index 634d3e5..6650af4 100644
--- a/Documentation/pci-error-recovery.txt
+++ b/Documentation/pci-error-recovery.txt
@@ -172,7 +172,7 @@ is STEP 6 (Permanent Failure).
 >>> a value of 0xff on read, and writes will be dropped. If the device
 >>> driver attempts more than 10K I/O's to a frozen adapter, it will
 >>> assume that the device driver has gone into an infinite loop, and
->>> it will panic the the kernel. There doesn't seem to be any other
+>>> it will panic the kernel. There doesn't seem to be any other
 >>> way of stopping a device driver that insists on spinning on I/O.
 
 STEP 2: MMIO Enabled
diff --git a/Documentation/power/swsusp.txt b/Documentation/power/swsusp.txt
index 823b2cf..24f7de1 100644
--- a/Documentation/power/swsusp.txt
+++ b/Documentation/power/swsusp.txt
@@ -156,7 +156,7 @@ instead set the PF_NOFREEZE process flag
 be very carefull).
 
 
-Q: What is the difference between between "platform", "shutdown" and
+Q: What is the difference between "platform", "shutdown" and
 "firmware" in /sys/power/disk?
 
 A:
diff --git a/Documentation/prio_tree.txt b/Documentation/prio_tree.txt
index 2fbb0c4..3aa68f9 100644
--- a/Documentation/prio_tree.txt
+++ b/Documentation/prio_tree.txt
@@ -88,7 +88,7 @@ path which is not desirable. Hence, we d
 heap-and-size indexed overflow-sub-trees using prio_tree->index_bits.
 Instead the overflow sub-trees are indexed using full BITS_PER_LONG bits
 of size_index. This may lead to skewed sub-trees because most of the
-higher significant bits of the size_index are likely to be be 0 (zero). In
+higher significant bits of the size_index are likely to be 0 (zero). In
 the example above, all 3 overflow-sub-trees are skewed. This may marginally
 affect the performance. However, processes rarely map many vmas with the
 same start_vm_pgoff but different end_vm_pgoffs. Therefore, we normally
diff --git a/Documentation/rpc-cache.txt b/Documentation/rpc-cache.txt
index 5f757c8..ccab573 100644
--- a/Documentation/rpc-cache.txt
+++ b/Documentation/rpc-cache.txt
@@ -53,7 +53,7 @@ Creating a Cache
 		structure
 	void cache_put(struct kref *)
 		This is called when the last reference to an item is
-		is dropped.  The pointer passed is to the 'ref' field
+		dropped.  The pointer passed is to the 'ref' field
 		in the cache_head.  cache_put should release any
 		references create by 'cache_init' and, if CACHE_VALID
 		is set, any references created by cache_update.
diff --git a/Documentation/rt-mutex-design.txt b/Documentation/rt-mutex-design.txt
index c472ffa..71f148f 100644
--- a/Documentation/rt-mutex-design.txt
+++ b/Documentation/rt-mutex-design.txt
@@ -582,7 +582,7 @@ contention).
 try_to_take_rt_mutex is used every time the task tries to grab a mutex in the
 slow path.  The first thing that is done here is an atomic setting of
 the "Has Waiters" flag of the mutex's owner field.  Yes, this could really
-be false, because if the the mutex has no owner, there are no waiters and
+be false, because if the mutex has no owner, there are no waiters and
 the current task also won't have any waiters.  But we don't have the lock
 yet, so we assume we are going to be a waiter.  The reason for this is to
 play nice for those architectures that do have CMPXCHG.  By setting this flag
diff --git a/Documentation/s390/Debugging390.txt b/Documentation/s390/Debugging390.txt
index 844c03f..1c73329 100644
--- a/Documentation/s390/Debugging390.txt
+++ b/Documentation/s390/Debugging390.txt
@@ -1085,8 +1085,7 @@ Notes
 -----
 Addresses & values in the VM debugger are always hex never decimal
 Address ranges are of the format <HexValue1>-<HexValue2> or <HexValue1>.<HexValue2> 
-e.g. The address range  0x2000 to 0x3000 can be described described as
-2000-3000 or 2000.1000
+e.g. The address range  0x2000 to 0x3000 can be described as 2000-3000 or 2000.1000
 
 The VM Debugger is case insensitive.
 
@@ -1413,7 +1412,7 @@ SMP Specific commands
 To find out how many cpus you have
 Q CPUS displays all the CPU's available to your virtual machine
 To find the cpu that the current cpu VM debugger commands are being directed at do
-Q CPU to change the current cpu cpu VM debugger commands are being directed at do
+Q CPU to change the current cpu VM debugger commands are being directed at do
 CPU <desired cpu no>
 
 On a SMP guest issue a command to all CPUs try prefixing the command with cpu all.
@@ -2184,7 +2183,7 @@ ps -aux | grep gdb
 kill -SIGSEGV <gdb's pid>
 or alternatively use killall -SIGSEGV gdb if you have the killall command.
 Now look at the core dump.
-./gdb ./gdb core
+./gdb core
 Displays the following
 GNU gdb 4.18
 Copyright 1998 Free Software Foundation, Inc.
@@ -2477,7 +2476,7 @@ Lcrash is a perfectly normal program,how
 additional files, Kerntypes which is built using a patch to the 
 linux kernel sources in the linux root directory & the System.map.
 
-Kerntypes is an an objectfile whose sole purpose in life
+Kerntypes is an objectfile whose sole purpose in life
 is to provide stabs debug info to lcrash, to do this
 Kerntypes is built from kerntypes.c which just includes the most commonly
 referenced header files used when debugging, lcrash can then read the
diff --git a/Documentation/s390/crypto/crypto-API.txt b/Documentation/s390/crypto/crypto-API.txt
index 78a7762..e38c6c0 100644
--- a/Documentation/s390/crypto/crypto-API.txt
+++ b/Documentation/s390/crypto/crypto-API.txt
@@ -63,7 +63,7 @@ Example:	z990 crypto instruction for SHA
 
 TBD:	a userspace module probin mechanism
 	something like 'probe sha1 sha1_z990 sha1' in modprobe.conf
-	-> try module sha1_z990, if it fails to load load standard module sha1
+	-> try module sha1_z990, if it fails to load standard module sha1
 	the 'probe' statement is currently not supported in modprobe.conf
 
 
diff --git a/Documentation/s390/s390dbf.txt b/Documentation/s390/s390dbf.txt
index e321a8e..6893219 100644
--- a/Documentation/s390/s390dbf.txt
+++ b/Documentation/s390/s390dbf.txt
@@ -65,7 +65,7 @@ Predefined views for hex/ascii, sprintf 
 It is also possible to define other views. The content of
 a view can be inspected simply by reading the corresponding debugfs file.
 
-All debug logs have an an actual debug level (range from 0 to 6).
+All debug logs have an actual debug level (range from 0 to 6).
 The default level is 3. Event and Exception functions have a 'level'
 parameter. Only debug entries with a level that is lower or equal
 than the actual level are written to the log. This means, when
@@ -556,7 +556,7 @@ The input_proc can be used to implement 
 the view (e.g. like with 'echo "0" > /sys/kernel/debug/s390dbf/dasd/level).
 
 For header_proc there can be used the default function
-debug_dflt_header_fn() which is defined in in debug.h.
+debug_dflt_header_fn() which is defined in debug.h.
 and which produces the same header output as the predefined views.
 E.g:
 00 00964419409:440761 2 - 00 88023ec
diff --git a/Documentation/scsi/ChangeLog.1992-1997 b/Documentation/scsi/ChangeLog.1992-1997
index dc88ee2..6faad7e 100644
--- a/Documentation/scsi/ChangeLog.1992-1997
+++ b/Documentation/scsi/ChangeLog.1992-1997
@@ -1214,7 +1214,7 @@ Thu Jul 21 10:37:39 1994  Eric Youngdale
 
 	* sr.c(sr_open): Do not allow opens with write access.
 
-Mon Jul 18 09:51:22 1994 1994  Eric Youngdale  (eric@esp22)
+Mon Jul 18 09:51:22 1994  Eric Youngdale  (eric@esp22)
 
 	* Linux 1.1.31 released.
 
diff --git a/Documentation/scsi/scsi_mid_low_api.txt b/Documentation/scsi/scsi_mid_low_api.txt
index 75a535a..f879dd6 100644
--- a/Documentation/scsi/scsi_mid_low_api.txt
+++ b/Documentation/scsi/scsi_mid_low_api.txt
@@ -1350,7 +1350,7 @@ Members of interest:
                    underruns (overruns should be rare). If possible an LLD
                    should set 'resid' prior to invoking 'done'. The most
                    interesting case is data transfers from a SCSI target
-                   device device (i.e. READs) that underrun. 
+                   device (i.e. READs) that underrun.
     underflow    - LLD should place (DID_ERROR << 16) in 'result' if
                    actual number of bytes transferred is less than this
                    figure. Not many LLDs implement this check and some that
diff --git a/Documentation/scsi/st.txt b/Documentation/scsi/st.txt
index 20e30cf..1788e61 100644
--- a/Documentation/scsi/st.txt
+++ b/Documentation/scsi/st.txt
@@ -249,7 +249,7 @@ BOOT TIME CONFIGURATION
 
 If the driver is compiled into the kernel, the same parameters can be
 also set using, e.g., the LILO command line. The preferred syntax is
-is to use the same keyword used when loading as module but prepended
+to use the same keyword used when loading as module but prepended
 with 'st.'. For instance, to set the maximum number of scatter/gather
 segments, the parameter 'st.max_sg_segs=xx' should be used (xx is the
 number of scatter/gather segments).
diff --git a/Documentation/sh/new-machine.txt b/Documentation/sh/new-machine.txt
index eb2dd2e..8128564 100644
--- a/Documentation/sh/new-machine.txt
+++ b/Documentation/sh/new-machine.txt
@@ -174,7 +174,7 @@ The tree can be built in two ways:
 There are three ways in which IO can be performed:
  - none at all. This is really only useful for the 'unknown' machine type,
    which us designed to run on a machine about which we know nothing, and
-   so all all IO instructions do nothing.
+   so all IO instructions do nothing.
  - fully custom. In this case all IO functions go to a machine specific
    set of functions which can do what they like
  - a generic set of functions. These will cope with most situations,
diff --git a/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl b/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl
index 635cbb9..4493bfe 100644
--- a/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl
+++ b/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl
@@ -5487,7 +5487,7 @@ #endif
   <chapter id="power-management">
     <title>Power Management</title>
     <para>
-      If the chip is supposed to work with with suspend/resume
+      If the chip is supposed to work with suspend/resume
       functions, you need to add the power-management codes to the
       driver. The additional codes for the power-management should be
       <function>ifdef</function>'ed with
diff --git a/Documentation/sound/oss/AWE32 b/Documentation/sound/oss/AWE32
index cb179bf..b5908a6 100644
--- a/Documentation/sound/oss/AWE32
+++ b/Documentation/sound/oss/AWE32
@@ -55,7 +55,7 @@ SB32.
   install awe_wave /sbin/modprobe --first-time -i awe_wave && /usr/local/bin/sfxload PATH_TO_SOUND_BANK_FILE
 
   You will of course have to change "PATH_TO_SOUND_BANK_FILE" to the full
-  path of of the sound bank file. That will enable the Sound Blaster and AWE
+  path of the sound bank file. That will enable the Sound Blaster and AWE
   wave synthesis. To play midi files you should get one of these programs if
   you don't already have them:
 
diff --git a/Documentation/sound/oss/solo1 b/Documentation/sound/oss/solo1
index 6f53d40..95c4c83 100644
--- a/Documentation/sound/oss/solo1
+++ b/Documentation/sound/oss/solo1
@@ -6,7 +6,7 @@ is at least one report of it working on 
 The chip behaves differently than described in the data sheet,
 likely due to a chip bug. Working around this would require
 the help of ESS (for example by publishing an errata sheet),
-but ESS has not done so so far.
+but ESS has not done so far.
 
 Also, the chip only supports 24 bit addresses for recording,
 which means it cannot work on some Alpha mainboards.
diff --git a/Documentation/sound/oss/ultrasound b/Documentation/sound/oss/ultrasound
index 32cd504..eed331c 100644
--- a/Documentation/sound/oss/ultrasound
+++ b/Documentation/sound/oss/ultrasound
@@ -19,7 +19,7 @@ db16		???
 no_wave_dma option
 
 This option defaults to a value of 0, which allows the Ultrasound wavetable
-DSP to use DMA for for playback and downloading samples. This is the same
+DSP to use DMA for playback and downloading samples. This is the same
 as the old behaviour. If set to 1, no DMA is needed for downloading samples,
 and allows owners of a GUS MAX to make use of simultaneous digital audio
 (/dev/dsp), MIDI, and wavetable playback.
diff --git a/Documentation/sound/oss/vwsnd b/Documentation/sound/oss/vwsnd
index a6ea0a1..4c6cbdb 100644
--- a/Documentation/sound/oss/vwsnd
+++ b/Documentation/sound/oss/vwsnd
@@ -12,7 +12,7 @@ boxes.
 
 The Visual Workstation has an Analog Devices AD1843 "SoundComm" audio
 codec chip.  The AD1843 is accessed through the Cobalt I/O ASIC, also
-known as Lithium.  This driver programs both both chips.
+known as Lithium.  This driver programs both chips.
 
 ==============================================================================
 QUICK CONFIGURATION
diff --git a/Documentation/spi/pxa2xx b/Documentation/spi/pxa2xx
index 9c45f3d..3346bab 100644
--- a/Documentation/spi/pxa2xx
+++ b/Documentation/spi/pxa2xx
@@ -124,12 +124,12 @@ use a value of 8.
 The "pxa2xx_spi_chip.timeout_microsecs" fields is used to efficiently handle
 trailing bytes in the SSP receiver fifo.  The correct value for this field is
 dependent on the SPI bus speed ("spi_board_info.max_speed_hz") and the specific
-slave device.  Please note the the PXA2xx SSP 1 does not support trailing byte
+slave device.  Please note the PXA2xx SSP 1 does not support trailing byte
 timeouts and must busy-wait any trailing bytes.
 
 The "pxa2xx_spi_chip.enable_loopback" field is used to place the SSP porting
 into internal loopback mode.  In this mode the SSP controller internally
-connects the SSPTX pin the the SSPRX pin.  This is useful for initial setup
+connects the SSPTX pin the SSPRX pin.  This is useful for initial setup
 testing.
 
 The "pxa2xx_spi_chip.cs_control" field is used to point to a board specific
@@ -208,7 +208,7 @@ DMA and PIO I/O Support
 -----------------------
 The pxa2xx_spi driver support both DMA and interrupt driven PIO message
 transfers.  The driver defaults to PIO mode and DMA transfers must enabled by
-setting the "enable_dma" flag in the "pxa2xx_spi_master" structure and and
+setting the "enable_dma" flag in the "pxa2xx_spi_master" structure and
 ensuring that the "pxa2xx_spi_chip.dma_burst_size" field is non-zero.  The DMA
 mode support both coherent and stream based DMA mappings.
 
diff --git a/Documentation/spi/spi-summary b/Documentation/spi/spi-summary
index 068732d..7279579 100644
--- a/Documentation/spi/spi-summary
+++ b/Documentation/spi/spi-summary
@@ -262,7 +262,7 @@ NON-STATIC CONFIGURATIONS
 Developer boards often play by different rules than product boards, and one
 example is the potential need to hotplug SPI devices and/or controllers.
 
-For those cases you might need to use use spi_busnum_to_master() to look
+For those cases you might need to use spi_busnum_to_master() to look
 up the spi bus master, and will likely need spi_new_device() to provide the
 board info based on the board that was hotplugged.  Of course, you'd later
 call at least spi_unregister_device() when that board is removed.
@@ -322,7 +322,7 @@ As soon as it enters probe(), the driver
 the SPI device using "struct spi_message".  When remove() returns,
 the driver guarantees that it won't submit any more such messages.
 
-  - An spi_message is a sequence of of protocol operations, executed
+  - An spi_message is a sequence of protocol operations, executed
     as one atomic sequence.  SPI driver controls include:
 
       + when bidirectional reads and writes start ... by how its
diff --git a/Documentation/unshare.txt b/Documentation/unshare.txt
index 90a5e9e..a864351 100644
--- a/Documentation/unshare.txt
+++ b/Documentation/unshare.txt
@@ -260,7 +260,7 @@ items:
        a pointer to it.
 
   7.4) Appropriately modify architecture specific code to register the
-       the new system call.
+       new system call.
 
 8) Test Specification
 ---------------------
diff --git a/Documentation/usb/error-codes.txt b/Documentation/usb/error-codes.txt
index 867f4c3..1d9eb93 100644
--- a/Documentation/usb/error-codes.txt
+++ b/Documentation/usb/error-codes.txt
@@ -145,7 +145,7 @@ (*) Error codes like -EPROTO, -EILSEQ an
 hardware problems such as bad devices (including firmware) or cables.
 
 (**) This is also one of several codes that different kinds of host
-controller use to to indicate a transfer has failed because of device
+controller use to indicate a transfer has failed because of device
 disconnect.  In the interval before the hub driver starts disconnect
 processing, devices may receive such fault reports for every request.
 
diff --git a/Documentation/usb/hiddev.txt b/Documentation/usb/hiddev.txt
index cd6fb4b..6a79075 100644
--- a/Documentation/usb/hiddev.txt
+++ b/Documentation/usb/hiddev.txt
@@ -118,7 +118,7 @@ index, the ioctl returns -1 and sets err
 HIDIOCGDEVINFO - struct hiddev_devinfo (read)
 Gets a hiddev_devinfo structure which describes the device.
 
-HIDIOCGSTRING - struct struct hiddev_string_descriptor (read/write)
+HIDIOCGSTRING - struct hiddev_string_descriptor (read/write)
 Gets a string descriptor from the device. The caller must fill in the
 "index" field to indicate which descriptor should be returned.
 
diff --git a/Documentation/usb/usb-serial.txt b/Documentation/usb/usb-serial.txt
index f001cd9..6272ab1 100644
--- a/Documentation/usb/usb-serial.txt
+++ b/Documentation/usb/usb-serial.txt
@@ -228,7 +228,7 @@ Cypress M8 CY4601 Family Serial Driver
 		-Cypress HID->COM RS232 adapter
 	
 		Note: Cypress Semiconductor claims no affiliation with the
-			the hid->com device.
+			hid->com device.
 
 	Most devices using chipsets under the CY4601 family should
      work with the driver.  As long as they stay true to the CY4601
@@ -427,7 +427,7 @@ Options supported:
   debug			- extra verbose debugging info
   			  (default: 0; nonzero enables)
   use_lowlatency	- use low_latency flag to speed up tty layer
-			  when reading from from the device.
+			  when reading from the device.
 			  (default: 0; nonzero enables)
 
   See http://www.uuhaus.de/linux/palmconnect.html for up-to-date
diff --git a/Documentation/video4linux/README.pvrusb2 b/Documentation/video4linux/README.pvrusb2
index c73a32c..a4b7ae8 100644
--- a/Documentation/video4linux/README.pvrusb2
+++ b/Documentation/video4linux/README.pvrusb2
@@ -155,7 +155,7 @@ Source file list / functional overview:
   pvrusb2-i2c-core.[ch] - This module provides an implementation of a
     kernel-friendly I2C adaptor driver, through which other external
     I2C client drivers (e.g. msp3400, tuner, lirc) may connect and
-    operate corresponding chips within the the pvrusb2 device.  It is
+    operate corresponding chips within the pvrusb2 device.  It is
     through here that other V4L modules can reach into this driver to
     operate specific pieces (and those modules are in turn driven by
     glue logic which is coordinated by pvrusb2-hdw, doled out by
diff --git a/Documentation/video4linux/Zoran b/Documentation/video4linux/Zoran
index 040a2c8..deb218f 100644
--- a/Documentation/video4linux/Zoran
+++ b/Documentation/video4linux/Zoran
@@ -144,7 +144,7 @@ tv broadcast formats all aver the world.
 
 The CCIR defines parameters needed for broadcasting the signal.
 The CCIR has defined different standards: A,B,D,E,F,G,D,H,I,K,K1,L,M,N,...
-The CCIR says not much about about the colorsystem used !!!
+The CCIR says not much about the colorsystem used !!!
 And talking about a colorsystem says not to much about how it is broadcast.
 
 The CCIR standards A,E,F are not used any more.
diff --git a/Documentation/vm/numa b/Documentation/vm/numa
index 4b8db1b..e93ad94 100644
--- a/Documentation/vm/numa
+++ b/Documentation/vm/numa
@@ -22,7 +22,7 @@ The initial port includes NUMAizing the 
 encapsulating all the pieces of information into a bootmem_data_t
 structure. Node specific calls have been added to the allocator. 
 In theory, any platform which uses the bootmem allocator should 
-be able to to put the bootmem and mem_map data structures anywhere
+be able to put the bootmem and mem_map data structures anywhere
 it deems best.
 
 Each node's page allocation data structures have also been encapsulated


-- 
	Paolo Ornati
	Linux 2.6.17.1 on x86_64
