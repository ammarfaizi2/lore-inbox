Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276411AbRJKOZT>; Thu, 11 Oct 2001 10:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276429AbRJKOZI>; Thu, 11 Oct 2001 10:25:08 -0400
Received: from ns.caldera.de ([212.34.180.1]:26056 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S276411AbRJKOZB>;
	Thu, 11 Oct 2001 10:25:01 -0400
Date: Thu, 11 Oct 2001 16:24:29 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: gibbs@freebsd.org, gibbs@scsiguy.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: PATCH: AIC7xxx : readd MODULE_DEVICE_TABLE
Message-ID: <20011011162429.A27016@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin!

This change got lost somehow in one of your diffs. Was this intentional?

If not, please readd it, it helps with autoprobing.

Ciao, Marcus

Index: drivers/scsi/aic7xxx/aic7xxx_linux_pci.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/scsi/aic7xxx/aic7xxx_linux_pci.c,v
retrieving revision 1.16
diff -u -r1.16 aic7xxx_linux_pci.c
--- drivers/scsi/aic7xxx/aic7xxx_linux_pci.c	2001/08/13 06:47:27	1.16
+++ drivers/scsi/aic7xxx/aic7xxx_linux_pci.c	2001/10/11 14:16:27
@@ -56,6 +56,7 @@
 	},
 	{ 0 }
 };
+MODULE_DEVICE_TABLE(pci,ahc_linux_pci_id_table);
 
 struct pci_driver aic7xxx_pci_driver = {
 	name:		"aic7xxx",
