Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbUKDCCb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbUKDCCb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbUKDCAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:00:09 -0500
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:62867
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S262050AbUKDBz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:55:28 -0500
Subject: [patch 20/20] uml: add missing newline in help string
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org,
       blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 04 Nov 2004 00:18:02 +0100
Message-Id: <20041103231802.625B455C8F@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add missing newline in help string for "nosysemu" param. Run ./vmlinux --help
before and after to see the difference. Trivial - must go in.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/kernel/process.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/kernel/process.c~uml-add-missing-newline-in-help arch/um/kernel/process.c
--- vanilla-linux-2.6.9/arch/um/kernel/process.c~uml-add-missing-newline-in-help	2004-11-03 23:30:40.100163376 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/process.c	2004-11-03 23:30:40.102163072 +0100
@@ -235,7 +235,7 @@ __uml_setup("nosysemu", nosysemu_cmd_par
 		"    SYSEMU is a performance-patch introduced by Laurent Vivier. It changes\n"
 		"    behaviour of ptrace() and helps reducing host context switch rate.\n"
 		"    To make it working, you need a kernel patch for your host, too.\n"
-		"    See http://perso.wanadoo.fr/laurent.vivier/UML/ for further information.\n");
+		"    See http://perso.wanadoo.fr/laurent.vivier/UML/ for further information.\n\n");
 
 static void __init check_sysemu(void)
 {
_
