Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274134AbRI0Xhf>; Thu, 27 Sep 2001 19:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274137AbRI0XhY>; Thu, 27 Sep 2001 19:37:24 -0400
Received: from lsd.nurk.org ([208.8.184.53]:31627 "HELO lsd.nurk.org")
	by vger.kernel.org with SMTP id <S274131AbRI0XhM>;
	Thu, 27 Sep 2001 19:37:12 -0400
Date: Thu, 27 Sep 2001 16:37:50 -0700 (PDT)
From: Sean Swallow <sean@swallow.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dan Hollis <goemon@anime.net>, <linux-kernel@vger.kernel.org>
Subject: Re: AMD viper chipset and UDMA100
In-Reply-To: <20010928002410.A18608@suse.cz>
Message-ID: <Pine.LNX.4.33.0109271637160.604-100000@lsd.nurk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech,

I would be interested in trying out your code.

cheers,

-- 
Sean J. Swallow
pgp (6.5.2) keyfile @ https://nurk.org/keyfile.txt


On Fri, 28 Sep 2001, Vojtech Pavlik wrote:

> On Thu, Sep 27, 2001 at 03:16:18PM -0700, Dan Hollis wrote:
>
> > On Thu, 27 Sep 2001, Vojtech Pavlik wrote:
> > > On Thu, Sep 27, 2001 at 02:26:50PM -0700, Sean Swallow wrote:
> > > > I just got a tyan tiger w/ the AMD Viper chipset on it. For some reason
> > > > Linux will only set the onboard (AMD viper) chains to UDMA33.
> > > > I'm using linux 2.4.9, and I have also tried 2.4.10. Is there a limitation
> > > > to the AMD Viper driver?
> > > > PS. The cables (2) are BRAND new ata100 cables.
> > > The Viper can do UDMA66 max. At least it's doing it for me quite well.
> >
> > If he's got the Tyan Tiger i'm thinking of, it's the Tyan S2460 with
> > AMD766 southbridge. Tyan says it will do U100:
> > http://www.tyan.com/products/html/tigermp.html
>
> This southbridge is called Viper Plus as far as I know. In the past,
> I've written a driver for this, but it didn't make it into the kernel,
> because Andre also had his version.
>
> > AMD does too:
> > http://www.amd.com/us-en/Processors/TechnicalResources/0,,30_182_873,00.html
> >
> > And I've got the same problem with my S2460:
> >
> > Uniform Multi-Platform E-IDE driver Revision: 6.31
> > ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> > AMD7411: IDE controller on PCI bus 00 dev 39
> > AMD7411: chipset revision 1
> > AMD7411: not 100% native mode: will probe irqs later
> > AMD7411: disabling single-word DMA support (revision < C4)
> >     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
> >     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
> > hda: 20010816 sectors (10246 MB) w/2048KiB Cache, CHS=1245/255/63, UDMA(33)
> > hdc: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(33)
> >
> > But these drives will do U66/U100:
> >
> > And yes, I *DO* have the proper cables. These same drives connected to a
> > Promise 20267 or a VIA KT133 with the same cables will do U66/U100
> > perfectly.
>
> Perhaps I could dig up my code and you can give it a test. Would you be
> interested?
>
>

