Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbULNBT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbULNBT1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 20:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbULNBT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 20:19:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54800 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261374AbULNBKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 20:10:39 -0500
Date: Tue, 14 Dec 2004 02:10:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@HansenPartnership.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386 voyager_smp.c: remove a duplicate #include
Message-ID: <20041214011033.GU23151@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason including this file twice.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.9-mm1-full/arch/i386/mach-voyager/voyager_smp.c.old	2004-10-22 21:37:31.000000000 +0200
+++ linux-2.6.9-mm1-full/arch/i386/mach-voyager/voyager_smp.c	2004-10-22 21:42:20.000000000 +0200
@@ -27,7 +27,6 @@
 #include <asm/mtrr.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
-#include <asm/desc.h>
 #include <asm/arch_hooks.h>
 
 #include <linux/irq.h>

