Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUH0Qc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUH0Qc0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 12:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266532AbUH0Qc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 12:32:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4995 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266519AbUH0QcO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 12:32:14 -0400
Message-ID: <412F6203.9020701@pobox.com>
Date: Fri, 27 Aug 2004 12:32:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Petter_Sundl=F6f?= <petter.sundlof@findus.dhs.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Cannot enable DMA on SATA drive (SCSI-libsata, VIA SATA)
References: <412F5D50.7000807@findus.dhs.org>
In-Reply-To: <412F5D50.7000807@findus.dhs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petter Sundlöf wrote:
> Using 2.6.8.1. DMA works fine on /dev/hda (PATA, CD burner).
> 
> When I try to enable it for my SATA drive (which is performing horribly 
> bad -- 80-90% CPU load on an AMD64 3200+ during copy of large files) I 
> get this error:

> sata_via(0000:00:0f.0): routed to hard irq line 10
> ata1: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xD000 irq 20
> ata2: SATA max UDMA/133 cmd 0xD800 ctl 0xD402 bmdma 0xD008 irq 20
> ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69 86:3e01 87:4003 
> 88:407f
> ata1: dev 0 ATA, max UDMA/133, 398297088 sectors: lba48
> ata1: dev 0 configured for UDMA/133


DMA is always enabled.

	Jeff


