Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265179AbSKRWJL>; Mon, 18 Nov 2002 17:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265180AbSKRWJK>; Mon, 18 Nov 2002 17:09:10 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:994 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S265179AbSKRWJJ>;
	Mon, 18 Nov 2002 17:09:09 -0500
Date: Mon, 18 Nov 2002 23:16:04 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] More missing includes [1/4]
Message-ID: <Pine.GSO.4.21.0211182314490.16079-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add missing #include <linux/init.h>

--- linux-2.5.48/drivers/scsi/scsi.h	Mon Nov 18 10:03:40 2002
+++ linux-m68k-2.5.48/drivers/scsi/scsi.h	Mon Nov 18 14:18:21 2002
@@ -18,6 +18,7 @@
 #include <linux/config.h>	/* for CONFIG_SCSI_LOGGING */
 #include <linux/devfs_fs_kernel.h>
 #include <linux/proc_fs.h>
+#include <linux/init.h>
 
 /*
  * Some of the public constants are being moved to this file.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

