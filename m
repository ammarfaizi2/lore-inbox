Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264680AbSJUArB>; Sun, 20 Oct 2002 20:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264681AbSJUArA>; Sun, 20 Oct 2002 20:47:00 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:56583 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264680AbSJUAq7>; Sun, 20 Oct 2002 20:46:59 -0400
Date: Sun, 20 Oct 2002 20:52:45 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "J.A. Magallon" <jamagallon@able.es>
cc: thunder7@xs4all.nl,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Any hope of fixing shutdown power off for SMP?
In-Reply-To: <20021020235107.GA14334@werewolf.able.es>
Message-ID: <Pine.LNX.3.96.1021020204830.1444A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2002, J.A. Magallon wrote:

> 
> On 2002.10.20 Jurriaan wrote:
> >From: Bill Davidsen <davidsen@tmr.com>
> >Date: Sat, Oct 19, 2002 at 03:40:22PM -0400
> >> I've beaten this dead horse before, but it still irks me that Linux can't
> >> power down an SMP system. People claim that it can't be done safely, but
> >> maybe somone can reverse engineer NT if we aren't up to the job.
> >> 
> >I'm trying to find out the same. So far:
> >
> 
> There are patches both in the -ac and -aa tree to make smp kernels shut
> down properly, even to support full APM if you have enough luck. shutdown
> works fine on my smp box...

I'm kind of out of time to play any more, I think I'm going to leave
2.5.43 where it is (lots of stuff not working), send the patches to -mm3
and think about 2.5.44. That should be less volatile since Linus is out.

I can't get apm to even load, it whines in depmod about missing stuff, and
I've got about two days of my so-called vacation in what I do hve working,
so a good time to call it a version.

Thanks for the pointer, I'll try -aa and -ac kernels again at .44.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

