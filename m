Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161398AbWJKVXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161398AbWJKVXq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161411AbWJKVGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:06:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:50591 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161410AbWJKVGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:06:13 -0400
Date: Wed, 11 Oct 2006 14:05:24 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Andrew Morton <akpm@osdl.org>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org,
       alan@lxorguk.ukuu.org.uk, Jeff Garzik <jeff@garzik.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 22/67] sky2 network driver device ids
Message-ID: <20061011210524.GW16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sky2-network-driver-device-ids.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Stephen Hemminger <shemminger@osdl.org>

This makes the id table match the current netdev upstream tree.

From: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/net/sky2.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- linux-2.6.18.orig/drivers/net/sky2.c
+++ linux-2.6.18/drivers/net/sky2.c
@@ -106,6 +106,7 @@ static const struct pci_device_id sky2_i
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYSKONNECT, 0x9000) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYSKONNECT, 0x9E00) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, 0x4b00) },	/* DGE-560T */
+	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK, 0x4001) }, 	/* DGE-550SX */
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4340) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4341) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4342) },
@@ -117,10 +118,17 @@ static const struct pci_device_id sky2_i
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4350) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4351) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4352) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4353) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4360) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4361) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4362) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4363) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4364) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4365) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4366) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4367) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4368) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, 0x4369) },
 	{ 0 }
 };
 

--
