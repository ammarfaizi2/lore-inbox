Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317698AbSHHRe6>; Thu, 8 Aug 2002 13:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317696AbSHHRez>; Thu, 8 Aug 2002 13:34:55 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:53256
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317698AbSHHRe0>; Thu, 8 Aug 2002 13:34:26 -0400
Date: Thu, 8 Aug 2002 10:30:00 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Nick Orlov <nick.orlov@mail.ru>, B.Zolnierkiewicz@elka.pw.edu.pl,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, davidsen@tmr.com
Subject: Re: [PATCH] pdc20265 problem.
In-Reply-To: <170FF7412A6@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.10.10208081018150.25573-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Petr,

Here is a short list!

http://www.tyan.com/products/html/thunderlet.html
http://www.tyan.com/products/html/tiger200t.html
http://www.tyan.com/products/html/trinityi845e.html
http://www.tyan.com/products/html/trinitygcsl.html
http://www.epox.com/html/english/products/motherboard/ep-d3va.htm
http://www.epox.com/html/english/products/motherboard/ep-8k3a.htm
http://www.supermicro.com/PRODUCT/MotherBoards/VIA/370DDE.htm
http://www.supermicro.com/PRODUCT/MotherBoards/VIA/P3TDDE.htm


It is absolutely lame that people in 2.5 are clueless to what is going to
need to be supported.  Also it is lame in 2.4 that cruft from OEMs who do
not get Linux, but their changes are accepted.  There were very careful
decisions made over the past 4-5 years about device ordering and
protecting the power of ide0/ide1.  Within a few days it is shot to hell
because nobody ever thinks to look at what was there before them.  They
all know better, are wiser, empower w/ megalmania (sp) and gawd knows what
else.  Please next time, do your homework before you attempt to call me
on these issues.  Do the two word "Native" and "Compatablity" in ATA-ATAPI
have meaning?  This will help you go a long way.

Regards,


Andre Hedrick
LAD Storage Consulting Group


On Thu, 8 Aug 2002, Petr Vandrovec wrote:

> On  8 Aug 02 at 6:02, Andre Hedrick wrote:
> > 
> > There are mainboard out there designed specifically to boot off the third
> > party host.  I have one with the pdc20265 on it.  So if you mainboard is
> 
> Vendor + motherboard name, please.
> 
> > produced by some lame OEM who is trying to grant first access to the addon
> > host chip by playing silly devfn/bus ordering games you get what you
> > bought.  Yeah there are cheesy crap-mainboard oem's that play this game.
> 
> Uhh? Changing boot order in the BIOS must NOT change what ide0 is.
> 
> What are you smoking? It would completely screw my system that if I
> decide to boot from secondary channel, it magically becomes ide0. If
> Linux would behave this way, I could never tell which disk will get which
> name until I boot. What if I boot from floppy? Then IDE interfaces will 
> become numbered from ide1, because of there was no IDE boot device?
> Should we also swap hda with hdb if I boot my system from primary slave?
> 
> And I did not found anything about ide0 in documents you provided.
> 
> And BTW, my board is A7V from Asus. Manual refers to VIA interface
> as 'primary/secondary channels', and to PDC as 'UDMA100 interface'(s).
> And PDC is always run in the native mode, IRQ14/15 is not wired to the
> PDC chip at all.
> 
> I always thought that if there is IDE interface at the 0x1F0 in the
> system, it will become ide0, and if there is interface at the 0x170,
> it will become ide1 (and simillary for ISA-based tertiary/quaterniary). 
> After this step unused ide* interfaces are populated with native PCI IDE 
> interfaces, starting at ide0, and going up...
>                                             Petr Vandrovec
>                                             vandrove@vc.cvut.cz
>                                             
> 

