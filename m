Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWELX4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWELX4X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWELXpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:45:00 -0400
Received: from mx.pathscale.com ([64.160.42.68]:64681 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932295AbWELXoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:34 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 49 of 53] ipath - NULL-terminate pci_device_id table
X-Mercurial-Node: 40532fdc53f0f1befcd74178d5aa7f7d59681f6b
Message-Id: <40532fdc53f0f1befcd7.1147477414@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:34 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 49b446b12f16 -r 40532fdc53f0 drivers/infiniband/hw/ipath/ipath_driver.c
--- a/drivers/infiniband/hw/ipath/ipath_driver.c	Fri May 12 15:55:29 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_driver.c	Fri May 12 15:55:29 2006 -0700
@@ -120,6 +120,7 @@ static const struct pci_device_id ipath_
 		    PCI_DEVICE_ID_INFINIPATH_HT)},
 	{PCI_DEVICE(PCI_VENDOR_ID_PATHSCALE,
 		    PCI_DEVICE_ID_INFINIPATH_PE800)},
+	{0}
 };
 
 MODULE_DEVICE_TABLE(pci, ipath_pci_tbl);
