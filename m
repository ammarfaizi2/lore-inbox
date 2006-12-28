Return-Path: <linux-kernel-owner+w=401wt.eu-S1754843AbWL1NQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843AbWL1NQk (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 08:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754846AbWL1NQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 08:16:40 -0500
Received: from cacti.profiwh.com ([85.93.165.66]:43638 "EHLO cacti.profiwh.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754843AbWL1NQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 08:16:39 -0500
Message-id: <1214120557197983619@wsc.cz>
In-reply-to: <188453909150148968@wsc.cz>
Subject: [PATCH 2/4] Char: mxser, obsolete old, nonexperimental new
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Thu, 28 Dec 2006 14:16:43 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser, obsolete old, nonexperimental new

Mark v 1.x as obsolete and v 2.x as non-experimental in Kconfig.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit ce3d140accc090dee75676a4db2b1ddf7b39843e
tree a4322efa3ce3a55abd76340d769ec8e365a43b38
parent 8fc2346d2eab1a1780c319ddd77d818a270aba02
author Jiri Slaby <jirislaby@gmail.com> Sat, 23 Dec 2006 02:15:32 +0059
committer Jiri Slaby <jirislaby@gmail.com> Thu, 28 Dec 2006 13:48:56 +0059

 drivers/char/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 5a8974c..5841b77 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -191,7 +191,7 @@ config MOXA_INTELLIO
 	  module will be called moxa.
 
 config MOXA_SMARTIO
-	tristate "Moxa SmartIO support"
+	tristate "Moxa SmartIO support (OBSOLETE)"
 	depends on SERIAL_NONSTANDARD
 	help
 	  Say Y here if you have a Moxa SmartIO multiport serial card.
@@ -202,7 +202,7 @@ config MOXA_SMARTIO
 	  here.
 
 config MOXA_SMARTIO_NEW
-	tristate "Moxa SmartIO support v. 2.0 (EXPERIMENTAL)"
+	tristate "Moxa SmartIO support v. 2.0"
 	depends on SERIAL_NONSTANDARD && (PCI || EISA || ISA)
 	help
 	  Say Y here if you have a Moxa SmartIO multiport serial card and/or
