Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317399AbSIATjd>; Sun, 1 Sep 2002 15:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317400AbSIATjc>; Sun, 1 Sep 2002 15:39:32 -0400
Received: from 24-168-145-62.nj.rr.com ([24.168.145.62]:63310 "HELO
	larvalstage.com") by vger.kernel.org with SMTP id <S317399AbSIATjc>;
	Sun, 1 Sep 2002 15:39:32 -0400
Date: Sun, 1 Sep 2002 15:52:36 -0400 (EDT)
From: John Kim <john@larvalstage.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.5.33] trivial compile fix for include/asm-arm/arch-pxa/pxa-regs.h
Message-ID: <Pine.LNX.4.44.0209011549070.15519-100000@daria.larvalstage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a simple compile fix patch for 2.5.33.

John Kim


diff -Naur linux-2.5.33/include/asm-arm/arch-pxa/pxa-regs.h linux-2.5.33-new/include/asm-arm/arch-pxa/pxa-regs.h
--- linux-2.5.33/include/asm-arm/arch-pxa/pxa-regs.h	Sun Sep  1 15:00:00 2002
+++ linux-2.5.33-new/include/asm-arm/arch-pxa/pxa-regs.h	Sun Sep  1 15:11:01 2002
@@ -362,7 +362,7 @@
 #define LSR_OE		(1 << 1)	/* Overrun Error */
 #define LSR_DR		(1 << 0)	/* Data Ready */

-#define MCR_LOOP	(1 << 4)	*/
+#define MCR_LOOP	(1 << 4)
 #define MCR_OUT2	(1 << 3)	/* force MSR_DCD in loopback mode */
 #define MCR_OUT1	(1 << 2)	/* force MSR_RI in loopback mode */
 #define MCR_RTS		(1 << 1)	/* Request to Send */

