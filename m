Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282373AbRLLWEp>; Wed, 12 Dec 2001 17:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282400AbRLLWE0>; Wed, 12 Dec 2001 17:04:26 -0500
Received: from inje.iskon.hr ([213.191.128.16]:58362 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S282392AbRLLWEO>;
	Wed, 12 Dec 2001 17:04:14 -0500
To: "Marcelo ''Mosca'' de Paula Bezerra" <mosca@roadnet.com.br>
Cc: Rui Sousa <rui.p.m.sousa@clix.pt>, emu10k1-devel@opensource.creative.com,
        linux-kernel@vger.kernel.org
Subject: Re: emu10k1 - interrupt storm?
In-Reply-To: <Pine.LNX.4.33.0112121112450.2868-100000@sophia-sousar2.nice.mindspeed.com>
	<3C175A7C.6C532320@roadnet.com.br>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 12 Dec 2001 22:47:30 +0100
In-Reply-To: <3C175A7C.6C532320@roadnet.com.br> ("Marcelo ''Mosca'' de Paula Bezerra"'s message of "Wed, 12 Dec 2001 11:24:12 -0200")
Message-ID: <878zc8az65.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Marcelo ''Mosca'' de Paula Bezerra" <mosca@roadnet.com.br> writes:

> Try running esd with the -as 10 options..
> As the help says, it will disconnect the audio device after 10 seconds
> of inactivity. It will at least help you with the interrupt load while
> not using sound.
> 

Yes, nice idea, but easier said than done. :)

Unfortunately esd is started by the gnome desktop environment and I
can disable or enable it, but can't set any parameters (as far as I
can see). Probably I'll disable it for good, as emu10k1 driver already
does a great job mixing multiple sound streams.

Regards,
-- 
Zlatko
