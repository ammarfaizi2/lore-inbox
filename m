Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318272AbSHUNU3>; Wed, 21 Aug 2002 09:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318274AbSHUNU3>; Wed, 21 Aug 2002 09:20:29 -0400
Received: from ext-ch1gw-1.online-age.net ([216.34.191.35]:25568 "EHLO
	ext-ch1gw-1.online-age.net") by vger.kernel.org with ESMTP
	id <S318272AbSHUNU2>; Wed, 21 Aug 2002 09:20:28 -0400
Message-ID: <EB3FFD6C1A30D411810400D0B774DEE406883BA9@VACHO1MISGE>
From: "Warner, Bill (IndSys, GEFanuc, VMIC)" <Bill.Warner@gefanuc.com>
To: "'Geert Uytterhoeven'" <geert@linux-m68k.org>,
       Andre Hedrick <andre@linux-ide.org>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
       "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>,
       "'Padraig Brady'" <padraig.brady@corvil.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "Warner, Bill (IndSys, GEFanuc, VMIC)" <Bill.Warner@gefanuc.com>
Subject: RE: IDE-flash device and hard disk on same controller
Date: Wed, 21 Aug 2002 09:22:34 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please take me off of this discussion thread.

Thank you.

> Bill Warner  , CPU Design Engineer
VMIC    A GE Fanuc Company
> bill.warner@gefanuc.com  
> VMIC - A GE Fanuc Company
> 12090 S. Memorial Pkwy, Huntsville, AL 35803
> ph (256) 382-8230, fax (256) 650-5472                    
> 
> -----Original Message-----
> From:	Geert Uytterhoeven [SMTP:geert@linux-m68k.org]
> Sent:	Wednesday, August 21, 2002 2:17 AM
> To:	Andre Hedrick
> Cc:	Jeff Garzik; Heater, Daniel (IndSys, GEFanuc, VMIC); 'Padraig
> Brady'; 'Linux Kernel'; Warner, Bill (IndSys, GEFanuc, VMIC)
> Subject:	Re: IDE-flash device and hard disk on same controller
> 
> On Tue, 20 Aug 2002, Andre Hedrick wrote:
> > Look at 2.4.20-pre2-ac5.
> > 
> > I fixed that problem.
> 
> OK, thanks!
> 
> > On Wed, 21 Aug 2002, Geert Uytterhoeven wrote:
> > > On Tue, 20 Aug 2002, Jeff Garzik wrote:
> > > > Jeff Garzik wrote:
> > > > > Attached is the ATA core...
> > > > 
> > > > Just to give a little bit more information about the previously
> attached 
> > > > code, it is merely a module that does two things:  (a) demonstrates 
> > > > proper [and sometimes faster-than-current-linus] ATA bus probing,
> and 
> > > > (b) demonstrates generic registration and initialization of ATA
> devices 
> > > > and channels.  All other tasks can be left to "personality" (a.k.a. 
> > > > class) drivers, such as 'disk', 'cdrom', 'floppy', ... types.
> > > 
> > > Looks nice (at first sight)!
> > > 
> > > But one limitation is that it always assumes the IDE ports are located
> in I/O
> > > space :-(
> > > What about architectures where IDE ports are located in MMIO space? Or
> worse,
> > > have some ports in I/O space (e.g. PCI IDE card) and some in MMIO
> space (e.g.
> > > SOC or mainboard IDE host interface)?
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker.
> But
> when I'm talking to journalists I just say "programmer" or something like
> that.
> 							    -- Linus
> Torvalds
