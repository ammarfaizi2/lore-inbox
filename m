Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161103AbWJKQY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161103AbWJKQY1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 12:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030671AbWJKQY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 12:24:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53692 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030670AbWJKQY0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 12:24:26 -0400
To: torvalds@osdl.org
Subject: [PATCH] m32r: C99 initializers in setup.c
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXgsb-0005Y1-6T@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 11 Oct 2006 17:24:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/m32r/kernel/setup.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/m32r/kernel/setup.c b/arch/m32r/kernel/setup.c
index 3f35ab3..0e7778b 100644
--- a/arch/m32r/kernel/setup.c
+++ b/arch/m32r/kernel/setup.c
@@ -369,10 +369,10 @@ static void c_stop(struct seq_file *m, v
 }
 
 struct seq_operations cpuinfo_op = {
-	start:	c_start,
-	next:	c_next,
-	stop:	c_stop,
-	show:	show_cpuinfo,
+	.start = c_start,
+	.next = c_next,
+	.stop = c_stop,
+	.show = show_cpuinfo,
 };
 #endif	/* CONFIG_PROC_FS */
 
-- 
1.4.2.GIT


