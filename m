Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWAIT1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWAIT1j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWAIT1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:27:39 -0500
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:44811 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1750704AbWAIT1i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:27:38 -0500
Date: Mon, 9 Jan 2006 20:27:54 +0100
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH] cs89x0: Fix the Kconfig help text
Message-Id: <20060109202754.4aa8ea54.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, Lennert,

Fix the help text of the cs89x0 network driver Kconfig entry.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/net/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15-git.orig/drivers/net/Kconfig	2006-01-09 18:29:50.000000000 +0100
+++ linux-2.6.15-git/drivers/net/Kconfig	2006-01-09 20:17:33.000000000 +0100
@@ -1384,7 +1384,7 @@
 
 	  To compile this driver as a module, choose M here and read
 	  <file:Documentation/networking/net-modules.txt>.  The module will be
-	  called cs89x.
+	  called cs89x0.
 
 config TC35815
 	tristate "TOSHIBA TC35815 Ethernet support"


-- 
Jean Delvare
