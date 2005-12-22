Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965121AbVLVFBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbVLVFBB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 00:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbVLVFAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 00:00:32 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:24272 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965066AbVLVEuK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:50:10 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 13/36] m68k: static vs. extern in amigaints.h
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIP3-0004rO-IL@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:50:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133435734 -0500

extern declaration of static object removed from header

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 include/asm-m68k/amigaints.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

b6c724850218171c583673055920e48692f12209
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

