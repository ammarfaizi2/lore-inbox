Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270930AbTG0WlA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 18:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270931AbTG0WlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 18:41:00 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:42757 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S270930AbTG0Wk7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:40:59 -0400
Date: Mon, 28 Jul 2003 00:46:35 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com, hch@lst.de, torvalds@osdl.org
Subject: [PATCH] 2.6.0-test2 - typo in drivers/net/arcnet/com20020-isa.c
Message-ID: <20030728004635.A28671@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Typo during last module refcounting fix.


 drivers/net/arcnet/com20020-isa.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/net/arcnet/com20020-isa.c~janitor-driver-com20020 drivers/net/arcnet/com20020-isa.c
--- linux-2.6.0-test2/drivers/net/arcnet/com20020-isa.c~janitor-driver-com20020	Mon Jul 28 00:19:49 2003
+++ linux-2.6.0-test2-fr/drivers/net/arcnet/com20020-isa.c	Mon Jul 28 00:19:49 2003
@@ -152,7 +152,7 @@ int init_module(void)
 	lp->clockp = clockp & 7;
 	lp->clockm = clockm & 3;
 	lp->timeout = timeout & 3;
-	lp->owner = THIS_MODULE;
+	lp->hw.owner = THIS_MODULE;
 
 	dev->base_addr = io;
 	dev->irq = irq;

_
