Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270154AbUJEQi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270154AbUJEQi5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 12:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270149AbUJEQii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 12:38:38 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:62436 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S270047AbUJEQhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 12:37:52 -0400
Subject: [patch 1/1] uml: makefile fix for .lds scripts.
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Tue, 05 Oct 2004 18:20:43 +0200
Message-Id: <20041005162044.A6C11B005@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove uml.lds and dyn.lds from extra-y; this was a relict from the recent
past.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/kernel/Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/kernel/Makefile~uml-makefiles-lds-script-fix arch/um/kernel/Makefile
--- linux-2.6.9-current/arch/um/kernel/Makefile~uml-makefiles-lds-script-fix	2004-10-05 18:20:08.097717672 +0200
+++ linux-2.6.9-current-paolo/arch/um/kernel/Makefile	2004-10-05 18:20:08.099717368 +0200
@@ -3,7 +3,7 @@
 # Licensed under the GPL
 #
 
-extra-y := vmlinux.lds uml.lds dyn.lds
+extra-y := vmlinux.lds
 clean-files := vmlinux.lds.S
 
 obj-y = checksum.o config.o exec_kern.o exitcode.o frame_kern.o frame.o \
_
