Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270031AbUJEQiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270031AbUJEQiE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 12:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269340AbUJEQiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 12:38:03 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:54434 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S270031AbUJEQhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 12:37:45 -0400
Subject: [patch 1/1] uml:makefile whitespace fix
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Tue, 05 Oct 2004 18:27:36 +0200
Message-Id: <20041005162736.6F03DB007@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Change the spacing for this command to fix alignment on output.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/kernel/Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/kernel/Makefile~uml-kbuild-whitespace-fix arch/um/kernel/Makefile
--- linux-2.6.9-current/arch/um/kernel/Makefile~uml-kbuild-whitespace-fix	2004-10-05 18:25:45.225466464 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/Makefile	2004-10-05 18:25:45.227466160 +0200
@@ -35,7 +35,7 @@ $(USER_OBJS) : %.o: %.c
 
 QUOTE = 'my $$config=`cat $(TOPDIR)/.config`; $$config =~ s/"/\\"/g ; $$config =~ s/\n/\\n"\n"/g ; while(<STDIN>) { $$_ =~ s/CONFIG/$$config/; print $$_ }'
 
-quiet_cmd_quote = QUOTE $@
+quiet_cmd_quote = QUOTE   $@
 cmd_quote = $(PERL) -e $(QUOTE) < $< > $@
 
 targets += config.c
_
