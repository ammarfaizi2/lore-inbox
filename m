Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317861AbSHHSkR>; Thu, 8 Aug 2002 14:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317864AbSHHSkR>; Thu, 8 Aug 2002 14:40:17 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:63240
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317861AbSHHSkO>; Thu, 8 Aug 2002 14:40:14 -0400
Date: Thu, 8 Aug 2002 11:35:45 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Nick Orlov <nick.orlov@mail.ru>, B.Zolnierkiewicz@elka.pw.edu.pl,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, davidsen@tmr.com
Subject: Re: [PATCH] pdc20265 problem.
In-Reply-To: <17291A73E81@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.10.10208081128430.25573-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Clearly the difference between what is silkscreened and the usage intent
is beyond the obvious :-/  Since I have had or still have first hand
experience in the observed behaior under Linux and MicroSoft, you are
going by what is read.  Book knowledges gets you books not reality.
try a few w/ all of them bootable and see what happens.  So until Linux
gets a clue about EDDS 2.0 and or 3.0 it has not a chance of getting the
correct hd0/hd1 from the INT13/19 services.  Obviously experience and
first hand knowledge of reality is worthless in Linux.  I am out of this
thread.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Thu, 8 Aug 2002, Petr Vandrovec wrote:

> On  8 Aug 02 at 10:30, Andre Hedrick wrote:
> > 
> > http://www.tyan.com/products/html/thunderlet.html
> 
> Page 40 of manual: choose Onboard IDE or FastTrak ATA-100/RAID.
> OnboardIDE means Serverworks, FastTrak means PDC20265.
> BIOS settings for primary/secondary disk relate to the Serverworks
> channels.
> 
> > http://www.tyan.com/products/html/tiger200t.html
> 
> Page 11: Primary/secondary IDE: VIA, RAID primary/secondary: PDC.
> Page 33: Primary/secondary IDE settings relate to the VIA.
> 
> > http://www.tyan.com/products/html/trinityi845e.html
> 
> Page 5: Integrated PCI IDE (it talks about i845 internal) +
> integrated IDE RAID (20267, so no relevance here). Page 28:
> primary/secondary disables i845, not PDC.
> 
> > http://www.tyan.com/products/html/trinitygcsl.html
> 
> Serverworks, with IDE. Serverworks IDE is primary.
> RAID is 20267, so no relevance. Manual not available yet.
> 
> > http://www.epox.com/html/english/products/motherboard/ep-d3va.htm
> 
> VIA onboard, HPT370 RAID. Connectors of RAID marked IDE3/IDE4.
> 
> > http://www.epox.com/html/english/products/motherboard/ep-8k3a.htm
> 
> 8k3a has no RAID. 8k3a+ has PDC20267. Primary IDE is from VIA,
> RAID is additional...
> 
> > http://www.supermicro.com/PRODUCT/MotherBoards/VIA/370DDE.htm
> 
> Manual unavailable from the web (404 Page not found after clicking
> on manual). Picture shows IDE #1/IDE #2 (VIA) and IDE RAID #1/#2.
> Besides that it has PDC20267, so it has no relevance to this discussion.
> 
> > http://www.supermicro.com/PRODUCT/MotherBoards/VIA/P3TDDE.htm
> 
> Manual page #10: IDE1/IDE2 for VIA, IDE RAID #1/#2 for PDC.
> Page 14: 2 IDE bus master interfaces support UDMA/100 (listed first),
> 2 IDE RAID connectors (listed later). Page 49: IDE primary/secondary
> settings relate to the VIA.
>  
> > all know better, are wiser, empower w/ megalmania (sp) and gawd knows what
> > else.  Please next time, do your homework before you attempt to call me
> > on these issues.  Do the two word "Native" and "Compatablity" in ATA-ATAPI
> > have meaning?  This will help you go a long way.
> 
> I did my homework. I still believe that there is NO MAINBOARD with
> PDC20265, and without southbridge IDE - be it VIA, SiS, Intel or Nvidia.
> All motherboards you listed have PDC (or HPT) as an additional controller,
> and manual always refers to southbridge as IDE#1/IDE#2, while PDC
> is referred as IDE RAID#1/#2, or even as IDE#3/IDE#4.
> 
> If you tried to prove that PDC20265 should never be ide0/ide1, then
> we are on the same boat.
>                                                 Petr Vandrovec
>                                                 vandrove@vc.cvut.cz
>                                                 
> P.S.: Both Tyan and Epox should make their ftp servers much, much faster...
>                                                 
> 

