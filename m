Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbTHTIXW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 04:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbTHTIMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 04:12:55 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:60877 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S261821AbTHTIEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 04:04:47 -0400
Date: Wed, 20 Aug 2003 18:05:56 +1000
Message-Id: <200308200805.h7K85uIe011803@theirongiant.lochness.weebeastie.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 15/16] C99: 2.6.0-t3-bk7/scripts
Cc: Linus Torvalds <torvalds@osdl.org>
From: CaT <cat@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -aur linux.backup/scripts/kconfig/symbol.c linux/scripts/kconfig/symbol.c
--- linux.backup/scripts/kconfig/symbol.c	Thu Jun 26 23:48:14 2003
+++ linux/scripts/kconfig/symbol.c	Wed Aug 20 16:40:22 2003
@@ -12,21 +12,21 @@
 #include "lkc.h"
 
 struct symbol symbol_yes = {
-	name: "y",
-	curr: { "y", yes },
-	flags: SYMBOL_YES|SYMBOL_VALID,
+	.name = "y",
+	.curr = { "y", yes },
+	.flags = SYMBOL_YES|SYMBOL_VALID,
 }, symbol_mod = {
-	name: "m",
-	curr: { "m", mod },
-	flags: SYMBOL_MOD|SYMBOL_VALID,
+	.name = "m",
+	.curr = { "m", mod },
+	.flags = SYMBOL_MOD|SYMBOL_VALID,
 }, symbol_no = {
-	name: "n",
-	curr: { "n", no },
-	flags: SYMBOL_NO|SYMBOL_VALID,
+	.name = "n",
+	.curr = { "n", no },
+	.flags = SYMBOL_NO|SYMBOL_VALID,
 }, symbol_empty = {
-	name: "",
-	curr: { "", no },
-	flags: SYMBOL_VALID,
+	.name = "",
+	.curr = { "", no },
+	.flags = SYMBOL_VALID,
 };
 
 int sym_change_count;
