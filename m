Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVEIXXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVEIXXb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 19:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVEIXVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 19:21:45 -0400
Received: from [151.97.230.9] ([151.97.230.9]:31506 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261385AbVEIXVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 19:21:38 -0400
Subject: [patch 3/6] uml: add modversions support
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Tue, 10 May 2005 00:45:15 +0200
Message-Id: <20050509224515.4EF5F13C216@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Actually, the real support was added by some earlier patches. Now we simply
re-enable the config. option. I've actually tested it and it works well.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/init/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN init/Kconfig~uml-modversions-resupport init/Kconfig
--- linux-2.6.git/init/Kconfig~uml-modversions-resupport	2005-05-10 00:38:21.000000000 +0200
+++ linux-2.6.git-paolo/init/Kconfig	2005-05-10 00:38:21.000000000 +0200
@@ -442,7 +442,7 @@ config OBSOLETE_MODPARM
 
 config MODVERSIONS
 	bool "Module versioning support (EXPERIMENTAL)"
-	depends on MODULES && EXPERIMENTAL && !UML
+	depends on MODULES && EXPERIMENTAL
 	help
 	  Usually, you have to use modules compiled with your kernel.
 	  Saying Y here makes it sometimes possible to use modules
_
