Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbTJAQ16 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 12:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbTJAQZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 12:25:54 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:20887 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262407AbTJAQVa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 12:21:30 -0400
Subject: [PATCH] [TRIVIAL 12/12] 2.6.0-test6-bk remove reference to
	modules.txt in sound/Kconfig
From: Steven Cole <elenstev@mesatop.com>
To: Jaroslav Kysela <perex@suse.cz>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Content-Type: text/plain
Organization: 
Message-Id: <1065025225.1995.2425.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 01 Oct 2003 10:20:25 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the reference to Documentation/modules.txt,
which has been removed.  The patch was made against the current
2.6-bk tree.

This patch was also done slightly differently than the rest, removing
only the reference to Documentation/modules.txt, and maintaining the
reference to the other document.

Steven

--- 2.6-bk-current/sound/Kconfig	2003-09-30 21:12:05.000000000 -0600
+++ linux/sound/Kconfig	2003-09-30 22:31:50.000000000 -0600
@@ -25,8 +25,8 @@
 	  compile the sound card support as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want)
 	  and load that module after the PnP configuration is finished.  To do
-	  this, say M here and read <file:Documentation/modules.txt> as well
-	  as <file:Documentation/sound/oss/README.modules>; the module will be
+	  this, say M here and read
+	  <file:Documentation/sound/oss/README.modules>; the module will be
 	  called soundcore.
 
 	  I'm told that even without a sound card, you can make your computer







