Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVCVSBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVCVSBc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 13:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVCVSB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 13:01:27 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:14470 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261506AbVCVR4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 12:56:44 -0500
Subject: [patch 03/12] uml: export getgid for hostfs
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Tue, 22 Mar 2005 17:21:23 +0100
Message-Id: <20050322162123.890086BA6F@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Export this symbol which is not satisfied currently. The code using it has
been merged, so please export this symbol.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/os-Linux/user_syms.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN arch/um/os-Linux/user_syms.c~uml-export-getgid-for-hostfs arch/um/os-Linux/user_syms.c
--- linux-2.6.11/arch/um/os-Linux/user_syms.c~uml-export-getgid-for-hostfs	2005-03-21 15:25:39.000000000 +0100
+++ linux-2.6.11-paolo/arch/um/os-Linux/user_syms.c	2005-03-21 15:25:39.000000000 +0100
@@ -82,6 +82,7 @@ EXPORT_SYMBOL_PROTO(statfs);
 EXPORT_SYMBOL_PROTO(statfs64);
 
 EXPORT_SYMBOL_PROTO(getuid);
+EXPORT_SYMBOL_PROTO(getgid);
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
_
