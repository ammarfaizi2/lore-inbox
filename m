Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273333AbRIYTnC>; Tue, 25 Sep 2001 15:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273309AbRIYTmx>; Tue, 25 Sep 2001 15:42:53 -0400
Received: from [194.213.32.137] ([194.213.32.137]:5892 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S273143AbRIYTmi>;
	Tue, 25 Sep 2001 15:42:38 -0400
Date: Fri, 21 Sep 2001 00:46:40 +0000
From: Pavel Machek <pavel@suse.cz>
To: Dan Hollis <goemon@anime.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Re[2]: [PATCH] Athlon bug stomper. Pls apply.
Message-ID: <20010921004639.B35@toy.ucw.cz>
In-Reply-To: <9oafeuo0@penguin.transmeta.com> <Pine.LNX.4.30.0109191141560.24917-100000@anime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0109191141560.24917-100000@anime.net>; from goemon@anime.net on Wed, Sep 19, 2001 at 11:43:48AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It is _probably_ an undocumented performance thing, and clearing that
> > bit may slow something down. But it might also change some behaviour,
> > and knowing _what_ the behaviour is might be very useful for figuring
> > out what it is that triggers the problem.
> 
> AFAIK noone has even tested it yet to see what it does to performance! Eg
> it might slow down memory access so that athlon-optimized memcopy is now
> slower than non-athlon-optimized memcopy. And if it turns out to be the
> case, we might as well just use the non-athlon-optimized memcopy instead
> of twiddling undocumented northbridge bits...

And if someone does optimized copy in userspace, whole machine is dead?

Do you really wnt me to post bugtraq?

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

