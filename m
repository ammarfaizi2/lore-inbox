Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265685AbTBYD13>; Mon, 24 Feb 2003 22:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266292AbTBYD13>; Mon, 24 Feb 2003 22:27:29 -0500
Received: from [24.77.48.240] ([24.77.48.240]:28259 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S265685AbTBYD1Z>;
	Mon, 24 Feb 2003 22:27:25 -0500
Date: Mon, 24 Feb 2003 19:37:45 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200302250337.h1P3bjq32719@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Spelling fixes for 2.5.63 - occurrence
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling fixes for 2.5.63:

This patch fixes:
    occurence -> occurrence
    occurences -> occurrences

Fixes 13 occurrences (literally!) in all.

diff -ur 2.5.63a/drivers/char/cyclades.c 2.5.63b/drivers/char/cyclades.c
--- 2.5.63a/drivers/char/cyclades.c	Mon Feb 24 11:05:12 2003
+++ 2.5.63b/drivers/char/cyclades.c	Mon Feb 24 18:22:35 2003
@@ -151,7 +151,7 @@
  * Revision 2.2.1.4  1998/08/04 11:02:50 ivan
  * /proc/cyclades implementation with great collaboration of 
  * Marc Lewis <marc@blarg.net>;
- * cyy_interrupt was changed to avoid occurence of kernel oopses
+ * cyy_interrupt was changed to avoid occurrence of kernel oopses
  * during PPP operation.
  *
  * Revision 2.2.1.3  1998/06/01 12:09:10 ivan
diff -ur 2.5.63a/drivers/char/epca.c 2.5.63b/drivers/char/epca.c
--- 2.5.63a/drivers/char/epca.c	Mon Feb 24 11:05:34 2003
+++ 2.5.63b/drivers/char/epca.c	Mon Feb 24 18:22:37 2003
@@ -3516,7 +3516,7 @@
 /* ------------------------------------------------------------------
 	The below routines pc_throttle and pc_unthrottle are used 
 	to slow (And resume) the receipt of data into the kernels
-	receive buffers.  The exact occurence of this depends on the
+	receive buffers.  The exact occurrence of this depends on the
 	size of the kernels receive buffer and what the 'watermarks'
 	are set to for that buffer.  See the n_ttys.c file for more
 	details. 
diff -ur 2.5.63a/drivers/hotplug/ibmphp_res.c 2.5.63b/drivers/hotplug/ibmphp_res.c
--- 2.5.63a/drivers/hotplug/ibmphp_res.c	Mon Feb 24 11:05:41 2003
+++ 2.5.63b/drivers/hotplug/ibmphp_res.c	Mon Feb 24 18:22:39 2003
@@ -740,7 +740,7 @@
 				res->nextRange = NULL;
 			}
 		} else {
-			/* this is the case where it is 1st occurence of the range */
+			/* this is the case where it is 1st occurrence of the range */
 			if (!res_prev) {
 				/* at the beginning of the resource list */
 				res->next = NULL;
diff -ur 2.5.63a/drivers/isdn/hisax/l3dss1.c 2.5.63b/drivers/isdn/hisax/l3dss1.c
--- 2.5.63a/drivers/isdn/hisax/l3dss1.c	Mon Feb 24 11:05:17 2003
+++ 2.5.63b/drivers/isdn/hisax/l3dss1.c	Mon Feb 24 18:22:41 2003
@@ -1603,7 +1603,7 @@
 	 * Bearer Capabilities
 	 */
 	p = skb->data;
-	/* only the first occurence 'll be detected ! */
+	/* only the first occurrence 'll be detected ! */
 	if ((p = findie(p, skb->len, 0x04, 0))) {
 		if ((p[1] < 2) || (p[1] > 11))
 			err = 1;
diff -ur 2.5.63a/drivers/isdn/hisax/l3ni1.c 2.5.63b/drivers/isdn/hisax/l3ni1.c
--- 2.5.63a/drivers/isdn/hisax/l3ni1.c	Mon Feb 24 11:05:12 2003
+++ 2.5.63b/drivers/isdn/hisax/l3ni1.c	Mon Feb 24 18:22:43 2003
@@ -1456,7 +1456,7 @@
 	 * Bearer Capabilities
 	 */
 	p = skb->data;
-	/* only the first occurence 'll be detected ! */
+	/* only the first occurrence 'll be detected ! */
 	if ((p = findie(p, skb->len, 0x04, 0))) {
 		if ((p[1] < 2) || (p[1] > 11))
 			err = 1;
diff -ur 2.5.63a/drivers/macintosh/via-pmu.c 2.5.63b/drivers/macintosh/via-pmu.c
--- 2.5.63a/drivers/macintosh/via-pmu.c	Mon Feb 24 11:05:43 2003
+++ 2.5.63b/drivers/macintosh/via-pmu.c	Mon Feb 24 18:22:44 2003
@@ -1179,7 +1179,7 @@
 static inline void
 wait_for_ack(void)
 {
-	/* Sightly increased the delay, I had one occurence of the message
+	/* Sightly increased the delay, I had one occurrence of the message
 	 * reported
 	 */
 	int timeout = 4000;
diff -ur 2.5.63a/drivers/net/skfp/h/smc.h 2.5.63b/drivers/net/skfp/h/smc.h
--- 2.5.63a/drivers/net/skfp/h/smc.h	Mon Feb 24 11:05:10 2003
+++ 2.5.63b/drivers/net/skfp/h/smc.h	Mon Feb 24 18:22:46 2003
@@ -320,7 +320,7 @@
 	u_char	evc_rep_required ;		/* report required */
 	u_short	evc_para ;			/* SMT Para Number */
 	u_char	*evc_cond_state ;		/* condition state */
-	u_char	*evc_multiple ;			/* multiple occurence */
+	u_char	*evc_multiple ;			/* multiple occurrence */
 } ;
 
 /*
diff -ur 2.5.63a/drivers/net/wan/sdla_fr.c 2.5.63b/drivers/net/wan/sdla_fr.c
--- 2.5.63a/drivers/net/wan/sdla_fr.c	Mon Feb 24 11:06:01 2003
+++ 2.5.63b/drivers/net/wan/sdla_fr.c	Mon Feb 24 18:22:48 2003
@@ -1726,7 +1726,7 @@
 
 
 /*============================================================================
- * Setup so that a frame can be transmitted on the occurence of a transmit
+ * Setup so that a frame can be transmitted on the occurrence of a transmit
  * interrupt.
  */
 static int setup_for_delayed_transmit (netdevice_t* dev, struct sk_buff *skb)
diff -ur 2.5.63a/drivers/net/wan/sdla_x25.c 2.5.63b/drivers/net/wan/sdla_x25.c
--- 2.5.63a/drivers/net/wan/sdla_x25.c	Mon Feb 24 11:05:38 2003
+++ 2.5.63b/drivers/net/wan/sdla_x25.c	Mon Feb 24 18:22:50 2003
@@ -1598,7 +1598,7 @@
 }
 
 /*============================================================================
- * Setup so that a frame can be transmitted on the occurence of a transmit
+ * Setup so that a frame can be transmitted on the occurrence of a transmit
  * interrupt.
  *===========================================================================*/
 
diff -ur 2.5.63a/drivers/scsi/cpqfcTScontrol.c 2.5.63b/drivers/scsi/cpqfcTScontrol.c
--- 2.5.63a/drivers/scsi/cpqfcTScontrol.c	Mon Feb 24 11:05:06 2003
+++ 2.5.63b/drivers/scsi/cpqfcTScontrol.c	Mon Feb 24 18:22:52 2003
@@ -586,7 +586,7 @@
 
 
 
-// This "look ahead" function examines the IMQ for occurence of
+// This "look ahead" function examines the IMQ for occurrence of
 // "type".  Returns 1 if found, 0 if not.
 static int PeekIMQEntry( PTACHYON fcChip, ULONG type)
 {
diff -ur 2.5.63a/fs/jbd/revoke.c 2.5.63b/fs/jbd/revoke.c
--- 2.5.63a/fs/jbd/revoke.c	Mon Feb 24 11:05:07 2003
+++ 2.5.63b/fs/jbd/revoke.c	Mon Feb 24 18:22:54 2003
@@ -577,7 +577,7 @@
 	
 	record = find_revoke_record(journal, blocknr);
 	if (record) {
-		/* If we have multiple occurences, only record the
+		/* If we have multiple occurrences, only record the
 		 * latest sequence number in the hashed record */
 		if (tid_gt(sequence, record->sequence))
 			record->sequence = sequence;
diff -ur 2.5.63a/fs/seq_file.c 2.5.63b/fs/seq_file.c
--- 2.5.63a/fs/seq_file.c	Mon Feb 24 11:05:38 2003
+++ 2.5.63b/fs/seq_file.c	Mon Feb 24 18:22:56 2003
@@ -250,7 +250,7 @@
  *	@s:	string
  *	@esc:	set of characters that need escaping
  *
- *	Puts string into buffer, replacing each occurence of character from
+ *	Puts string into buffer, replacing each occurrence of character from
  *	@esc with usual octal escape.  Returns 0 in case of success, -1 - in
  *	case of overflow.
  */
diff -ur 2.5.63a/fs/xfs/xfs_dquot.c 2.5.63b/fs/xfs/xfs_dquot.c
--- 2.5.63a/fs/xfs/xfs_dquot.c	Mon Feb 24 11:05:31 2003
+++ 2.5.63b/fs/xfs/xfs_dquot.c	Mon Feb 24 18:22:58 2003
@@ -1449,7 +1449,7 @@
 		xfs_dqtrace_entry(dqp, "DQPURGE ->DQFLUSH: DQDIRTY");
 		/* dqflush unlocks dqflock */
 		/*
-		 * Given that dqpurge is a very rare occurence, it is OK
+		 * Given that dqpurge is a very rare occurrence, it is OK
 		 * that we're holding the hashlist and mplist locks
 		 * across the disk write. But, ... XXXsup
 		 *
