Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVGMRZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVGMRZp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVGMRXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:23:48 -0400
Received: from mta04.mail.t-online.hu ([195.228.240.57]:9152 "EHLO
	mta04.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S261561AbVGMRXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:23:09 -0400
Subject: [PATCH 11/19] Kconfig I18N: gconfig: symbol fix
From: Egry =?ISO-8859-1?Q?G=E1bor?= <gaboregry@t-online.hu>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
In-Reply-To: <1121273456.2975.3.camel@spirit>
References: <1121273456.2975.3.camel@spirit>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 19:23:07 +0200
Message-Id: <1121275388.2975.34.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I18N support for symbol names are unnecessary.

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>
---

 scripts/kconfig/gconf.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN scripts/kconfig/gconf.c~kconfig-i18n-11-gconfig-symbol-fix scripts/kconfig/gconf.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/kconfig/gconf.c~kconfig-i18n-11-gconfig-symbol-fix	2005-07-13 18:32:18.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/kconfig/gconf.c	2005-07-13 18:32:18.000000000 +0200
@@ -474,7 +474,7 @@ static void text_insert_help(struct menu
 		help = _(menu->sym->help);
 
 	if (menu->sym && menu->sym->name)
-		name = g_strdup_printf(_(menu->sym->name));
+		name = g_strdup_printf(menu->sym->name);
 	else
 		name = g_strdup("");
 
_


