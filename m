Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263715AbTDGWll (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 18:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263722AbTDGWlk (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 18:41:40 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:35200
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263715AbTDGWlg (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 18:41:36 -0400
Date: Tue, 8 Apr 2003 01:00:31 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080000.h3800VKA008888@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: alpha typos part 2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/arch/alpha/kernel/setup.c linux-2.5.67-ac1/arch/alpha/kernel/setup.c
--- linux-2.5.67/arch/alpha/kernel/setup.c	2003-02-10 18:38:01.000000000 +0000
+++ linux-2.5.67-ac1/arch/alpha/kernel/setup.c	2003-04-03 23:49:57.000000000 +0100
@@ -486,7 +486,7 @@
 	notifier_chain_register(&panic_notifier_list, &alpha_panic_block);
 
 #ifdef CONFIG_ALPHA_GENERIC
-	/* Assume that we've booted from SRM if we havn't booted from MILO.
+	/* Assume that we've booted from SRM if we haven't booted from MILO.
 	   Detect the later by looking for "MILO" in the system serial nr.  */
 	alpha_using_srm = strncmp((const char *)hwrpb->ssn, "MILO", 4) != 0;
 #endif
@@ -569,7 +569,7 @@
 #endif
 
 	/*
-	 * Indentify and reconfigure for the current system.
+	 * Identify and reconfigure for the current system.
 	 */
 	cpu = (struct percpu_struct*)((char*)hwrpb + hwrpb->processor_offset);
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/arch/alpha/kernel/time.c linux-2.5.67-ac1/arch/alpha/kernel/time.c
--- linux-2.5.67/arch/alpha/kernel/time.c	2003-03-06 17:04:22.000000000 +0000
+++ linux-2.5.67-ac1/arch/alpha/kernel/time.c	2003-04-03 23:49:57.000000000 +0100
@@ -331,7 +331,7 @@
 
 	/* From John Bowman <bowman@math.ualberta.ca>: allow the values
 	   to settle, as the Update-In-Progress bit going low isn't good
-	   enough on some hardware.  2ms is our guess; we havn't found 
+	   enough on some hardware.  2ms is our guess; we haven't found 
 	   bogomips yet, but this is close on a 500Mhz box.  */
 	__delay(1000000);
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/arch/alpha/lib/strrchr.S linux-2.5.67-ac1/arch/alpha/lib/strrchr.S
--- linux-2.5.67/arch/alpha/lib/strrchr.S	2003-02-10 18:38:51.000000000 +0000
+++ linux-2.5.67-ac1/arch/alpha/lib/strrchr.S	2003-04-03 23:49:57.000000000 +0100
@@ -2,7 +2,7 @@
  * arch/alpha/lib/strrchr.S
  * Contributed by Richard Henderson (rth@tamu.edu)
  *
- * Return the address of the last occurrance of a given character
+ * Return the address of the last occurrence of a given character
  * within a null-terminated string, or null if it is not found.
  */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/arch/alpha/math-emu/math.c linux-2.5.67-ac1/arch/alpha/math-emu/math.c
--- linux-2.5.67/arch/alpha/math-emu/math.c	2003-02-10 18:38:59.000000000 +0000
+++ linux-2.5.67-ac1/arch/alpha/math-emu/math.c	2003-04-03 23:49:57.000000000 +0100
@@ -294,7 +294,7 @@
 	 *	  the appropriate signal to the translated program.
 	 *
 	 * In addition, properly track the exception state in software
-	 * as described in the Alpha Architectre Handbook section 4.7.7.3.
+	 * as described in the Alpha Architecture Handbook section 4.7.7.3.
 	 */
 done:
 	if (_fex) {
