Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbUCJSHs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 13:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUCJSHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 13:07:20 -0500
Received: from witte.sonytel.be ([80.88.33.193]:63134 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262750AbUCJSG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 13:06:27 -0500
Date: Wed, 10 Mar 2004 19:06:19 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Woodhouse <dwmw2@infradead.org>, Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] Applicom warning
Message-ID: <Pine.GSO.4.58.0403101905080.14075@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add missing include (needed for struct inode)

--- linux-2.6.4-rc3/drivers/char/applicom.c	2003-10-19 10:45:02.000000000 +0200
+++ linux-m68k-2.6.4-rc3/drivers/char/applicom.c	2004-03-04 17:07:57.000000000 +0100
@@ -29,6 +29,7 @@
 #include <linux/pci.h>
 #include <linux/wait.h>
 #include <linux/init.h>
+#include <linux/fs.h>

 #include <asm/io.h>
 #include <asm/uaccess.h>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
