Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276934AbRJHPVG>; Mon, 8 Oct 2001 11:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276930AbRJHPUz>; Mon, 8 Oct 2001 11:20:55 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:49967 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S276336AbRJHPUg>; Mon, 8 Oct 2001 11:20:36 -0400
Date: Mon, 8 Oct 2001 17:19:52 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, jamal <hadi@cyberus.ca>,
        linux-kernel@vger.kernel.org, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Robert Olsson <Robert.Olsson@data.slu.se>,
        Benjamin LaHaise <bcrl@redhat.com>, netdev@oss.sgi.com,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
Message-ID: <20011008171952.Z726@athlon.random>
In-Reply-To: <20011008023118.L726@athlon.random> <E15qbtV-0000hd-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15qbtV-0000hd-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Oct 08, 2001 at 04:00:36PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2001 at 04:00:36PM +0100, Alan Cox wrote:
> > Of course we agree that such a "polling router/firewall" behaviour must
> > not be the default but it must be enabled on demand by the admin via
> > sysctl or whatever else userspace API. And I don't see any problem with
> > that.
> 
> No I don't agree. "Stop random end users crashing my machine at will" is not
> a magic sysctl option - its a default. 

The "random user hanging my machine" has nothing to do with "it is ok in
a router to dedicate one cpu to polling".

The whole email was about "in a router is ok to poll" I'm not saying "to
solve the food problem you should be forced to turn on polling".

I also said that if you turn on polling you also solve the DoS, yes, but
that was just a side note. My only implicit thought about the side note
was that most machines sensible to the  DoS are routers where people
wants the max performance and where they can dedicate one cpu (also in
UP) to polling.  So the only argument I can make is that the amount of
userbase concerned about the "current" hardirq DoS would decrease
significantly if polling method would becomes available in linux.

I'm certainly not saying that the "stop random user crashing my machine
at will" should be a sysctl option and not the default.

Andrea
