Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136698AbRECKfN>; Thu, 3 May 2001 06:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136708AbRECKfD>; Thu, 3 May 2001 06:35:03 -0400
Received: from femail1.sdc1.sfba.home.com ([24.0.95.81]:49643 "EHLO
	femail1.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S136698AbRECKes>; Thu, 3 May 2001 06:34:48 -0400
Message-ID: <3AF13442.BC84900B@home.com>
Date: Thu, 03 May 2001 03:34:42 -0700
From: Seth Goldberg <bergsoft@home.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Moses McKnight <m_mcknight@surfbest.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: DISCOVERED! Cause of Athlon/VIA KX133 Instability
In-Reply-To: <Pine.LNX.4.10.10105012333400.18414-100000@coffee.psychology.mcmaster.ca> <3AEFB8BE.5050007@surfbest.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Thanks moses -- this is the instability that I have as well.
I tried compiling on 1/2 of the k7 optimized mmx routines.
So far, running with JUST the fast_clear_page using k7 streaming (and
not
fast_copy_page), the system is still stable.  I'll try adding fast_copy
_page, but I think that's where our problems lie (of course I could be
full of crap,  too).

 --S

Moses McKnight wrote:
> 
> Mark Hahn wrote:
> 
> >>  Actually, I think there are 2 problems that have been discussed -- the
> >>disk corruption and a general instability resulting in oops'es at
> >>various points shortly after boot up.
> >>
> >
> > I don't see this.  specifically, there were scattered reports
> > of a via-ide problem a few months ago; this is the issue that's
> > gotten some press, and for which Alan has a fix.  and there are reports
> > of via-smp problems at boot (which go away with noapic).  I see no reports
> > of the kind of general instability you're talking about.  and all the
> > via-users I've heard of have no such stability problems -
> > me included (kt133/duron).
> >
> > the only general issue is that kx133 systems seem to be difficult
> > to configure for stability.  ugly things like tweaking Vio.
> > there's no implication that has anything to do with Linux, though.
> 
> When I reported my problem a couple weeks back another fellow
> said he and several others on the list had the same problem,
> and as far as I can tell it is *only* with the IWILL boards.
> When I compiled with k7 optimizations I'd get all kinds of oopses
> and panics and never fully boot.  They were different every time.
> When any of the lesser optimizations are used I have no problems.
> My memory is one 256MB Corsair PC150 dimm, CPU is a Thunderbird 850,
> and mobo is an IWILL KK266 (KT133A).  The CPU runs between 35°C
> and 40°C.
> 
> >>  My memory system jas been set up very conservitavely and has been
> >>rock solid in my other board (ka7), so I doubt it's that, but I
> >>sure am happy to try a few more cominations of bios settings.  Anything
> >>I should look for in particular?
> >>
> >
> > how many dimms do you have?  interleave settings?  Vio jumper?
> > already checked on cooling issues?  and that you're not overclocking...
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
