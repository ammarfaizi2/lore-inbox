Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbTBTCDg>; Wed, 19 Feb 2003 21:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265096AbTBTCAP>; Wed, 19 Feb 2003 21:00:15 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:56069 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S265074AbTBTB7U>; Wed, 19 Feb 2003 20:59:20 -0500
Subject: [PATCH] Spelling fixes for paticular -> particular and others in 18
	files.
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 19 Feb 2003 19:00:41 -0700
Message-Id: <1045706442.5965.495.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides the following spelling fixes:

paticular   -> particular
usefull     -> useful
occurance   -> occurrence
occurances  -> occurrences
successfull -> successful 

 Documentation/DocBook/deviceiobook.tmpl |    2 +-
 Documentation/networking/sk98lin.txt    |    2 +-
 Documentation/s390/s390dbf.txt          |    2 +-
 arch/i386/kernel/dmi_scan.c             |    2 +-
 arch/i386/pci/visws.c                   |    2 +-
 arch/m68knommu/kernel/ints.c            |    2 +-
 drivers/net/3c501.c                     |    4 ++--
 drivers/net/3c527.c                     |    2 +-
 drivers/net/sk98lin/skgepnmi.c          |   10 +++++-----
 drivers/net/sungem.h                    |    2 +-
 drivers/net/tlan.c                      |    4 ++--
 drivers/s390/block/dasd.c               |    2 +-
 fs/befs/btree.c                         |    2 +-
 fs/cifs/cifs_unicode.h                  |    2 +-
 fs/eventpoll.c                          |    2 +-
 fs/jffs2/compr_rtime.c                  |    2 +-
 kernel/pm.c                             |    2 +-
 sound/core/seq/seq_timer.c              |    2 +-
 18 files changed, 24 insertions(+), 24 deletions(-)

diff -ur linux-2.5-current/Documentation/DocBook/deviceiobook.tmpl linux/Documentation/DocBook/deviceiobook.tmpl
--- linux-2.5-current/Documentation/DocBook/deviceiobook.tmpl	Wed Feb 19 07:34:57 2003
+++ linux/Documentation/DocBook/deviceiobook.tmpl	Wed Feb 19 14:22:45 2003
@@ -152,7 +152,7 @@
       <para>
 	While the basic functions are defined to be synchronous with respect
 	to each other and ordered with respect to each other the busses the
-	devices sit on may themselves have asynchronocity. In paticular many
+	devices sit on may themselves have asynchronicity. In particular many
 	authors are burned by the fact that PCI bus writes are posted
 	asynchronously. A driver author must issue a read from the same
 	device to ensure that writes have occurred in the specific cases the
diff -ur linux-2.5-current/Documentation/networking/sk98lin.txt linux/Documentation/networking/sk98lin.txt
--- linux-2.5-current/Documentation/networking/sk98lin.txt	Wed Feb 19 07:35:05 2003
+++ linux/Documentation/networking/sk98lin.txt	Wed Feb 19 14:22:44 2003
@@ -187,7 +187,7 @@
   this port is not "Sense". If autonegotiation is "On", all
   three values are possible. If it is "Off", only "Full" and
   "Half" are allowed.
-  It is usefull if your link partner does not support all
+  It is useful if your link partner does not support all
   possible combinations.
 
 - Flow Control
diff -ur linux-2.5-current/Documentation/s390/s390dbf.txt linux/Documentation/s390/s390dbf.txt
--- linux-2.5-current/Documentation/s390/s390dbf.txt	Wed Feb 19 07:35:06 2003
+++ linux/Documentation/s390/s390dbf.txt	Wed Feb 19 14:22:44 2003
@@ -14,7 +14,7 @@
 If the system still runs but only a subcomponent which uses dbf failes,
 it is possible to look at the debug logs on a live system via the Linux proc
 filesystem.
-The debug feature may also very usefull for kernel and driver development.
+The debug feature may also very useful for kernel and driver development.
 
 Design:
 -------
diff -ur linux-2.5-current/arch/i386/kernel/dmi_scan.c linux/arch/i386/kernel/dmi_scan.c
--- linux-2.5-current/arch/i386/kernel/dmi_scan.c	Wed Feb 19 07:34:54 2003
+++ linux/arch/i386/kernel/dmi_scan.c	Wed Feb 19 14:22:45 2003
@@ -440,7 +440,7 @@
 {
 	printk(KERN_INFO " *** Possibly defective BIOS detected (irqtable)\n");
 	printk(KERN_INFO " *** Many BIOSes matching this signature have incorrect IRQ routing tables.\n");
-	printk(KERN_INFO " *** If you see IRQ problems, in paticular SCSI resets and hangs at boot\n");
+	printk(KERN_INFO " *** If you see IRQ problems, in particular SCSI resets and hangs at boot\n");
 	printk(KERN_INFO " *** contact your hardware vendor and ask about updates.\n");
 	printk(KERN_INFO " *** Building an SMP kernel may evade the bug some of the time.\n");
 #ifdef CONFIG_X86_IO_APIC
diff -ur linux-2.5-current/arch/i386/pci/visws.c linux/arch/i386/pci/visws.c
--- linux-2.5-current/arch/i386/pci/visws.c	Wed Feb 19 07:35:07 2003
+++ linux/arch/i386/pci/visws.c	Wed Feb 19 14:22:44 2003
@@ -52,7 +52,7 @@
 
 	pin--;
 
-	/* Nothing usefull at PIIX4 pin 1 */
+	/* Nothing useful at PIIX4 pin 1 */
 	if (bus == pci_bus0 && slot == 4 && pin == 0)
 		return -1;
 
diff -ur linux-2.5-current/arch/m68knommu/kernel/ints.c linux/arch/m68knommu/kernel/ints.c
--- linux-2.5-current/arch/m68knommu/kernel/ints.c	Wed Feb 19 07:34:44 2003
+++ linux/arch/m68knommu/kernel/ints.c	Wed Feb 19 14:22:44 2003
@@ -214,7 +214,7 @@
 /*
  * Do we need these probe functions on the m68k?
  *
- *  ... may be usefull with ISA devices
+ *  ... may be useful with ISA devices
  */
 unsigned long probe_irq_on (void)
 {
diff -ur linux-2.5-current/drivers/net/3c501.c linux/drivers/net/3c501.c
--- linux-2.5-current/drivers/net/3c501.c	Wed Feb 19 07:34:38 2003
+++ linux/drivers/net/3c501.c	Wed Feb 19 14:22:45 2003
@@ -494,7 +494,7 @@
  * @regs: Register data (surplus to our requirements)
  *
  * Handle the ether interface interrupts. The 3c501 needs a lot more 
- * hand holding than most cards. In paticular we get a transmit interrupt
+ * hand holding than most cards. In particular we get a transmit interrupt
  * with a collision error because the board firmware isnt capable of rewinding
  * its own transmit buffer pointers. It can however count to 16 for us.
  *
@@ -684,7 +684,7 @@
  * @dev: Device to pull the packets from
  *
  * We have a good packet. Well, not really "good", just mostly not broken.
- * We must check everything to see if it is good. In paticular we occasionally
+ * We must check everything to see if it is good. In particular we occasionally
  * get wild packet sizes from the card. If the packet seems sane we PIO it
  * off the card and queue it for the protocol layers.
  */
diff -ur linux-2.5-current/drivers/net/3c527.c linux/drivers/net/3c527.c
--- linux-2.5-current/drivers/net/3c527.c	Wed Feb 19 07:35:02 2003
+++ linux/drivers/net/3c527.c	Wed Feb 19 14:22:45 2003
@@ -227,7 +227,7 @@
  * Because MCA bus is a real bus and we can scan for cards we could do a
  * single scan for all boards here. Right now we use the passed in device
  * structure and scan for only one board. This needs fixing for modules
- * in paticular.
+ * in particular.
  */
 
 int __init mc32_probe(struct net_device *dev)
diff -ur linux-2.5-current/drivers/net/sk98lin/skgepnmi.c linux/drivers/net/sk98lin/skgepnmi.c
--- linux-2.5-current/drivers/net/sk98lin/skgepnmi.c	Wed Feb 19 07:35:07 2003
+++ linux/drivers/net/sk98lin/skgepnmi.c	Wed Feb 19 14:22:44 2003
@@ -236,7 +236,7 @@
  *	-Fixed bug for RX counters. On an RX overflow interrupt the high
  *	 words of all RX counters were incremented.
  *	-SET operations on FLOWCTRL_MODE and LINK_MODE accept now the
- *	 value 0, which has no effect. It is usefull for multiple instance
+ *	 value 0, which has no effect. It is useful for multiple instance
  *	 SETs.
  *	
  *	Revision 1.37  1998/11/20 08:02:04  mhaveman
@@ -1672,7 +1672,7 @@
  * Description:
  *	Calls a general sub-function for all this stuff. The preset does
  *	the same as a set, but returns just before finally setting the
- *	new value. This is usefull to check if a set might be successfull.
+ *	new value. This is useful to check if a set might be successful.
  *	If as instance a -1 is passed, an array of values is supposed and
  *	all instance of the OID will be set.
  *
@@ -1716,7 +1716,7 @@
  * Description:
  *	Calls a general sub-function for all this stuff. The preset does
  *	the same as a set, but returns just before finally setting the
- *	new value. This is usefull to check if a set might be successfull.
+ *	new value. This is useful to check if a set might be successful.
  *	If as instance a -1 is passed, an array of values is supposed and
  *	all instance of the OID will be set.
  *
@@ -1935,7 +1935,7 @@
  * Description:
  *	Calls a general sub-function for all this set stuff. The preset does
  *	the same as a set, but returns just before finally setting the
- *	new value. This is usefull to check if a set might be successfull.
+ *	new value. This is useful to check if a set might be successful.
  *	The sub-function runs through the IdTable, checks which OIDs are able
  *	to set, and calls the handler function of the OID to perform the
  *	preset. The return value of the function will also be stored in
@@ -6813,7 +6813,7 @@
  *
  * Description:
  *	The COMMON module only tells us if the mode is half or full duplex.
- *	But in the decade of auto sensing it is usefull for the user to
+ *	But in the decade of auto sensing it is useful for the user to
  *	know if the mode was negotiated or forced. Therefore we have a
  *	look to the mode, which was last used by the negotiation process.
  *
diff -ur linux-2.5-current/drivers/net/sungem.h linux/drivers/net/sungem.h
--- linux-2.5-current/drivers/net/sungem.h	Wed Feb 19 07:35:02 2003
+++ linux/drivers/net/sungem.h	Wed Feb 19 14:22:46 2003
@@ -562,7 +562,7 @@
  */
 
 /* Statistics Registers.  All of these registers are 16-bits and
- * track occurances of a specific event.  GEM can be configured
+ * track occurrences of a specific event.  GEM can be configured
  * to interrupt the host cpu when any of these counters overflow.
  * They should all be explicitly initialized to zero when the interface
  * is brought up.
diff -ur linux-2.5-current/drivers/net/tlan.c linux/drivers/net/tlan.c
--- linux-2.5-current/drivers/net/tlan.c	Wed Feb 19 07:34:42 2003
+++ linux/drivers/net/tlan.c	Wed Feb 19 14:22:46 2003
@@ -1630,7 +1630,7 @@
 	 *		host_int	The contents of the HOST_INT
 	 *				port.
 	 *
-	 *	This driver is structured to determine EOC occurances by
+	 *	This driver is structured to determine EOC occurrences by
 	 *	reading the CSTAT member of the list structure.  Tx EOC
 	 *	interrupts are disabled via the DIO INTDIS register.
 	 *	However, TLAN chips before revision 3.0 didn't have this
@@ -1753,7 +1753,7 @@
 	 *		host_int	The contents of the HOST_INT
 	 *				port.
 	 *
-	 *	This driver is structured to determine EOC occurances by
+	 *	This driver is structured to determine EOC occurrences by
 	 *	reading the CSTAT member of the list structure.  Rx EOC
 	 *	interrupts are disabled via the DIO INTDIS register.
 	 *	However, TLAN chips before revision 3.0 didn't have this
diff -ur linux-2.5-current/drivers/s390/block/dasd.c linux/drivers/s390/block/dasd.c
--- linux-2.5-current/drivers/s390/block/dasd.c	Wed Feb 19 07:34:57 2003
+++ linux/drivers/s390/block/dasd.c	Wed Feb 19 14:22:44 2003
@@ -1582,7 +1582,7 @@
 
 /*
  * Cancels a request that was started with dasd_sleep_on_req.
- * This is usefull to timeout requests. The request will be
+ * This is useful to timeout requests. The request will be
  * terminated if it is currently in i/o.
  * Returns 1 if the request has been terminated.
  */
diff -ur linux-2.5-current/fs/befs/btree.c linux/fs/befs/btree.c
--- linux-2.5-current/fs/befs/btree.c	Wed Feb 19 07:34:38 2003
+++ linux/fs/befs/btree.c	Wed Feb 19 14:22:44 2003
@@ -41,7 +41,7 @@
 /* Befs B+tree structure:
  * 
  * The first thing in the tree is the tree superblock. It tells you
- * all kinds of usefull things about the tree, like where the rootnode
+ * all kinds of useful things about the tree, like where the rootnode
  * is located, and the size of the nodes (always 1024 with current version
  * of BeOS).
  *
diff -ur linux-2.5-current/fs/cifs/cifs_unicode.h linux/fs/cifs/cifs_unicode.h
--- linux-2.5-current/fs/cifs/cifs_unicode.h	Wed Feb 19 07:35:21 2003
+++ linux/fs/cifs/cifs_unicode.h	Wed Feb 19 14:22:46 2003
@@ -99,7 +99,7 @@
  * UniStrchr:  Find a character in a string
  *
  * Returns:
- *     Address of first occurance of character in string
+ *     Address of first occurrence of character in string
  *     or NULL if the character is not in the string
  */
 static inline wchar_t *
diff -ur linux-2.5-current/fs/eventpoll.c linux/fs/eventpoll.c
--- linux-2.5-current/fs/eventpoll.c	Wed Feb 19 07:34:55 2003
+++ linux/fs/eventpoll.c	Wed Feb 19 14:22:44 2003
@@ -97,7 +97,7 @@
 
 /*
  * Remove the item from the list and perform its initialization.
- * This is usefull for us because we can test if the item is linked
+ * This is useful for us because we can test if the item is linked
  * using "EP_IS_LINKED(p)".
  */
 #define EP_LIST_DEL(p) do { list_del(p); INIT_LIST_HEAD(p); } while (0)
diff -ur linux-2.5-current/fs/jffs2/compr_rtime.c linux/fs/jffs2/compr_rtime.c
--- linux-2.5-current/fs/jffs2/compr_rtime.c	Wed Feb 19 07:34:42 2003
+++ linux/fs/jffs2/compr_rtime.c	Wed Feb 19 14:22:46 2003
@@ -13,7 +13,7 @@
  * Very simple lz77-ish encoder.
  *
  * Theory of operation: Both encoder and decoder have a list of "last
- * occurances" for every possible source-value; after sending the
+ * occurrences" for every possible source-value; after sending the
  * first source-byte, the second byte indicated the "run" length of
  * matches
  *
diff -ur linux-2.5-current/kernel/pm.c linux/kernel/pm.c
--- linux-2.5-current/kernel/pm.c	Wed Feb 19 07:34:43 2003
+++ linux/kernel/pm.c	Wed Feb 19 14:22:45 2003
@@ -145,7 +145,7 @@
  *	and conflicting.
  *
  *	WARNING: Calling pm_send directly is not generally recommended, in
- *	paticular there is no locking against the pm_dev going away. The
+ *	particular there is no locking against the pm_dev going away. The
  *	caller must maintain all needed locking or have 'inside knowledge'
  *	on the safety. Also remember that this function is not locked against
  *	pm_unregister. This means that you must handle SMP races on callback
diff -ur linux-2.5-current/sound/core/seq/seq_timer.c linux/sound/core/seq/seq_timer.c
--- linux-2.5-current/sound/core/seq/seq_timer.c	Wed Feb 19 07:35:08 2003
+++ linux/sound/core/seq/seq_timer.c	Wed Feb 19 14:22:44 2003
@@ -401,7 +401,7 @@
 	return cur_time;	
 }
 
-/* TODO: use interpolation on tick queue (will only be usefull for very
+/* TODO: use interpolation on tick queue (will only be useful for very
  high PPQ values) */
 snd_seq_tick_time_t snd_seq_timer_get_cur_tick(seq_timer_t *tmr)
 {

