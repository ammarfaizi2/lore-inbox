Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbUC3Xdt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 18:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbUC3XcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 18:32:13 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:14533 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261671AbUC3XcC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 18:32:02 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeff Garzik <jgarzik@pobox.com>, Petr Sebor <petr@scssoft.com>
Subject: Re: [sata] libata update
Date: Wed, 31 Mar 2004 01:39:35 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <4064E691.2070009@pobox.com> <4069FBC3.2080104@scssoft.com> <4069FFB1.3060503@pobox.com>
In-Reply-To: <4069FFB1.3060503@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403310139.36003.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 of March 2004 01:16, Jeff Garzik wrote:
> Petr Sebor wrote:
> > Hi Jeff,
> >
> > I have upgraded from 2.6.3 to 2.6.5-rc3 and can't see the secondary
> > sata drive anymore...
> >
> > I am seeing this:
> > -------------------------------------------------------------------
> > libata version 1.02 loaded.
> > sata_via version 0.20
> > sata_via(0000:00:0f.0): routed to hard irq line 11
> > ata1: SATA max UDMA/133 cmd 0xC400 ctl 0xC802 bmdma 0xD400 irq 20
> > ata2: SATA max UDMA/133 cmd 0xCC00 ctl 0xD002 bmdma 0xD408 irq 20
> > ata1: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003
> > 88:203f
> > ata1: dev 0 ATA, max UDMA/100, 488397168 sectors (lba48)
> > ata1: dev 0 configured for UDMA/100
> > scsi0 : sata_via
> > ata2: no device found (phy stat 00000000)
> > ata2: thread exiting
> > scsi1 : sata_via
>
> oh, and are both disks SATA?
>
> Or is the 37G drive a PATA drive on a PATA->SATA adapter (a.k.a. bridge)?

   Vendor: ATA       Model: WDC WD360GD-00FN  Rev: 1.00
   Type:   Direct-Access                      ANSI SCSI revision: 05

WD Raptor electronics includes PATA->SATA bridge.

Bartlomiej

