Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129053AbRBMDDx>; Mon, 12 Feb 2001 22:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129054AbRBMDDn>; Mon, 12 Feb 2001 22:03:43 -0500
Received: from mailgw.prontomail.com ([216.163.180.10]:16188 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S129053AbRBMDDa>; Mon, 12 Feb 2001 22:03:30 -0500
Message-ID: <3A88A335.E8E41626@mvista.com>
Date: Mon, 12 Feb 2001 19:00:05 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Michael B. Trausch" <fd0man@crosswinds.net>
CC: Tom Eastep <teastep@seattlefirewall.dyndns.org>,
        Josh Myer <jbm@joshisanerd.com>, linux-kernel@vger.kernel.org
Subject: Re:  Major Clock Drift
In-Reply-To: <Pine.LNX.4.21.0102042015350.5276-100000@fd0man.accesstoledo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I may be off base here, but the problem as described below does _NOT_
seem to be OT so I removed that from the subject line.  A clock drift
change with an OS update is saying _something_ about the OS, not the
hardware.  In this case it seems to be the 2.4.x OS that is loosing
time.  I suspect the cause is some driver that is not being nice to the
hardware, either by abusing the interrupt off code or locking up the bus
or some such.  In any case I think it should _not_ be considered OT.

George



"Michael B. Trausch" wrote:
> 
> On Sun, 4 Feb 2001, Tom Eastep wrote:
> 
> > Thus spoke Michael B. Trausch:
> >
> > > On Sat, 3 Feb 2001, Josh Myer wrote:
> > >
> > > > Hello all,
> > > >
> > > > I know this _really_ isn't the forum for this, but a friend of mine has
> > > > noticed major, persistent clock drift over time. After several weeks, the
> > > > clock is several minutes slow (always slow). Any thoughts on the
> > > > cause? (Google didn't show up anything worthwhile in the first couple of
> > > > pages, so i gave up).
> > > >
> > >
> > > I'm having the same problem here.  AMD K6-II, 450 MHz, VIA Chipset, Kernel
> > > 2.4.1.
> > >
> >
> >
> > The video on this system is an onboard ATI 3D Rage LT Pro; I use vesafb
> > rather than atyfb because the latter screws up X.
> >
> 
> I'm not using any framebuffer on my machine (I have an ATI 3D Rage 128
> Pro, myself).  I use the standard 80x50 console, and X when I need
> it.  I'm about to put Debian on the system and see how that works and if I
> like it, I just got the .ISO of disc 1 downloaded (after about a week) and
> now it's burning.  (I hate having a 33.6 connection!)
> 
> However the clock drift didn't happen as much, if at all, with 2.2.xx
> kernels.  It's kept itself pretty well sane.  But now I'm losing something
> on the order of a half hour a week - that didn't happen before.
> 
>         - Mike
> 
> ===========================================================================
> Michael B. Trausch                                    fd0man@crosswinds.net
> Avid Linux User since April, '96!                           AIM:  ML100Smkr
> 
>               Contactable via IRC (DALNet) or AIM as ML100Smkr
> ===========================================================================
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
