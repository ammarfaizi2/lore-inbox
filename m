Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269550AbRHMVHY>; Mon, 13 Aug 2001 17:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269767AbRHMVHP>; Mon, 13 Aug 2001 17:07:15 -0400
Received: from hinako.ambusiness.com ([64.59.51.7]:48141 "EHLO
	Hinako.AMBusiness.com") by vger.kernel.org with ESMTP
	id <S269432AbRHMVHE>; Mon, 13 Aug 2001 17:07:04 -0400
Message-ID: <010b01c1243b$df3509b0$0ac809c0@optima>
From: "Anthony Barbachan" <barbacha@Hinako.AMBusiness.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E15WOG9-0008A5-00@the-village.bc.nu>
Subject: Re: Are we going too fast?
Date: Mon, 13 Aug 2001 17:06:49 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Welcome to wacky hardware. To get a G400 stable on x86 you need at
least
> > >
> > > XFree86 4.1 if you are running hardware 3D (and DRM 4.1)
> > > 2.4.8 or higher with the VIA fixes
> > > Preferably a very recent BIOS update for the VIA box
> >
> > I'm sorry, but what "VIA fixes" are we referring to?
>
> Certain VIA chipsets had some nasty bugs that caused corruption. The older
> kernels have a workaround that mostly does the job but has a few side
> effects. The 2.4.8 kernel has the official VIA provided workaround, which
> makes sbpci128 cards work again, and sorts out some bus hangs, especially
> with matrox cards

    Could these "fixes" resolve any issues with the vt82c686a Southbridge?
For the life of me I have yet to be able to get my FIC VA-503A (that uses a
vt82c686a Southbridge for UDMA66 support) working correctly under Linux
2.4.x (or 2.2.x with the enhanced IDE patch) with DMA enabled by default.
And yes I have already tried switching the 80 pin cables 7 times.  Heck, I
even get CRC errors on UDMA33 drives using 40 pin cables; albeit a lesser
amount.  I have also noticed a hanging issue on a FIC VA-503+ board in which
the PC speaker can hang, in mid beep, along with the system for a short
while occasionally when the speaker issues a beep.  By the way, any ideas on
how I can help debug this particular problem?  There is no Ooops so I am not
sure how I can help out.  Both systems otherwise work very well and
perfectly on Win9x, Win2k, FreeBSD, and OpenBSD.  I'm starting to take a
very dim view of Linux on VIA boards.

