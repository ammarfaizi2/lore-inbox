Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268881AbUH3Tq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268881AbUH3Tq7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 15:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268408AbUH3Tpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 15:45:46 -0400
Received: from ppp-62-11-78-150.dialup.tiscali.it ([62.11.78.150]:61057 "EHLO
	zion.localdomain") by vger.kernel.org with ESMTP id S268882AbUH3TpT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 15:45:19 -0400
Subject: [patch 1/1] Refer to CONFIG_USERMODE, not to CONFIG_UM
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Mon, 30 Aug 2004 21:41:36 +0200
Message-Id: <20040830194136.6CAEE7D67@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Correct one Kconfig dependency, which should refer to CONFIG_USERMODE rather
than to CONFIG_UM.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.8.1-paolo/drivers/char/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/char/Kconfig~CONFIG_UM-is-USERMODE drivers/char/Kconfig
--- vanilla-linux-2.6.8.1/drivers/char/Kconfig~CONFIG_UM-is-USERMODE	2004-08-30 16:06:58.826847672 +0200
+++ vanilla-linux-2.6.8.1-paolo/drivers/char/Kconfig	2004-08-30 16:06:58.829847216 +0200
@@ -59,7 +59,7 @@ config VT_CONSOLE
 
 config HW_CONSOLE
 	bool
-	depends on VT && !S390 && !UM
+	depends on VT && !S390 && !USERMODE
 	default y
 
 config SERIAL_NONSTANDARD
_
