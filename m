Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268618AbTBZCwU>; Tue, 25 Feb 2003 21:52:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268627AbTBZCvF>; Tue, 25 Feb 2003 21:51:05 -0500
Received: from [24.77.48.240] ([24.77.48.240]:24377 "EHLO aiinc.aiinc.ca")
	by vger.kernel.org with ESMTP id <S268620AbTBZCus>;
	Tue, 25 Feb 2003 21:50:48 -0500
Date: Tue, 25 Feb 2003 19:01:09 -0800
From: Michael Hayes <mike@aiinc.ca>
Message-Id: <200302260301.h1Q319p07261@aiinc.aiinc.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Spelling fixes for 2.5.63 - whether
Cc: torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes:
    wether -> whether

(A "wether" is a castrated goat.)

Fixes 18 occurrences in all.

diff -ur a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Mon Feb 24 11:05:31 2003
+++ b/arch/i386/kernel/smpboot.c	Tue Feb 25 18:47:22 2003
@@ -170,7 +170,7 @@
 /*
  * TSC synchronization.
  *
- * We first check wether all CPUs have their TSC's synchronized,
+ * We first check whether all CPUs have their TSC's synchronized,
  * then we print a warning if not, and always resync.
  */
 
diff -ur a/arch/mips/kernel/r2300_switch.S b/arch/mips/kernel/r2300_switch.S
--- a/arch/mips/kernel/r2300_switch.S	Mon Feb 24 11:05:41 2003
+++ b/arch/mips/kernel/r2300_switch.S	Tue Feb 25 18:47:26 2003
@@ -108,7 +108,7 @@
 
 /*
  * Load the FPU with signalling NANS.  This bit pattern we're using has
- * the property that no matter wether considered as single or as double
+ * the property that no matter whether considered as single or as double
  * precission represents signaling NANS.
  *
  * We initialize fcr31 to rounding to nearest, no exceptions.
diff -ur a/arch/sh/kernel/fpu.c b/arch/sh/kernel/fpu.c
--- a/arch/sh/kernel/fpu.c	Mon Feb 24 11:05:33 2003
+++ b/arch/sh/kernel/fpu.c	Tue Feb 25 18:47:28 2003
@@ -118,7 +118,7 @@
 
 /*
  * Load the FPU with signalling NANS.  This bit pattern we're using
- * has the property that no matter wether considered as single or as
+ * has the property that no matter whether considered as single or as
  * double precission represents signaling NANS.  
  */
 
diff -ur a/arch/x86_64/kernel/apic.c b/arch/x86_64/kernel/apic.c
--- a/arch/x86_64/kernel/apic.c	Mon Feb 24 11:05:10 2003
+++ b/arch/x86_64/kernel/apic.c	Tue Feb 25 18:47:30 2003
@@ -292,7 +292,7 @@
 		__error_in_apic_c();
 
 	/*
-	 * Double-check wether this APIC is really registered.
+	 * Double-check whether this APIC is really registered.
 	 * This is meaningless in clustered apic mode, so we skip it.
 	 */
 	if (!clustered_apic_mode && 
diff -ur a/arch/x86_64/kernel/smpboot.c b/arch/x86_64/kernel/smpboot.c
--- a/arch/x86_64/kernel/smpboot.c	Mon Feb 24 11:06:02 2003
+++ b/arch/x86_64/kernel/smpboot.c	Tue Feb 25 18:47:32 2003
@@ -104,7 +104,7 @@
 /*
  * TSC synchronization.
  *
- * We first check wether all CPUs have their TSC's synchronized,
+ * We first check whether all CPUs have their TSC's synchronized,
  * then we print a warning if not, and always resync.
  */
 
diff -ur a/drivers/atm/firestream.c b/drivers/atm/firestream.c
--- a/drivers/atm/firestream.c	Mon Feb 24 11:05:09 2003
+++ b/drivers/atm/firestream.c	Tue Feb 25 18:47:34 2003
@@ -105,7 +105,7 @@
    The FS50 CAM (VP/VC match registers) always take the lowest channel
    number that matches. This is not a problem.
 
-   However, they also ignore wether the channel is enabled or
+   However, they also ignore whether the channel is enabled or
    not. This means that if you allocate channel 0 to 1.2 and then
    channel 1 to 0.0, then disabeling channel 0 and writing 0 to the
    match channel for channel 0 will "steal" the traffic from channel
diff -ur a/drivers/char/watchdog/i810-tco.c b/drivers/char/watchdog/i810-tco.c
--- a/drivers/char/watchdog/i810-tco.c	Mon Feb 24 11:05:05 2003
+++ b/drivers/char/watchdog/i810-tco.c	Tue Feb 25 18:47:36 2003
@@ -218,7 +218,7 @@
 
 		tco_expect_close = 0;
 
-		/* scan to see wether or not we got the magic character */
+		/* scan to see whether or not we got the magic character */
 		for (i = 0; i != len; i++) {
 			u8 c;
 			if(get_user(c, data+i))
diff -ur a/drivers/ieee1394/ohci1394.c b/drivers/ieee1394/ohci1394.c
--- a/drivers/ieee1394/ohci1394.c	Mon Feb 24 11:05:41 2003
+++ b/drivers/ieee1394/ohci1394.c	Tue Feb 25 18:47:39 2003
@@ -827,7 +827,7 @@
 		return 0;
 	}
 
-	/* Decide wether we have an iso, a request, or a response packet */
+	/* Decide whether we have an iso, a request, or a response packet */
 	if (packet->type == hpsb_raw)
 		d = &ohci->at_req_context;
 	else if (packet->tcode == TCODE_ISO_DATA) {
@@ -3530,7 +3530,7 @@
 	tasklet_init(&tasklet->tasklet, func, data);
 	tasklet->type = type;
 	/* We init the tasklet->link field, so we can list_del() it
-	 * without worrying wether it was added to the list or not. */
+	 * without worrying whether it was added to the list or not. */
 	INIT_LIST_HEAD(&tasklet->link);
 }
 
diff -ur a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
--- a/drivers/net/wireless/airo.c	Mon Feb 24 11:05:08 2003
+++ b/drivers/net/wireless/airo.c	Tue Feb 25 18:47:41 2003
@@ -970,7 +970,7 @@
 	int open;
 	struct net_device             *dev;
 	/* Note, we can have MAX_FIDS outstanding.  FIDs are 16-bits, so we
-	   use the high bit to mark wether it is in use. */
+	   use the high bit to mark whether it is in use. */
 #define MAX_FIDS 6
 	int                           fids[MAX_FIDS];
 	int registered;
diff -ur a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
--- a/drivers/s390/char/sclp.c	Mon Feb 24 11:05:35 2003
+++ b/drivers/s390/char/sclp.c	Tue Feb 25 18:47:44 2003
@@ -26,7 +26,7 @@
 #define SCLP_CORE_PRINT_HEADER "sclp low level driver: "
 
 /*
- * decides wether we make use of the macro MACHINE_IS_VM to
+ * decides whether we make use of the macro MACHINE_IS_VM to
  * configure the driver for VM at run time (a little bit
  * different behaviour); otherwise we use the default
  * settings in sclp_data.init_ioctls
diff -ur a/drivers/usb/image/mdc800.c b/drivers/usb/image/mdc800.c
--- a/drivers/usb/image/mdc800.c	Mon Feb 24 11:05:33 2003
+++ b/drivers/usb/image/mdc800.c	Tue Feb 25 18:47:47 2003
@@ -213,7 +213,7 @@
 
 
 /*
- * Checks wether the camera responds busy
+ * Checks whether the camera responds busy
  */
 static int mdc800_isBusy (char* ch)
 {
@@ -229,7 +229,7 @@
 
 
 /*
- * Checks wether the Camera is ready
+ * Checks whether the Camera is ready
  */
 static int mdc800_isReady (char *ch)
 {
diff -ur a/include/asm-ppc/uninorth.h b/include/asm-ppc/uninorth.h
--- a/include/asm-ppc/uninorth.h	Mon Feb 24 11:05:41 2003
+++ b/include/asm-ppc/uninorth.h	Tue Feb 25 18:47:49 2003
@@ -111,7 +111,7 @@
 #define UNI_N_ARB_CTRL_QACK_DELAY105	0x00
 
 /* This one _might_ return the CPU number of the CPU reading it;
- * the bootROM decides wether to boot or to sleep/spinloop depending
+ * the bootROM decides whether to boot or to sleep/spinloop depending
  * on this register beeing 0 or not
  */
 #define UNI_N_CPU_NUMBER		0x0050
diff -ur a/net/ipv4/netfilter/ip_nat_irc.c b/net/ipv4/netfilter/ip_nat_irc.c
--- a/net/ipv4/netfilter/ip_nat_irc.c	Mon Feb 24 11:06:02 2003
+++ b/net/ipv4/netfilter/ip_nat_irc.c	Tue Feb 25 18:47:51 2003
@@ -188,7 +188,7 @@
 
 	datalen = (*pskb)->len - iph->ihl * 4 - tcph->doff * 4;
 	LOCK_BH(&ip_irc_lock);
-	/* Check wether the whole IP/address pattern is carried in the payload */
+	/* Check whether the whole IP/address pattern is carried in the payload */
 	if (between(exp->seq + ct_irc_info->len,
 		    ntohl(tcph->seq),
 		    ntohl(tcph->seq) + datalen)) {
diff -ur a/sound/oss/maestro.c b/sound/oss/maestro.c
--- a/sound/oss/maestro.c	Mon Feb 24 11:05:42 2003
+++ b/sound/oss/maestro.c	Tue Feb 25 18:47:55 2003
@@ -252,7 +252,7 @@
 
 /* we try to setup 2^(dsps_order) /dev/dsp devices */
 static int dsps_order=0;
-/* wether or not we mess around with power management */
+/* whether or not we mess around with power management */
 static int use_pm=2; /* set to 1 for force */
 /* clocking for broken hardware - a few laptops seem to use a 50Khz clock
 	ie insmod with clocking=50000 or so */
@@ -3271,7 +3271,7 @@
 	outb(0x88, iobase+0x1f);
 
 	/* it appears some maestros (dell 7500) only work if these are set,
-		regardless of wether we use the assp or not. */
+		regardless of whether we use the assp or not. */
 
 	outb(0, iobase+0xA4); 
 	outb(3, iobase+0xA2); 
diff -ur a/sound/pci/es1968.c b/sound/pci/es1968.c
--- a/sound/pci/es1968.c	Mon Feb 24 11:05:38 2003
+++ b/sound/pci/es1968.c	Tue Feb 25 18:47:57 2003
@@ -2329,7 +2329,7 @@
 	outb(0x88, iobase+0x1f);
 
 	/* it appears some maestros (dell 7500) only work if these are set,
-	   regardless of wether we use the assp or not. */
+	   regardless of whether we use the assp or not. */
 
 	outb(0, iobase + ASSP_CONTROL_B);
 	outb(3, iobase + ASSP_CONTROL_A);	/* M: Reserved bits... */
