Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVE0BKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVE0BKc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 21:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbVE0BHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 21:07:45 -0400
Received: from [151.97.230.9] ([151.97.230.9]:49937 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261429AbVE0BFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 21:05:20 -0400
Subject: [patch 1/8] uml: add modversions support
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 27 May 2005 02:38:29 +0200
Message-Id: <20050527003834.559631AE4C2@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Actually, the real support was added by some earlier patches. Now we simply
re-enable the config. option. I've actually tested it and it works well.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/init/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN init/Kconfig~uml-modversions-resupport init/Kconfig
--- linux-2.6.git/init/Kconfig~uml-modversions-resupport	2005-05-25 01:34:19.000000000 +0200
+++ linux-2.6.git-paolo/init/Kconfig	2005-05-25 01:34:19.000000000 +0200
@@ -442,7 +442,7 @@ config OBSOLETE_MODPARM
 
 config MODVERSIONS
 	bool "Module versioning support (EXPERIMENTAL)"
-	depends on MODULES && EXPERIMENTAL && !UML
+	depends on MODULES && EXPERIMENTAL
 	help
 	  Usually, you have to use modules compiled with your kernel.
 	  Saying Y here makes it sometimes possible to use modules
_
