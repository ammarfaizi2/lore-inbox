Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289084AbSAVAQ1>; Mon, 21 Jan 2002 19:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289094AbSAVAQR>; Mon, 21 Jan 2002 19:16:17 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:17999 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S289084AbSAVAQP>; Mon, 21 Jan 2002 19:16:15 -0500
Date: Tue, 22 Jan 2002 11:41:47 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: linux-kernel@vger.kernel.org
Subject: [PATCHLET 2.2]agpgart_fe - less terse printk
Message-ID: <Pine.LNX.4.05.10201221136530.10478-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


IMVHO, this printk was somewhat too terse.

Regards,
Neale.

--- linux-2.2.21-pre2-pristine/drivers/char/agp/agpgart_fe.c	Sat Nov  3 03:39:06 2001
+++ linux-2.2.21-pre2-ntb/drivers/char/agp/agpgart_fe.c	Mon Jan 21 22:50:45 2002
@@ -300,7 +300,7 @@
 	agp_memory *memory;
 
 	memory = agp_allocate_memory(pg_count, type);
-   	printk(KERN_DEBUG "memory : %p\n", memory);
+   	printk(KERN_DEBUG "agp_allocate_memory: %p\n", memory);
 	if (memory == NULL) {
 		return NULL;
 	}

