Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbWHQN1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWHQN1m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWHQN1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:27:41 -0400
Received: from euridica.enternet.net.pl ([62.233.231.82]:49057 "EHLO
	euridica.enternet.net.pl") by vger.kernel.org with ESMTP
	id S964856AbWHQN1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:27:10 -0400
Date: Thu, 17 Aug 2006 13:27:44 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: becker@scyld.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC][PATCH 23/75] net: drivers/net/epic100.c pci_module_init to pci_register_driver conversion
Message-ID: <20060817132744.23.HwyrYe4219.3636.michal@euridica.enternet.net.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
In-Reply-To: <20060817132638.0.iSIzDm3640.3636.michal@euridica.enternet.net.pl>  
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/drivers/net/epic100.c linux-work2/drivers/net/epic100.c
--- linux-work-clean/drivers/net/epic100.c	2006-08-16 22:41:00.000000000 +0200
+++ linux-work2/drivers/net/epic100.c	2006-08-17 05:14:49.000000000 +0200
@@ -1604,7 +1604,7 @@ static int __init epic_init (void)
 		version, version2, version3);
 #endif
 
-	return pci_module_init (&epic_driver);
+	return pci_register_driver(&epic_driver);
 }
 
 
