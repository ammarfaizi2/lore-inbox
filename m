Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265500AbUATNpP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 08:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265505AbUATNpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 08:45:15 -0500
Received: from zork.zork.net ([64.81.246.102]:29117 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S265500AbUATNpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 08:45:13 -0500
To: Andrew Morton <akpm@osdl.org>, vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] missing space in printk message (was Re: 2.6.1-mm5)
References: <20040120000535.7fb8e683.akpm@osdl.org>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, vojtech@suse.cz,
 linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Date: Tue, 20 Jan 2004 13:45:01 +0000
In-Reply-To: <20040120000535.7fb8e683.akpm@osdl.org> (Andrew Morton's
 message of "Tue, 20 Jan 2004 00:05:35 -0800")
Message-ID: <6ur7xuzqci.fsf@zork.zork.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Against 2.6.1-mm5.


--- S1-mm5/drivers/input/keyboard/atkbd.c~	2004-01-20 13:36:13.000000000 +0000
+++ S1-mm5/drivers/input/keyboard/atkbd.c	2004-01-20 13:36:24.000000000 +0000
@@ -279,7 +279,7 @@
 				atkbd->translated ? "translated" : "raw", 
 				atkbd->set, code, serio->phys);
 			if (atkbd->translated && atkbd->set == 2 && code == 0x7a)
-				printk(KERN_WARNING "atkbd.c: This is an XFree86 bug. It shouldn't access"
+				printk(KERN_WARNING "atkbd.c: This is an XFree86 bug. It shouldn't access "
 					"hardware directly.\n");
 			else
 				printk(KERN_WARNING "atkbd.c: Use 'setkeycodes %s%02x <keycode>' to make it known.\n",						code & 0x80 ? "e0" : "", code & 0x7f);
