Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271498AbRILQgI>; Wed, 12 Sep 2001 12:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271655AbRILQf7>; Wed, 12 Sep 2001 12:35:59 -0400
Received: from [209.10.41.242] ([209.10.41.242]:52175 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S271498AbRILQfm>;
	Wed, 12 Sep 2001 12:35:42 -0400
Date: Tue, 11 Sep 2001 18:21:31 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Nicholas Knight <tegeran@home.com>
cc: Jonathan Morton <chromi@cyberspace.org>,
        Roberto Jung Drebes <drebes@inf.ufrgs.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [GOLDMINE!!!] Athlon optimisation bug (was Re: Duron kernel
 crash)
In-Reply-To: <01091105594100.00173@c779218-a>
Message-ID: <Pine.LNX.4.33.0109111814200.26348-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, on a trial athlon 1GhZ FSB 133 MHZ i did an upgrade from a well
working KT73c to KT73r and BOOM!

here i read from their changelog!!

1.Update BIOS code.

7.Enhance the high speed 133FSB Athlon
                    stability for KT7A/KT7A-RAID.

I think I should make a try with a 1300 Mhz 100MhzFSB!

effectivelly all my Athlon now wroks well using
KT73c bios, i never upgraded to a following one, but i made a further
check, and noticed that the first oops reports are older than this bios
release. So there is no way that first report could be related to
KT73r bios version. maybe also KT73n has problems.... (1.First release for
KT7A/KT7A-RAID V
                    1.3 or newer.)

Luigi

On Tue, 11 Sep 2001, Nicholas Knight wrote:

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

