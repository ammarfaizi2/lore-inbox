Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265095AbTBTCBf>; Wed, 19 Feb 2003 21:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265094AbTBTCBS>; Wed, 19 Feb 2003 21:01:18 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:62725 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S265095AbTBTB7l>; Wed, 19 Feb 2003 20:59:41 -0500
Subject: [PATCH] Spelling fixes for whic -> which and others in 13 files.
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 19 Feb 2003 19:01:03 -0700
Message-Id: <1045706464.5611.502.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides spelling fixes for the following:

shold      -> should
Docement   -> Document
docomented -> documented
whic       -> which
thresold   -> threshold
asociation -> association

 arch/mips/ddb5xxx/common/pci.c     |    2 +-
 arch/mips/kernel/pci.c             |    2 +-
 drivers/net/sk98lin/h/xmac_ii.h    |    2 +-
 drivers/net/sk98lin/skcsum.c       |    2 +-
 drivers/net/wan/dlci.c             |    2 +-
 fs/reiserfs/journal.c              |    2 +-
 include/asm-mips/ddb5xxx/ddb5xxx.h |    2 +-
 include/net/irda/irda_device.h     |    2 +-
 mm/swap.c                          |    2 +-
 net/sctp/primitive.c               |    2 +-
 net/sctp/sm_statefuns.c            |    2 +-
 net/wanrouter/af_wanpipe.c         |    2 +-
 sound/oss/rme96xx.c                |    2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff -ur linux-2.5-current/arch/mips/ddb5xxx/common/pci.c linux/arch/mips/ddb5xxx/common/pci.c
--- linux-2.5-current/arch/mips/ddb5xxx/common/pci.c	Wed Feb 19 07:35:21 2003
+++ linux/arch/mips/ddb5xxx/common/pci.c	Wed Feb 19 09:26:30 2003
@@ -20,7 +20,7 @@
  * Strategies:
  *
  * . We rely on pci_auto.c file to assign PCI resources (MEM and IO)
- *   TODO: this shold be optional for some machines where they do have
+ *   TODO: this should be optional for some machines where they do have
  *   a real "pcibios" that does resource assignment.
  *
  * . We then use pci_scan_bus() to "discover" all the resources for
diff -ur linux-2.5-current/arch/mips/kernel/pci.c linux/arch/mips/kernel/pci.c
--- linux-2.5-current/arch/mips/kernel/pci.c	Wed Feb 19 07:35:06 2003
+++ linux/arch/mips/kernel/pci.c	Wed Feb 19 09:26:15 2003
@@ -19,7 +19,7 @@
  * Strategies:
  *
  * . We rely on pci_auto.c file to assign PCI resources (MEM and IO)
- *   TODO: this shold be optional for some machines where they do have
+ *   TODO: this should be optional for some machines where they do have
  *   a real "pcibios" that does resource assignment.
  *
  * . We then use pci_scan_bus() to "discover" all the resources for
diff -ur linux-2.5-current/drivers/net/sk98lin/h/xmac_ii.h linux/drivers/net/sk98lin/h/xmac_ii.h
--- linux-2.5-current/drivers/net/sk98lin/h/xmac_ii.h	Wed Feb 19 07:35:16 2003
+++ linux/drivers/net/sk98lin/h/xmac_ii.h	Wed Feb 19 09:22:32 2003
@@ -279,7 +279,7 @@
  * XMAC Bit Definitions
  *
  * If the bit access behaviour differs from the register access behaviour
- * (r/w, ro) this is docomented after the bit number. The following bit
+ * (r/w, ro) this is documented after the bit number. The following bit
  * access behaviours are used:
  *	(sc)	self clearing
  *	(ro)	read only
diff -ur linux-2.5-current/drivers/net/sk98lin/skcsum.c linux/drivers/net/sk98lin/skcsum.c
--- linux-2.5-current/drivers/net/sk98lin/skcsum.c	Wed Feb 19 07:34:40 2003
+++ linux/drivers/net/sk98lin/skcsum.c	Wed Feb 19 09:31:46 2003
@@ -195,7 +195,7 @@
  *	zero.)
  *
  * Note:
- *	There is a bug in the ASIC whic may lead to wrong checksums.
+ *	There is a bug in the ASIC which may lead to wrong checksums.
  *
  * Arguments:
  *	pAc - A pointer to the adapter context struct.
diff -ur linux-2.5-current/drivers/net/wan/dlci.c linux/drivers/net/wan/dlci.c
--- linux-2.5-current/drivers/net/wan/dlci.c	Wed Feb 19 07:35:00 2003
+++ linux/drivers/net/wan/dlci.c	Wed Feb 19 09:31:46 2003
@@ -14,7 +14,7 @@
  *		0.15	Mike Mclagan	Packet freeing, bug in kmalloc call
  *					DLCI_RET handling
  *		0.20	Mike McLagan	More conservative on which packets
- *					are returned for retry and whic are
+ *					are returned for retry and which are
  *					are dropped.  If DLCI_RET_DROP is
  *					returned from the FRAD, the packet is
  *				 	sent back to Linux for re-transmission
diff -ur linux-2.5-current/fs/reiserfs/journal.c linux/fs/reiserfs/journal.c
--- linux-2.5-current/fs/reiserfs/journal.c	Wed Feb 19 07:35:02 2003
+++ linux/fs/reiserfs/journal.c	Wed Feb 19 09:31:46 2003
@@ -1629,7 +1629,7 @@
 /*
 ** read and replay the log
 ** on a clean unmount, the journal header's next unflushed pointer will be to an invalid
-** transaction.  This tests that before finding all the transactions in the log, whic makes normal mount times fast.
+** transaction.  This tests that before finding all the transactions in the log, which makes normal mount times fast.
 **
 ** After a crash, this starts with the next unflushed transaction, and replays until it finds one too old, or invalid.
 **
diff -ur linux-2.5-current/include/asm-mips/ddb5xxx/ddb5xxx.h linux/include/asm-mips/ddb5xxx/ddb5xxx.h
--- linux-2.5-current/include/asm-mips/ddb5xxx/ddb5xxx.h	Wed Feb 19 07:35:01 2003
+++ linux/include/asm-mips/ddb5xxx/ddb5xxx.h	Wed Feb 19 09:23:11 2003
@@ -34,7 +34,7 @@
  * that are true for all DDB 5xxx boards.  The modification is based on
  *
  *	uPD31577(VRC5477) VR5432-SDRAM/PCI Bridge (Luke)
- *	Preliminary Specification Decoment, Rev 1.1, 27 Dec, 2000
+ *	Preliminary Specification Document, Rev 1.1, 27 Dec, 2000
  *  
  */
 
diff -ur linux-2.5-current/include/net/irda/irda_device.h linux/include/net/irda/irda_device.h
--- linux-2.5-current/include/net/irda/irda_device.h	Wed Feb 19 07:35:23 2003
+++ linux/include/net/irda/irda_device.h	Wed Feb 19 09:28:39 2003
@@ -195,7 +195,7 @@
 
 /* The SIR unwrapper async_unwrap_char() will use a Rx-copy-break mechanism
  * when using the optional ZeroCopy Rx, where only small frames are memcpy
- * to a smaller skb to save memory. This is the thresold under which copy
+ * to a smaller skb to save memory. This is the threshold under which copy
  * will happen (and over which it won't happen).
  * Some FIR drivers may use this #define as well...
  * This is the same value as various Ethernet drivers. - Jean II */
diff -ur linux-2.5-current/mm/swap.c linux/mm/swap.c
--- linux-2.5-current/mm/swap.c	Wed Feb 19 07:34:55 2003
+++ linux/mm/swap.c	Wed Feb 19 09:31:46 2003
@@ -27,7 +27,7 @@
 int page_cluster;
 
 /*
- * Writeback is about to end against a page whic has been marked for immediate
+ * Writeback is about to end against a page which has been marked for immediate
  * reclaim.  If it still appears to be reclaimable, move it to the tail of the
  * inactive list.  The page still has PageWriteback set, which will pin it.
  *
diff -ur linux-2.5-current/net/sctp/primitive.c linux/net/sctp/primitive.c
--- linux-2.5-current/net/sctp/primitive.c	Wed Feb 19 07:35:22 2003
+++ linux/net/sctp/primitive.c	Wed Feb 19 09:24:22 2003
@@ -199,7 +199,7 @@
  * o association id - local handle to the SCTP association
  *
  * o destination transport address - the transport address of the
- *   asociation on which a heartbeat should be issued.
+ *   association on which a heartbeat should be issued.
  */
 
 DECLARE_PRIMITIVE(REQUESTHEARTBEAT);
diff -ur linux-2.5-current/net/sctp/sm_statefuns.c linux/net/sctp/sm_statefuns.c
--- linux-2.5-current/net/sctp/sm_statefuns.c	Wed Feb 19 07:34:41 2003
+++ linux/net/sctp/sm_statefuns.c	Wed Feb 19 09:24:13 2003
@@ -3734,7 +3734,7 @@
  * o association id - local handle to the SCTP association
  *
  * o destination transport address - the transport address of the
- *   asociation on which a heartbeat should be issued.
+ *   association on which a heartbeat should be issued.
  */
 sctp_disposition_t sctp_sf_do_prm_requestheartbeat(
 					const sctp_endpoint_t *ep,
diff -ur linux-2.5-current/net/wanrouter/af_wanpipe.c linux/net/wanrouter/af_wanpipe.c
--- linux-2.5-current/net/wanrouter/af_wanpipe.c	Wed Feb 19 07:35:21 2003
+++ linux/net/wanrouter/af_wanpipe.c	Wed Feb 19 09:31:46 2003
@@ -388,7 +388,7 @@
 
 	/* Register the lcn on which incoming call came
          * from. Thus, if we have to clear it, we know
-         * whic lcn to clear 
+         * which lcn to clear
 	 */ 
 
 	newwp->lcn = mbox_ptr->cmd.lcn;
diff -ur linux-2.5-current/sound/oss/rme96xx.c linux/sound/oss/rme96xx.c
--- linux-2.5-current/sound/oss/rme96xx.c	Wed Feb 19 07:34:53 2003
+++ linux/sound/oss/rme96xx.c	Wed Feb 19 09:26:46 2003
@@ -1332,7 +1332,7 @@
                 file->f_flags |= O_NONBLOCK;
                 return 0;
 
-        case SNDCTL_DSP_GETODELAY: /* What shold this exactly do ? , 
+        case SNDCTL_DSP_GETODELAY: /* What should this exactly do ? ,
 				      ATM it is just abinfo.bytes */
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;

