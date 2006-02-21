Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161301AbWBUDsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161301AbWBUDsh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 22:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161304AbWBUDsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 22:48:13 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:65212 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1161303AbWBUDsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 22:48:06 -0500
Message-Id: <20060221034748.733117000@localhost.localdomain>
References: <20060221034628.799606000@localhost.localdomain>
Date: Tue, 21 Feb 2006 12:46:30 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Akinobu Mita <mita@miraclelinux.com>
Subject: [-mm patch 2/8] more s/fucn/func/ typo fixes
Content-Disposition: inline; filename=more-fucn-to-func.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s/fucntion/function/ typo fixes

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |    2 +-
 arch/m68k/bvme6000/config.c                                  |    2 +-
 arch/s390/crypto/crypt_s390_query.c                          |    2 +-
 drivers/acpi/processor_core.c                                |    2 +-
 drivers/net/sis900.c                                         |    4 ++--
 include/linux/gameport.h                                     |    4 ++--
 include/linux/serio.h                                        |    6 +++---
 7 files changed, 11 insertions(+), 11 deletions(-)

Index: 2.6-mm/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl
===================================================================
--- 2.6-mm.orig/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl
+++ 2.6-mm/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl
@@ -2836,7 +2836,7 @@ struct _snd_pcm_runtime {
 
         <para>
 	Note that this callback became non-atomic since the recent version.
-	You can use schedule-related fucntions safely in this callback now.
+	You can use schedule-related functions safely in this callback now.
         </para>
 
         <para>
Index: 2.6-mm/arch/m68k/bvme6000/config.c
===================================================================
--- 2.6-mm.orig/arch/m68k/bvme6000/config.c
+++ 2.6-mm/arch/m68k/bvme6000/config.c
@@ -142,7 +142,7 @@ void __init config_bvme6000(void)
     /* Now do the PIT configuration */
 
     pit->pgcr	= 0x00;	/* Unidirectional 8 bit, no handshake for now */
-    pit->psrr	= 0x18;	/* PIACK and PIRQ fucntions enabled */
+    pit->psrr	= 0x18;	/* PIACK and PIRQ functions enabled */
     pit->pacr	= 0x00;	/* Sub Mode 00, H2 i/p, no DMA */
     pit->padr	= 0x00;	/* Just to be tidy! */
     pit->paddr	= 0x00;	/* All inputs for now (safest) */
Index: 2.6-mm/arch/s390/crypto/crypt_s390_query.c
===================================================================
--- 2.6-mm.orig/arch/s390/crypto/crypt_s390_query.c
+++ 2.6-mm/arch/s390/crypto/crypt_s390_query.c
@@ -55,7 +55,7 @@ static void query_available_functions(vo
 	printk(KERN_INFO "KMC_AES_256: %d\n",
 		crypt_s390_func_available(KMC_AES_256_ENCRYPT));
 
-	/* query available KIMD fucntions */
+	/* query available KIMD functions */
 	printk(KERN_INFO "KIMD_QUERY: %d\n",
 		crypt_s390_func_available(KIMD_QUERY));
 	printk(KERN_INFO "KIMD_SHA_1: %d\n",
Index: 2.6-mm/drivers/acpi/processor_core.c
===================================================================
--- 2.6-mm.orig/drivers/acpi/processor_core.c
+++ 2.6-mm/drivers/acpi/processor_core.c
@@ -246,7 +246,7 @@ static int acpi_processor_errata(struct 
 }
 
 /* --------------------------------------------------------------------------
-                              Common ACPI processor fucntions
+                              Common ACPI processor functions
    -------------------------------------------------------------------------- */
 
 /*
Index: 2.6-mm/drivers/net/sis900.c
===================================================================
--- 2.6-mm.orig/drivers/net/sis900.c
+++ 2.6-mm/drivers/net/sis900.c
@@ -1692,7 +1692,7 @@ static irqreturn_t sis900_interrupt(int 
  *
  *	Process receive interrupt events, 
  *	put buffer to higher layer and refill buffer pool
- *	Note: This fucntion is called by interrupt handler, 
+ *	Note: This function is called by interrupt handler, 
  *	don't do "too much" work here
  */
 
@@ -1839,7 +1839,7 @@ static int sis900_rx(struct net_device *
  *
  *	Check for error condition and free socket buffer etc 
  *	schedule for more transmission as needed
- *	Note: This fucntion is called by interrupt handler, 
+ *	Note: This function is called by interrupt handler, 
  *	don't do "too much" work here
  */
 
Index: 2.6-mm/include/linux/gameport.h
===================================================================
--- 2.6-mm.orig/include/linux/gameport.h
+++ 2.6-mm/include/linux/gameport.h
@@ -120,7 +120,7 @@ static inline void gameport_set_name(str
 }
 
 /*
- * Use the following fucntions to manipulate gameport's per-port
+ * Use the following functions to manipulate gameport's per-port
  * driver-specific data.
  */
 static inline void *gameport_get_drvdata(struct gameport *gameport)
@@ -134,7 +134,7 @@ static inline void gameport_set_drvdata(
 }
 
 /*
- * Use the following fucntions to pin gameport's driver in process context
+ * Use the following functions to pin gameport's driver in process context
  */
 static inline int gameport_pin_driver(struct gameport *gameport)
 {
Index: 2.6-mm/include/linux/serio.h
===================================================================
--- 2.6-mm.orig/include/linux/serio.h
+++ 2.6-mm/include/linux/serio.h
@@ -120,7 +120,7 @@ static inline void serio_cleanup(struct 
 }
 
 /*
- * Use the following fucntions to manipulate serio's per-port
+ * Use the following functions to manipulate serio's per-port
  * driver-specific data.
  */
 static inline void *serio_get_drvdata(struct serio *serio)
@@ -134,7 +134,7 @@ static inline void serio_set_drvdata(str
 }
 
 /*
- * Use the following fucntions to protect critical sections in
+ * Use the following functions to protect critical sections in
  * driver code from port's interrupt handler
  */
 static inline void serio_pause_rx(struct serio *serio)
@@ -148,7 +148,7 @@ static inline void serio_continue_rx(str
 }
 
 /*
- * Use the following fucntions to pin serio's driver in process context
+ * Use the following functions to pin serio's driver in process context
  */
 static inline int serio_pin_driver(struct serio *serio)
 {

--
