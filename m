Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbUC3XRK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 18:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUC3XRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 18:17:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29573 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261524AbUC3XQO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 18:16:14 -0500
Message-ID: <4069FFB1.3060503@pobox.com>
Date: Tue, 30 Mar 2004 18:16:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Petr Sebor <petr@scssoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [sata] libata update
References: <4064E691.2070009@pobox.com> <4069FBC3.2080104@scssoft.com>
In-Reply-To: <4069FBC3.2080104@scssoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Sebor wrote:
> Hi Jeff,
> 
> I have upgraded from 2.6.3 to 2.6.5-rc3 and can't see the secondary
> sata drive anymore...
> 
> I am seeing this:
> -------------------------------------------------------------------
> libata version 1.02 loaded.
> sata_via version 0.20
> sata_via(0000:00:0f.0): routed to hard irq line 11
> ata1: SATA max UDMA/133 cmd 0xC400 ctl 0xC802 bmdma 0xD400 irq 20
> ata2: SATA max UDMA/133 cmd 0xCC00 ctl 0xD002 bmdma 0xD408 irq 20
> ata1: dev 0 cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003 
> 88:203f
> ata1: dev 0 ATA, max UDMA/100, 488397168 sectors (lba48)
> ata1: dev 0 configured for UDMA/100
> scsi0 : sata_via
> ata2: no device found (phy stat 00000000)
> ata2: thread exiting
> scsi1 : sata_via

oh, and are both disks SATA?

Or is the 37G drive a PATA drive on a PATA->SATA adapter (a.k.a. bridge)?

Do you have any special settings like BIOS RAID turned on, that might 
interfere with things?

	Jeff



