Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316614AbSHaPCn>; Sat, 31 Aug 2002 11:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317471AbSHaPCn>; Sat, 31 Aug 2002 11:02:43 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:29683
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316614AbSHaPCn>; Sat, 31 Aug 2002 11:02:43 -0400
Subject: Re: 2.4.20-pre5-ac1 and Intel ICH3M EIDE woes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3elcguiq7.fsf@lapper.ihatent.com>
References: <m3elcguiq7.fsf@lapper.ihatent.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 31 Aug 2002 16:07:36 +0100
Message-Id: <1030806456.3449.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-30 at 22:42, Alexander Hoogerhuis wrote:
> ICH3M: IDE controller at PCI slot 00:1f.1
> PCI: Device 00:1f.1 not available because of resource collisions
> PCI: Assigned IRQ 11 for device 00:1f.1
> ICH3M: Not fully BIOS configured!

Looks fine to me. We reconfigured the relevant bits

> ICH3M: chipset revision 2
> ICH3M: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0x4440-0x4447, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0x4448-0x444f, BIOS settings: hdc:DMA, hdd:pio

And you got full DMA

