Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVCNL2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVCNL2o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 06:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVCNL2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 06:28:44 -0500
Received: from [151.97.230.9] ([151.97.230.9]:53769 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261305AbVCNL2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 06:28:43 -0500
Subject: [patch 1/1] uml-export-getgid-for-hostfs
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 11 Mar 2005 20:27:52 +0100
Message-Id: <20050311192753.043836477@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/os-Linux/user_syms.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN arch/um/os-Linux/user_syms.c~uml-export-getgid-for-hostfs arch/um/os-Linux/user_syms.c
--- linux-2.6.11/arch/um/os-Linux/user_syms.c~uml-export-getgid-for-hostfs	2005-03-11 20:15:37.347405816 +0100
+++ linux-2.6.11-paolo/arch/um/os-Linux/user_syms.c	2005-03-11 20:15:43.868414472 +0100
@@ -82,6 +82,7 @@ EXPORT_SYMBOL_PROTO(statfs);
 EXPORT_SYMBOL_PROTO(statfs64);
 
 EXPORT_SYMBOL_PROTO(getuid);
+EXPORT_SYMBOL_PROTO(getgid);
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
_
