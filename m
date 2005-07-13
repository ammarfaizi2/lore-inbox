Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbVGMReO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbVGMReO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVGMRcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:32:33 -0400
Received: from mta04.mail.t-online.hu ([195.228.240.57]:23545 "EHLO
	mta04.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S261931AbVGMRbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:31:24 -0400
Subject: [PATCH 17/19] Kconfig I18N: xconfig: symbol fix
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
Date: Wed, 13 Jul 2005 19:31:23 +0200
Message-Id: <1121275883.2975.47.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I18N support for symbol names are unnecessary.

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>
---

 scripts/kconfig/qconf.cc |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN scripts/kconfig/qconf.cc~kconfig-i18n-17-qconfig-symbol-fix scripts/kconfig/qconf.cc
--- linux-2.6.13-rc3-i18n-kconfig/scripts/kconfig/qconf.cc~kconfig-i18n-17-qconfig-symbol-fix	2005-07-13 18:32:19.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/kconfig/qconf.cc	2005-07-13 18:32:19.000000000 +0200
@@ -1038,12 +1038,12 @@ void ConfigMainWindow::setHelp(QListView
 			head += "</b></big>";
 			if (sym->name) {
 				head += " (";
-				head += print_filter(_(sym->name));
+				head += print_filter(sym->name);
 				head += ")";
 			}
 		} else if (sym->name) {
 			head += "<big><b>";
-			head += print_filter(_(sym->name));
+			head += print_filter(sym->name);
 			head += "</b></big>";
 		}
 		head += "<br><br>";
_


