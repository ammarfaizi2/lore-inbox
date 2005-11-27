Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbVK0SdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbVK0SdZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 13:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbVK0SdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 13:33:25 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:8973 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751135AbVK0SdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 13:33:24 -0500
Date: Sun, 27 Nov 2005 19:33:13 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Martin Drab <drab@kepler.fjfi.cvut.cz>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: PC speaker beeping on high CPU loads on an nForce2
Message-ID: <20051127183313.GQ11266@alpha.home.local>
References: <Pine.LNX.4.60.0511270409430.30055@kepler.fjfi.cvut.cz> <200511270111.29831.gene.heskett@verizon.net> <Pine.LNX.4.60.0511271839480.24919@kepler.fjfi.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0511271839480.24919@kepler.fjfi.cvut.cz>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2005 at 06:56:23PM +0100, Martin Drab wrote:
> On Sun, 27 Nov 2005, Gene Heskett wrote:
> 
> > On Saturday 26 November 2005 22:23, Martin Drab wrote:
> > >Hi,
> > >
> > >on an nForce2 system (GigaByte 7NNXP) when the CPU is under heavy load
> > >(like during kernel compilation for instance, or any compilation of any
> > >bigger project, for that matter), I hear some beeps comming out of the
> > > PC speaker. It's like few short beeps per second for a while, then
> > > silence for few seconds, then a beep here and there, and again, and so
> > > on. It is quite strange. It happens ever since I remember (I mean in
> > > kernel versions of course, I have the board for about 1.5 years). I've
> > > just been kind of ignoring it until now. Does anybody else happen to
> > > see the same symptoms? What could be the cause of this. Is it
> > > something about timing? But how come the PC speaker gets kiced in,
> > > while it's not being used at all (well, at least not intentionally)
> > > for anything. Perhaps something is writing some ports it is not
> > > supposed to?
> > >
> > >Martin
> > 
> > Usually, thats a sign of cpu overheating.  At 18 months, if the cpu
> > fan/heat sink hasn't been blown out by an air hose, its so packed full
> > of dust bunnies that no amount of rpms can force any air thru the cpu's 
> > heat sink fins.
> 
> No, it isn't a problem of dust or grease. It is a problem of a case full 
> of devices and bad airflow within it. (There's 6 HDDs, 8 PCI cards, an 
> AthlonXP 3200+ with massive Zalman CNPS6000-Cu on top of it and 10 fans 
> that are doing all they can running at maximum (with the noise of a 
> medium vacuum cleaner ;), trying to cool it all, but it just isn't 
> enough.) So I'll try to solve it by a water cooling.

Should be cheaper to buy a bigger case with a *real airflow path, and
remove some of those fans. It's non-sense to put 10 fans in a mono-proc
system ! even with 6 disks (probably even IDE disks).

BTW, if you have the case FAN orthogonal to the CPU's and close to it,
you'd better stop it as ot will prevent part of the airflow from entering
the CPU's fan. It's amazing to see the number of boxes with a case FAN
which increases the CPU temperature by 5 degrees once it spins up ! I
too had one which made my dual athlon regularly crash, and it's OK now
that I have unplugged it. I noticed it first because the rear CPU was
5 degrees hotter than the front one.

> I just didn't connect these sounds with the MB alarm. (Even though I know 
> that there is this kind of feature.)

If your system is stable, you can also disable the alarm. It's very
conservative and will beep for nearly nothing. My dual athlon runs
up to 92 degrees celcius on summer without crashing. The highest alarm
threshold was something like 60 degrees...

> However thanks for the advises anyway,
> Martin

Regards,
Willy

