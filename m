Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266238AbTGJASM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 20:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266225AbTGJAQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 20:16:27 -0400
Received: from rtichy.netro.cz ([213.235.180.210]:53755 "HELO 192.168.1.21")
	by vger.kernel.org with SMTP id S266219AbTGJAPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 20:15:51 -0400
Message-ID: <03dd01c3467a$7281a7c0$401a71c3@izidor>
From: "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz>
To: "Samuel Flory" <sflory@rackable.com>
Cc: <linux-kernel@vger.kernel.org>, <mru@users.sourceforge.net>
References: <Pine.LNX.4.53.0307091413030.683@mx.homelinux.com> <027901c3461e$e023c670$401a71c3@izidor> <yw1xadbnx017.fsf@users.sourceforge.net> <02ff01c34642$5512d7f0$401a71c3@izidor> <3F0C5D55.4030304@rackable.com> <039701c34675$81a8b0e0$401a71c3@izidor> <3F0CB01F.5070308@rackable.com>
Subject: Re: Promise SATA 150 TX2 plus
Date: Thu, 10 Jul 2003 02:30:18 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So what about the main advantage of SATA, that is hot-swap?
Is it possible to make hotswap in the linux and change it for the
same disk? Or is it possible to change it for other disk with other
geometry? Is it depending on SATA controller or I only need
support in the linux kernel? Is there that support for this
controllers/drives?
Thanx for the answer
    Milan Roubal

> Milan Roubal wrote:
>
> >Hi,
> >
> >
> >>Milan Roubal wrote:
> >>
> >>
> >>
> >>>So other question - is there SATA controler that
> >>>is working in linux multiple controlers (4 cards)
> >>>and is for better bus than standart PCI? Like PCI-X or
> >>>PCI 66 MHz like promise is?
> >>>
> >>>
> >>>
> >>>
> >>  Most current SATA cards aren't faster than 64/66.  Heck many are
> >>32/66, or 64/33.  The problem is most everyone other than 3ware's linux
> >>drivers suck.  I can't find a non raid SATA controller than works for me
> >>under linux.
> >>
> >>
> >>
> >
> >Heh, bad news for me.
> >
> >
> >
> >>  3ware cards tend to max out a 64/33 solt around 6 drives for
> >>sequential IO.  (This will change in their next gen cards)  You get much
> >>better performance with two 8 port cards running 6 drives each than a
> >>single 12 port card.  Personally I recommend either 3ware raid10, or
> >>linux software raid 5 if you're a performance junky.
> >>
> >>  Adaptec does have a new 4 port card sata raid card.  It seems to work
> >>well, and the driver on their cdrom includes around 30 precompiled
> >>binaries for various RH, MDK, and Suse kernels.  Source for the updated
> >>aacraid driver is included.   An interesting side note their cdrom seem
> >>to run linux.  (Yes they seem to provide source/patches for the various
> >>gpl programs it uses.)
> >>
> >>-- 
> >>Once you have their hardware. Never give it back.
> >>(The First Rule of Hardware Acquisition)
> >>Sam Flory  <sflory@rackable.com>
> >>
> >>
> >>
> >
> >All this cards are RAID controllers, I want only SATA controlers and I am
> >using software raid 5.
> >I was using Promise TX2 controllers for PATA drives and it was working
> >great, so I tried
> >the SATA card from Promise too and it looks only troubles and troubles...
> >    Milan Roubal
> >
> >
> >
>
>   Your best bet may be some silcon image chipset, or the high point card
> that seem to have the same interface as their pata card.  Personally at
> this stage there really isn't any reason to switch to sata.  (Other than
> saner cabling.)  I've yet to see a sata drive, other than the WD raptor,
> that faster than pata drive.  The WD raptors are nearly scsi drive fast,
> but are small cap and pricey.
>
> -- 
> Once you have their hardware. Never give it back.
> (The First Rule of Hardware Acquisition)
> Sam Flory  <sflory@rackable.com>
>
>

