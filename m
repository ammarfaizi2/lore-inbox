Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283582AbRLMHrl>; Thu, 13 Dec 2001 02:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283603AbRLMHrW>; Thu, 13 Dec 2001 02:47:22 -0500
Received: from inje.iskon.hr ([213.191.128.16]:18376 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S283582AbRLMHrS>;
	Thu, 13 Dec 2001 02:47:18 -0500
To: Doug McNaught <doug@wireboard.com>
Cc: "Marcelo ''Mosca'' de Paula Bezerra" <mosca@roadnet.com.br>,
        Rui Sousa <rui.p.m.sousa@clix.pt>,
        emu10k1-devel@opensource.creative.com, linux-kernel@vger.kernel.org
Subject: Re: emu10k1 - interrupt storm?
In-Reply-To: <Pine.LNX.4.33.0112121112450.2868-100000@sophia-sousar2.nice.mindspeed.com>
	<3C175A7C.6C532320@roadnet.com.br> <878zc8az65.fsf@atlas.iskon.hr>
	<m3n10ot6vq.fsf@belphigor.mcnaught.org>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 13 Dec 2001 08:47:02 +0100
In-Reply-To: <m3n10ot6vq.fsf@belphigor.mcnaught.org> (Doug McNaught's message of "12 Dec 2001 17:23:37 -0500")
Message-ID: <dnitbbtvd5.fsf@magla.zg.iskon.hr>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug McNaught <doug@wireboard.com> writes:

> Zlatko Calusic <zlatko.calusic@iskon.hr> writes:
> 
> > Yes, nice idea, but easier said than done. :)
> > 
> > Unfortunately esd is started by the gnome desktop environment and I
> > can disable or enable it, but can't set any parameters (as far as I
> > can see). Probably I'll disable it for good, as emu10k1 driver already
> > does a great job mixing multiple sound streams.
> 
> There's always the hack...
> 
> # cd /usr/bin
> # mv esd esd.real
> # cat >>esd
> #!/bin/sh
> exec esd.real -as 10 $*
> ^D
> # chmod 755 esd
> 

Sure, but it's messy. :)

Also, as I do frequent upgrades (Debian unstable) it would get
overwritten quite fast.
-- 
Zlatko
