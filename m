Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268395AbTAMWvO>; Mon, 13 Jan 2003 17:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268394AbTAMWvO>; Mon, 13 Jan 2003 17:51:14 -0500
Received: from mail.mediaways.net ([193.189.224.113]:28315 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP
	id <S268395AbTAMWvM>; Mon, 13 Jan 2003 17:51:12 -0500
Subject: Re: Linux 2.4.21-pre3-ac3 and KT400
From: Soeren Sonnenburg <kernel@nn7.de>
To: Edward Tandi <ed@efix.biz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1042497524.2819.51.camel@wires.home.biz>
References: <1042495829.1223.10.camel@sun>
	 <1042497524.2819.51.camel@wires.home.biz>
Content-Type: text/plain
Organization: 
Message-Id: <1042498392.1191.31.camel@sun>
Mime-Version: 1.0
Date: 13 Jan 2003 23:53:12 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-13 at 23:38, Edward Tandi wrote:
> On Mon, 2003-01-13 at 22:10, Soeren Sonnenburg wrote:
> > [...]
> > > I am running Linux on an ASUS A7V8X, VIA KT400 chipset motherboard.
> > > The processor is a 1.5GHz Athlon XP. I started experimenting with
> > > new-ish kernels again because of the general lack of kernel support
> > > for this chipset in stock kernels. 3 questions below:
> > 
> > Hey finally someone with my setup :-))
> > 
> > > 1) I have 1GB ram, but I cannot get high memory support to work. It
> > > falls over during boot. I've seen discussions about AMD cache issues,
> > > but has it been fixed yet? Is it supposed to work?
> > 
> > I am using older kernels (2.4.20) and it seems to work...
> 
> Yes, but as you mention below, it is unstable.

Well it works rock stable - except for one of my harddisks freezing once
in a week (but that is another issue) - if I don't use the two
additional promise TX2 ide controllers (extra cards not the onboard
stuff).

> OK. I am using the OSS driver. Still, it should work normally.

agreed.

> > 3) I get the following messages at boot-time:
> > [...]
> > > Jan 13 18:23:05 wires kernel: hda: dma_intr: error=0x84 {
> > > DriveStatusError BadCRC }
> > > Jan 13 18:23:05 wires kernel: blk: queue c0437940, I/O limit 4095Mb
[...] 
> > That sounds like a bad cable. Do you use 80wires ide cables, connectors
> > attached to the ends ?
> 
> No, but my drives are old and only support UDMA 2 anyway. I get most
> things off the LAN. It should really enable UDMA 2.

hmmhh, I would consider checking the harddisk then... it might be
defective.

Soeren.

