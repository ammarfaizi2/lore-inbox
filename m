Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282969AbRLQWR4>; Mon, 17 Dec 2001 17:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282968AbRLQWRr>; Mon, 17 Dec 2001 17:17:47 -0500
Received: from www.transvirtual.com ([206.14.214.140]:59399 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S282955AbRLQWRh>; Mon, 17 Dec 2001 17:17:37 -0500
Date: Mon, 17 Dec 2001 14:17:19 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] block_ioctl EXPORT
Message-ID: <Pine.LNX.4.10.10112171416240.11180-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Another missed exported function when the IDE layer is completely compiled
modular. 

  .-.                               .-.
  oo|  Give Microsoft The Bird!!!!  oo|
 /`'\  Use Linux!!!                /`'\
(_;/)                            (_;/)
-----------------------------------------------------

--- /usr/src/linux-2.5.1/drivers/block/block_ioctl.c	Mon Dec 17 11:16:56 2001
+++ linux/drivers/block/block_ioctl.c	Mon Dec 17 15:05:42 2001
@@ -81,3 +81,5 @@
 #endif
 	return err;
 }
+
+EXPORT_SYMBOL(block_ioctl);

