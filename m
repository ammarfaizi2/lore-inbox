Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268514AbTBSDKW>; Tue, 18 Feb 2003 22:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268400AbTBSDJ1>; Tue, 18 Feb 2003 22:09:27 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:57864 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S268401AbTBSC54>; Tue, 18 Feb 2003 21:57:56 -0500
Subject: [PATCH] 2.5.62 various spelling fixes in 19 files.
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 18 Feb 2003 19:59:20 -0700
Message-Id: <1045623562.10680.305.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides the following spelling fixes.

posible  -> possible
messsage -> message
reqeuest -> request
exeption -> exception
seqeunce -> sequence
loggger  -> logger
resposible -> responsible
qeueu    -> queue
microsecnds -> microseconds
positiion -> position
feilds    -> fields


 Documentation/vm/hugetlbpage.txt       |    2 +-
 arch/arm/mm/alignment.c                |    2 +-
 arch/ia64/sn/io/l1.c                   |    2 +-
 arch/um/include/sysdep-i386/checksum.h |    2 +-
 drivers/acorn/block/fd1772.c           |    2 +-
 drivers/acpi/namespace/nsxfobj.c       |    2 +-
 drivers/char/genrtc.c                  |    2 +-
 drivers/isdn/eicon/divalog.h           |    2 +-
 drivers/message/fusion/lsi/mpi_raid.h  |    2 +-
 drivers/net/e1000/e1000_main.c         |    2 +-
 drivers/net/sk98lin/skgeinit.c         |    2 +-
 drivers/s390/block/dasd.c              |    2 +-
 drivers/video/fm2fb.c                  |    2 +-
 drivers/video/q40fb.c                  |    2 +-
 fs/ntfs/mst.c                          |    2 +-
 net/ipv4/ipconfig.c                    |    2 +-
 net/sched/sch_atm.c                    |    2 +-
 net/sunrpc/svcauth.c                   |    2 +-
 sound/pci/via82xx.c                    |    2 +-
 19 files changed, 19 insertions(+), 19 deletions(-)

diff -ur linux-2.5.62-1104-orig/Documentation/vm/hugetlbpage.txt linux-2.5.62-1104/Documentation/vm/hugetlbpage.txt
--- linux-2.5.62-1104-orig/Documentation/vm/hugetlbpage.txt	Thu Jan 16 19:21:39 2003
+++ linux-2.5.62-1104/Documentation/vm/hugetlbpage.txt	Tue Feb 18 18:38:27 2003
@@ -66,7 +66,7 @@
 
 /proc/sys/vm_nr_hugepages indicates the current number of configured hugetlb
 pages in the kernel.  Super user privileges are required for modification of
-this value.  The allocation of hugetlb pages is posible only if there are
+this value.  The allocation of hugetlb pages is possible only if there are
 enough physically contiguous free pages in system OR if there are enough
 hugetlb pages free that can be transfered back to regular memory pool.
 
diff -ur linux-2.5.62-1104-orig/arch/arm/mm/alignment.c linux-2.5.62-1104/arch/arm/mm/alignment.c
--- linux-2.5.62-1104-orig/arch/arm/mm/alignment.c	Thu Jan 16 19:21:40 2003
+++ linux-2.5.62-1104/arch/arm/mm/alignment.c	Tue Feb 18 18:38:27 2003
@@ -400,7 +400,7 @@
 	 * For alignment faults on the ARM922T/ARM920T the MMU  makes
 	 * the FSR (and hence addr) equal to the updated base address
 	 * of the multiple access rather than the restored value.
-	 * Switch this messsage off if we've got a ARM92[02], otherwise
+	 * Switch this message off if we've got a ARM92[02], otherwise
 	 * [ls]dm alignment faults are noisy!
 	 */
 #if !(defined CONFIG_CPU_ARM922T)  && !(defined CONFIG_CPU_ARM920T)
diff -ur linux-2.5.62-1104-orig/arch/ia64/sn/io/l1.c linux-2.5.62-1104/arch/ia64/sn/io/l1.c
--- linux-2.5.62-1104-orig/arch/ia64/sn/io/l1.c	Thu Jan 16 19:22:44 2003
+++ linux-2.5.62-1104/arch/ia64/sn/io/l1.c	Tue Feb 18 18:38:27 2003
@@ -2734,7 +2734,7 @@
  * bigger.
  *
  * Be careful using the same buffer for both cmd and resp; it could get
- * hairy if there were ever an L1 command reqeuest that spanned multiple
+ * hairy if there were ever an L1 command request that spanned multiple
  * packets.  (On the other hand, that would require some additional
  * rewriting of the L1 command interface anyway.)
  */
diff -ur linux-2.5.62-1104-orig/arch/um/include/sysdep-i386/checksum.h linux-2.5.62-1104/arch/um/include/sysdep-i386/checksum.h
--- linux-2.5.62-1104-orig/arch/um/include/sysdep-i386/checksum.h	Thu Jan 16 19:21:39 2003
+++ linux-2.5.62-1104/arch/um/include/sysdep-i386/checksum.h	Tue Feb 18 18:38:27 2003
@@ -60,7 +60,7 @@
 
 /*
  * These are the old (and unsafe) way of doing checksums, a warning message 
- * will be printed if they are used and an exeption occurs.
+ * will be printed if they are used and an exception occurs.
  *
  * these functions should go away after some time.
  */
diff -ur linux-2.5.62-1104-orig/drivers/acorn/block/fd1772.c linux-2.5.62-1104/drivers/acorn/block/fd1772.c
--- linux-2.5.62-1104-orig/drivers/acorn/block/fd1772.c	Mon Feb 17 17:36:00 2003
+++ linux-2.5.62-1104/drivers/acorn/block/fd1772.c	Tue Feb 18 18:38:27 2003
@@ -99,7 +99,7 @@
  *                Removed the busy wait loop in do_fd_request and replaced
  *                by a routine on tq_immediate; only 11% cpu on a dd off the
  *                raw disc - but the speed is the same.
- *	1/ 9/96 - Idea (failed!) - set the 'disable spin-up seqeunce'
+ *	1/ 9/96 - Idea (failed!) - set the 'disable spin-up sequence'
  *		  when we read the track if we know the motor is on; didn't
  *		  help - perhaps we have to do it in stepping as well.
  *		  Nope. Still doesn't help.
diff -ur linux-2.5.62-1104-orig/drivers/acpi/namespace/nsxfobj.c linux-2.5.62-1104/drivers/acpi/namespace/nsxfobj.c
--- linux-2.5.62-1104-orig/drivers/acpi/namespace/nsxfobj.c	Fri Feb 14 20:11:50 2003
+++ linux-2.5.62-1104/drivers/acpi/namespace/nsxfobj.c	Tue Feb 18 18:38:27 2003
@@ -140,7 +140,7 @@
 	*ret_handle =
 		acpi_ns_convert_entry_to_handle (acpi_ns_get_parent_node (node));
 
-	/* Return exeption if parent is null */
+	/* Return exception if parent is null */
 
 	if (!acpi_ns_get_parent_node (node)) {
 		status = AE_NULL_ENTRY;
diff -ur linux-2.5.62-1104-orig/drivers/char/genrtc.c linux-2.5.62-1104/drivers/char/genrtc.c
--- linux-2.5.62-1104-orig/drivers/char/genrtc.c	Thu Jan 16 19:22:43 2003
+++ linux-2.5.62-1104/drivers/char/genrtc.c	Tue Feb 18 18:38:27 2003
@@ -97,7 +97,7 @@
 static spinlock_t gen_rtc_lock = SPIN_LOCK_UNLOCKED;
 
 /*
- * Routine to poll RTC seconds field for change as often as posible,
+ * Routine to poll RTC seconds field for change as often as possible,
  * after first RTC_UIE use timer to reduce polling
  */
 void genrtc_troutine(void *data)
diff -ur linux-2.5.62-1104-orig/drivers/isdn/eicon/divalog.h linux-2.5.62-1104/drivers/isdn/eicon/divalog.h
--- linux-2.5.62-1104-orig/drivers/isdn/eicon/divalog.h	Thu Jan 16 19:22:55 2003
+++ linux-2.5.62-1104/drivers/isdn/eicon/divalog.h	Tue Feb 18 18:38:27 2003
@@ -1,5 +1,5 @@
 /*
- * Include file for defining the kernel loggger messages
+ * Include file for defining the kernel logger messages
  * These definitions are shared between the klog driver and the
  * klogd daemon process
  *
diff -ur linux-2.5.62-1104-orig/drivers/message/fusion/lsi/mpi_raid.h linux-2.5.62-1104/drivers/message/fusion/lsi/mpi_raid.h
--- linux-2.5.62-1104-orig/drivers/message/fusion/lsi/mpi_raid.h	Thu Jan 16 19:22:09 2003
+++ linux-2.5.62-1104/drivers/message/fusion/lsi/mpi_raid.h	Tue Feb 18 18:38:27 2003
@@ -184,7 +184,7 @@
 

 /****************************************************************************/
-/* Mailbox reqeust structure */
+/* Mailbox request structure */
 /****************************************************************************/
 
 typedef struct _MSG_MAILBOX_REQUEST
diff -ur linux-2.5.62-1104-orig/drivers/net/e1000/e1000_main.c linux-2.5.62-1104/drivers/net/e1000/e1000_main.c
--- linux-2.5.62-1104-orig/drivers/net/e1000/e1000_main.c	Mon Feb 10 12:23:00 2003
+++ linux-2.5.62-1104/drivers/net/e1000/e1000_main.c	Tue Feb 18 18:38:27 2003
@@ -1150,7 +1150,7 @@
  *
  * The set_multi entry point is called whenever the multicast address
  * list or the network interface flags are updated.  This routine is
- * resposible for configuring the hardware for proper multicast,
+ * responsible for configuring the hardware for proper multicast,
  * promiscuous mode, and all-multi behavior.
  **/
 
diff -ur linux-2.5.62-1104-orig/drivers/net/sk98lin/skgeinit.c linux-2.5.62-1104/drivers/net/sk98lin/skgeinit.c
--- linux-2.5.62-1104-orig/drivers/net/sk98lin/skgeinit.c	Mon Feb 10 12:23:00 2003
+++ linux-2.5.62-1104/drivers/net/sk98lin/skgeinit.c	Tue Feb 18 18:38:27 2003
@@ -181,7 +181,7 @@
  *
  *	Revision 1.21  1998/10/20 12:11:56  malthoff
  *	Don't dendy the Queue config if the size of the unused
- *	rx qeueu is zero.
+ *	rx queue is zero.
  *
  *	Revision 1.20  1998/10/19 07:27:58  malthoff
  *	SkGeInitRamIface() is public to be called by diagnostics.
diff -ur linux-2.5.62-1104-orig/drivers/s390/block/dasd.c linux-2.5.62-1104/drivers/s390/block/dasd.c
--- linux-2.5.62-1104-orig/drivers/s390/block/dasd.c	Thu Jan 16 19:22:06 2003
+++ linux-2.5.62-1104/drivers/s390/block/dasd.c	Tue Feb 18 18:38:27 2003
@@ -555,7 +555,7 @@
 dasd_profile_end(dasd_device_t *device, dasd_ccw_req_t * cqr,
 		 struct request *req)
 {
-	long strtime, irqtime, endtime, tottime;	/* in microsecnds */
+	long strtime, irqtime, endtime, tottime;	/* in microseconds */
 	long tottimeps, sectors;
 
 	if (dasd_profile_level != DASD_PROFILE_ON)
diff -ur linux-2.5.62-1104-orig/drivers/video/fm2fb.c linux-2.5.62-1104/drivers/video/fm2fb.c
--- linux-2.5.62-1104-orig/drivers/video/fm2fb.c	Thu Jan 16 19:22:03 2003
+++ linux-2.5.62-1104/drivers/video/fm2fb.c	Tue Feb 18 18:38:27 2003
@@ -267,7 +267,7 @@
 		fb_info.fix = fb_fix;
 		fb_info.flags = FBINFO_FLAG_DEFAULT;
 
-		/* The below feilds will go away !!!! */
+		/* The below fields will go away !!!! */
 		fb_alloc_cmap(&fb_info.cmap, 16, 0);
 
 		if (register_framebuffer(&fb_info) < 0)
diff -ur linux-2.5.62-1104-orig/drivers/video/q40fb.c linux-2.5.62-1104/drivers/video/q40fb.c
--- linux-2.5.62-1104-orig/drivers/video/q40fb.c	Thu Jan 16 19:21:48 2003
+++ linux-2.5.62-1104/drivers/video/q40fb.c	Tue Feb 18 18:38:27 2003
@@ -111,7 +111,7 @@
 	fb_info.pseudo_palette = pseudo_palette;	
    	fb_info.screen_base = (char *) q40fb_fix.smem_start;
 
-	/* The below feilds will go away !!!! */
+	/* The below fields will go away !!!! */
 	fb_alloc_cmap(&fb_info.cmap, 16, 0);
 
 	master_outb(3, DISPLAY_CONTROL_REG);
diff -ur linux-2.5.62-1104-orig/fs/ntfs/mst.c linux-2.5.62-1104/fs/ntfs/mst.c
--- linux-2.5.62-1104-orig/fs/ntfs/mst.c	Thu Jan 16 19:22:18 2003
+++ linux-2.5.62-1104/fs/ntfs/mst.c	Tue Feb 18 18:38:27 2003
@@ -114,7 +114,7 @@
  * mean that the structure is not subject to protection and hence doesn't need
  * to be fixed up. This means that you have to create a valid update sequence
  * array header in the ntfs record before calling this function, otherwise it
- * will fail (the header needs to contain the position of the update seqeuence
+ * will fail (the header needs to contain the position of the update sequence
  * array together with the number of elements in the array). You also need to
  * initialise the update sequence number before calling this function
  * otherwise a random word will be used (whatever was in the record at that
diff -ur linux-2.5.62-1104-orig/net/ipv4/ipconfig.c linux-2.5.62-1104/net/ipv4/ipconfig.c
--- linux-2.5.62-1104-orig/net/ipv4/ipconfig.c	Thu Jan 16 19:21:37 2003
+++ linux-2.5.62-1104/net/ipv4/ipconfig.c	Tue Feb 18 18:38:27 2003
@@ -603,7 +603,7 @@
 	*e++ = 3;		/* Default gateway request */
 	*e++ = 4;
 	e += 4;
-	*e++ = 5;		/* Name server reqeust */
+	*e++ = 5;		/* Name server request */
 	*e++ = 8;
 	e += 8;
 	*e++ = 12;		/* Host name request */
diff -ur linux-2.5.62-1104-orig/net/sched/sch_atm.c linux-2.5.62-1104/net/sched/sch_atm.c
--- linux-2.5.62-1104-orig/net/sched/sch_atm.c	Thu Jan 16 19:22:07 2003
+++ linux-2.5.62-1104/net/sched/sch_atm.c	Tue Feb 18 18:38:27 2003
@@ -492,7 +492,7 @@
 				(void) flow->q->ops->requeue(skb,flow->q);
 				break;
 			}
-			D2PRINTK("atm_tc_deqeueue: sending on class %p\n",flow);
+			D2PRINTK("atm_tc_dequeue: sending on class %p\n",flow);
 			/* remove any LL header somebody else has attached */
 			skb_pull(skb,(char *) skb->nh.iph-(char *) skb->data);
 			if (skb_headroom(skb) < flow->hdr_len) {
diff -ur linux-2.5.62-1104-orig/net/sunrpc/svcauth.c linux-2.5.62-1104/net/sunrpc/svcauth.c
--- linux-2.5.62-1104-orig/net/sunrpc/svcauth.c	Thu Jan 16 19:22:27 2003
+++ linux-2.5.62-1104/net/sunrpc/svcauth.c	Tue Feb 18 18:38:27 2003
@@ -52,7 +52,7 @@
 	return aops->accept(rqstp, authp);
 }
 
-/* A reqeust, which was authenticated, has now executed.
+/* A request, which was authenticated, has now executed.
  * Time to finalise the the credentials and verifier
  * and release and resources
  */
diff -ur linux-2.5.62-1104-orig/sound/pci/via82xx.c linux-2.5.62-1104/sound/pci/via82xx.c
--- linux-2.5.62-1104-orig/sound/pci/via82xx.c	Mon Feb 17 17:36:05 2003
+++ linux-2.5.62-1104/sound/pci/via82xx.c	Tue Feb 18 18:38:27 2003
@@ -683,7 +683,7 @@
 			}
 		}
 	}
-	viadev->lastpos = res; /* remember the last positiion */
+	viadev->lastpos = res; /* remember the last position */
 	if (res >= viadev->bufsize)
 		res -= viadev->bufsize;
 	return res;



