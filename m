Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275355AbTHMTvS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 15:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275375AbTHMTvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 15:51:18 -0400
Received: from ip64-48-93-2.z93-48-64.customer.algx.net ([64.48.93.2]:57520
	"EHLO ns1.limegroup.com") by vger.kernel.org with ESMTP
	id S275355AbTHMTvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 15:51:14 -0400
Date: Wed, 13 Aug 2003 15:51:10 -0400 (EDT)
From: Ion Badulescu <ionut@badula.org>
X-X-Sender: ion@guppy.limebrokerage.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Tulip driver support for the 3Com 3CSOHO100B-TX
Message-ID: <Pine.LNX.4.44.0308131538410.8431-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

This patch adds the PCI id's for the 3Com 3CSOHO100B-TX to tulip_core.c. 
I've got this chip (which looks like a rebranded Comet) on a new Albatron 
KX600 Pro, and I can confirm that the tulip driver can handle it just 
fine.

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
-----------------------------------
--- linux-2.4.22/drivers/net/tulip/tulip_core.c.old	Fri Aug  8 14:02:45 2003
+++ linux-2.4.22/drivers/net/tulip/tulip_core.c	Wed Aug 13 15:46:26 2003
@@ -232,6 +232,7 @@
 	{ 0x17B3, 0xAB08, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },
 	{ 0x14f1, 0x1803, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CONEXANT },
 	{ 0x10b9, 0x5261, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DM910X },	/* ALi 1563 integrated ethernet */
+	{ 0x10b7, 0x9300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET },	/* 3Com 3CSOHO100B-TX */
 	{ } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, tulip_pci_tbl);

