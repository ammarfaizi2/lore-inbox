Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268165AbRGWKLH>; Mon, 23 Jul 2001 06:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268171AbRGWKK5>; Mon, 23 Jul 2001 06:10:57 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:64321 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S268165AbRGWKKq>;
	Mon, 23 Jul 2001 06:10:46 -0400
Date: Mon, 23 Jul 2001 11:12:06 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [patch] one-liner bugfix to 2.4.7 (microcode.c)
Message-ID: <Pine.LNX.4.21.0107231106330.612-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi Linus,

A trivial fix, please apply.

Regards,
Tigran

--- linux/arch/i386/kernel/microcode.c	Fri Feb  9 19:29:44 2001
+++ linux-mc/arch/i386/kernel/microcode.c	Mon Jul 23 10:53:08 2001
@@ -126,6 +126,7 @@
 		printk(KERN_ERR "microcode: failed to devfs_register()\n");
 		goto out;
 	}
+	error = 0;
 	printk(KERN_INFO 
 		"IA-32 Microcode Update Driver: v%s <tigran@veritas.com>\n", 
 		MICROCODE_VERSION);


