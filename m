Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWBEFZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWBEFZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 00:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWBEFZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 00:25:55 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54281 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964888AbWBEFZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 00:25:55 -0500
Date: Sun, 5 Feb 2006 06:25:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: geert@linux-m68k.org, zippel@linux-m68k.org
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/asm-m68k/irq.h: remove unused #define enable_irq_nosync
Message-ID: <20060205052551.GC5271@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/asm-m68k/irq.h #define's enable_irq_nosync, but it isn't used 
anywhere.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc1-mm5-full/include/asm-m68k/irq.h.old	2006-02-05 06:24:09.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/include/asm-m68k/irq.h	2006-02-05 06:24:21.000000000 +0100
@@ -79,7 +79,6 @@
 
 extern void (*enable_irq)(unsigned int);
 extern void (*disable_irq)(unsigned int);
-#define enable_irq_nosync	enable_irq
 
 struct pt_regs;
 

