Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbUC3Xrc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 18:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbUC3Xrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 18:47:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5254 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261784AbUC3Xr3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 18:47:29 -0500
Message-ID: <406A0704.7060706@pobox.com>
Date: Tue, 30 Mar 2004 18:47:16 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Petr Sebor <petr@scssoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [sata] libata update
References: <4064E691.2070009@pobox.com> <4069FBC3.2080104@scssoft.com> <4069FFB1.3060503@pobox.com> <200403310139.36003.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200403310139.36003.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 31 of March 2004 01:16, Jeff Garzik wrote:
> 
>>Petr Sebor wrote:
>>
>>>Hi Jeff,
>>>
>>>I have upgraded from 2.6.3 to 2.6.5-rc3 and can't see the secondary
>>>sata drive anymore...
>>>
>>>I am seeing this:
>>>-------------------------------------------------------------------
>>>libata version 1.02 loaded.
>>>sata_via version 0.20
>>>sata_via(0000:00:0f.0): routed to hard irq line 11
>>>ata1: SATA max UDMA/133 cmd 0xC400 ctl 0xC802 bmdma 0xD400 irq 20
>>>ata2: SATA max UDMA/133 cmd 0xCC00 ctl 0xD002 bmdma 0xD408 irq 20
>>>ata1: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003
>>>88:203f
>>>ata1: dev 0 ATA, max UDMA/100, 488397168 sectors (lba48)
>>>ata1: dev 0 configured for UDMA/100
>>>scsi0 : sata_via
>>>ata2: no device found (phy stat 00000000)
>>>ata2: thread exiting
>>>scsi1 : sata_via
>>
>>oh, and are both disks SATA?
>>
>>Or is the 37G drive a PATA drive on a PATA->SATA adapter (a.k.a. bridge)?
> 
> 
>    Vendor: ATA       Model: WDC WD360GD-00FN  Rev: 1.00
>    Type:   Direct-Access                      ANSI SCSI revision: 05
> 
> WD Raptor electronics includes PATA->SATA bridge.

Yes, a lot of drives do.

I meant outside the drive, an adapter/bridge the user plugs into the 
device, that allows it to pretend it is a SATA device.

	Jeff




