Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262618AbRE3Fqb>; Wed, 30 May 2001 01:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262615AbRE3FqV>; Wed, 30 May 2001 01:46:21 -0400
Received: from [203.143.19.4] ([203.143.19.4]:49426 "EHLO kitul.learn.ac.lk")
	by vger.kernel.org with ESMTP id <S262617AbRE3FqP>;
	Wed, 30 May 2001 01:46:15 -0400
Date: Wed, 30 May 2001 01:17:49 +0600 (LKT)
From: Anuradha Ratnaweera <anuradha@gnu.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] compiler warning fixes in via82cxxx_audio.c
Message-ID: <Pine.LNX.4.21.0105300114400.424-100000@presario>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Following patch fixes a compiler warning in via82cxxx_audio.c.

Regards,

Anuradha

----------------------------------
http://www.bee.lk/people/anuradha/


diff -rua linux-2.4.5/drivers/sound/via82cxxx_audio.c linux/drivers/sound/via82cxxx_audio.c
--- linux-2.4.5/drivers/sound/via82cxxx_audio.c	Tue May 29 23:42:12 2001
+++ linux/drivers/sound/via82cxxx_audio.c	Wed May 30 01:11:29 2001
@@ -1371,7 +1371,6 @@
 static int __init via_ac97_reset (struct via_info *card)
 {
 	struct pci_dev *pdev = card->pdev;
-	u8 tmp8;
 	u16 tmp16;
 
 	DPRINTK ("ENTER\n");


