Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318248AbSHDWNQ>; Sun, 4 Aug 2002 18:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318249AbSHDWNQ>; Sun, 4 Aug 2002 18:13:16 -0400
Received: from ares.sdinet.de ([193.103.161.26]:65292 "HELO ares.sdinet.de")
	by vger.kernel.org with SMTP id <S318248AbSHDWNP>;
	Sun, 4 Aug 2002 18:13:15 -0400
Date: Mon, 5 Aug 2002 00:17:00 +0200 (CEST)
From: Sven Koch <haegar@sdinet.de>
X-X-Sender: haegar@space.comunit.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: alien.ant@ntlworld.com, <linux-kernel@vger.kernel.org>
Subject: Re: Re: 2.4.19 IDE Partition Check issue
In-Reply-To: <1028488801.15200.4.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208050012200.29388-100000@space.comunit.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Aug 2002, Alan Cox wrote:

> On Sun, 2002-08-04 at 10:11, alien.ant@ntlworld.com wrote:
> > > Can you try 2.4.19-ac1 once I upload it.
> > > That has slightly further updated IDE code and it would
> > > useful to know if the same problem occurs
> >
> > Yes, it has exactly the same problem as stock 2.4.19
> >
> > Sorry!
>
> I'm out of ideas on the promise one then.

Perhaps one funny thing which got me with 2.4.19-rc3-ac3 bites you here
too:

With a "VIA vt82c596b (rev 23) IDE UDMA66 controller on pci00:07.1" a am
not able to boot or read the partition-table, UNLESS I select
CONFIG_IDEDMA_AUTO=y

If want to play safe and "use the slow pio modes" its broken, with
dma from the start it works without further problems.

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)

