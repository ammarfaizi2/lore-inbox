Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265747AbSKAVNU>; Fri, 1 Nov 2002 16:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265748AbSKAVNT>; Fri, 1 Nov 2002 16:13:19 -0500
Received: from mamona.cetuc.puc-rio.br ([139.82.74.4]:52365 "EHLO
	mamona.cetuc.puc-rio.br") by vger.kernel.org with ESMTP
	id <S265747AbSKAVNT>; Fri, 1 Nov 2002 16:13:19 -0500
Subject: [PATCH] 2.5.45 [TRIVIAL]: Cosmetic ide-cd error message printk
	format
From: Marcelo Roberto Jimenez <mroberto@cetuc.puc-rio.br>
To: Trivial Patch Monkey <trivial@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Nov 2002 18:19:34 -0200
Message-Id: <1036181975.2036.13.camel@genipapo>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is just part one, once I got the message. Now have I to 
figure out WHY I got this message :-)

Regards,

Marcelo.

diff -Nru a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c	Fri Nov  1 18:02:36 2002
+++ b/drivers/ide/ide-cd.c	Fri Nov  1 18:02:36 2002
@@ -1462,7 +1462,7 @@
 	} else {
 confused:
 		printk ("%s: cdrom_pc_intr: The drive "
-			"appears confused (ireason = 0x%2x)\n",
+			"appears confused (ireason = 0x%02x)\n",
 			drive->name, ireason);
 		rq->flags |= REQ_FAILED;
 	}



