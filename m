Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261469AbTCaIfz>; Mon, 31 Mar 2003 03:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261470AbTCaIfy>; Mon, 31 Mar 2003 03:35:54 -0500
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:1757 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S261469AbTCaIfy>; Mon, 31 Mar 2003 03:35:54 -0500
Subject: Re: Bad interactive behaviour in 2.5.65-66 (sched.c)
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Jens Axboe <axboe@suse.de>, Con Kolivas <kernel@kolivas.org>,
       Robert Love <rml@tech9.net>, Peter Lundkvist <p.lundkvist@telia.com>,
       akpm@digeo.com, mingo@elte.hu, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <5.2.0.9.2.20030331085710.01aa6d30@pop.gmx.net>
References: <5.2.0.9.2.20030331033120.00cf0d08@pop.gmx.net>
	 <20030330141404.GG917@suse.de> <3E8610EA.8080309@telia.com>
	 <1048992365.13757.23.camel@localhost> <20030330141404.GG917@suse.de>
	 <5.2.0.9.2.20030331033120.00cf0d08@pop.gmx.net>
	 <5.2.0.9.2.20030331085710.01aa6d30@pop.gmx.net>
Content-Type: text/plain
Organization: 
Message-Id: <1049100382.638.2.camel@teapot>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 31 Mar 2003 10:46:22 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-31 at 09:05, Mike Galbraith wrote:
> > > I don't think it's really bad for system responsiveness.  I think the
> >
> >What drugs are you on? 2.5.65/66 is the worst interactive kernel I've
> >ever used, it would be _embarassing_ to release a 2.6-test with such a
> >rudimentary flaw in it. IOW, a big show stopper.
> 
> It's only horrible when you trigger the problems, otherwise it's wonderful.

With scheduler tunables (in -mm, for example), setting min_timeslice =
max_timeslice = 25 helps a lot with those problems (at least for me) :-)

> > > problem is just that the sample is too small.  The proof is that simply
> > > doing sleep_time %= HZ cures most of my woes.  WRT contest and it's
> >
> >Irk, that sounds like a really ugly bandaid.
> 
> Nope, it's a really ugly _tourniquet_ ;-)
> 
> >I'm wondering why the scheduler guys aren't all over this problem,
> >getting it fixed.
> 
> I think they are.

I hope so ;-)

        Felipe Alfaro Solana
   Linux Registered User #287198
http://counter.li.org

