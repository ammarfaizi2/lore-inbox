Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132075AbQLHXk6>; Fri, 8 Dec 2000 18:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132551AbQLHXki>; Fri, 8 Dec 2000 18:40:38 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:3332 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S132075AbQLHXk1>;
	Fri, 8 Dec 2000 18:40:27 -0500
Message-Id: <200012081621.eB8GLNE14764@sleipnir.valparaiso.cl>
To: David Woodhouse <dwmw2@infradead.org>
cc: Andi Kleen <ak@suse.de>, Rainer Mager <rmager@vgkk.com>,
        linux-kernel@vger.kernel.org, Mark Vojkovich <mvojkovich@valinux.com>
Subject: Re: Signal 11 
In-Reply-To: Message from David Woodhouse <dwmw2@infradead.org> 
   of "Fri, 08 Dec 2000 09:46:07 -0000." <25692.976268767@redhat.com> 
Date: Fri, 08 Dec 2000 13:21:23 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> said:

[...]

> I quote from the X devel list, which perhaps I shouldn't do but this is
> hardly NDA'd stuff:

> On Mon 20 Nov 2000, mvojkovich@valinux.com said:
> >   I have seen random crashes on dual P3 BX boards (Tyan) and dual Xeon
> > GX boards (Intel).  XFree86 core dumps indicate that it happens in
> > random places, in old as dirt software rendering code that has nothing
> > wrong with it.  I've only seen this under 2.3.x/2.4 SMP kernels.  I
> > would say that this is definitely a kernel problem. 

> XFree86 3.9 and XFree86 4 were rock solid for a _long_ time on 2.[34]
> kernels - even on my BP6¹. The random crashes started to happen when I
> upgraded my distribution² - and are only seen by people using 2.4. So I
> suspect that it's the combination of glibc and kernel which is triggering
> it.

I get regular segfaults and random lockups trying to build CVS GCCs and
kernels since I updated RH 7 to glibc-2.2-5. P3, sr440bx mobo (UP),
2.2.18preX kernels; previously rock solid. Might be that the mains voltage
here tends to be out of whack, but I doubt it.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
