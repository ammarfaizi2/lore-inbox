Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266199AbTBKUJy>; Tue, 11 Feb 2003 15:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266200AbTBKUJx>; Tue, 11 Feb 2003 15:09:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:23277 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S266199AbTBKUJw>;
	Tue, 11 Feb 2003 15:09:52 -0500
Date: Tue, 11 Feb 2003 21:19:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Jason Lunz <lunz@falooley.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030211201930.GB930@suse.de>
References: <20030209133013.41763.qmail@web41404.mail.yahoo.com> <20030209144622.GB31401@dualathlon.random> <20030210162301.GB443@elf.ucw.cz> <20030211114936.GE22275@dualathlon.random> <20030211124330.GK930@suse.de> <slrnb4i27n.3s0.lunz@stoli.localnet> <20030211144143.GR930@suse.de> <slrnb4ic5v.4gi.lunz@stoli.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <slrnb4ic5v.4gi.lunz@stoli.localnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11 2003, Jason Lunz wrote:
> axboe@suse.de said:
> >> By all means, do the same thing with disk i/o. It's been a smashing
> >> success with packet queueing.
> > 
> > Well, that's the point.
> 
> Yes, what you've done with cbq is great. What I was referring to,
> though, is the user configurability of network frame queueing. It's
> possible to do really complex things for very specialized needs, yet
> also easy to put in a simple tweak if there's just one type of traffic
> you need to prioritize.  It'd be nice to have that kind of
> configurability for unusual i/o loads, and the arbitrary queue stacking
> is a whole different beast than having a couple of tunables to tweak.

That is indeed the goal. We'll see how much is doable within the 2.6
time frame, though.

-- 
Jens Axboe

