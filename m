Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268604AbTBZCfj>; Tue, 25 Feb 2003 21:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268611AbTBZCfj>; Tue, 25 Feb 2003 21:35:39 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:10249 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S268604AbTBZCf0>; Tue, 25 Feb 2003 21:35:26 -0500
Subject: [PATCH] 2.5.63-current replace it's with its where appropriate.
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 25 Feb 2003 19:44:44 -0700
Message-Id: <1046227485.2543.271.camel@spc1.mesatop.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces it's (it is) with its (possessive of it)
in the following cases where the possessive of it is meant.

to it's      -> to its
into it's    -> into its
from it's    -> from its
of it's      -> of its
with it's    -> with its
under it's   -> under its
about it's   -> about its

This was diffed against the current 2.5 tree.

Steven

 Documentation/filesystems/hpfs.txt       |    2 +-
 Documentation/networking/ifenslave.c     |    2 +-
 arch/alpha/kernel/sys_marvel.c           |    2 +-
 arch/i386/mach-visws/visws_apic.c        |    2 +-
 arch/ia64/sn/io/hcl.c                    |    2 +-
 arch/ia64/sn/io/sn1/pcibr.c              |    2 +-
 arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c    |    2 +-
 arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c   |    2 +-
 arch/m68k/ifpsp060/src/fpsp.S            |    6 +++---
 arch/m68k/ifpsp060/src/isp.S             |    2 +-
 arch/m68k/ifpsp060/src/pfpsp.S           |    6 +++---
 arch/mips/dec/boot/decstation.c          |    2 +-
 arch/mips/kernel/r2300_misc.S            |    2 +-
 arch/mips/kernel/r4k_misc.S              |    2 +-
 arch/mips/kernel/traps.c                 |    4 ++--
 arch/mips64/kernel/traps.c               |    2 +-
 arch/parisc/kernel/perf.c                |    2 +-
 arch/ppc/platforms/pmac_feature.c        |    2 +-
 arch/ppc64/kernel/ioctl32.c              |    2 +-
 arch/ppc64/kernel/pci_dn.c               |    2 +-
 arch/sparc64/kernel/ioctl32.c            |    2 +-
 arch/sparc64/kernel/pci_common.c         |    2 +-
 arch/sparc64/prom/misc.c                 |    2 +-
 arch/x86_64/ia32/ia32_ioctl.c            |    2 +-
 drivers/acorn/net/ether3.c               |    2 +-
 drivers/acpi/dispatcher/dsobject.c       |    2 +-
 drivers/acpi/resources/rsmemory.c        |    2 +-
 drivers/atm/lanai.c                      |    2 +-
 drivers/base/bus.c                       |    2 +-
 drivers/block/ll_rw_blk.c                |    2 +-
 drivers/char/ftape/lowlevel/ftape_syms.c |    2 +-
 drivers/char/nvram.c                     |    2 +-
 drivers/char/rocket_int.h                |    2 +-
 drivers/isdn/hysdn/hycapi.c              |    2 +-
 drivers/message/fusion/mptlan.c          |    2 +-
 drivers/message/i2o/i2o_core.c           |    2 +-
 drivers/mtd/devices/pmc551.c             |    2 +-
 drivers/net/sk98lin/skvpd.c              |    2 +-
 drivers/net/sunhme.c                     |    2 +-
 drivers/parisc/ccio-dma.c                |    2 +-
 drivers/parisc/dino.c                    |    2 +-
 drivers/parisc/sba_iommu.c               |    2 +-
 drivers/scsi/cpqfcTSinit.c               |    2 +-
 drivers/video/pvr2fb.c                   |    2 +-
 fs/befs/ChangeLog                        |    2 +-
 fs/devfs/base.c                          |    6 +++---
 fs/hpfs/dnode.c                          |    2 +-
 fs/nfsd/nfsctl.c                         |    2 +-
 fs/ntfs/attrib.c                         |    2 +-
 fs/udf/dir.c                             |    2 +-
 fs/xfs/xfs_buf_item.c                    |    2 +-
 fs/xfs/xfs_inode.c                       |    2 +-
 include/asm-ia64/sn/pci/bridge.h         |    2 +-
 include/linux/telephony.h                |    2 +-
 net/8021q/vlan.h                         |    2 +-
 net/llc/af_llc.c                         |    2 +-
 scripts/README.Menuconfig                |    2 +-
 57 files changed, 64 insertions(+), 64 deletions(-)

diff -ur linux-2.5/Documentation/filesystems/hpfs.txt linux/Documentation/filesystems/hpfs.txt
--- linux-2.5/Documentation/filesystems/hpfs.txt	Tue Feb 25 18:25:36 2003
+++ linux/Documentation/filesystems/hpfs.txt	Tue Feb 25 18:47:23 2003
@@ -109,7 +109,7 @@
 Once I booted English OS/2 working in cp 850 and I created a file on my 852
 partition. It marked file name codepage as 850 - good. But when I again booted
 Czech OS/2, the file was completely inaccessible under any name. It seems that
-OS/2 uppercases the search pattern with it's system code page (852) and file
+OS/2 uppercases the search pattern with its system code page (852) and file
 name it's comparing to with its code page (850). These could never match. Is it
 really what IBM developers wanted? But problems continued. When I created in
 Czech OS/2 another file in that directory, that file was inaccessible too. OS/2
diff -ur linux-2.5/Documentation/networking/ifenslave.c linux/Documentation/networking/ifenslave.c
--- linux-2.5/Documentation/networking/ifenslave.c	Tue Feb 25 18:24:58 2003
+++ linux/Documentation/networking/ifenslave.c	Tue Feb 25 18:47:06 2003
@@ -299,7 +299,7 @@
 		else {  /* attach a slave interface to the master */
 			/* two possibilities :
 			   - if hwaddr_notset, do nothing.  The bond will assign the
-			     hwaddr from it's first slave.
+			     hwaddr from its first slave.
 			   - if !hwaddr_notset, assign the master's hwaddr to each slave
 			*/
 
diff -ur linux-2.5/arch/alpha/kernel/sys_marvel.c linux/arch/alpha/kernel/sys_marvel.c
--- linux-2.5/arch/alpha/kernel/sys_marvel.c	Tue Feb 25 18:27:47 2003
+++ linux/arch/alpha/kernel/sys_marvel.c	Tue Feb 25 18:47:17 2003
@@ -440,7 +440,7 @@
 		return;
 
 	/* 
-	 * There is a local IO7 - redirect all of it's interrupts here.
+	 * There is a local IO7 - redirect all of its interrupts here.
 	 */
 	printk("Redirecting IO7 interrupts to local CPU at PE %u\n", cpuid);
 
diff -ur linux-2.5/arch/i386/mach-visws/visws_apic.c linux/arch/i386/mach-visws/visws_apic.c
--- linux-2.5/arch/i386/mach-visws/visws_apic.c	Tue Feb 25 18:24:46 2003
+++ linux/arch/i386/mach-visws/visws_apic.c	Tue Feb 25 18:47:06 2003
@@ -190,7 +190,7 @@
  * the 'master' interrupt source: CO_IRQ_8259.
  *
  * When the 8259 interrupts its handler figures out which of these
- * devices is interrupting and dispatches to it's handler.
+ * devices is interrupting and dispatches to its handler.
  *
  * CAREFUL: devices see the 'virtual' interrupt only. Thus disable/
  * enable_irq gets the right irq. This 'master' irq is never directly
diff -ur linux-2.5/arch/ia64/sn/io/hcl.c linux/arch/ia64/sn/io/hcl.c
--- linux-2.5/arch/ia64/sn/io/hcl.c	Tue Feb 25 18:27:45 2003
+++ linux/arch/ia64/sn/io/hcl.c	Tue Feb 25 18:47:06 2003
@@ -467,7 +467,7 @@
 		/*
 		 * We need to clean up!
 		 */
-		printk(KERN_WARNING "HCL: Unable to set the connect point to it's parent 0x%p\n",
+		printk(KERN_WARNING "HCL: Unable to set the connect point to its parent 0x%p\n",
 			(void *)new_devfs_handle);
 	}
 
diff -ur linux-2.5/arch/ia64/sn/io/sn1/pcibr.c linux/arch/ia64/sn/io/sn1/pcibr.c
--- linux-2.5/arch/ia64/sn/io/sn1/pcibr.c	Tue Feb 25 18:26:52 2003
+++ linux/arch/ia64/sn/io/sn1/pcibr.c	Tue Feb 25 18:47:06 2003
@@ -2647,7 +2647,7 @@
 	/*
 	 * The Adaptec 1160 FC Controller WAR #767995:
 	 * The part incorrectly ignores the upper 32 bits of a 64 bit
-	 * address when decoding references to it's registers so to
+	 * address when decoding references to its registers so to
 	 * keep it from responding to a bus cycle that it shouldn't
 	 * we only use I/O space to get at it's registers.  Don't
 	 * enable memory space accesses on that PCI device.
diff -ur linux-2.5/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c linux/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c
--- linux-2.5/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c	Tue Feb 25 18:28:56 2003
+++ linux/arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c	Tue Feb 25 18:47:06 2003
@@ -849,7 +849,7 @@
      * will set the c_slot (which is suppose to represent the external
      * slot (i.e the slot number silk screened on the back of the I/O
      * brick)).  So for PIC we need to adjust this "internal slot" num
-     * passed into us, into it's external representation.  See comment
+     * passed into us, into its external representation.  See comment
      * for the PCIBR_DEVICE_TO_SLOT macro for more information.
      */
     NEW(pcibr_info);
diff -ur linux-2.5/arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c linux/arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c
--- linux-2.5/arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c	Tue Feb 25 18:26:01 2003
+++ linux/arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c	Tue Feb 25 18:47:06 2003
@@ -1449,7 +1449,7 @@
 	/*
 	 * The Adaptec 1160 FC Controller WAR #767995:
 	 * The part incorrectly ignores the upper 32 bits of a 64 bit
-	 * address when decoding references to it's registers so to
+	 * address when decoding references to its registers so to
 	 * keep it from responding to a bus cycle that it shouldn't
 	 * we only use I/O space to get at it's registers.  Don't
 	 * enable memory space accesses on that PCI device.
diff -ur linux-2.5/arch/m68k/ifpsp060/src/fpsp.S linux/arch/m68k/ifpsp060/src/fpsp.S
--- linux-2.5/arch/m68k/ifpsp060/src/fpsp.S	Tue Feb 25 18:28:38 2003
+++ linux/arch/m68k/ifpsp060/src/fpsp.S	Tue Feb 25 18:47:06 2003
@@ -2201,7 +2201,7 @@
 	mov.l		LOCAL_SIZE+2+EXC_PC(%sp),LOCAL_SIZE+2+EXC_PC-0xc(%sp)
 	mov.l		LOCAL_SIZE+EXC_EA(%sp),LOCAL_SIZE+EXC_EA-0xc(%sp)
 
-# now, we copy the default result to it's proper location
+# now, we copy the default result to its proper location
 	mov.l		LOCAL_SIZE+FP_DST_EX(%sp),LOCAL_SIZE+0x4(%sp)
 	mov.l		LOCAL_SIZE+FP_DST_HI(%sp),LOCAL_SIZE+0x8(%sp)
 	mov.l		LOCAL_SIZE+FP_DST_LO(%sp),LOCAL_SIZE+0xc(%sp)
@@ -2241,7 +2241,7 @@
 	mov.l		LOCAL_SIZE+2+EXC_PC(%sp),LOCAL_SIZE+2+EXC_PC-0xc(%sp)
 	mov.l		LOCAL_SIZE+EXC_EA(%sp),LOCAL_SIZE+EXC_EA-0xc(%sp)
 
-# now, we copy the default result to it's proper location
+# now, we copy the default result to its proper location
 	mov.l		LOCAL_SIZE+FP_DST_EX(%sp),LOCAL_SIZE+0x4(%sp)
 	mov.l		LOCAL_SIZE+FP_DST_HI(%sp),LOCAL_SIZE+0x8(%sp)
 	mov.l		LOCAL_SIZE+FP_DST_LO(%sp),LOCAL_SIZE+0xc(%sp)
@@ -2281,7 +2281,7 @@
 	mov.l		LOCAL_SIZE+2+EXC_PC(%sp),LOCAL_SIZE+2+EXC_PC-0xc(%sp)
 	mov.l		LOCAL_SIZE+EXC_EA(%sp),LOCAL_SIZE+EXC_EA-0xc(%sp)
 
-# now, we copy the default result to it's proper location
+# now, we copy the default result to its proper location
 	mov.l		LOCAL_SIZE+FP_DST_EX(%sp),LOCAL_SIZE+0x4(%sp)
 	mov.l		LOCAL_SIZE+FP_DST_HI(%sp),LOCAL_SIZE+0x8(%sp)
 	mov.l		LOCAL_SIZE+FP_DST_LO(%sp),LOCAL_SIZE+0xc(%sp)
diff -ur linux-2.5/arch/m68k/ifpsp060/src/isp.S linux/arch/m68k/ifpsp060/src/isp.S
--- linux-2.5/arch/m68k/ifpsp060/src/isp.S	Tue Feb 25 18:25:00 2003
+++ linux/arch/m68k/ifpsp060/src/isp.S	Tue Feb 25 18:47:06 2003
@@ -843,7 +843,7 @@
 	bra.l		_real_access		
 
 # if the addressing mode was (an)+ or -(an), the address register must
-# be restored to it's pre-exception value before entering _real_access.
+# be restored to its pre-exception value before entering _real_access.
 isp_restore:
 	cmpi.b		SPCOND_FLG(%a6),&restore_flg # do we need a restore?
 	bne.b		isp_restore_done	# no
diff -ur linux-2.5/arch/m68k/ifpsp060/src/pfpsp.S linux/arch/m68k/ifpsp060/src/pfpsp.S
--- linux-2.5/arch/m68k/ifpsp060/src/pfpsp.S	Tue Feb 25 18:24:50 2003
+++ linux/arch/m68k/ifpsp060/src/pfpsp.S	Tue Feb 25 18:47:06 2003
@@ -2200,7 +2200,7 @@
 	mov.l		LOCAL_SIZE+2+EXC_PC(%sp),LOCAL_SIZE+2+EXC_PC-0xc(%sp)
 	mov.l		LOCAL_SIZE+EXC_EA(%sp),LOCAL_SIZE+EXC_EA-0xc(%sp)
 
-# now, we copy the default result to it's proper location
+# now, we copy the default result to its proper location
 	mov.l		LOCAL_SIZE+FP_DST_EX(%sp),LOCAL_SIZE+0x4(%sp)
 	mov.l		LOCAL_SIZE+FP_DST_HI(%sp),LOCAL_SIZE+0x8(%sp)
 	mov.l		LOCAL_SIZE+FP_DST_LO(%sp),LOCAL_SIZE+0xc(%sp)
@@ -2240,7 +2240,7 @@
 	mov.l		LOCAL_SIZE+2+EXC_PC(%sp),LOCAL_SIZE+2+EXC_PC-0xc(%sp)
 	mov.l		LOCAL_SIZE+EXC_EA(%sp),LOCAL_SIZE+EXC_EA-0xc(%sp)
 
-# now, we copy the default result to it's proper location
+# now, we copy the default result to its proper location
 	mov.l		LOCAL_SIZE+FP_DST_EX(%sp),LOCAL_SIZE+0x4(%sp)
 	mov.l		LOCAL_SIZE+FP_DST_HI(%sp),LOCAL_SIZE+0x8(%sp)
 	mov.l		LOCAL_SIZE+FP_DST_LO(%sp),LOCAL_SIZE+0xc(%sp)
@@ -2280,7 +2280,7 @@
 	mov.l		LOCAL_SIZE+2+EXC_PC(%sp),LOCAL_SIZE+2+EXC_PC-0xc(%sp)
 	mov.l		LOCAL_SIZE+EXC_EA(%sp),LOCAL_SIZE+EXC_EA-0xc(%sp)
 
-# now, we copy the default result to it's proper location
+# now, we copy the default result to its proper location
 	mov.l		LOCAL_SIZE+FP_DST_EX(%sp),LOCAL_SIZE+0x4(%sp)
 	mov.l		LOCAL_SIZE+FP_DST_HI(%sp),LOCAL_SIZE+0x8(%sp)
 	mov.l		LOCAL_SIZE+FP_DST_LO(%sp),LOCAL_SIZE+0xc(%sp)
diff -ur linux-2.5/arch/mips/dec/boot/decstation.c linux/arch/mips/dec/boot/decstation.c
--- linux-2.5/arch/mips/dec/boot/decstation.c	Tue Feb 25 18:26:18 2003
+++ linux/arch/mips/dec/boot/decstation.c	Tue Feb 25 18:47:06 2003
@@ -70,7 +70,7 @@
 
 #ifdef RELOC
 	/*
-	 * Now copy kernel image to it's destination.
+	 * Now copy kernel image to its destination.
 	 */
 	len = ((unsigned long) (&_end) - k_start);
 	memcpy((void *)k_start, &_ftext, len);
diff -ur linux-2.5/arch/mips/kernel/r2300_misc.S linux/arch/mips/kernel/r2300_misc.S
--- linux-2.5/arch/mips/kernel/r2300_misc.S	Tue Feb 25 18:27:44 2003
+++ linux/arch/mips/kernel/r2300_misc.S	Tue Feb 25 18:47:23 2003
@@ -76,7 +76,7 @@
 	/* Check is PTE is present, if not then jump to LABEL.
 	 * PTR points to the page table where this PTE is located,
 	 * when the macro is done executing PTE will be restored
-	 * with it's original value.
+	 * with its original value.
 	 */
 #define PTE_PRESENT(pte, ptr, label) \
 	andi	pte, pte, (_PAGE_PRESENT | _PAGE_READ); \
diff -ur linux-2.5/arch/mips/kernel/r4k_misc.S linux/arch/mips/kernel/r4k_misc.S
--- linux-2.5/arch/mips/kernel/r4k_misc.S	Tue Feb 25 18:25:20 2003
+++ linux/arch/mips/kernel/r4k_misc.S	Tue Feb 25 18:47:23 2003
@@ -93,7 +93,7 @@
 	/* Check is PTE is present, if not then jump to LABEL.
 	 * PTR points to the page table where this PTE is located,
 	 * when the macro is done executing PTE will be restored
-	 * with it's original value.
+	 * with its original value.
 	 */
 #define PTE_PRESENT(pte, ptr, label) \
 	andi	pte, pte, (_PAGE_PRESENT | _PAGE_READ); \
diff -ur linux-2.5/arch/mips/kernel/traps.c linux/arch/mips/kernel/traps.c
--- linux-2.5/arch/mips/kernel/traps.c	Tue Feb 25 18:25:49 2003
+++ linux/arch/mips/kernel/traps.c	Tue Feb 25 18:47:06 2003
@@ -793,7 +793,7 @@
 	/* Some firmware leaves the BEV flag set, clear it.  */
 	clear_cp0_status(ST0_BEV);
 
-	/* Copy the generic exception handler code to it's final destination. */
+	/* Copy the generic exception handler code to its final destination. */
 	memcpy((void *)(KSEG0 + 0x80), &except_vec1_generic, 0x80);
 	memcpy((void *)(KSEG0 + 0x100), &except_vec2_generic, 0x80);
 	memcpy((void *)(KSEG0 + 0x180), &except_vec3_generic, 0x80);
@@ -805,7 +805,7 @@
 		set_except_vector(i, handle_reserved);
 
 	/* 
-	 * Copy the EJTAG debug exception vector handler code to it's final 
+	 * Copy the EJTAG debug exception vector handler code to its final 
 	 * destination.
 	 */
 	memcpy((void *)(KSEG0 + 0x300), &except_vec_ejtag_debug, 0x80);
diff -ur linux-2.5/arch/mips64/kernel/traps.c linux/arch/mips64/kernel/traps.c
--- linux-2.5/arch/mips64/kernel/traps.c	Tue Feb 25 18:26:50 2003
+++ linux/arch/mips64/kernel/traps.c	Tue Feb 25 18:47:06 2003
@@ -497,7 +497,7 @@
 	/* Some firmware leaves the BEV flag set, clear it.  */
 	set_cp0_status(ST0_BEV, 0);
 
-	/* Copy the generic exception handler code to it's final destination. */
+	/* Copy the generic exception handler code to its final destination. */
 	memcpy((void *)(KSEG0 + 0x100), &except_vec2_generic, 0x80);
 	memcpy((void *)(KSEG0 + 0x180), &except_vec3_generic, 0x80);
 
diff -ur linux-2.5/arch/parisc/kernel/perf.c linux/arch/parisc/kernel/perf.c
--- linux-2.5/arch/parisc/kernel/perf.c	Tue Feb 25 18:25:30 2003
+++ linux/arch/parisc/kernel/perf.c	Tue Feb 25 18:47:17 2003
@@ -255,7 +255,7 @@
 }
 
 /*
- * Open the device and initialize all of it's memory.  The device is only 
+ * Open the device and initialize all of its memory.  The device is only 
  * opened once, but can be "queried" by multiple processes that know its
  * file descriptor.
  */
diff -ur linux-2.5/arch/ppc/platforms/pmac_feature.c linux/arch/ppc/platforms/pmac_feature.c
--- linux-2.5/arch/ppc/platforms/pmac_feature.c	Tue Feb 25 18:28:18 2003
+++ linux/arch/ppc/platforms/pmac_feature.c	Tue Feb 25 18:47:17 2003
@@ -50,7 +50,7 @@
 
 /*
  * We use a single global lock to protect accesses. Each driver has
- * to take care of it's own locking
+ * to take care of its own locking
  */
 static spinlock_t feature_lock  __pmacdata = SPIN_LOCK_UNLOCKED;
 
diff -ur linux-2.5/arch/ppc64/kernel/ioctl32.c linux/arch/ppc64/kernel/ioctl32.c
--- linux-2.5/arch/ppc64/kernel/ioctl32.c	Tue Feb 25 18:28:53 2003
+++ linux/arch/ppc64/kernel/ioctl32.c	Tue Feb 25 18:47:17 2003
@@ -3315,7 +3315,7 @@
  *
  *	But how to keep track of these kernel buffers?  We'd need to either
  *	keep track of them in some table _or_ know about usbdevicefs internals
- *	(ie. the exact layout of it's file private, which is actually defined
+ *	(ie. the exact layout of its file private, which is actually defined
  *	in linux/usbdevice_fs.h, the layout of the async queues are private to
  *	devio.c)
  *
diff -ur linux-2.5/arch/ppc64/kernel/pci_dn.c linux/arch/ppc64/kernel/pci_dn.c
--- linux-2.5/arch/ppc64/kernel/pci_dn.c	Tue Feb 25 18:28:52 2003
+++ linux/arch/ppc64/kernel/pci_dn.c	Tue Feb 25 18:47:23 2003
@@ -150,7 +150,7 @@
 }
 
 /* This is the "slow" path for looking up a device_node from a
- * pci_dev.  It will hunt for the device under it's parent's
+ * pci_dev.  It will hunt for the device under its parent's
  * phb and then update sysdata for a future fastpath.
  *
  * It may also do fixups on the actual device since this happens
diff -ur linux-2.5/arch/sparc64/kernel/ioctl32.c linux/arch/sparc64/kernel/ioctl32.c
--- linux-2.5/arch/sparc64/kernel/ioctl32.c	Tue Feb 25 18:28:13 2003
+++ linux/arch/sparc64/kernel/ioctl32.c	Tue Feb 25 18:47:17 2003
@@ -3947,7 +3947,7 @@
  *
  *	But how to keep track of these kernel buffers?  We'd need to either
  *	keep track of them in some table _or_ know about usbdevicefs internals
- *	(ie. the exact layout of it's file private, which is actually defined
+ *	(ie. the exact layout of its file private, which is actually defined
  *	in linux/usbdevice_fs.h, the layout of the async queues are private to
  *	devio.c)
  *
diff -ur linux-2.5/arch/sparc64/kernel/pci_common.c linux/arch/sparc64/kernel/pci_common.c
--- linux-2.5/arch/sparc64/kernel/pci_common.c	Tue Feb 25 18:25:05 2003
+++ linux/arch/sparc64/kernel/pci_common.c	Tue Feb 25 18:47:17 2003
@@ -583,7 +583,7 @@
 	 * the PBM.
 	 *
 	 * However if that parent bridge has interrupt map/mask
-	 * properties of it's own we use the PROM register property
+	 * properties of its own we use the PROM register property
 	 * of the next child device on the path to PDEV.
 	 *
 	 * In detail the two cases are (note that the 'X' below is the
diff -ur linux-2.5/arch/sparc64/prom/misc.c linux/arch/sparc64/prom/misc.c
--- linux-2.5/arch/sparc64/prom/misc.c	Tue Feb 25 18:27:37 2003
+++ linux/arch/sparc64/prom/misc.c	Tue Feb 25 18:47:17 2003
@@ -142,7 +142,7 @@
 	return prom_prev;
 }
 
-/* Install Linux trap table so PROM uses that instead of it's own. */
+/* Install Linux trap table so PROM uses that instead of its own. */
 void prom_set_trap_table(unsigned long tba)
 {
 	p1275_cmd("SUNW,set-trap-table", P1275_INOUT(1, 0), tba);
diff -ur linux-2.5/arch/x86_64/ia32/ia32_ioctl.c linux/arch/x86_64/ia32/ia32_ioctl.c
--- linux-2.5/arch/x86_64/ia32/ia32_ioctl.c	Tue Feb 25 18:26:13 2003
+++ linux/arch/x86_64/ia32/ia32_ioctl.c	Tue Feb 25 18:47:17 2003
@@ -3196,7 +3196,7 @@
  *
  *	But how to keep track of these kernel buffers?  We'd need to either
  *	keep track of them in some table _or_ know about usbdevicefs internals
- *	(ie. the exact layout of it's file private, which is actually defined
+ *	(ie. the exact layout of its file private, which is actually defined
  *	in linux/usbdevice_fs.h, the layout of the async queues are private to
  *	devio.c)
  *
diff -ur linux-2.5/drivers/acorn/net/ether3.c linux/drivers/acorn/net/ether3.c
--- linux-2.5/drivers/acorn/net/ether3.c	Tue Feb 25 18:28:39 2003
+++ linux/drivers/acorn/net/ether3.c	Tue Feb 25 18:47:06 2003
@@ -101,7 +101,7 @@
 
 /*
  * ether3 read/write.  Slow things down a bit...
- * The SEEQ8005 doesn't like us writing to it's registers
+ * The SEEQ8005 doesn't like us writing to its registers
  * too quickly.
  */
 static inline void ether3_outb(int v, const int r)
diff -ur linux-2.5/drivers/acpi/dispatcher/dsobject.c linux/drivers/acpi/dispatcher/dsobject.c
--- linux-2.5/drivers/acpi/dispatcher/dsobject.c	Tue Feb 25 18:24:43 2003
+++ linux/drivers/acpi/dispatcher/dsobject.c	Tue Feb 25 18:47:06 2003
@@ -396,7 +396,7 @@
 		return_ACPI_STATUS (status);
 	}
 
-	/* Re-type the object according to it's argument */
+	/* Re-type the object according to its argument */
 
 	node->type = ACPI_GET_OBJECT_TYPE (obj_desc);
 
diff -ur linux-2.5/drivers/acpi/resources/rsmemory.c linux/drivers/acpi/resources/rsmemory.c
--- linux-2.5/drivers/acpi/resources/rsmemory.c	Tue Feb 25 18:27:48 2003
+++ linux/drivers/acpi/resources/rsmemory.c	Tue Feb 25 18:47:06 2003
@@ -278,7 +278,7 @@
 	/*
 	 *  Point to the place in the output buffer where the data portion will
 	 *  begin.
-	 *  1. Set the RESOURCE_DATA * Data to point to it's own address, then
+	 *  1. Set the RESOURCE_DATA * Data to point to its own address, then
 	 *  2. Set the pointer to the next address.
 	 *
 	 *  NOTE: output_struct->Data is cast to u8, otherwise, this addition adds
diff -ur linux-2.5/drivers/atm/lanai.c linux/drivers/atm/lanai.c
--- linux-2.5/drivers/atm/lanai.c	Tue Feb 25 18:25:07 2003
+++ linux/drivers/atm/lanai.c	Tue Feb 25 18:47:23 2003
@@ -1300,7 +1300,7 @@
 #define DESCRIPTOR_AAL5_STREAM	(0x00004000)
 #define DESCRIPTOR_CLP		(0x00002000)
 
-/* Add 32-bit descriptor with it's padding */
+/* Add 32-bit descriptor with its padding */
 static inline void vcc_tx_add_aal5_descriptor(struct lanai_vcc *lvcc,
 	u32 flags, int len)
 {
diff -ur linux-2.5/drivers/base/bus.c linux/drivers/base/bus.c
--- linux-2.5/drivers/base/bus.c	Tue Feb 25 18:25:04 2003
+++ linux/drivers/base/bus.c	Tue Feb 25 18:47:06 2003
@@ -459,7 +459,7 @@
  *	@drv:	driver.
  *
  *	Detach the driver from the devices it controls, and remove
- *	it from it's bus's list of drivers. Finally, we drop the reference
+ *	it from its bus's list of drivers. Finally, we drop the reference
  *	to the bus we took in bus_add_driver().
  */
 
diff -ur linux-2.5/drivers/block/ll_rw_blk.c linux/drivers/block/ll_rw_blk.c
--- linux-2.5/drivers/block/ll_rw_blk.c	Tue Feb 25 18:24:51 2003
+++ linux/drivers/block/ll_rw_blk.c	Tue Feb 25 18:47:06 2003
@@ -1893,7 +1893,7 @@
 }
 
 /**
- * generic_make_request: hand a buffer to it's device driver for I/O
+ * generic_make_request: hand a buffer to its device driver for I/O
  * @bio:  The bio describing the location in memory and on the device.
  *
  * generic_make_request() is used to make I/O requests of block
diff -ur linux-2.5/drivers/char/ftape/lowlevel/ftape_syms.c linux/drivers/char/ftape/lowlevel/ftape_syms.c
--- linux-2.5/drivers/char/ftape/lowlevel/ftape_syms.c	Tue Feb 25 18:25:28 2003
+++ linux/drivers/char/ftape/lowlevel/ftape_syms.c	Tue Feb 25 18:47:06 2003
@@ -22,7 +22,7 @@
  *
  *      This file contains the symbols that the ftape low level
  *      part of the QIC-40/80/3010/3020 floppy-tape driver "ftape"
- *      exports to it's high level clients
+ *      exports to its high level clients
  */
 
 #include <linux/config.h>
diff -ur linux-2.5/drivers/char/nvram.c linux/drivers/char/nvram.c
--- linux-2.5/drivers/char/nvram.c	Tue Feb 25 18:25:41 2003
+++ linux/drivers/char/nvram.c	Tue Feb 25 18:47:17 2003
@@ -606,7 +606,7 @@
 
 #if MACH == COBALT
 
-/* the cobalt CMOS has a wider range of it's checksum */
+/* the cobalt CMOS has a wider range of its checksum */
 static int cobalt_check_checksum(void)
 {
 	int i;
diff -ur linux-2.5/drivers/char/rocket_int.h linux/drivers/char/rocket_int.h
--- linux-2.5/drivers/char/rocket_int.h	Tue Feb 25 18:24:57 2003
+++ linux/drivers/char/rocket_int.h	Tue Feb 25 18:47:06 2003
@@ -834,7 +834,7 @@
 
 /***************************************************************************
 Function: sInitChanDefaults
-Purpose:  Initialize a channel structure to it's default state.
+Purpose:  Initialize a channel structure to its default state.
 Call:     sInitChanDefaults(ChP)
           CHANNEL_T *ChP; Ptr to the channel structure
 Comments: This function must be called once for every channel structure
diff -ur linux-2.5/drivers/isdn/hysdn/hycapi.c linux/drivers/isdn/hysdn/hycapi.c
--- linux-2.5/drivers/isdn/hysdn/hycapi.c	Tue Feb 25 18:24:49 2003
+++ linux/drivers/isdn/hysdn/hycapi.c	Tue Feb 25 18:47:23 2003
@@ -702,7 +702,7 @@
 /********************************************************************
 hycapi_capi_create(hysdn_card *card)
 
-Attach the card with it's capi-ctrl.
+Attach the card with its capi-ctrl.
 *********************************************************************/
 
 static void hycapi_fill_profile(hysdn_card *card)
diff -ur linux-2.5/drivers/message/fusion/mptlan.c linux/drivers/message/fusion/mptlan.c
--- linux-2.5/drivers/message/fusion/mptlan.c	Tue Feb 25 18:26:06 2003
+++ linux/drivers/message/fusion/mptlan.c	Tue Feb 25 18:47:06 2003
@@ -242,7 +242,7 @@
 			//  would Oops because mf has already been set
 			//  to NULL.  So after return from this func,
 			//  mpt_interrupt() will attempt to put (NULL) mf ptr
-			//  item back onto it's adapter FreeQ - Oops!:-(
+			//  item back onto its adapter FreeQ - Oops!:-(
 			//  It's Ok, since mpt_lan_send_turbo() *currently*
 			//  always returns 0, but..., just in case:
 
diff -ur linux-2.5/drivers/message/i2o/i2o_core.c linux/drivers/message/i2o/i2o_core.c
--- linux-2.5/drivers/message/i2o/i2o_core.c	Tue Feb 25 18:26:43 2003
+++ linux/drivers/message/i2o/i2o_core.c	Tue Feb 25 18:47:06 2003
@@ -340,7 +340,7 @@
 
 /*
  *	Each I2O controller has a chain of devices on it.
- * Each device has a pointer to it's LCT entry to be used
+ * Each device has a pointer to its LCT entry to be used
  * for fun purposes.
  */
 
diff -ur linux-2.5/drivers/mtd/devices/pmc551.c linux/drivers/mtd/devices/pmc551.c
--- linux-2.5/drivers/mtd/devices/pmc551.c	Tue Feb 25 18:27:37 2003
+++ linux/drivers/mtd/devices/pmc551.c	Tue Feb 25 18:47:17 2003
@@ -30,7 +30,7 @@
  *	 
  * Notes:
  *	 Due to what I assume is more buggy SROM, the 64M PMC551 I
- *	 have available claims that all 4 of it's DRAM banks have 64M
+ *	 have available claims that all 4 of its DRAM banks have 64M
  *	 of ram configured (making a grand total of 256M onboard).
  *	 This is slightly annoying since the BAR0 size reflects the
  *	 aperture size, not the dram size, and the V370PDC supplies no
diff -ur linux-2.5/drivers/net/sk98lin/skvpd.c linux/drivers/net/sk98lin/skvpd.c
--- linux-2.5/drivers/net/sk98lin/skvpd.c	Tue Feb 25 18:26:33 2003
+++ linux/drivers/net/sk98lin/skvpd.c	Tue Feb 25 18:47:24 2003
@@ -563,7 +563,7 @@
 
 /*
  *	find the Keyword 'key' in the VPD buffer and fills the
- *	parameter sturct 'p' with it's values
+ *	parameter sturct 'p' with its values
  *
  * returns	*p	success
  *		0:	parameter was not found or VPD encoding error
diff -ur linux-2.5/drivers/net/sunhme.c linux/drivers/net/sunhme.c
--- linux-2.5/drivers/net/sunhme.c	Tue Feb 25 18:25:27 2003
+++ linux/drivers/net/sunhme.c	Tue Feb 25 18:47:06 2003
@@ -1651,7 +1651,7 @@
 		    hme_read32(hp, etxregs + ETX_CFG) | ETX_CFG_DMAENABLE);
 
 	/* This chip really rots, for the receiver sometimes when you
-	 * write to it's control registers not all the bits get there
+	 * write to its control registers not all the bits get there
 	 * properly.  I cannot think of a sane way to provide complete
 	 * coverage for this hardware bug yet.
 	 */
diff -ur linux-2.5/drivers/parisc/ccio-dma.c linux/drivers/parisc/ccio-dma.c
--- linux-2.5/drivers/parisc/ccio-dma.c	Tue Feb 25 18:24:58 2003
+++ linux/drivers/parisc/ccio-dma.c	Tue Feb 25 18:47:24 2003
@@ -924,7 +924,7 @@
 			** can't change. And we need the offset from the first
 			** chunk - not the last one. Ergo Successive chunks
 			** must start on page boundaries and dove tail
-			** with it's predecessor.
+			** with its predecessor.
 			*/
 			sg_dma_len(vcontig_sg) = vcontig_len;
 
diff -ur linux-2.5/drivers/parisc/dino.c linux/drivers/parisc/dino.c
--- linux-2.5/drivers/parisc/dino.c	Tue Feb 25 18:24:45 2003
+++ linux/drivers/parisc/dino.c	Tue Feb 25 18:47:17 2003
@@ -755,7 +755,7 @@
 
 	/*
 	** This enables DINO to generate interrupts when it sees
-	** any of it's inputs *change*. Just asserting an IRQ
+	** any of its inputs *change*. Just asserting an IRQ
 	** before it's enabled (ie unmasked) isn't good enough.
 	*/
 	gsc_writel(eim, dino_dev->hba.base_addr+DINO_IAR0);
diff -ur linux-2.5/drivers/parisc/sba_iommu.c linux/drivers/parisc/sba_iommu.c
--- linux-2.5/drivers/parisc/sba_iommu.c	Tue Feb 25 18:27:31 2003
+++ linux/drivers/parisc/sba_iommu.c	Tue Feb 25 18:47:24 2003
@@ -1219,7 +1219,7 @@
 			** can't change. And we need the offset from the first
 			** chunk - not the last one. Ergo Successive chunks
 			** must start on page boundaries and dove tail
-			** with it's predecessor.
+			** with its predecessor.
 			*/
 			sg_dma_len(vcontig_sg) = vcontig_len;
 
diff -ur linux-2.5/drivers/scsi/cpqfcTSinit.c linux/drivers/scsi/cpqfcTSinit.c
--- linux-2.5/drivers/scsi/cpqfcTSinit.c	Tue Feb 25 18:24:47 2003
+++ linux/drivers/scsi/cpqfcTSinit.c	Tue Feb 25 18:47:18 2003
@@ -1514,7 +1514,7 @@
       Exchanges->fcExchange[i].timeOut = 10; // seconds default (changed later)
 
       // Since we need to immediately return the aborted Cmnd to Scsi 
-      // upper layers, we can't make future reference to any of it's 
+      // upper layers, we can't make future reference to any of its 
       // fields (e.g the Nexus).
 
       cpqfcTSPutLinkQue( cpqfcHBAdata, BLS_ABTS, &i);
diff -ur linux-2.5/drivers/video/pvr2fb.c linux/drivers/video/pvr2fb.c
--- linux-2.5/drivers/video/pvr2fb.c	Tue Feb 25 18:24:50 2003
+++ linux/drivers/video/pvr2fb.c	Tue Feb 25 18:47:18 2003
@@ -15,7 +15,7 @@
  * an odd scheme for converting hardware values to/from framebuffer values, here are
  * some hacked-up formulas:
  *
- *  The Dreamcast has screen offsets from each side of it's four borders and the start
+ *  The Dreamcast has screen offsets from each side of its four borders and the start
  *  offsets of the display window.  I used these values to calculate 'pseudo' values
  *  (think of them as placeholders) for the fb video mode, so that when it came time
  *  to convert these values back into their hardware values, I could just add mode-
diff -ur linux-2.5/fs/befs/ChangeLog linux/fs/befs/ChangeLog
--- linux-2.5/fs/befs/ChangeLog	Tue Feb 25 18:24:52 2003
+++ linux/fs/befs/ChangeLog	Tue Feb 25 18:47:06 2003
@@ -117,7 +117,7 @@
 * Rewrote datastream positon lookups.
 	(datastream.c) [WD]
 
-* Moved the TODO list to it's own file.
+* Moved the TODO list to its own file.
 

 Version 0.50 (2001-11-13)
diff -ur linux-2.5/fs/devfs/base.c linux/fs/devfs/base.c
--- linux-2.5/fs/devfs/base.c	Tue Feb 25 18:24:57 2003
+++ linux/fs/devfs/base.c	Tue Feb 25 18:47:06 2003
@@ -1312,7 +1312,7 @@
  *	free_dentry - Free the dentry for a device entry and invalidate inode.
  *	@de: The entry.
  *
- *	This must only be called after the entry has been unhooked from it's
+ *	This must only be called after the entry has been unhooked from its
  *	 parent directory.
  */
 
@@ -1584,7 +1584,7 @@
 

 /**
- *	_devfs_unregister - Unregister a device entry from it's parent.
+ *	_devfs_unregister - Unregister a device entry from its parent.
  *	@dir: The parent directory.
  *	@de: The entry to unregister.
  *
@@ -2658,7 +2658,7 @@
     else de->u.dir.no_more_additions = TRUE;
     write_unlock (&de->u.dir.lock);
     if (err) return err;
-    /*  Now unhook the directory from it's parent  */
+    /*  Now unhook the directory from its parent  */
     write_lock (&de->parent->u.dir.lock);
     if ( !_devfs_unhook (de) ) err = -ENOENT;
     write_unlock (&de->parent->u.dir.lock);
diff -ur linux-2.5/fs/hpfs/dnode.c linux/fs/hpfs/dnode.c
--- linux-2.5/fs/hpfs/dnode.c	Tue Feb 25 18:26:03 2003
+++ linux/fs/hpfs/dnode.c	Tue Feb 25 18:47:24 2003
@@ -188,7 +188,7 @@
 	return de;
 }
 
-/* Delete dirent and don't care about it's subtree */
+/* Delete dirent and don't care about its subtree */
 
 void hpfs_delete_de(struct super_block *s, struct dnode *d, struct hpfs_dirent *de)
 {
diff -ur linux-2.5/fs/nfsd/nfsctl.c linux/fs/nfsd/nfsctl.c
--- linux-2.5/fs/nfsd/nfsctl.c	Tue Feb 25 18:24:58 2003
+++ linux/fs/nfsd/nfsctl.c	Tue Feb 25 18:47:24 2003
@@ -77,7 +77,7 @@
 };
 
 /* an argresp is stored in an allocated page and holds the 
- * size of the argument or response, along with it's content
+ * size of the argument or response, along with its content
  */
 struct argresp {
 	ssize_t size;
diff -ur linux-2.5/fs/ntfs/attrib.c linux/fs/ntfs/attrib.c
--- linux-2.5/fs/ntfs/attrib.c	Tue Feb 25 18:28:54 2003
+++ linux/fs/ntfs/attrib.c	Tue Feb 25 18:47:06 2003
@@ -830,7 +830,7 @@
 				goto io_error;
 			for (deltaxcn = (s8)buf[b--]; b > b2; b--)
 				deltaxcn = (deltaxcn << 8) + buf[b];
-			/* Change the current lcn to it's new value. */
+			/* Change the current lcn to its new value. */
 			lcn += deltaxcn;
 #ifdef DEBUG
 			/*
diff -ur linux-2.5/fs/udf/dir.c linux/fs/udf/dir.c
--- linux-2.5/fs/udf/dir.c	Tue Feb 25 18:25:13 2003
+++ linux/fs/udf/dir.c	Tue Feb 25 18:47:06 2003
@@ -19,7 +19,7 @@
  *
  * HISTORY
  *
- *  10/05/98 dgb  Split directory operations into it's own file
+ *  10/05/98 dgb  Split directory operations into its own file
  *                Implemented directory reads via do_udf_readdir
  *  10/06/98      Made directory operations work!
  *  11/17/98      Rewrote directory to support ICBTAG_FLAG_AD_LONG
diff -ur linux-2.5/fs/xfs/xfs_buf_item.c linux/fs/xfs/xfs_buf_item.c
--- linux-2.5/fs/xfs/xfs_buf_item.c	Tue Feb 25 18:24:44 2003
+++ linux/fs/xfs/xfs_buf_item.c	Tue Feb 25 18:47:24 2003
@@ -924,7 +924,7 @@
 

 /*
- * Add the given log item with it's callback to the list of callbacks
+ * Add the given log item with its callback to the list of callbacks
  * to be called when the buffer's I/O completes.  If it is not set
  * already, set the buffer's b_iodone() routine to be
  * xfs_buf_iodone_callbacks() and link the log item into the list of
diff -ur linux-2.5/fs/xfs/xfs_inode.c linux/fs/xfs/xfs_inode.c
--- linux-2.5/fs/xfs/xfs_inode.c	Tue Feb 25 18:28:37 2003
+++ linux/fs/xfs/xfs_inode.c	Tue Feb 25 18:47:18 2003
@@ -1001,7 +1001,7 @@
 }
 
 /*
- * Allocate an inode on disk and return a copy of it's in-core version.
+ * Allocate an inode on disk and return a copy of its in-core version.
  * The in-core inode is locked exclusively.  Set mode, nlink, and rdev
  * appropriately within the inode.  The uid and gid for the inode are
  * set according to the contents of the given cred structure.
diff -ur linux-2.5/include/asm-ia64/sn/pci/bridge.h linux/include/asm-ia64/sn/pci/bridge.h
--- linux-2.5/include/asm-ia64/sn/pci/bridge.h	Tue Feb 25 18:24:59 2003
+++ linux/include/asm-ia64/sn/pci/bridge.h	Tue Feb 25 18:47:18 2003
@@ -14,7 +14,7 @@
  * bridge.h - header file for bridge chip and bridge portion of xbridge chip
  *
  * Also including offsets for unique PIC registers.
- * The PIC asic is a follow-on to Xbridge and most of it's registers are
+ * The PIC asic is a follow-on to Xbridge and most of its registers are
  * identical to those of Xbridge.  PIC is different than Xbridge in that
  * it will accept 64 bit register access and that, in some cases, data
  * is kept in bits 63:32.   PIC registers that are identical to Xbridge
diff -ur linux-2.5/include/linux/telephony.h linux/include/linux/telephony.h
--- linux-2.5/include/linux/telephony.h	Tue Feb 25 18:26:27 2003
+++ linux/include/linux/telephony.h	Tue Feb 25 18:47:18 2003
@@ -68,7 +68,7 @@
 * device installed in your system.  The PHONECTL_CAPABILITIES ioctl
 * returns an integer value indicating the number of capabilities the   
 * device has.  The PHONECTL_CAPABILITIES_LIST will fill an array of 
-* capability structs with all of it's capabilities.  The
+* capability structs with all of its capabilities.  The
 * PHONECTL_CAPABILITIES_CHECK takes a single capability struct and returns
 * a TRUE if the device has that capability, otherwise it returns false.
 * 
diff -ur linux-2.5/net/8021q/vlan.h linux/net/8021q/vlan.h
--- linux-2.5/net/8021q/vlan.h	Tue Feb 25 18:26:50 2003
+++ linux/net/8021q/vlan.h	Tue Feb 25 18:47:18 2003
@@ -38,7 +38,7 @@
 extern struct vlan_group *vlan_group_hash[VLAN_GRP_HASH_SIZE];
 extern spinlock_t vlan_group_lock;
 
-/*  Find a VLAN device by the MAC address of it's Ethernet device, and
+/*  Find a VLAN device by the MAC address of its Ethernet device, and
  *  it's VLAN ID.  The default configuration is to have VLAN's scope
  *  to be box-wide, so the MAC will be ignored.  The mac will only be
  *  looked at if we are configured to have a separate set of VLANs per
diff -ur linux-2.5/net/llc/af_llc.c linux/net/llc/af_llc.c
--- linux-2.5/net/llc/af_llc.c	Tue Feb 25 18:24:41 2003
+++ linux/net/llc/af_llc.c	Tue Feb 25 18:47:07 2003
@@ -301,7 +301,7 @@
 	llc->daddr.lsap = addr->sllc_dsap;
 	memcpy(llc->daddr.mac, addr->sllc_dmac, IFHWADDRLEN);
 	memcpy(&llc->addr, addr, sizeof(llc->addr));
-	/* assign new connection to it's SAP */
+	/* assign new connection to its SAP */
 	llc_sap_assign_sock(sap, sk);
 	rc = sk->zapped = 0;
 out:
diff -ur linux-2.5/scripts/README.Menuconfig linux/scripts/README.Menuconfig
--- linux-2.5/scripts/README.Menuconfig	Tue Feb 25 18:25:51 2003
+++ linux/scripts/README.Menuconfig	Tue Feb 25 18:47:07 2003
@@ -127,7 +127,7 @@
 source tree is fresh, or changes are patched into it via a kernel
 patch or you do 'make mrproper'.  If changes to lxdialog are patched
 in, most likely the rebuild time will be short.  You may force a
-complete rebuild of lxdialog by changing to it's directory and doing
+complete rebuild of lxdialog by changing to its directory and doing
 'make clean all'
 
 If you use Menuconfig in an XTERM window make sure you have your 

