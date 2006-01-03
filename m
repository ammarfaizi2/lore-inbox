Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965138AbWACXoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbWACXoI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbWACX1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:27:08 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56283 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965031AbWACX1B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:27:01 -0500
To: torvalds@osdl.org
Subject: [PATCH 07/41] m68k: isa_{type,sex} should be exported
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1EtvYS-0003Li-GM@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:27:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133442860 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m68k/kernel/setup.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

686fa8e15aa9e02bbae03b02c6539053bb923346
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

