Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312962AbSGUTgZ>; Sun, 21 Jul 2002 15:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSGUTgY>; Sun, 21 Jul 2002 15:36:24 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23313 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312962AbSGUTgX>; Sun, 21 Jul 2002 15:36:23 -0400
Subject: PATCH: 2.5.27 Fix dump non compile in ad1848 audio
To: torvalds@transmeta.com, davej@suse.de, linux-kernel@vger.kernel.org
Date: Sun, 21 Jul 2002 21:03:40 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17WMvc-0007XV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Header cleanups mean init.h now actually needs to be included properly

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.27/sound/isa/ad1848/ad1848_lib.c linux-2.5.27-ac1/sound/isa/ad1848/ad1848_lib.c
--- linux-2.5.27/sound/isa/ad1848/ad1848_lib.c	Sat Jul 20 20:11:16 2002
+++ linux-2.5.27-ac1/sound/isa/ad1848/ad1848_lib.c	Sun Jul 21 17:28:32 2002
@@ -26,6 +26,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
+#include <linux/init.h>
 #include <sound/core.h>
 #include <sound/ad1848.h>
 
