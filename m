Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422645AbVLOJTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422645AbVLOJTz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 04:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422662AbVLOJTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 04:19:49 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:63619 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422653AbVLOJTK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 04:19:10 -0500
To: torvalds@osdl.org
Subject: [PATCH] arch/powerpc/kernel/syscalls.c __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EmpGY-000814-4x@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 15 Dec 2005 09:19:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>


---

 arch/powerpc/kernel/syscalls.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

1d7fd4a3b28ba2cdcc4d66bf03f16be74330d1d2
diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index f72ced1..91b93d9 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -247,7 +247,7 @@ long ppc64_personality(unsigned long per
 #define OVERRIDE_MACHINE    0
 #endif
 
-static inline int override_machine(char *mach)
+static inline int override_machine(char __user *mach)
 {
 	if (OVERRIDE_MACHINE) {
 		/* change ppc64 to ppc */
-- 
0.99.9.GIT

