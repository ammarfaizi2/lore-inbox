Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTJMIaI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 04:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbTJMIaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 04:30:08 -0400
Received: from amsfep12-int.chello.nl ([213.46.243.18]:48986 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S261539AbTJMIaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 04:30:05 -0400
Date: Mon, 13 Oct 2003 10:31:17 +0200
Message-Id: <200310130831.h9D8VHt5015675@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 337] M68k export csum_partial
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M68k: Export missing symbol csum_partial

--- linux-2.6.0-test7/arch/m68k/lib/checksum.c	Thu Nov 28 10:19:26 2002
+++ linux-m68k-2.6.0-test7/arch/m68k/lib/checksum.c	Thu Oct  9 15:16:10 2003
@@ -125,6 +125,7 @@
 	return(sum);
 }
 
+EXPORT_SYMBOL(csum_partial);
 
 
 /*

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
