Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272471AbRIKOaj>; Tue, 11 Sep 2001 10:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272454AbRIKOaa>; Tue, 11 Sep 2001 10:30:30 -0400
Received: from shaker.worfie.net ([203.8.161.33]:787 "HELO mail.worfie.net")
	by vger.kernel.org with SMTP id <S272451AbRIKOaJ>;
	Tue, 11 Sep 2001 10:30:09 -0400
Date: Tue, 11 Sep 2001 22:30:25 +0800 (WST)
From: "J.Brown (Ender/Amigo)" <ender@enderboi.com>
X-X-Sender: <ender@shaker.worfie.net>
To: Nicholas Knight <tegeran@home.com>
cc: Jonathan Morton <chromi@cyberspace.org>,
        Roberto Jung Drebes <drebes@inf.ufrgs.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [GOLDMINE!!!] Athlon optimisation bug (was Re: Duron kernel
 crash)
In-Reply-To: <01091105594100.00173@c779218-a>
Message-ID: <Pine.LNX.4.31.0109112229110.10430-100000@shaker.worfie.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have any problems with the kernel, but if I'm compiling (say) the
kernel or any large program, user-mode apps like gcc, make, etc all
randomly segfault on me.

I'm running a Duron 800 on a Asus A7V133 mobo - and no bios version I've
tried has made a bit of difference yet :p

 - Ender


Regards,	| If I must have computer systems with publically
	 Ender  | available terminals, the maps they display of my complex
  (James Brown)	| will have a room clearly marked as the Main Control Room.
		| That room will be the Execution Chamber. The actual main
		| control room will be marked as Sewage Overflow Containment.

On Tue, 11 Sep 2001, Nicholas Knight wrote:

> Date: Tue, 11 Sep 2001 05:59:41 -0700
> From: Nicholas Knight <tegeran@home.com>
> To: Jonathan Morton <chromi@cyberspace.org>,
>      Roberto Jung Drebes <drebes@inf.ufrgs.br>
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [GOLDMINE!!!] Athlon optimisation bug (was Re: Duron kernel
>     crash)
>
> On Tuesday 11 September 2001 04:21 am, Jonathan Morton wrote:
> > >Today I updated the BIOS of my motherboard, a ABIT KT7A (VIA Apollo
> > > KT133A chipset). The kernel I had (2.4.9) started crashing on boot
> > > with an invalid page fault, usually right after starting init. I
> > > tryed a i686 kernel and noticed it works OK, so I recompiled my
> > > crashy kernel only switching the processor type and it also worked.
> > > changed it back to Athlon/K7/Duron and it starts crashing.
> > >
> > >Anyone else experiencing this?
> >
> > BINGO!
> >
> > This problem is known about, but this is the first report we've had
> > of it on a Duron (as opposed to Athlon), and you've successfully
> > tracked it down to the updated BIOS.
> >
>
> Actually we've had a couple reports on Durons on KT133A chipsets failing.
> We've only had a couple reports of BIOS versions making a difference
> though, and it was never really clear which version did what.
>
> > We need the versions of your old and new BIOSes, as accurately as you
> > can make it.
>
> Can someone compare the INTERNAL BIOS versions (as opposed to the
> external reported by the motherboard manufacturer)?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

