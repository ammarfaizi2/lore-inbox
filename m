Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbVIUGmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbVIUGmE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 02:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbVIUGmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 02:42:04 -0400
Received: from xenotime.net ([66.160.160.81]:48591 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932135AbVIUGmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 02:42:03 -0400
Date: Tue, 20 Sep 2005 23:42:00 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, jdike@karaya.com
Subject: [PATCH] clarify help text for INIT_ENV_ARG_LIMIT
Message-Id: <20050920234200.084a344e.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Try to make the INIT_ENV_ARG_LIMIT help text more readable
and understandable.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---

 init/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp linux-2614-rc2/init/Kconfig~help_text linux-2614-rc2/init/Kconfig
--- linux-2614-rc2/init/Kconfig~help_text	2005-09-20 19:31:56.000000000 -0700
+++ linux-2614-rc2/init/Kconfig	2005-09-20 22:54:47.000000000 -0700
@@ -60,8 +60,8 @@ config INIT_ENV_ARG_LIMIT
 	default 32 if !USERMODE
 	default 128 if USERMODE
 	help
-	  This is the value of the two limits on the number of argument and of
-	  env.var passed to init from the kernel command line.
+	  Maximum of each of the number of arguments and environment
+	  variables passed to init from the kernel command line.
 
 endmenu
 

---

