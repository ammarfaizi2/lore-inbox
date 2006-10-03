Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030479AbWJCWFO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030479AbWJCWFO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030593AbWJCWFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:05:14 -0400
Received: from av4.karneval.cz ([81.27.192.11]:46610 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S1030479AbWJCWFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:05:11 -0400
Message-id: <123402123123@karneval.cz>
Subject: [PATCH 3/6] Char: mxser_new, remove request for testers line
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
Date: Wed,  4 Oct 2006 00:05:07 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, remove request for testers line

Remove printk with info we are looking for a tester.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 1f480651fc90540603834743c1d3a598b2a0c722
tree 45dc81d4c6b194dba7bc0d3e655e41c2c1116296
parent 4c32efcfdb10227313ef7271ffc4658dbdf2d81c
author Jiri Slaby <jirislaby@gmail.com> Tue, 03 Oct 2006 22:46:43 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Tue, 03 Oct 2006 22:46:43 +0200

 drivers/char/mxser_new.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index db89d73..029b7e4 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -495,9 +495,6 @@ static int __init mxser_module_init(void
 
 	if (verbose)
 		printk(KERN_DEBUG "Loading module mxser ...\n");
-	printk(KERN_INFO "This is mxser driver version 1.9.1 and needs TESTING."
-		"If your are willing to test this driver, please report to "
-		"jirislaby@gmail.com. Thanks.\n");
 	ret = mxser_init();
 	if (verbose)
 		printk(KERN_DEBUG "Done.\n");
