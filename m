Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbTBYD1g>; Mon, 24 Feb 2003 22:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266320AbTBYD1g>; Mon, 24 Feb 2003 22:27:36 -0500
Received: from [24.77.48.240] ([24.77.48.240]:28515 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S265446AbTBYD1Z>;
	Mon, 24 Feb 2003 22:27:25 -0500
Date: Mon, 24 Feb 2003 19:37:45 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200302250337.h1P3bjv32728@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Spelling fixes for 2.5.63 - receive
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling fixes for 2.5.63:

This patch fixes:
    recieve -> receive
    recieved -> received
    reciever -> receiver

Fixes 14 occurrences in all.

diff -ur 2.5.63a/arch/i386/mach-voyager/voyager_smp.c 2.5.63b/arch/i386/mach-voyager/voyager_smp.c
--- 2.5.63a/arch/i386/mach-voyager/voyager_smp.c	Mon Feb 24 11:05:16 2003
+++ 2.5.63b/arch/i386/mach-voyager/voyager_smp.c	Mon Feb 24 18:25:02 2003
@@ -1453,7 +1453,7 @@
 }
 
 /* send a CPI at level cpi to a set of cpus in cpuset (set 1 bit per
- * processor to recieve CPI */
+ * processor to receive CPI */
 static void
 send_CPI(__u32 cpuset, __u8 cpi)
 {
diff -ur 2.5.63a/arch/ppc/4xx_io/serial_sicc.c 2.5.63b/arch/ppc/4xx_io/serial_sicc.c
--- 2.5.63a/arch/ppc/4xx_io/serial_sicc.c	Mon Feb 24 11:05:05 2003
+++ 2.5.63b/arch/ppc/4xx_io/serial_sicc.c	Mon Feb 24 18:25:04 2003
@@ -139,7 +139,7 @@
 #define _LSR_RX_ERR    (_LSR_LB_BREAK | _LSR_FE_MASK | _LSR_OE_MASK | \
 			 _LSR_PE_MASK )
 
-/* serial port reciever command register */
+/* serial port receiver command register */
 
 #define _RCR_ER_MASK   0x80           /* enable receiver mask */
 #define _RCR_DME_MASK  0x60           /* dma mode */
diff -ur 2.5.63a/arch/ppc/8xx_io/cs4218_tdm.c 2.5.63b/arch/ppc/8xx_io/cs4218_tdm.c
--- 2.5.63a/arch/ppc/8xx_io/cs4218_tdm.c	Mon Feb 24 11:05:06 2003
+++ 2.5.63b/arch/ppc/8xx_io/cs4218_tdm.c	Mon Feb 24 18:25:05 2003
@@ -2495,7 +2495,7 @@
 	cp->cp_simode &= ~0x00000fff;
 
 	/* Enable common receive/transmit clock pins, use IDL format.
-	 * Sync on falling edge, transmit rising clock, recieve falling
+	 * Sync on falling edge, transmit rising clock, receive falling
 	 * clock, delay 1 bit on both Tx and Rx.  Common Tx/Rx clocks and
 	 * sync.
 	 * Connect SMC2 to TSA.
diff -ur 2.5.63a/arch/ppc/platforms/4xx/ibmstbx25.h 2.5.63b/arch/ppc/platforms/4xx/ibmstbx25.h
--- 2.5.63a/arch/ppc/platforms/4xx/ibmstbx25.h	Mon Feb 24 11:05:15 2003
+++ 2.5.63b/arch/ppc/platforms/4xx/ibmstbx25.h	Mon Feb 24 18:25:07 2003
@@ -164,7 +164,7 @@
 #define IBM_CPM_CPU	0x10000000	/* PPC405B3 clock control */
 #define IBM_CPM_AUD	0x08000000	/* Audio Decoder */
 #define IBM_CPM_EBIU	0x04000000	/* External Bus Interface Unit */
-#define IBM_CPM_IRR	0x02000000	/* Infrared reciever */
+#define IBM_CPM_IRR	0x02000000	/* Infrared receiver */
 #define IBM_CPM_DMA	0x01000000	/* DMA controller */
 #define IBM_CPM_UART2	0x00200000	/* Serial Control Port */
 #define IBM_CPM_UART1	0x00100000	/* Serial 1 / Infrared */
diff -ur 2.5.63a/drivers/char/hangcheck-timer.c 2.5.63b/drivers/char/hangcheck-timer.c
--- 2.5.63a/drivers/char/hangcheck-timer.c	Mon Feb 24 11:05:16 2003
+++ 2.5.63b/drivers/char/hangcheck-timer.c	Mon Feb 24 18:25:09 2003
@@ -16,7 +16,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * General Public License for more details.
  * 
- * You should have recieved a copy of the GNU General Public
+ * You should have received a copy of the GNU General Public
  * License along with this program; if not, write to the
  * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
  * Boston, MA 021110-1307, USA.
diff -ur 2.5.63a/drivers/isdn/hisax/amd7930_fn.c 2.5.63b/drivers/isdn/hisax/amd7930_fn.c
--- 2.5.63a/drivers/isdn/hisax/amd7930_fn.c	Mon Feb 24 11:05:35 2003
+++ 2.5.63b/drivers/isdn/hisax/amd7930_fn.c	Mon Feb 24 18:25:10 2003
@@ -317,7 +317,7 @@
 								QuickHex(t, cs->rcvbuf, cs->rcvidx);
 								debugl1(cs, cs->dlog);
 							}
-                                                        /* moves recieved data in sk-buffer */
+                                                        /* moves received data in sk-buffer */
 							memcpy(skb_put(skb, cs->rcvidx), cs->rcvbuf, cs->rcvidx);
 							skb_queue_tail(&cs->rq, skb);
 						}
diff -ur 2.5.63a/drivers/net/e100/e100_main.c 2.5.63b/drivers/net/e100/e100_main.c
--- 2.5.63a/drivers/net/e100/e100_main.c	Mon Feb 24 11:05:31 2003
+++ 2.5.63b/drivers/net/e100/e100_main.c	Mon Feb 24 18:25:12 2003
@@ -1949,7 +1949,7 @@
 		/* to allow manipulation with current skb we need to unlink it */
 		list_del(&(rx_struct->list_elem));
 
-		/* do not free & unmap badly recieved packet.
+		/* do not free & unmap badly received packet.
 		 * move it to the end of skb list for reuse */
 		if (!(rfd_status & RFD_STATUS_OK)) {
 			e100_add_skb_to_end(bdp, rx_struct);
diff -ur 2.5.63a/include/linux/ipmi.h 2.5.63b/include/linux/ipmi.h
--- 2.5.63a/include/linux/ipmi.h	Mon Feb 24 11:06:02 2003
+++ 2.5.63b/include/linux/ipmi.h	Mon Feb 24 18:25:13 2003
@@ -166,7 +166,7 @@
 typedef struct ipmi_user *ipmi_user_t;
 
 /*
- * Stuff coming from the recieve interface comes as one of these.
+ * Stuff coming from the receive interface comes as one of these.
  * They are allocated, the receiver must free them with
  * ipmi_free_recv_msg() when done with the message.  The link is not
  * used after the message is delivered, so the upper layer may use the
diff -ur 2.5.63a/include/net/llc_conn.h 2.5.63b/include/net/llc_conn.h
--- 2.5.63a/include/net/llc_conn.h	Mon Feb 24 11:05:42 2003
+++ 2.5.63b/include/net/llc_conn.h	Mon Feb 24 18:25:15 2003
@@ -61,7 +61,7 @@
 	u8		    inc_cntr;
 	u8		    dec_cntr;
 	u8		    connect_step;
-	u8		    last_nr;	   /* NR of last pdu recieved */
+	u8		    last_nr;	   /* NR of last pdu received */
 	u32		    rx_pdu_hdr;	   /* used for saving header of last pdu
 					      received and caused sending FRMR.
 					      Used for resending FRMR */
diff -ur 2.5.63a/include/net/sctp/structs.h 2.5.63b/include/net/sctp/structs.h
--- 2.5.63a/include/net/sctp/structs.h	Mon Feb 24 11:06:02 2003
+++ 2.5.63b/include/net/sctp/structs.h	Mon Feb 24 18:25:17 2003
@@ -1233,7 +1233,7 @@
 		/* Pointer to last transport I have sent on.  */
 		struct sctp_transport *last_sent_to;
 
-		/* This is the last transport I have recieved DATA on.  */
+		/* This is the last transport I have received DATA on.  */
 		struct sctp_transport *last_data_from;
 
 		/*
diff -ur 2.5.63a/include/net/sctp/user.h 2.5.63b/include/net/sctp/user.h
--- 2.5.63a/include/net/sctp/user.h	Mon Feb 24 11:05:05 2003
+++ 2.5.63b/include/net/sctp/user.h	Mon Feb 24 18:25:18 2003
@@ -177,7 +177,7 @@
  */
 
 enum sctp_sinfo_flags {
-	MSG_UNORDERED = 1,  /* Send/recieve message unordered. */
+	MSG_UNORDERED = 1,  /* Send/receive message unordered. */
 	MSG_ADDR_OVER = 2,  /* Override the primary destination. */
 	MSG_ABORT=4,        /* Send an ABORT message to the peer. */
 	/* MSG_EOF is already defined per socket.h */
diff -ur 2.5.63a/net/llc/llc_pdu.c 2.5.63b/net/llc/llc_pdu.c
--- 2.5.63a/net/llc/llc_pdu.c	Mon Feb 24 11:05:11 2003
+++ 2.5.63b/net/llc/llc_pdu.c	Mon Feb 24 18:25:20 2003
@@ -203,7 +203,7 @@
 	xid_info	 = (struct llc_xid_info *)(((u8 *)&pdu->ctrl_1) + 1);
 	xid_info->fmt_id = LLC_XID_FMT_ID;	/* 0x81 */
 	xid_info->type	 = svcs_supported;
-	xid_info->rw	 = rx_window << 1;	/* size of recieve window */
+	xid_info->rw	 = rx_window << 1;	/* size of receive window */
 	skb_put(skb, 3);
 }
 
diff -ur 2.5.63a/net/sctp/outqueue.c 2.5.63b/net/sctp/outqueue.c
--- 2.5.63a/net/sctp/outqueue.c	Mon Feb 24 11:05:15 2003
+++ 2.5.63b/net/sctp/outqueue.c	Mon Feb 24 18:25:21 2003
@@ -423,7 +423,7 @@
 				*start_timer = 1;
 
 			/* Stop sending DATA as there is no more room
-			 * at the reciever.
+			 * at the receiver.
 			 */
 			list_add(lchunk, lqueue);
 			lchunk = NULL;
diff -ur 2.5.63a/net/sctp/ulpevent.c 2.5.63b/net/sctp/ulpevent.c
--- 2.5.63a/net/sctp/ulpevent.c	Mon Feb 24 11:05:11 2003
+++ 2.5.63b/net/sctp/ulpevent.c	Mon Feb 24 18:25:26 2003
@@ -785,7 +785,7 @@
 	sctp_association_put(asoc);
 }
 
-/* Charge receive window for bytes recieved.  */
+/* Charge receive window for bytes received.  */
 static void sctp_ulpevent_set_owner_r(struct sk_buff *skb, sctp_association_t *asoc)
 {
 	sctp_ulpevent_t *event;
