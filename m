Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbSL2Un2>; Sun, 29 Dec 2002 15:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261599AbSL2Un2>; Sun, 29 Dec 2002 15:43:28 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:60599 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S261463AbSL2UnW>; Sun, 29 Dec 2002 15:43:22 -0500
Message-ID: <3E0F605E.9C124324@wieseckel.de>
Date: Sun, 29 Dec 2002 21:51:42 +0100
From: Stefan Wieseckel <s@wieseckel.de>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.21-pre2 : fixed a few typos
Content-Type: multipart/mixed;
 boundary="------------08D61497F920D1C210581855"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------08D61497F920D1C210581855
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

the attached patch fixes these typos in 2.4.21-pre2:

Documentation/DocBook/journal-api.tmpl: typo: the the
arch/ia64/kernel/perfmon.c: typo: the the
arch/ia64/sn/io/sn1/pcibr.c: typo: the the
arch/parisc/kernel/entry.S: typo: the the
drivers/net/meth.h: typo: the the
drivers/net/eepro.c: typo: the the
drivers/net/e1000/e1000_hw.c: typo: the the
drivers/net/e100/e100_eeprom.c: typo: the the
drivers/net/wan/sdla_x25.c: typo: the the
drivers/net/wireless/orinoco.c: typo: the the
drivers/ide/arm/icside.c: typo: the the
drivers/usb/hc_sl811_rh.c: typo: the the
drivers/s390/net/iucv.c: typo: the the
drivers/s390/net/iucv.h: typo: the the
drivers/message/fusion/mptscsih.c: typo: the the
fs/jfs/jfs_logmgr.c: typo: the the
fs/jfs/jfs_imap.c: typo: the the
fs/jfs/jfs_dmap.c: typo: the the
include/asm-x86_64/mmzone.h: typo: the the
net/ipv4/netfilter/ip_conntrack_core.c: typo: the the
drivers/s390/block/dasd_3990_erp.c: typo: wiht
drivers/sbus/char/bpp.c: typo: execption
drivers/acpi/namespace/nsxfobj.c: typo: exeption
fs/befs/btree.c: typo: Exept
include/asm-i386/checksum.h: typo: exeption
include/asm-sh/checksum.h: typo: exeption

bye...
    Stef'
--------------08D61497F920D1C210581855
Content-Type: text/plain; charset=us-ascii;
 name="typos-2.4.21-pre2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="typos-2.4.21-pre2.diff"

--- ./linux-2.4.21-pre2/fs/jfs/jfs_logmgr.c.orig	Thu Dec 26 00:40:34 2002
+++ ./linux-2.4.21-pre2/fs/jfs/jfs_logmgr.c	Thu Dec 26 00:40:46 2002
@@ -1774,7 +1774,7 @@
 /*
  * NAME:	lbmRedrive
  *
- * FUNCTION:	add a log buffer to the the log redrive list
+ * FUNCTION:	add a log buffer to the log redrive list
  *
  * PARAMETER:
  *     bp	- log buffer
--- ./linux-2.4.21-pre2/fs/jfs/jfs_imap.c.orig	Thu Dec 26 00:41:20 2002
+++ ./linux-2.4.21-pre2/fs/jfs/jfs_imap.c	Thu Dec 26 00:41:36 2002
@@ -402,7 +402,7 @@
 		return EIO;
 	}
 
-	/* locate the the disk inode requested */
+	/* locate the disk inode requested */
 	dp = (struct dinode *) mp->data;
 	dp += rel_inode;
 
@@ -1431,7 +1431,7 @@
 	inum = pip->i_ino + 1;
 	ino = inum & (INOSPERIAG - 1);
 
-	/* back off the the hint if it is outside of the iag */
+	/* back off the hint if it is outside of the iag */
 	if (ino == 0)
 		inum = pip->i_ino;
 
--- ./linux-2.4.21-pre2/fs/jfs/jfs_dmap.c.orig	Thu Dec 26 00:41:43 2002
+++ ./linux-2.4.21-pre2/fs/jfs/jfs_dmap.c	Thu Dec 26 00:42:00 2002
@@ -1525,7 +1525,7 @@
 		if (l2nb < budmin) {
 
 			/* search the lower level dmap control pages to get
-			 * the starting block number of the the dmap that
+			 * the starting block number of the dmap that
 			 * contains or starts off the free space.
 			 */
 			if ((rc =
--- ./linux-2.4.21-pre2/fs/befs/btree.c.orig	Thu Dec 26 01:01:14 2002
+++ ./linux-2.4.21-pre2/fs/befs/btree.c	Thu Dec 26 01:01:49 2002
@@ -617,7 +617,7 @@
  * header and then rounded up to a multiple of four to get the begining
  * of the key length index" (p.88, practical filesystem design).
  *
- * Exept that rounding up to 8 works, and rounding up to 4 doesn't.
+ * Except that rounding up to 8 works, and rounding up to 4 doesn't.
  */
 static u16 *
 befs_bt_keylen_index(befs_btree_node * node)
--- ./linux-2.4.21-pre2/include/asm-x86_64/mmzone.h.orig	Thu Dec 26 00:42:41 2002
+++ ./linux-2.4.21-pre2/include/asm-x86_64/mmzone.h	Thu Dec 26 00:42:51 2002
@@ -78,7 +78,7 @@
 
 /*
  * Given a kaddr, ADDR_TO_MAPBASE finds the owning node of the memory
- * and returns the the mem_map of that node.
+ * and returns the mem_map of that node.
  */
 #define ADDR_TO_MAPBASE(kaddr) \
 			NODE_MEM_MAP(KVADDR_TO_NID((unsigned long)(kaddr)))
--- ./linux-2.4.21-pre2/include/asm-i386/checksum.h.orig	Thu Dec 26 01:02:17 2002
+++ ./linux-2.4.21-pre2/include/asm-i386/checksum.h	Thu Dec 26 01:02:25 2002
@@ -50,7 +50,7 @@
 
 /*
  * These are the old (and unsafe) way of doing checksums, a warning message will be
- * printed if they are used and an exeption occurs.
+ * printed if they are used and an exception occurs.
  *
  * these functions should go away after some time.
  */
--- ./linux-2.4.21-pre2/include/asm-sh/checksum.h.orig	Thu Dec 26 01:02:46 2002
+++ ./linux-2.4.21-pre2/include/asm-sh/checksum.h	Thu Dec 26 01:02:56 2002
@@ -59,7 +59,7 @@
 
 /*
  * These are the old (and unsafe) way of doing checksums, a warning message will be
- * printed if they are used and an exeption occurs.
+ * printed if they are used and an exception occurs.
  *
  * these functions should go away after some time.
  */
--- ./linux-2.4.21-pre2/net/ipv4/netfilter/ip_conntrack_core.c.orig	Thu Dec 26 00:43:30 2002
+++ ./linux-2.4.21-pre2/net/ipv4/netfilter/ip_conntrack_core.c	Thu Dec 26 00:43:41 2002
@@ -983,7 +983,7 @@
 			return -EPERM;
 		}
 
-		/* choose the the oldest expectation to evict */
+		/* choose the oldest expectation to evict */
 		list_for_each(cur_item, &related_to->sibling_list) { 
 			struct ip_conntrack_expect *cur;
 
--- ./linux-2.4.21-pre2/drivers/net/e1000/e1000_hw.c.orig	Thu Dec 26 00:32:58 2002
+++ ./linux-2.4.21-pre2/drivers/net/e1000/e1000_hw.c	Thu Dec 26 00:33:38 2002
@@ -2545,8 +2545,7 @@
  * hw - Struct containing variables accessed by shared code
  *
  * Reads the first 64 16 bit words of the EEPROM and sums the values read.
- * If the the sum of the 64 16 bit words is 0xBABA, the EEPROM's checksum is
- * valid.
+ * If the sum of the 64 16 bit words is 0xBABA, the EEPROM's checksum is valid.
  *****************************************************************************/
 int32_t
 e1000_validate_eeprom_checksum(struct e1000_hw *hw)
--- ./linux-2.4.21-pre2/drivers/net/e100/e100_eeprom.c.orig	Thu Dec 26 00:34:16 2002
+++ ./linux-2.4.21-pre2/drivers/net/e100/e100_eeprom.c	Thu Dec 26 00:34:29 2002
@@ -518,7 +518,7 @@
 //----------------------------------------------------------------------------------------
 // Procedure:   eeprom_wait_cmd_done
 //
-// Description: This routine waits for the the EEPROM to finish its command.  
+// Description: This routine waits for the EEPROM to finish its command.  
 //                              Specifically, it waits for EEDO (data out) to go high.
 // Returns:     true - If the command finished
 //              false - If the command never finished (EEDO stayed low)
--- ./linux-2.4.21-pre2/drivers/net/wan/sdla_x25.c.orig	Thu Dec 26 00:34:55 2002
+++ ./linux-2.4.21-pre2/drivers/net/wan/sdla_x25.c	Thu Dec 26 00:46:54 2002
@@ -4721,9 +4721,8 @@
 /*===============================================================
  * api_incoming_call 
  *
- *	Pass an incoming call request up the the listening
- *      sock.  If the API sock is not listening reject the
- *      call.
+ *	Pass an incoming call request up the listening sock.
+ *	If the API sock is not listening reject the call.
  *
  *===============================================================*/
 
--- ./linux-2.4.21-pre2/drivers/net/wireless/orinoco.c.orig	Thu Dec 26 00:35:59 2002
+++ ./linux-2.4.21-pre2/drivers/net/wireless/orinoco.c	Thu Dec 26 00:36:10 2002
@@ -3131,7 +3131,7 @@
 
 	TRACE_ENTER(dev->name);
 
-	/* In theory, we could allow most of the the SET stuff to be
+	/* In theory, we could allow most of the SET stuff to be
 	 * done In practice, the laps of time at startup when the card
 	 * is not ready is very short, so why bother...  Note that
 	 * netif_device_present is different from up/down (ifconfig),
--- ./linux-2.4.21-pre2/drivers/net/meth.h.orig	Thu Dec 26 00:30:38 2002
+++ ./linux-2.4.21-pre2/drivers/net/meth.h	Thu Dec 26 00:30:50 2002
@@ -169,7 +169,7 @@
 				       /*   Note: when loopback is set this bit becomes collision control.  Setting this bit will */
 				       /*         cause a collision to be reported. */
 
-				       /* Bits 5 and 6 are used to determine the the Destination address filter mode */
+				       /* Bits 5 and 6 are used to determine the Destination address filter mode */
 #define METH_ACCEPT_MY 0			/* 00: Accept PHY address only */
 #define METH_ACCEPT_MCAST 0x20	/* 01: Accept physical, broadcast, and multicast filter matches only */
 #define METH_ACCEPT_AMCAST 0x40	/* 10: Accept physical, broadcast, and all multicast packets */
--- ./linux-2.4.21-pre2/drivers/net/eepro.c.orig	Thu Dec 26 00:31:05 2002
+++ ./linux-2.4.21-pre2/drivers/net/eepro.c	Thu Dec 26 00:31:16 2002
@@ -1116,7 +1116,7 @@
 	printk (KERN_ERR "%s: transmit timed out, %s?\n", dev->name,
 		"network cable problem");
 	/* This is not a duplicate. One message for the console,
-	   one for the the log file  */
+	   one for the log file  */
 	printk (KERN_DEBUG "%s: transmit timed out, %s?\n", dev->name,
 		"network cable problem");
 	eepro_complete_selreset(ioaddr);
--- ./linux-2.4.21-pre2/drivers/sbus/char/bpp.c.orig	Thu Dec 26 00:58:20 2002
+++ ./linux-2.4.21-pre2/drivers/sbus/char/bpp.c	Thu Dec 26 00:58:29 2002
@@ -96,7 +96,7 @@
 /*
  * These are for data access.
  * Control lines accesses are hidden in set_bits() and get_bits().
- * The exeption is the probe procedure, which is system-dependent.
+ * The exception is the probe procedure, which is system-dependent.
  */
 #define bpp_outb_p(data, base)  outb_p((data), (base))
 #define bpp_inb(base)  inb(base)
--- ./linux-2.4.21-pre2/drivers/ide/arm/icside.c.orig	Thu Dec 26 00:36:34 2002
+++ ./linux-2.4.21-pre2/drivers/ide/arm/icside.c	Thu Dec 26 00:36:44 2002
@@ -29,7 +29,7 @@
 #include "ide-noise.h"
 
 /*
- * FIXME: We want to drop the the MACRO CRAP!
+ * FIXME: We want to drop the MACRO CRAP!
  *
  * ec->iops->in{b/w/l}
  * ec->iops->in{b/w/l}_p
--- ./linux-2.4.21-pre2/drivers/usb/hc_sl811_rh.c.orig	Thu Dec 26 00:37:27 2002
+++ ./linux-2.4.21-pre2/drivers/usb/hc_sl811_rh.c	Thu Dec 26 00:37:42 2002
@@ -163,7 +163,7 @@
 /***************************************************************************
  * Function Name : rh_int_timer_do
  * 
- * This function is called when the timer expires.  It gets the the port 
+ * This function is called when the timer expires.  It gets the port 
  * change data and pass along to the upper protocol.
  * 
  * Note:  The virtual root hub interrupt pipe are polled by the timer
@@ -235,7 +235,7 @@
 /***************************************************************************
  * Function Name : rh_submit_urb
  * 
- * This function handles all USB request to the the virtual root hub
+ * This function handles all USB request to the virtual root hub
  * 
  * Input: urb = USB request block 
  *
--- ./linux-2.4.21-pre2/drivers/s390/block/dasd_3990_erp.c.orig	Thu Dec 26 00:51:00 2002
+++ ./linux-2.4.21-pre2/drivers/s390/block/dasd_3990_erp.c	Thu Dec 26 00:51:15 2002
@@ -2809,7 +2809,7 @@
  *     - exit with permanent error
  *
  * PARAMETER
- *   erp                ERP which is in progress wiht no retry left
+ *   erp                ERP which is in progress with no retry left
  *
  * RETURN VALUES
  *   erp                modified/additional ERP
--- ./linux-2.4.21-pre2/drivers/s390/net/iucv.c.orig	Thu Dec 26 00:38:18 2002
+++ ./linux-2.4.21-pre2/drivers/s390/net/iucv.c	Thu Dec 26 00:38:38 2002
@@ -418,7 +418,7 @@
 /**
  * grab_param: - Get a parameter buffer from the pre-allocated pool.
  *
- * This function searches for an unused element in the the pre-allocated pool
+ * This function searches for an unused element in the pre-allocated pool
  * of parameter buffers. If one is found, it marks it "in use" and returns
  * a pointer to it. The calling function is responsible for releasing it
  * when it has finished its usage.
@@ -1525,7 +1525,7 @@
  *        buflen - length of reply buffer
  * Output: ipbfadr2 - Address of buffer updated by the number
  *                    of bytes you have moved.
- *         ipbfln2f - Contains on the the following values
+ *         ipbfln2f - Contains on the following values
  *              If the answer buffer is the same length as the reply, this field
  *               contains zero.
  *              If the answer buffer is longer than the reply, this field contains
@@ -1590,7 +1590,7 @@
  *        buffer - address of array of reply buffers
  *        buflen - total length of reply buffers
  * Output: ipbfadr2 - Address of buffer which IUCV is currently working on.
- *         ipbfln2f - Contains on the the following values
+ *         ipbfln2f - Contains on the following values
  *              If the answer buffer is the same length as the reply, this field
  *               contains zero.
  *              If the answer buffer is longer than the reply, this field contains
--- ./linux-2.4.21-pre2/drivers/s390/net/iucv.h.orig	Thu Dec 26 00:38:47 2002
+++ ./linux-2.4.21-pre2/drivers/s390/net/iucv.h	Thu Dec 26 00:39:15 2002
@@ -446,7 +446,7 @@
  *        buflen - Length of reply buffer.                              
  * Output: residual_buffer - Address of buffer updated by the number 
  *                    of bytes you have moved.              
- *         residual_length - Contains on the the following values
+ *         residual_length - Contains on the following values
  *		If the answer buffer is the same length as the reply, this field
  *		 contains zero.
  *		If the answer buffer is longer than the reply, this field contains
@@ -480,7 +480,7 @@
  *        buffer - Address of array of reply buffers.                     
  *        buflen - Total length of reply buffers.                         
  * Output: residual_buffer - Address of buffer which IUCV is currently working on.
- *         residual_length - Contains on the the following values
+ *         residual_length - Contains on the following values
  *              If the answer buffer is the same length as the reply, this field
  *               contains zero.
  *              If the answer buffer is longer than the reply, this field contains
--- ./linux-2.4.21-pre2/drivers/acpi/namespace/nsxfobj.c.orig	Thu Dec 26 00:59:14 2002
+++ ./linux-2.4.21-pre2/drivers/acpi/namespace/nsxfobj.c	Thu Dec 26 00:59:26 2002
@@ -439,7 +439,7 @@
 	*ret_handle =
 		acpi_ns_convert_entry_to_handle (acpi_ns_get_parent_object (node));
 
-	/* Return exeption if parent is null */
+	/* Return exception if parent is null */
 
 	if (!acpi_ns_get_parent_object (node)) {
 		status = AE_NULL_ENTRY;
--- ./linux-2.4.21-pre2/drivers/message/fusion/mptscsih.c.orig	Thu Dec 26 00:39:49 2002
+++ ./linux-2.4.21-pre2/drivers/message/fusion/mptscsih.c	Thu Dec 26 00:40:00 2002
@@ -1057,7 +1057,7 @@
 	 * index = chain_idx
 	 *
 	 * Calculate the number of chain buffers needed(plus 1) per I/O 
-	 * then multiply the the maximum number of simultaneous cmds
+	 * then multiply the maximum number of simultaneous cmds
 	 *
 	 * num_sge = num sge in request frame + last chain buffer
 	 * scale = num sge per chain buffer if no chain element
--- ./linux-2.4.21-pre2/arch/ia64/kernel/perfmon.c.orig	Thu Dec 26 00:29:04 2002
+++ ./linux-2.4.21-pre2/arch/ia64/kernel/perfmon.c	Thu Dec 26 00:29:16 2002
@@ -3412,7 +3412,7 @@
 	 * (not perfmon) by the previous task. 
 	 *
 	 * XXX: dealing with this in a lazy fashion requires modifications
-	 * to the way the the debug registers are managed. This is will done
+	 * to the way the debug registers are managed. This is will done
 	 * in the next version of perfmon.
 	 */
 	if (ctx->ctx_fl_using_dbreg) {
--- ./linux-2.4.21-pre2/arch/ia64/sn/io/sn1/pcibr.c.orig	Thu Dec 26 00:29:33 2002
+++ ./linux-2.4.21-pre2/arch/ia64/sn/io/sn1/pcibr.c	Thu Dec 26 00:29:46 2002
@@ -7485,7 +7485,7 @@
 
 #ifdef LITTLE_ENDIAN
 /*
- * on sn-ia we need to twiddle the the addresses going out
+ * on sn-ia we need to twiddle the addresses going out
  * the pci bus because we use the unswizzled synergy space
  * (the alternative is to use the swizzled synergy space
  * and byte swap the data)
--- ./linux-2.4.21-pre2/arch/parisc/kernel/entry.S.orig	Thu Dec 26 00:30:06 2002
+++ ./linux-2.4.21-pre2/arch/parisc/kernel/entry.S	Thu Dec 26 00:30:17 2002
@@ -678,7 +678,7 @@
 	 * whatever was last stored in the task structure, which might
 	 * be inconsistant if an interrupt occured while on the gateway
 	 * page) Note that we may be "trashing" values the user put in
-	 * them, but we don't support the the user changing them.
+	 * them, but we don't support the user changing them.
 	 */
 
 	STREG   %r0,PT_SR2(%r16)
--- ./linux-2.4.21-pre2/Documentation/DocBook/journal-api.tmpl.orig	Thu Dec 26 00:28:14 2002
+++ ./linux-2.4.21-pre2/Documentation/DocBook/journal-api.tmpl	Thu Dec 26 00:28:40 2002
@@ -113,7 +113,7 @@
 
 You still need to actually journal your filesystem changes, this
 is done by wrapping them into transactions. Additionally you
-also need to wrap the modification of each of the the buffers
+also need to wrap the modification of each of the buffers
 with calls to the journal layer, so it knows what the modifications
 you are actually making are. To do this use  journal_start() which
 returns a transaction handle.
@@ -125,7 +125,7 @@
 are nestable calls, so you can reenter a transaction if necessary,
 but remember you must call journal_stop() the same number of times as
 journal_start() before the transaction is completed (or more accurately
-leaves the the update phase). Ext3/VFS makes use of this feature to simplify 
+leaves the update phase). Ext3/VFS makes use of this feature to simplify 
 quota support.
 </para>
 

--------------08D61497F920D1C210581855--

