Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVCNLbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVCNLbJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 06:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVCNLbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 06:31:08 -0500
Received: from [151.97.230.9] ([151.97.230.9]:56329 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261372AbVCNLam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 06:30:42 -0500
Subject: [patch 1/2] uml: export getgid for hostfs
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 11 Mar 2005 20:29:45 +0100
Message-Id: <20050311192945.DEB396477@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Export this symbol which is now needed for a typo fix (getuid() -> getgid()).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/os-Linux/user_syms.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN arch/um/os-Linux/user_syms.c~uml-export-getgid-for-hostfs arch/um/os-Linux/user_syms.c
--- linux-2.6.11/arch/um/os-Linux/user_syms.c~uml-export-getgid-for-hostfs	2005-03-11 20:16:17.061368376 +0100
+++ linux-2.6.11-paolo/arch/um/os-Linux/user_syms.c	2005-03-11 20:16:17.065367768 +0100
@@ -82,6 +82,7 @@ EXPORT_SYMBOL_PROTO(statfs);
 EXPORT_SYMBOL_PROTO(statfs64);
 
 EXPORT_SYMBOL_PROTO(getuid);
+EXPORT_SYMBOL_PROTO(getgid);
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
_
