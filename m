Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161057AbWBNOzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161057AbWBNOzF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 09:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161060AbWBNOzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 09:55:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:275 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161049AbWBNOzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 09:55:03 -0500
Date: Tue, 14 Feb 2006 15:55:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: geert@linux-m68k.org, zippel@linux-m68k.org, linux-m68k@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/asm-m68k/irq.h: remove unused #define enable_irq_nosync
Message-ID: <20060214145501.GE10701@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/asm-m68k/irq.h #define's enable_irq_nosync, but it isn't used 
anywhere.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 5 Feb 2006

--- linux-2.6.16-rc1-mm5-full/include/asm-m68k/irq.h.old	2006-02-05 06:24:09.000000000 +0100
+++ linux-2.6.16-rc1-mm5-full/include/asm-m68k/irq.h	2006-02-05 06:24:21.000000000 +0100
@@ -79,7 +79,6 @@
 
 extern void (*enable_irq)(unsigned int);
 extern void (*disable_irq)(unsigned int);
-#define enable_irq_nosync	enable_irq
 
 struct pt_regs;
 

