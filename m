Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268628AbTBZCwU>; Tue, 25 Feb 2003 21:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268618AbTBZCwF>; Tue, 25 Feb 2003 21:52:05 -0500
Received: from [24.77.48.240] ([24.77.48.240]:23865 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S268621AbTBZCut>;
	Tue, 25 Feb 2003 21:50:49 -0500
Date: Tue, 25 Feb 2003 19:01:09 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200302260301.h1Q319e07247@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Spelling fixes for 2.5.63 - accommodate
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes:
    accomodate -> accommodate
    accomodated -> accommodated
    accomodates -> accommodates

Fixes 43 occurrences in all.

diff -ur a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
--- a/arch/ia64/kernel/perfmon.c	Mon Feb 24 11:05:44 2003
+++ b/arch/ia64/kernel/perfmon.c	Tue Feb 25 17:44:04 2003
@@ -718,7 +718,7 @@
 
 /*
  * counts the number of PMDS to save per entry.
- * This code is generic enough to accomodate more than 64 PMDS when they become available
+ * This code is generic enough to accommodate more than 64 PMDS when they become available
  */
 static unsigned long
 pfm_smpl_entry_size(unsigned long *which, unsigned long size)
diff -ur a/arch/ia64/lib/do_csum.S b/arch/ia64/lib/do_csum.S
--- a/arch/ia64/lib/do_csum.S	Mon Feb 24 11:05:10 2003
+++ b/arch/ia64/lib/do_csum.S	Tue Feb 25 17:44:09 2003
@@ -41,7 +41,7 @@
 //	into one 8 byte word. In this case we have only one entry in the pipeline.
 //
 //	We use a (LOAD_LATENCY+2)-stage pipeline in the loop to account for
-//	possible load latency and also to accomodate for head and tail.
+//	possible load latency and also to accommodate for head and tail.
 //
 //	The end of the function deals with folding the checksum from 64bits
 //	down to 16bits taking care of the carry.
diff -ur a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
--- a/arch/parisc/kernel/irq.c	Mon Feb 24 11:05:16 2003
+++ b/arch/parisc/kernel/irq.c	Tue Feb 25 17:44:11 2003
@@ -349,7 +349,7 @@
 
 
 /*
-** The alloc process needs to accept a parameter to accomodate limitations
+** The alloc process needs to accept a parameter to accommodate limitations
 ** of the HW/SW which use these bits:
 ** Legacy PA I/O (GSC/NIO): 5 bits (architected EIM register)
 ** V-class (EPIC):          6 bits
diff -ur a/arch/ppc/kernel/l2cr.S b/arch/ppc/kernel/l2cr.S
--- a/arch/ppc/kernel/l2cr.S	Mon Feb 24 11:05:33 2003
+++ b/arch/ppc/kernel/l2cr.S	Tue Feb 25 17:44:14 2003
@@ -136,7 +136,7 @@
 	 /**** Might be a good idea to set L2DO here - to prevent instructions
 	       from getting into the cache.  But since we invalidate
 	       the next time we enable the cache it doesn't really matter.
-	       Don't do this unless you accomodate all processor variations.
+	       Don't do this unless you accommodate all processor variations.
 	       The bit moved on the 7450.....
 	  ****/
 
diff -ur a/arch/ppc/mm/mem_pieces.c b/arch/ppc/mm/mem_pieces.c
--- a/arch/ppc/mm/mem_pieces.c	Mon Feb 24 11:05:05 2003
+++ b/arch/ppc/mm/mem_pieces.c	Tue Feb 25 17:44:18 2003
@@ -1,6 +1,6 @@
 /*
  *    Copyright (c) 1996 Paul Mackerras <paulus@cs.anu.edu.au>
- *      Changes to accomodate Power Macintoshes.
+ *      Changes to accommodate Power Macintoshes.
  *    Cort Dougan <cort@cs.nmt.edu>
  *      Rewrites.
  *    Grant Erickson <grant@lcse.umn.edu>
diff -ur a/arch/ppc/mm/mem_pieces.h b/arch/ppc/mm/mem_pieces.h
--- a/arch/ppc/mm/mem_pieces.h	Mon Feb 24 11:05:04 2003
+++ b/arch/ppc/mm/mem_pieces.h	Tue Feb 25 17:44:20 2003
@@ -1,6 +1,6 @@
 /*
  *    Copyright (c) 1996 Paul Mackerras <paulus@cs.anu.edu.au>
- *      Changes to accomodate Power Macintoshes.
+ *      Changes to accommodate Power Macintoshes.
  *    Cort Dougan <cort@cs.nmt.edu>
  *      Rewrites.
  *    Grant Erickson <grant@lcse.umn.edu>
diff -ur a/drivers/acpi/hardware/hwtimer.c b/drivers/acpi/hardware/hwtimer.c
--- a/drivers/acpi/hardware/hwtimer.c	Mon Feb 24 11:05:09 2003
+++ b/drivers/acpi/hardware/hwtimer.c	Tue Feb 25 17:44:22 2003
@@ -133,7 +133,7 @@
  *              transitions (unlike many CPU timestamp counters) -- making it
  *              a versatile and accurate timer.
  *
- *              Note that this function accomodates only a single timer
+ *              Note that this function accommodates only a single timer
  *              rollover.  Thus for 24-bit timers, this function should only
  *              be used for calculating durations less than ~4.6 seconds
  *              (~20 minutes for 32-bit timers) -- calculations below
diff -ur a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
--- a/drivers/cdrom/cdrom.c	Mon Feb 24 11:05:10 2003
+++ b/drivers/cdrom/cdrom.c	Tue Feb 25 17:44:24 2003
@@ -173,7 +173,7 @@
   -- Fixed the CDROMREADxxx ioctls.
   -- CDROMPLAYTRKIND uses the GPCMD_PLAY_AUDIO_MSF command - too few
   drives supported it. We loose the index part, however.
-  -- Small modifications to accomodate opens of /dev/hdc1, required
+  -- Small modifications to accommodate opens of /dev/hdc1, required
   for ide-cd to handle multisession discs.
   -- Export cdrom_mode_sense and cdrom_mode_select.
   -- init_cdrom_command() for setting up a cgc command.
diff -ur a/drivers/char/rio/parmmap.h b/drivers/char/rio/parmmap.h
--- a/drivers/char/rio/parmmap.h	Mon Feb 24 11:05:42 2003
+++ b/drivers/char/rio/parmmap.h	Tue Feb 25 17:44:28 2003
@@ -31,7 +31,7 @@
  ----------------------------------------------------------------------------
   Date     By                Description
  ----------------------------------------------------------------------------
-6/4/1991   jonb		     Made changes to accomodate Mips R3230 bus
+6/4/1991   jonb		     Made changes to accommodate Mips R3230 bus
  ***************************************************************************/
 
 #ifndef _parmap_h
diff -ur a/drivers/char/rio/rioinit.c b/drivers/char/rio/rioinit.c
--- a/drivers/char/rio/rioinit.c	Mon Feb 24 11:05:14 2003
+++ b/drivers/char/rio/rioinit.c	Tue Feb 25 17:44:30 2003
@@ -145,7 +145,7 @@
 	p->RIOHosts[p->RIONumHosts].PaddrP	= info->location;
 
 	/*
-	** Check that we are able to accomodate another host
+	** Check that we are able to accommodate another host
 	*/
 	if ( p->RIONumHosts >= RIO_HOSTS )
 	{
diff -ur a/drivers/char/synclink.c b/drivers/char/synclink.c
--- a/drivers/char/synclink.c	Mon Feb 24 11:05:15 2003
+++ b/drivers/char/synclink.c	Tue Feb 25 17:44:33 2003
@@ -4260,7 +4260,7 @@
 
 	if ( info->tx_holding_count ) {
 		/* determine if we have enough tx dma buffers
-		 * to accomodate the next tx frame
+		 * to accommodate the next tx frame
 		 */
 		struct tx_holding_buffer *ptx =
 			&info->tx_holding_buffers[info->get_tx_holding_index];
diff -ur a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c	Mon Feb 24 11:05:31 2003
+++ b/drivers/ide/ide-cd.c	Tue Feb 25 17:44:36 2003
@@ -19,7 +19,7 @@
  * ftp://fission.dt.wdc.com/pub/standards/SFF_atapi/spec/SFF8020-r2.6/PS/8020r26.ps
  * ftp://ftp.avc-pioneer.com/Mtfuji4/Spec/Fuji4r10.pdf
  *
- * Drives that deviate from these standards will be accomodated as much
+ * Drives that deviate from these standards will be accommodated as much
  * as possible via compile time or command-line options.  Since I only have
  * a few drives, you generally need to send me patches...
  *
diff -ur a/drivers/isdn/hardware/eicon/dadapter.c b/drivers/isdn/hardware/eicon/dadapter.c
--- a/drivers/isdn/hardware/eicon/dadapter.c	Mon Feb 24 11:05:31 2003
+++ b/drivers/isdn/hardware/eicon/dadapter.c	Tue Feb 25 17:44:38 2003
@@ -327,7 +327,7 @@
    Adapter array will be written to memory described by 'buffer'
    If the last adapter seen in the returned adapter array is
    IDI_DADAPTER or if last adapter in array does have type '0', then
-   it was enougth space in buffer to accomodate all available
+   it was enougth space in buffer to accommodate all available
    adapter descriptors
   *NOTE 1 (debug interface):
    The IDI adapter of type 'IDI_DIMAINT' does register as 'request'
diff -ur a/drivers/isdn/hardware/eicon/istream.c b/drivers/isdn/hardware/eicon/istream.c
--- a/drivers/isdn/hardware/eicon/istream.c	Mon Feb 24 11:05:13 2003
+++ b/drivers/isdn/hardware/eicon/istream.c	Tue Feb 25 17:44:41 2003
@@ -142,7 +142,7 @@
   return 0  if zero packet was received
   return -1 if stream is empty
     return -2 if read buffer does not profide sufficient space
-              to accomodate entire segment
+              to accommodate entire segment
   max_length should be at least 68 bytes
   ------------------------------------------------------------------- */
 int diva_istream_read (void* context,
diff -ur a/drivers/mtd/maps/ceiva.c b/drivers/mtd/maps/ceiva.c
--- a/drivers/mtd/maps/ceiva.c	Mon Feb 24 11:05:15 2003
+++ b/drivers/mtd/maps/ceiva.c	Tue Feb 25 17:44:43 2003
@@ -94,7 +94,7 @@
  *
  * Please note:
  *  1. The flash size given should be the largest flash size that can
- *     be accomodated.
+ *     be accommodated.
  *
  *  2. The bus width must defined in clps_setup_flash.
  *
diff -ur a/drivers/mtd/maps/cstm_mips_ixx.c b/drivers/mtd/maps/cstm_mips_ixx.c
--- a/drivers/mtd/maps/cstm_mips_ixx.c	Mon Feb 24 11:05:11 2003
+++ b/drivers/mtd/maps/cstm_mips_ixx.c	Tue Feb 25 17:44:45 2003
@@ -5,7 +5,7 @@
  * Config with both CFI and JEDEC device support.
  *
  * Basically physmap.c with the addition of partitions and 
- * an array of mapping info to accomodate more than one flash type per board.
+ * an array of mapping info to accommodate more than one flash type per board.
  *
  * Copyright 2000 MontaVista Software Inc.
  *
diff -ur a/drivers/mtd/maps/sa1100-flash.c b/drivers/mtd/maps/sa1100-flash.c
--- a/drivers/mtd/maps/sa1100-flash.c	Mon Feb 24 11:05:13 2003
+++ b/drivers/mtd/maps/sa1100-flash.c	Tue Feb 25 17:44:47 2003
@@ -96,7 +96,7 @@
  *  1. We no longer support static flash mappings via the machine io_desc
  *     structure.
  *  2. The flash size given should be the largest flash size that can
- *     be accomodated.
+ *     be accommodated.
  *
  * The MTD layer will detect flash chip aliasing and reduce the size of
  * the map accordingly.
diff -ur a/drivers/net/irda/actisys-sir.c b/drivers/net/irda/actisys-sir.c
--- a/drivers/net/irda/actisys-sir.c	Mon Feb 24 11:05:34 2003
+++ b/drivers/net/irda/actisys-sir.c	Tue Feb 25 17:44:51 2003
@@ -207,7 +207,7 @@
  *	o second put the dongle in a know state
  *
  *	The dongle is powered of the RTS and DTR lines. In the dongle, there
- * is a big capacitor to accomodate the current spikes. This capacitor
+ * is a big capacitor to accommodate the current spikes. This capacitor
  * takes a least 50 ms to be charged. In theory, the Bios set those lines
  * up, so by the time we arrive here we should be set. It doesn't hurt
  * to be on the conservative side, so we will wait...
diff -ur a/drivers/net/irda/actisys.c b/drivers/net/irda/actisys.c
--- a/drivers/net/irda/actisys.c	Mon Feb 24 11:06:03 2003
+++ b/drivers/net/irda/actisys.c	Tue Feb 25 17:44:49 2003
@@ -217,7 +217,7 @@
  *	o second put the dongle in a know state
  *
  *	The dongle is powered of the RTS and DTR lines. In the dongle, there
- * is a big capacitor to accomodate the current spikes. This capacitor
+ * is a big capacitor to accommodate the current spikes. This capacitor
  * takes a least 50 ms to be charged. In theory, the Bios set those lines
  * up, so by the time we arrive here we should be set. It doesn't hurt
  * to be on the conservative side, so we will wait...
diff -ur a/drivers/net/tokenring/smctr.c b/drivers/net/tokenring/smctr.c
--- a/drivers/net/tokenring/smctr.c	Mon Feb 24 11:05:32 2003
+++ b/drivers/net/tokenring/smctr.c	Tue Feb 25 17:44:53 2003
@@ -5598,7 +5598,7 @@
                 /* if all transmit buffer are cleared
                  * need to set the tx_buff_curr[] to tx_buff_head[]
                  * otherwise, tx buffer will be segregate and cannot
-                 * accomodate and buffer greater than (curr - head) and
+                 * accommodate and buffer greater than (curr - head) and
                  * (end - curr) since we do not allow wrap around allocation.
                  */
                 if(tp->tx_buff_used[queue] == 0)
diff -ur a/drivers/net/wireless/wavelan_cs.h b/drivers/net/wireless/wavelan_cs.h
--- a/drivers/net/wireless/wavelan_cs.h	Mon Feb 24 11:05:35 2003
+++ b/drivers/net/wireless/wavelan_cs.h	Tue Feb 25 17:44:57 2003
@@ -60,7 +60,7 @@
 /* The detection of the wavelan card is made by reading the MAC address
  * from the card and checking it. If you have a non AT&T product (OEM,
  * like DEC RoamAbout, or Digital Ocean, Epson, ...), you must modify this
- * part to accomodate your hardware...
+ * part to accommodate your hardware...
  */
 const unsigned char	MAC_ADDRESSES[][3] =
 {
diff -ur a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
--- a/drivers/parport/parport_pc.c	Mon Feb 24 11:05:47 2003
+++ b/drivers/parport/parport_pc.c	Tue Feb 25 17:44:59 2003
@@ -35,7 +35,7 @@
  * All registers are 8 bits wide and read/write.  If your hardware differs
  * only in register addresses (eg because your registers are on 32-bit
  * word boundaries) then you can alter the constants in parport_pc.h to
- * accomodate this.
+ * accommodate this.
  *
  * Note that the ECP registers may not start at offset 0x400 for PCI cards,
  * but rather will start at port->base_hi.
diff -ur a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
--- a/drivers/sbus/char/envctrl.c	Mon Feb 24 11:05:10 2003
+++ b/drivers/sbus/char/envctrl.c	Tue Feb 25 17:45:01 2003
@@ -1115,7 +1115,7 @@
 		       envctrl_dev.minor);
 	}
 
-	/* Note above traversal routine post-incremented 'i' to accomodate 
+	/* Note above traversal routine post-incremented 'i' to accommodate 
 	 * a next child device, so we decrement before reverse-traversal of
 	 * child devices.
 	 */
diff -ur a/drivers/scsi/aic7xxx/aic79xx.h b/drivers/scsi/aic7xxx/aic79xx.h
--- a/drivers/scsi/aic7xxx/aic79xx.h	Mon Feb 24 11:05:36 2003
+++ b/drivers/scsi/aic7xxx/aic79xx.h	Tue Feb 25 17:45:03 2003
@@ -180,7 +180,7 @@
 
 /*
  * Define the size of our QIN and QOUT FIFOs.  They must be a power of 2
- * in size and accomodate as many transactions as can be queued concurrently.
+ * in size and accommodate as many transactions as can be queued concurrently.
  */
 #define	AHD_QIN_SIZE	AHD_MAX_QUEUE
 #define	AHD_QOUT_SIZE	AHD_MAX_QUEUE
diff -ur a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c	Mon Feb 24 11:05:06 2003
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c	Tue Feb 25 17:45:05 2003
@@ -108,7 +108,7 @@
  * but are not limited to:
  *
  *  1: Import of the latest FreeBSD sequencer code for this driver
- *  2: Modification of kernel code to accomodate different sequencer semantics
+ *  2: Modification of kernel code to accommodate different sequencer semantics
  *  3: Extensive changes throughout kernel portion of driver to improve
  *     abort/reset processing and error hanndling
  *  4: Other work contributed by various people on the Internet
diff -ur a/drivers/scsi/aic7xxx_old.c b/drivers/scsi/aic7xxx_old.c
--- a/drivers/scsi/aic7xxx_old.c	Mon Feb 24 11:05:17 2003
+++ b/drivers/scsi/aic7xxx_old.c	Tue Feb 25 17:45:07 2003
@@ -111,7 +111,7 @@
  * but are not limited to:
  *
  *  1: Import of the latest FreeBSD sequencer code for this driver
- *  2: Modification of kernel code to accomodate different sequencer semantics
+ *  2: Modification of kernel code to accommodate different sequencer semantics
  *  3: Extensive changes throughout kernel portion of driver to improve
  *     abort/reset processing and error hanndling
  *  4: Other work contributed by various people on the Internet
diff -ur a/drivers/scsi/cpqfcTSworker.c b/drivers/scsi/cpqfcTSworker.c
--- a/drivers/scsi/cpqfcTSworker.c	Mon Feb 24 11:05:39 2003
+++ b/drivers/scsi/cpqfcTSworker.c	Tue Feb 25 17:45:09 2003
@@ -79,7 +79,7 @@
 // synchronously (i.e. each of the 30k I/O had to be started one at a
 // time by sending a starting frame via Tachyon's outbound que).  
 
-// To accomodate kernel "module" build, this driver limits the exchanges
+// To accommodate kernel "module" build, this driver limits the exchanges
 // to 256, because of the contiguous physical memory limitation of 128M.
 
 // Typical FC Exchanges are opened presuming the FC frames start without errors,
diff -ur a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
--- a/drivers/scsi/scsi_ioctl.c	Mon Feb 24 11:05:47 2003
+++ b/drivers/scsi/scsi_ioctl.c	Tue Feb 25 17:45:11 2003
@@ -194,7 +194,7 @@
  *      of the given command. There is no way to override this.
  *   -  Data transfers are limited to PAGE_SIZE (4K on i386, 8K on alpha).
  *   -  The length (x + y) must be at least OMAX_SB_LEN bytes long to
- *      accomodate the sense buffer when an error occurs.
+ *      accommodate the sense buffer when an error occurs.
  *      The sense buffer is truncated to OMAX_SB_LEN (16) bytes so that
  *      old code will not be surprised.
  *   -  If a Unix error occurs (e.g. ENOMEM) then the user will receive
diff -ur a/drivers/scsi/st.c b/drivers/scsi/st.c
--- a/drivers/scsi/st.c	Mon Feb 24 11:05:36 2003
+++ b/drivers/scsi/st.c	Tue Feb 25 17:45:13 2003
@@ -2963,7 +2963,7 @@
    set the size of partition 1. There is no size field for the default partition.
    Michael Schaefer's Sony SDT-7000 returns two descriptors and the second is
    used to set the size of partition 1 (this is what the SCSI-3 standard specifies).
-   The following algorithm is used to accomodate both drives: if the number of
+   The following algorithm is used to accommodate both drives: if the number of
    partition size fields is greater than the maximum number of additional partitions
    in the mode page, the second field is used. Otherwise the first field is used.
 
diff -ur a/drivers/serial/sunzilog.c b/drivers/serial/sunzilog.c
--- a/drivers/serial/sunzilog.c	Mon Feb 24 11:06:01 2003
+++ b/drivers/serial/sunzilog.c	Tue Feb 25 17:45:15 2003
@@ -48,7 +48,7 @@
 #include "sunzilog.h"
 
 /* On 32-bit sparcs we need to delay after register accesses
- * to accomodate sun4 systems, but we do not need to flush writes.
+ * to accommodate sun4 systems, but we do not need to flush writes.
  * On 64-bit sparc we only need to flush single writes to ensure
  * completion.
  */
diff -ur a/drivers/usb/host/ehci-sched.c b/drivers/usb/host/ehci-sched.c
--- a/drivers/usb/host/ehci-sched.c	Mon Feb 24 11:05:15 2003
+++ b/drivers/usb/host/ehci-sched.c	Tue Feb 25 17:45:18 2003
@@ -417,7 +417,7 @@
 		if (unlikely (ehci->pshadow [frame].ptr != 0)) {
 
 // FIXME -- just link toward the end, before any qh with a shorter period,
-// AND accomodate it already having been linked here (after some other qh)
+// AND accommodate it already having been linked here (after some other qh)
 // AS WELL AS updating the schedule checking logic
 
 			BUG ();
diff -ur a/drivers/video/macfb.c b/drivers/video/macfb.c
--- a/drivers/video/macfb.c	Mon Feb 24 11:05:08 2003
+++ b/drivers/video/macfb.c	Tue Feb 25 17:45:20 2003
@@ -223,7 +223,7 @@
 	local_irq_save(flags);
 	
 	/* fbdev will set an entire colourmap, but X won't.  Hopefully
-	   this should accomodate both of them */
+	   this should accommodate both of them */
 	if (regno != lastreg+1) {
 		int i;
 		
diff -ur a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	Mon Feb 24 11:05:39 2003
+++ b/fs/ntfs/aops.c	Tue Feb 25 17:45:22 2003
@@ -1087,7 +1087,7 @@
 
 		if (block >= ablock) {
 			// TODO: block is above allocated_size, need to
-			// allocate it. Best done in one go to accomodate not
+			// allocate it. Best done in one go to accommodate not
 			// only block but all above blocks up to and including:
 			// ((page->index << PAGE_CACHE_SHIFT) + to + blocksize
 			// - 1) >> blobksize_bits. Obviously will need to round
diff -ur a/fs/reiserfs/super.c b/fs/reiserfs/super.c
--- a/fs/reiserfs/super.c	Mon Feb 24 11:05:31 2003
+++ b/fs/reiserfs/super.c	Tue Feb 25 17:45:25 2003
@@ -1356,7 +1356,7 @@
   buf->f_bavail  = buf->f_bfree;
   buf->f_blocks  = sb_block_count(rs) - sb_bmap_nr(rs) - 1;
   buf->f_bsize   = s->s_blocksize;
-  /* changed to accomodate gcc folks.*/
+  /* changed to accommodate gcc folks.*/
   buf->f_type    =  REISERFS_SUPER_MAGIC;
   return 0;
 }
diff -ur a/include/asm-i386/sigcontext.h b/include/asm-i386/sigcontext.h
--- a/include/asm-i386/sigcontext.h	Mon Feb 24 11:05:14 2003
+++ b/include/asm-i386/sigcontext.h	Tue Feb 25 17:45:28 2003
@@ -11,7 +11,7 @@
  * Pentium III FXSR, SSE support
  *	Gareth Hughes <gareth@valinux.com>, May 2000
  *
- * The FPU state data structure has had to grow to accomodate the
+ * The FPU state data structure has had to grow to accommodate the
  * extended FPU state required by the Streaming SIMD Extensions.
  * There is no documented standard to accomplish this at the moment.
  */
diff -ur a/include/asm-ia64/sn/klconfig.h b/include/asm-ia64/sn/klconfig.h
--- a/include/asm-ia64/sn/klconfig.h	Mon Feb 24 11:05:14 2003
+++ b/include/asm-ia64/sn/klconfig.h	Tue Feb 25 17:45:30 2003
@@ -273,7 +273,7 @@
  * Each BOARD consists of COMPONENTs and the BOARD structure has 
  * pointers (offsets) to its COMPONENT structure.
  * The COMPONENT structure has version info, size and speed info, revision,
- * error info and the NIC info. This structure can accomodate any
+ * error info and the NIC info. This structure can accommodate any
  * BOARD with arbitrary COMPONENT composition.
  *
  * The ERRORINFO part of each BOARD has error information
diff -ur a/include/asm-mips64/sn/klconfig.h b/include/asm-mips64/sn/klconfig.h
--- a/include/asm-mips64/sn/klconfig.h	Mon Feb 24 11:05:33 2003
+++ b/include/asm-mips64/sn/klconfig.h	Tue Feb 25 17:45:32 2003
@@ -293,7 +293,7 @@
  * Each BOARD consists of COMPONENTs and the BOARD structure has 
  * pointers (offsets) to its COMPONENT structure.
  * The COMPONENT structure has version info, size and speed info, revision,
- * error info and the NIC info. This structure can accomodate any
+ * error info and the NIC info. This structure can accommodate any
  * BOARD with arbitrary COMPONENT composition.
  *
  * The ERRORINFO part of each BOARD has error information
diff -ur a/include/linux/cyclades.h b/include/linux/cyclades.h
--- a/include/linux/cyclades.h	Mon Feb 24 11:06:02 2003
+++ b/include/linux/cyclades.h	Tue Feb 25 17:45:35 2003
@@ -141,7 +141,7 @@
 /****************** ****************** *******************/
 /*
  *	The data types defined below are used in all ZFIRM interface
- *	data structures. They accomodate differences between HW
+ *	data structures. They accommodate differences between HW
  *	architectures and compilers.
  */
 
diff -ur a/include/net/iw_handler.h b/include/net/iw_handler.h
--- a/include/net/iw_handler.h	Mon Feb 24 11:05:10 2003
+++ b/include/net/iw_handler.h	Tue Feb 25 17:45:37 2003
@@ -92,7 +92,7 @@
  * The implementation goals were as follow :
  *	o Obvious : you should not need a PhD to understand what's happening,
  *		the benefit is easier maintainance.
- *	o Flexible : it should accomodate a wide variety of driver
+ *	o Flexible : it should accommodate a wide variety of driver
  *		implementations and be as flexible as the old API.
  *	o Lean : it should be efficient memory wise to minimise the impact
  *		on kernel footprint.
diff -ur a/net/core/netfilter.c b/net/core/netfilter.c
--- a/net/core/netfilter.c	Mon Feb 24 11:05:31 2003
+++ b/net/core/netfilter.c	Tue Feb 25 17:45:39 2003
@@ -606,7 +606,7 @@
 	struct net_device *dev_src = NULL;
 	int err;
 
-	/* accomodate ip_route_output_slow(), which expects the key src to be
+	/* accommodate ip_route_output_slow(), which expects the key src to be
 	   0 or a local address; however some non-standard hacks like
 	   ipt_REJECT.c:send_reset() can cause packets with foreign
            saddr to be appear on the NF_IP_LOCAL_OUT hook -MB */
diff -ur a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
--- a/net/ipv6/ndisc.c	Mon Feb 24 11:05:34 2003
+++ b/net/ipv6/ndisc.c	Tue Feb 25 17:45:41 2003
@@ -208,7 +208,7 @@
 		default:
 			/*
 			 * Unknown options must be silently ignored,
-			 * to accomodate future extension to the protocol.
+			 * to accommodate future extension to the protocol.
 			 */
 			ND_PRINTK2(KERN_WARNING
 				   "ndisc_parse_options(): ignored unsupported option; type=%d, len=%d\n",
diff -ur a/sound/oss/es1371.c b/sound/oss/es1371.c
--- a/sound/oss/es1371.c	Mon Feb 24 11:05:39 2003
+++ b/sound/oss/es1371.c	Tue Feb 25 17:45:44 2003
@@ -73,7 +73,7 @@
  *                       detect the ES1373 and later parts.
  *                       added AC97 #defines for readability
  *                       added a /proc file system for dumping hardware state
- *                       updated SRC and CODEC w/r functions to accomodate bugs
+ *                       updated SRC and CODEC w/r functions to accommodate bugs
  *                       in some versions of the ES137x chips.
  *    31.08.1999   0.17  add spin_lock_init
  *                       replaced current->state = x with set_current_state(x)
diff -ur a/sound/oss/maestro.c b/sound/oss/maestro.c
--- a/sound/oss/maestro.c	Mon Feb 24 11:05:42 2003
+++ b/sound/oss/maestro.c	Tue Feb 25 17:45:51 2003
@@ -1518,7 +1518,7 @@
 				pa = virt_to_bus(buffer);
 			} else {
 				/* right channel records its split half.
-				*2 accomodates for rampant shifting earlier */
+				*2 accommodates for rampant shifting earlier */
 				pa = virt_to_bus(buffer + size*2);
 			}
 
