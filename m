Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264472AbTFQA2b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 20:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264476AbTFQA2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 20:28:31 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:54539 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S264472AbTFQA2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 20:28:30 -0400
Date: Mon, 16 Jun 2003 19:42:17 -0500
From: Art Haas <ahaas@airmail.net>
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 initializers for asm-alpha/include/xor.h
Message-ID: <20030617004217.GA21500@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch converts the file to C99 initializers. The patch is against
the current BK. The patch is untested as I don't have access to an Alpha
machine.

Art Haas

===== include/asm-alpha/xor.h 1.2 vs edited =====
--- 1.2/include/asm-alpha/xor.h	Sat Nov  9 06:16:32 2002
+++ edited/include/asm-alpha/xor.h	Mon Jun 16 18:18:35 2003
@@ -822,19 +822,19 @@
 ");
 
 static struct xor_block_template xor_block_alpha = {
-	name: "alpha",
-	do_2: xor_alpha_2,
-	do_3: xor_alpha_3,
-	do_4: xor_alpha_4,
-	do_5: xor_alpha_5,
+	.name	= "alpha",
+	.do_2	= xor_alpha_2,
+	.do_3	= xor_alpha_3,
+	.do_4	= xor_alpha_4,
+	.do_5	= xor_alpha_5,
 };
 
 static struct xor_block_template xor_block_alpha_prefetch = {
-	name: "alpha prefetch",
-	do_2: xor_alpha_prefetch_2,
-	do_3: xor_alpha_prefetch_3,
-	do_4: xor_alpha_prefetch_4,
-	do_5: xor_alpha_prefetch_5,
+	.name	= "alpha prefetch",
+	.do_2	= xor_alpha_prefetch_2,
+	.do_3	= xor_alpha_prefetch_3,
+	.do_4	= xor_alpha_prefetch_4,
+	.do_5	= xor_alpha_prefetch_5,
 };
 
 /* For grins, also test the generic routines.  */

-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
