Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266926AbTBLD6b>; Tue, 11 Feb 2003 22:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266967AbTBLD6b>; Tue, 11 Feb 2003 22:58:31 -0500
Received: from desnol.ru ([217.150.58.11]:18438 "EHLO desnol.ru")
	by vger.kernel.org with ESMTP id <S266926AbTBLD6a>;
	Tue, 11 Feb 2003 22:58:30 -0500
From: "agri" <agri@desnol.ru>
To: maxxle@t-online.de (maxxle), linux-kernel@vger.kernel.org
Reply-To: agri@desnol.ru
Subject: Re: Can't enable dma on /dev/hda
Date: Wed, 12 Feb 2003 07:06:40 +0800
Message-Id: <20030212070640.M56325@desnol.ru>
In-Reply-To: <1044991886.3923.43.camel@sam>
References: <1044991886.3923.43.camel@sam>
X-Mailer: Open WebMail 1.64 20020415
X-OriginatingIP: 217.150.59.18 (agri)
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I suppose that your chip is not supported by kernel. :-(

Kernel support only 82C*** chips... as you see, it's not your chip.
i have VT82C598 bridge, and dma is available on my system.

Agri

---------- Original Message -----------
From: maxxle@t-online.de (maxxle)
To: linux-kernel@vger.kernel.org
Sent: 11 Feb 2003 19:31:16 +0000
Subject: Can't enable dma on /dev/hda

> Hi!
> 
> I'm running a debian 3.0 System using kernel 2.4.19 (also tried 
> 2.4.20). On this system it's not possible to enable dma on /dev/hda 
> (HDD IDE)
> 
> The MoBo is a VIA Board called VIA-C3M266 (CLE266 chipset)
> Northbridge: VT8623
> Southbridge: VT8235
> 
> My kernel is compiled with this features:
> ATAPI/IDE/MFM/RLL support --> IDE, ATA and ATAPI Block devices --> 
> [*] generic PCI bus-master DMA support
> [*] Use PCI DMA by default when available  
> [*] VIA82CXXX chipset support
> 
> And this is what hdparm tels me:
> hdparm -d 1 /dev/hda:
> 
> /dev/hda:
>  setting using_dma to 1 (on)
>  HDIO_SET_DMA failed: Operation not permitted
>  using_dma    =  0 (off)
> 
> What can I do to force my system to run using dma on /dev/hda.
> Or is my CLE266 chipset a bit too new for being supported by 2.4.19/20?
> 
> Hope somebody is able to help me
> 
> maxxle
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-
> kernel" in the body of a message to majordomo@vger.kernel.org More 
> majordomo info at  http://vger.kernel.org/majordomo-info.html Please 
> read the FAQ at  http://www.tux.org/lkml/
------- End of Original Message -------

