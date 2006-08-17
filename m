Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932497AbWHQN0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbWHQN0I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbWHQN0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:26:07 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:27553 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S932481AbWHQN0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:26:05 -0400
Date: Thu, 17 Aug 2006 13:26:40 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: mikep@linuxtr.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 1/75] net: drivers/net/tokenring/3c359.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132640.1.yoveaO3659.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/tokenring/3c359.c linux-work2/drivers/net/tokenring/3c359.c
--- linux-work-clean/drivers/net/tokenring/3c359.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/tokenring/3c359.c	2006-08-17 05:18:07.000000000 +0200
@@ -1815,7 +1815,7 @@ static struct pci_driver xl_3c359_driver
 
 static int __init xl_pci_init (void)
 {
-	return pci_module_init (&xl_3c359_driver);
+	return pci_register_driver(&xl_3c359_driver);
 }
 
 
