Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267368AbSKPV2F>; Sat, 16 Nov 2002 16:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267369AbSKPV2F>; Sat, 16 Nov 2002 16:28:05 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:14326 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267368AbSKPV2E>; Sat, 16 Nov 2002 16:28:04 -0500
Date: Sat, 16 Nov 2002 22:34:55 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: rmk@arm.linux.org.uk, nico@cam.org,
       Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, John Kim <john@larvalstage.com>,
       trivial@rustcorp.com.au
Subject: [PATCH][2.5.33] trivial compile fix for include/asm-arm/arch-pxa/pxa-regs.h (fwd)
Message-ID: <20021116213455.GH28356@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The obviously correct patch in the forwarded mail below isn't in 2.5.47.

Please apply
Adrian


----- Forwarded message from John Kim <john@larvalstage.com> -----

Date: Sun, 1 Sep 2002 15:52:36 -0400 (EDT)
From: John Kim <john@larvalstage.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.5.33] trivial compile fix for include/asm-arm/arch-pxa/pxa-regs.h


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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

