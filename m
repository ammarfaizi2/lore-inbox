Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbRA3Evy>; Mon, 29 Jan 2001 23:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129398AbRA3Evn>; Mon, 29 Jan 2001 23:51:43 -0500
Received: from dandelion.com ([198.186.200.3]:33033 "EHLO dandelion.com")
	by vger.kernel.org with ESMTP id <S129274AbRA3Ev2>;
	Mon, 29 Jan 2001 23:51:28 -0500
Date: Mon, 29 Jan 2001 20:51:15 -0800
Message-Id: <200101300451.f0U4pFB14761@dandelion.com>
From: "Leonard N. Zubkoff" <lnz@dandelion.com>
To: rasmus@jaquet.dk
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20010129224838.I603@jaquet.dk> (message from Rasmus Andersen on
	Mon, 29 Jan 2001 22:48:38 +0100)
Subject: Re: [PATCH] drivers/scsi/BusLogic.c: No resource probing before pci_enable_device (241p11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Date: Mon, 29 Jan 2001 22:48:38 +0100
  From: Rasmus Andersen <rasmus@jaquet.dk>

  The following patch makes drivers/scsi/BusLogic.c wait with probing
  pdev->irq and pdev->resource[] until we call pci_enable_device. This
  is recommended due to hot-plug considerations (according to Jeff Garzik).

  It applies against ac12 and 241p11.

  Comments?

At a quick glance it looks reasonable to me.

		Leonard
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
