Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275848AbRI1F4L>; Fri, 28 Sep 2001 01:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275850AbRI1F4C>; Fri, 28 Sep 2001 01:56:02 -0400
Received: from cc839443-a.chmbl1.ga.home.com ([24.5.105.138]:31237 "EHLO spock")
	by vger.kernel.org with ESMTP id <S275848AbRI1Fz7>;
	Fri, 28 Sep 2001 01:55:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steven Joerger <steven@spock.2y.net>
To: "David Grant" <davidgrant79@hotmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: ide drive problem?
Date: Fri, 28 Sep 2001 01:55:59 -0400
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20010928041519.968EA4FA00@spock> <OE55yDnSI4nHp4PlNMu00004f47@hotmail.com>
In-Reply-To: <OE55yDnSI4nHp4PlNMu00004f47@hotmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010928060858.9CFA74FA00@spock>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

Thanks for the insight. I am using an 80 pin cable, but the length and 
quality are of course suspect. I will swap this out and see if it helps.

Thanks again,
Steven Joerger


On Friday 28 September 2001 01:44 am, David Grant wrote:
> I think the standard response people would give you is that your IDE cable
> is too long, of bad quality, or you are using a 40-pin cable instead of an
> 80-pin cable (although I'm pretty sure that should have been detected, and
> DMA should automatically have not been used, but I heard at one point that
> the code which detected this on motherboards using the vt82c686b chip
> didn't really work in some cases).
>
> That's the standard answer, but I used to get this messages on my machine
> as well (I think it was back when I was trying to use my VIA chipset with
> Redhat 7.1).  I don't seem to get them anymore though, but maybe that's
> just because I'm trying to install distros newer than Redhat 7.1.  That
> makes me think that I never had CRC errors, it was just some buggy VIA
> code.
>
> I just get the dma timeout errors now with my VIA IDE controller.  I also
> get them with the Promise controller (sigh...).
>
> David Grant
>
> ----- Original Message -----
> From: "Steven Joerger" <steven@spock.2y.net>
> To: <linux-kernel@vger.kernel.org>
> Sent: Thursday, September 27, 2001 9:02 PM
> Subject: ide drive problem?
>
> > List,
> >
> > When I enable support for my chipset in the kernel (via kt133) I always
>
> get
>
> > these messages:
> >
> > hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> > hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> >
> > over and over and ....
> >
> > Any clues to whats going on?
> >
> > Thanks,
> > Steven Joerger
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
