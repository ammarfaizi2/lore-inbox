Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265608AbTBPCVr>; Sat, 15 Feb 2003 21:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265637AbTBPCVr>; Sat, 15 Feb 2003 21:21:47 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:18191 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S265608AbTBPCVq>; Sat, 15 Feb 2003 21:21:46 -0500
Subject: [PATCH] 2.5.61 more accurate spelling of accuracy
From: Steven Cole <elenstev@mesatop.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 15 Feb 2003 19:23:24 -0700
Message-Id: <1045362206.5965.58.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This provides a accurate spelling of accuracy.

Steven


diff -ur linux-2.5.61-1.1027-orig/include/asm-arm/arch-pxa/time.h linux-2.5.61-1.1027/include/asm-arm/arch-pxa/time.h
--- linux-2.5.61-1.1027-orig/include/asm-arm/arch-pxa/time.h	Thu Jan 16 19:22:07 2003
+++ linux-2.5.61-1.1027/include/asm-arm/arch-pxa/time.h	Sat Feb 15 19:12:18 2003
@@ -53,7 +53,7 @@
 	int next_match;
 
 	/* Loop until we get ahead of the free running timer.
-	 * This ensures an exact clock tick count and time acuracy.
+	 * This ensures an exact clock tick count and time accuracy.
 	 * IRQs are disabled inside the loop to ensure coherence between
 	 * lost_ticks (updated in do_timer()) and the match reg value, so we
 	 * can use do_gettimeofday() from interrupt handlers.
diff -ur linux-2.5.61-1.1027-orig/include/asm-arm/arch-sa1100/time.h linux-2.5.61-1.1027/include/asm-arm/arch-sa1100/time.h
--- linux-2.5.61-1.1027-orig/include/asm-arm/arch-sa1100/time.h	Thu Jan 16 19:23:00 2003
+++ linux-2.5.61-1.1027/include/asm-arm/arch-sa1100/time.h	Sat Feb 15 19:11:56 2003
@@ -67,7 +67,7 @@
  * We will be entered with IRQs enabled.
  *
  * Loop until we get ahead of the free running timer.
- * This ensures an exact clock tick count and time acuracy.
+ * This ensures an exact clock tick count and time accuracy.
  * IRQs are disabled inside the loop to ensure coherence between
  * lost_ticks (updated in do_timer()) and the match reg value, so we
  * can use do_gettimeofday() from interrupt handlers.




