Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbTI1NSb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 09:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbTI1NHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 09:07:48 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:10281 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S262563AbTI1NGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 09:06:06 -0400
Date: Sun, 28 Sep 2003 14:55:24 +0200
Message-Id: <200309281255.h8SCtOsT005534@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 310] Atari Hades support is broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Atari Hades support is broken (needs updates for the new PCI code)

--- linux-2.6.0-test6/arch/m68k/Kconfig	Tue Sep  9 10:12:16 2003
+++ linux-m68k-2.6.0-test6/arch/m68k/Kconfig	Thu Sep 18 04:14:46 2003
@@ -90,7 +90,7 @@
 
 config HADES
 	bool "Hades support"
-	depends on ATARI
+	depends on ATARI && BROKEN
 	help
 	  This option enables support for the Hades Atari clone. If you plan
 	  to use this kernel on a Hades, say Y here; otherwise say N.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
