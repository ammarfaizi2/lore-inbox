Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264703AbSJUCe3>; Sun, 20 Oct 2002 22:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264702AbSJUCe0>; Sun, 20 Oct 2002 22:34:26 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:58375 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S264699AbSJUCeY>; Sun, 20 Oct 2002 22:34:24 -0400
Date: Sun, 20 Oct 2002 22:40:15 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "J.A. Magallon" <jamagallon@able.es>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Any hope of fixing shutdown power off for SMP?
In-Reply-To: <20021021010327.GC14334@werewolf.able.es>
Message-ID: <Pine.LNX.3.96.1021020223545.1655B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2002, J.A. Magallon wrote:

> 
> On 2002.10.21 Bill Davidsen wrote:

> >I'm kind of out of time to play any more, I think I'm going to leave
> >2.5.43 where it is (lots of stuff not working), send the patches to -mm3
> >and think about 2.5.44. That should be less volatile since Linus is out.
> >
> >I can't get apm to even load, it whines in depmod about missing stuff, and
> >I've got about two days of my so-called vacation in what I do hve working,
> >so a good time to call it a version.
> >
> >Thanks for the pointer, I'll try -aa and -ac kernels again at .44.
> >
> 
> Oops, you talk about 2.5...
> My pointers were about 2.4. Anyways, perhaps it is the same problem. Both
> trees did not shutdown properly because shutdown waited inifinitely for
> the apm task to schedule on cpu 0 due to bad interaction with O1
> scheduler.

I got a patch for that which *almost* works. The disks spin down, but the
console is still there. But when I hit the power button I don't have to
hold it, the system goes down like a rock, so it's doing more than it did.

In uni mode it goes all the way down, and I'm not sure the patch is quite
right, I just haven't had time to fight with it. Every once in a while I
have to do some work to keep the lights on.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

