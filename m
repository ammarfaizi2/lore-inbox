Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268615AbTBZCuu>; Tue, 25 Feb 2003 21:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268627AbTBZCuu>; Tue, 25 Feb 2003 21:50:50 -0500
Received: from [24.77.48.240] ([24.77.48.240]:24121 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S268615AbTBZCur>;
	Tue, 25 Feb 2003 21:50:47 -0500
Date: Tue, 25 Feb 2003 19:01:09 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200302260301.h1Q319907259@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Spelling fixes for 2.5.63 - weird
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes:
    wierd -> weird
    wierdo -> weirdo
    wierdness -> weirdness

Fixes 12 occurrences in all.

diff -ur a/arch/m68knommu/platform/68360/ints.c b/arch/m68knommu/platform/68360/ints.c
--- a/arch/m68knommu/platform/68360/ints.c	Mon Feb 24 11:05:04 2003
+++ b/arch/m68knommu/platform/68360/ints.c	Tue Feb 25 18:44:00 2003
@@ -291,7 +291,7 @@
 
 	/* unsigned long pend = *(volatile unsigned long *)pquicc->intr_cipr; */
 
-	/* Bugger all that wierdness. For the moment, I seem to know where I came from;
+	/* Bugger all that weirdness. For the moment, I seem to know where I came from;
 	 * vec is passed from a specific ISR, so I'll use it. */
 
 	if (int_irq_list[irq] && int_irq_list[irq]->handler) {
diff -ur a/arch/v850/kernel/rte_cb_multi.c b/arch/v850/kernel/rte_cb_multi.c
--- a/arch/v850/kernel/rte_cb_multi.c	Mon Feb 24 11:05:15 2003
+++ b/arch/v850/kernel/rte_cb_multi.c	Tue Feb 25 18:44:06 2003
@@ -67,7 +67,7 @@
 
 			if ((word & 0xFC0) == 0x780) {
 				/* A `jr' insn, fix up its offset (and yes, the
-				   wierd half-word swapping is intentional). */
+				   weird half-word swapping is intentional). */
 				unsigned short hi = word & 0xFFFF;
 				unsigned short lo = word >> 16;
 				unsigned long udisp22
diff -ur a/drivers/net/fec.c b/drivers/net/fec.c
--- a/drivers/net/fec.c	Mon Feb 24 11:05:07 2003
+++ b/drivers/net/fec.c	Tue Feb 25 18:44:08 2003
@@ -828,7 +828,7 @@
 /* 
  * I had some nice ideas of running the MDIO faster...
  * The 971 should support 8MHz and I tried it, but things acted really
- * wierd, so 2.5 MHz ought to be enough for anyone...
+ * weird, so 2.5 MHz ought to be enough for anyone...
  */
 
 static void mii_parse_lxt971_sr2(uint mii_reg, struct net_device *dev)
diff -ur a/include/asm-i386/mach-visws/cobalt.h b/include/asm-i386/mach-visws/cobalt.h
--- a/include/asm-i386/mach-visws/cobalt.h	Mon Feb 24 11:05:08 2003
+++ b/include/asm-i386/mach-visws/cobalt.h	Tue Feb 25 18:44:10 2003
@@ -60,7 +60,7 @@
 #define	CO_APIC_PCIA_BASE0	0 /* and 1 */	/* slot 0, line 0 */
 #define	CO_APIC_PCIA_BASE123	5 /* and 6 */	/* slot 0, line 1 */
 
-#define	CO_APIC_PIIX4_USB	7		/* this one is wierd */
+#define	CO_APIC_PIIX4_USB	7		/* this one is weird */
 
 /* Lithium PCI Bridge B -- "the one with PIIX4" */
 #define	CO_APIC_PCIB_BASE0	8 /* and 9-12 *//* slot 0, line 0 */
diff -ur a/include/asm-v850/sim.h b/include/asm-v850/sim.h
--- a/include/asm-v850/sim.h	Mon Feb 24 11:05:11 2003
+++ b/include/asm-v850/sim.h	Tue Feb 25 18:44:12 2003
@@ -22,7 +22,7 @@
 #define PLATFORM_LONG		"GDB V850E simulator"
 
 
-/* We use a wierd value for RAM, not just 0, for testing purposes.
+/* We use a weird value for RAM, not just 0, for testing purposes.
    These must match the values used in the linker script.  */
 #define RAM_ADDR		0x8F000000
 #define RAM_SIZE		0x01000000
diff -ur a/include/sound/wavefront.h b/include/sound/wavefront.h
--- a/include/sound/wavefront.h	Mon Feb 24 11:05:15 2003
+++ b/include/sound/wavefront.h	Tue Feb 25 18:44:14 2003
@@ -687,7 +687,7 @@
 
 /* Allow direct user-space control over FX memory/coefficient data.
    In theory this could be used to download the FX microprogram,
-   but it would be a little slower, and involve some wierd code.
+   but it would be a little slower, and involve some weird code.
  */
 
 #define WFFX_MEMSET              69
diff -ur a/sound/isa/wavefront/wavefront_fx.c b/sound/isa/wavefront/wavefront_fx.c
--- a/sound/isa/wavefront/wavefront_fx.c	Mon Feb 24 11:05:36 2003
+++ b/sound/isa/wavefront/wavefront_fx.c	Tue Feb 25 18:44:18 2003
@@ -227,7 +227,7 @@
    This code was developed using DOSEMU. The Turtle Beach SETUPSND
    utility was run with I/O tracing in DOSEMU enabled, and a reconstruction
    of the port I/O done, using the Yamaha faxback document as a guide
-   to add more logic to the code. Its really pretty wierd.
+   to add more logic to the code. Its really pretty weird.
 
    There was an alternative approach of just dumping the whole I/O
    sequence as a series of port/value pairs and a simple loop
@@ -692,7 +692,7 @@
 	return (0);
 }
 
-/* wierd stuff, derived from port I/O tracing with dosemu */
+/* weird stuff, derived from port I/O tracing with dosemu */
 
 static unsigned char page_zero[] __initdata = {
 0x01, 0x7c, 0x00, 0x1e, 0x00, 0x00, 0x00, 0x00, 0x00, 0xf5, 0x00,
diff -ur a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
--- a/sound/isa/wavefront/wavefront_synth.c	Mon Feb 24 11:05:16 2003
+++ b/sound/isa/wavefront/wavefront_synth.c	Tue Feb 25 18:44:25 2003
@@ -518,7 +518,7 @@
 /***********************************************************************
 WaveFront data munging   
 
-Things here are wierd. All data written to the board cannot 
+Things here are weird. All data written to the board cannot 
 have its most significant bit set. Any data item with values 
 potentially > 0x7F (127) must be split across multiple bytes.
 
@@ -527,7 +527,7 @@
 that is represented on the x86 side as an array of bytes. The most
 efficient approach to handling both cases seems to be to use 2
 different functions for munging and 2 for de-munging. This avoids
-wierd casting and worrying about bit-level offsets.
+weird casting and worrying about bit-level offsets.
 
 **********************************************************************/
 
@@ -1034,7 +1034,7 @@
 	shptr = munge_int32 (*((u32 *) &header->hdr.s.sampleEndOffset),
 			     shptr, 4);
 	
-	/* This one is truly wierd. What kind of wierdo decided that in
+	/* This one is truly weird. What kind of weirdo decided that in
 	   a system dominated by 16 and 32 bit integers, they would use
 	   a just 12 bits ?
 	*/
diff -ur a/sound/oss/dmasound/dmasound_core.c b/sound/oss/dmasound/dmasound_core.c
--- a/sound/oss/dmasound/dmasound_core.c	Mon Feb 24 11:05:10 2003
+++ b/sound/oss/dmasound/dmasound_core.c	Tue Feb 25 18:44:37 2003
@@ -1212,7 +1212,7 @@
 		return result ;
 		break ;
 	case SNDCTL_DSP_SPEED:
-		/* changing this on the fly will have wierd effects on the sound.
+		/* changing this on the fly will have weird effects on the sound.
 		   Where there are rate conversions implemented in soft form - it
 		   will cause the _ctx_xxx() functions to be substituted.
 		   However, there doesn't appear to be any reason to dis-allow it from
