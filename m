Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262983AbTCSMQo>; Wed, 19 Mar 2003 07:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262987AbTCSMQo>; Wed, 19 Mar 2003 07:16:44 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:10887 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S262983AbTCSMQm>;
	Wed, 19 Mar 2003 07:16:42 -0500
Date: Wed, 19 Mar 2003 13:27:44 +0100 (MET)
Message-Id: <200303191227.h2JCRir00904@vervain.sonytel.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] WD33c93 missing export
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wd33c93 SCSI: Export wd33c93_proc_info (needed for Amiga A3000, A2091, and GVP
II SCSI, and for MVME147 SCSI).

--- linux-2.5.x/drivers/scsi/wd33c93.c	Wed Mar  5 11:56:14 2003
+++ linux-m68k-2.5.x/drivers/scsi/wd33c93.c	Wed Mar  5 15:54:51 2003
@@ -2086,3 +2086,4 @@
 EXPORT_SYMBOL(wd33c93_abort);
 EXPORT_SYMBOL(wd33c93_queuecommand);
 EXPORT_SYMBOL(wd33c93_intr);
+EXPORT_SYMBOL(wd33c93_proc_info);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
