Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262856AbTC0EPf>; Wed, 26 Mar 2003 23:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262859AbTC0EPf>; Wed, 26 Mar 2003 23:15:35 -0500
Received: from dp.samba.org ([66.70.73.150]:30147 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262856AbTC0EPe>;
	Wed, 26 Mar 2003 23:15:34 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Module typo fixup
Date: Thu, 27 Mar 2003 15:26:26 +1100
Message-Id: <20030327042648.AEC902C054@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply after those last three (sent a slightly dated patch #2).

--- working-2.5.66-bk2-extable-list/kernel/module.c.~1~	2003-03-27 15:24:21.000000000 +1100
+++ working-2.5.66-bk2-extable-list/kernel/module.c	2003-03-27 15:24:55.000000000 +1100
@@ -1249,7 +1249,7 @@
 		goto cleanup;
 
 	/* Set up EXPORTed & EXPORT_GPLed symbols (section 0 is 0 length) */
-	mod->num_syms = sechdrs[exportindex].sh_size / sizeof(*mod->syms);
+	mod->num_ksyms = sechdrs[exportindex].sh_size / sizeof(*mod->syms);
 	mod->syms = (void *)sechdrs[exportindex].sh_addr;
 	if (crcindex)
 		mod->crcs = (void *)sechdrs[crcindex].sh_addr;
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
