Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTI1SWH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 14:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262666AbTI1SWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 14:22:07 -0400
Received: from amsfep16-int.chello.nl ([213.46.243.26]:54873 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S262652AbTI1SWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 14:22:05 -0400
Date: Sun, 28 Sep 2003 14:55:30 +0200
Message-Id: <200309281255.h8SCtUlF005588@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 319] MVME166/7 CD2401 serial is broken
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MVME166/7 CD2401 serial is broken (needs taskqueue updates)

--- linux-2.6.0-test6/arch/m68k/Kconfig	Tue Sep  9 10:12:16 2003
+++ linux-m68k-2.6.0-test6/arch/m68k/Kconfig	Fri Sep 19 14:11:50 2003
@@ -993,7 +993,7 @@
 
 config SERIAL167
 	bool "CD2401 support for MVME166/7 serial ports"
-	depends on MVME16x
+	depends on MVME16x && BROKEN
 	help
 	  This is the driver for the serial ports on the Motorola MVME166,
 	  167, and 172 boards.  Everyone using one of these boards should say

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
