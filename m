Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTE2WOb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 18:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbTE2WOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 18:14:30 -0400
Received: from smtp1.poczta.onet.pl ([213.180.130.31]:1451 "EHLO
	smtp1.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S263077AbTE2WO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 18:14:29 -0400
Message-ID: <001801c32631$642ba220$41010101@toshiba>
From: "Gutko" <gutko@poczta.onet.pl>
To: "lkml" <linux-kernel@vger.kernel.org>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
References: <Pine.LNX.4.44.0305291025550.11675-100000@bork.hampshire.edu> <1054216464.20725.70.camel@dhcp22.swansea.linux.org.uk>
Subject: Re: siimage driver status
Date: Fri, 30 May 2003 00:26:46 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.0
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>


> On Iau, 2003-05-29 at 15:32, Wm. Josiah Erikson wrote:
> > hard drives that I'm trying to get to work with linux 2.4.21-rc6. The
> > problem I'm having is that it's REALLY slow and crashy. The kernel
reports
> > this on bootup:
>
> I'm running the siimage driver fine with several drives. Your setup is
> intriguing in that the BIOS has chosen to leave the drives in PIO mode
>
> > SiI3112 Serial ATA: IDE controller at PCI slot 01:0b.0
> > SiI3112 Serial ATA: chipset revision 2
> > SiI3112 Serial ATA: not 100% native mode: will probe irqs later
> >     ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
> >     ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio
>
> Really the SATA drives ought to have come up in UDMA

I have Asus A7N8X deluxe too, and I reported this issue with rc4.
I'm running one IBM vancouver2 180gxp drive on SIL3112A, and I always have
PIO on boot.
I can enable DMA manually and it works good, but I can bet if I connect
second hdd in RAID
with this I already have, I'll get all problems described above!!! My friend
also runs succesfully ONE
hdd in DMA on the same ASUS on sata, but connecting seconf drive blows
everything away..

Gutko

