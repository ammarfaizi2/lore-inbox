Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVGJPho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVGJPho (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 11:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbVGJPho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 11:37:44 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26373 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261959AbVGJPh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 11:37:28 -0400
Date: Sun, 10 Jul 2005 17:37:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/ppc/kernel/ppc_ksyms.c: remove unused #define EXPORT_SYMTAB_STROPS
Message-ID: <20050710153722.GM28243@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This #define is only used on sparc.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

