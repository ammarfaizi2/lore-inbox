Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261258AbTC3UzO>; Sun, 30 Mar 2003 15:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261281AbTC3UzN>; Sun, 30 Mar 2003 15:55:13 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:28863 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S261258AbTC3UzN>;
	Sun, 30 Mar 2003 15:55:13 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Jens Axboe <axboe@suse.de>, Robert Love <rml@tech9.net>
Subject: Re: Bad interactive behaviour in 2.5.65-66 (sched.c)
Date: Mon, 31 Mar 2003 07:06:18 +1000
User-Agent: KMail/1.5
Cc: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Peter Lundkvist <p.lundkvist@telia.com>, akpm@digeo.com, mingo@elte.hu,
       LKML <linux-kernel@vger.kernel.org>
References: <3E8610EA.8080309@telia.com> <1048992365.13757.23.camel@localhost> <20030330141404.GG917@suse.de>
In-Reply-To: <20030330141404.GG917@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303310706.18484.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Mar 2003 00:14, Jens Axboe wrote:
> On Sat, Mar 29 2003, Robert Love wrote:
> > On Sat, 2003-03-29 at 21:33, Con Kolivas wrote:
> > > Are you sure this should be called a bug? Basically X is an interactive
> > > process. If it now is "interactive for a priority -10 process" then it
> > > should be hogging the cpu time no? The priority -10 was a workaround
> > > for lack of interactivity estimation on the old scheduler.
> >
> > Well, I do not necessarily think that renicing X is the problem.  Just
> > an idea.
>
> I see the exact same behaviour here (systems appears fine, cpu intensive
> app running, attempting to start anything _new_ stalls for ages), and I
> definitely don't play X renice tricks.
>
> It basically made 2.5 unusable here, waiting minutes for an ls to even
> start displaying _anything_ is totally unacceptable.

I guess I should have trusted my own benchmark that was showing this was worse 
for system responsiveness.

Con
