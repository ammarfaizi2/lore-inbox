Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261293AbTC3ODW>; Sun, 30 Mar 2003 09:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261307AbTC3ODW>; Sun, 30 Mar 2003 09:03:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51419 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261293AbTC3ODV>;
	Sun, 30 Mar 2003 09:03:21 -0500
Date: Sun, 30 Mar 2003 16:14:04 +0200
From: Jens Axboe <axboe@suse.de>
To: Robert Love <rml@tech9.net>
Cc: Con Kolivas <kernel@kolivas.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Peter Lundkvist <p.lundkvist@telia.com>, akpm@digeo.com, mingo@elte.hu,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bad interactive behaviour in 2.5.65-66 (sched.c)
Message-ID: <20030330141404.GG917@suse.de>
References: <3E8610EA.8080309@telia.com> <1048987260.679.7.camel@teapot> <1048989922.13757.20.camel@localhost> <200303301233.03803.kernel@kolivas.org> <1048992365.13757.23.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048992365.13757.23.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 29 2003, Robert Love wrote:
> On Sat, 2003-03-29 at 21:33, Con Kolivas wrote:
> 
> > Are you sure this should be called a bug? Basically X is an interactive 
> > process. If it now is "interactive for a priority -10 process" then it should 
> > be hogging the cpu time no? The priority -10 was a workaround for lack of 
> > interactivity estimation on the old scheduler.
> 
> Well, I do not necessarily think that renicing X is the problem.  Just
> an idea.

I see the exact same behaviour here (systems appears fine, cpu intensive
app running, attempting to start anything _new_ stalls for ages), and I
definitely don't play X renice tricks.

It basically made 2.5 unusable here, waiting minutes for an ls to even
start displaying _anything_ is totally unacceptable.

-- 
Jens Axboe

