Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbWACX1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbWACX1l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965050AbWACX1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:27:39 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:59355 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965022AbWACX10
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:27:26 -0500
To: torvalds@osdl.org
Subject: [PATCH 12/41] m68k: static vs. extern in amigaints.h
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1EtvYr-0003MG-HT@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:27:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133435734 -0500

extern declaration of static object removed from header

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/asm-m68k/amigaints.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

112440d40e9253c5f6d93e56af4781ba992bb2cd
diff --git a/include/asm-m68k/amigaints.h b/include/asm-m68k/amigaints.h
index 2aff4cf..aa968d0 100644
--- a/include/asm-m68k/amigaints.h
+++ b/include/asm-m68k/amigaints.h
@@ -109,8 +109,6 @@
 extern void amiga_do_irq(int irq, struct pt_regs *fp);
 extern void amiga_do_irq_list(int irq, struct pt_regs *fp);
 
-extern unsigned short amiga_intena_vals[];
-
 /* CIA interrupt control register bits */
 
 #define CIA_ICR_TA	0x01
-- 
0.99.9.GIT

