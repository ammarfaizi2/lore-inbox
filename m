Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbUBTM5h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 07:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbUBTMz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 07:55:57 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:34658 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S261200AbUBTMxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 07:53:07 -0500
Date: Fri, 20 Feb 2004 13:48:24 +0100
Message-Id: <200402201248.i1KCmOK9004317@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 413] Mac IOP spelling
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mac IOP spelling fix (from Matthias Urlichs)

--- linux-2.6.3/arch/m68k/mac/iop.c	2003-05-27 19:02:33.000000000 +0200
+++ linux-m68k-2.6.3/arch/m68k/mac/iop.c	2004-02-08 21:39:11.000000000 +0100
@@ -87,7 +87,7 @@
  * or more messages on the receive channels have gone to the MSG_NEW state.
  *
  * Since each channel handles only one message we have to implement a small
- * interrupt-driven queue on our end. Messages to e sent are placed on the
+ * interrupt-driven queue on our end. Messages to be sent are placed on the
  * queue for sending and contain a pointer to an optional callback function.
  * The handler for a message is called when the message state goes to
  * MSG_COMPLETE.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
