Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVG1OsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVG1OsS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 10:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVG1OsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 10:48:12 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23301 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261510AbVG1OrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 10:47:07 -0400
Date: Thu, 28 Jul 2005 16:47:05 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/ppc/kernel/ppc_ksyms.c: remove unused #define EXPORT_SYMTAB_STROPS
Message-ID: <20050728144705.GK3528@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This #define is only used on sparc.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 10 Jul 2005

--- linux-2.6.13-rc2-mm1-full/arch/ppc/kernel/ppc_ksyms.c.old	2005-07-10 17:35:05.000000000 +0200
+++ linux-2.6.13-rc2-mm1-full/arch/ppc/kernel/ppc_ksyms.c	2005-07-10 17:35:12.000000000 +0200
@@ -51,9 +51,6 @@
 #include <asm/commproc.h>
 #endif
 
-/* Tell string.h we don't want memcpy etc. as cpp defines */
-#define EXPORT_SYMTAB_STROPS
-
 extern void transfer_to_handler(void);
 extern void do_IRQ(struct pt_regs *regs);
 extern void MachineCheckException(struct pt_regs *regs);

