Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbVHBS2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVHBS2o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 14:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVHBS2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 14:28:44 -0400
Received: from [12.29.88.206] ([12.29.88.206]:59346 "EHLO quack.solace.net")
	by vger.kernel.org with ESMTP id S261693AbVHBS2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 14:28:43 -0400
Date: Tue, 2 Aug 2005 14:28:42 -0400
From: Nash <nash@solace.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12.3] drivers/pci: recognize more ICH7 PCI/SATA chips
Message-ID: <20050802182842.GC25843@quack.solace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Updated pci/quirks.c to recognize additional ICH7 PCI/SATA controller
chips such as those integrated on the ASUS P5WD2 Premium motherboard.

Signed-off-by: Nash E Foster <nash@solace.net>

Index: linux-2.6.13-rc4-mm1/mm/mempolicy.c
===================================================================
--- linux/drivers/pci/quirks.c  2005-07-26 22:32:09.000000000 -0400
+++ linux-2.6.12.3/drivers/pci/quirks.c 2005-07-15 17:18:57.000000000
-0400
@@ -1199,7 +1199,6 @@
        case 0x2680:    /* ESB2 */
                ich = 6;
                break;
-       case 0x27b8:
        case 0x27c0:
        case 0x27c4:
                ich = 7;

