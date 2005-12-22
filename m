Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbVLVE7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbVLVE7n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965068AbVLVEuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:50:12 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:22736 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965057AbVLVEtp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:49:45 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 08/36] m68k: isa_{type,sex} should be exported
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIOe-0004qX-Gl@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:49:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133442860 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m68k/kernel/setup.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

3e4d99de694a5ce17f86b49ecf08b2f9bcbfe4fe
diff --git a/arch/m68k/kernel/setup.c b/arch/m68k/kernel/setup.c
index d6ca992..c4d4d05 100644
--- a/arch/m68k/kernel/setup.c
+++ b/arch/m68k/kernel/setup.c
@@ -100,6 +100,8 @@ void (*mach_beep)(unsigned int, unsigned
 #if defined(CONFIG_ISA) && defined(MULTI_ISA)
 int isa_type;
 int isa_sex;
+EXPORT_SYMBOL(isa_type);
+EXPORT_SYMBOL(isa_sex);
 #endif
 
 extern int amiga_parse_bootinfo(const struct bi_record *);
-- 
0.99.9.GIT

