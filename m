Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313727AbSDHSeU>; Mon, 8 Apr 2002 14:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313728AbSDHSeU>; Mon, 8 Apr 2002 14:34:20 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:50949 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313727AbSDHSeS>; Mon, 8 Apr 2002 14:34:18 -0400
Date: Mon, 8 Apr 2002 14:31:41 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: faster boots?
In-Reply-To: <200204081732.g38HWUU15453@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.3.96.1020408141616.22382A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2002, Richard Gooch wrote:

> Bill Davidsen writes:
> > On Sun, 7 Apr 2002, Richard Gooch wrote:
> > 
> > 
> > > But I *want* to write while the drive is spun down. And leave it spun
> > > down until the system is RAM starved (or some threshold is reached).
> > 
> >   The threshold I hit is how much think time I want to risk. I have
> > no problem spinning down the drive after inactivity, but the idea of
> > investing several hours making little changes in a program or
> > proposal document and then maybe losing them... batteries are just
> > not that expensive.
> 
> It's not $$$ I'm concerned about. It's mass.

  The "I" in my posting referred to my personal preference which is safety
over what to me is a minor inconvenience.

  After looking at disk accesses for a while I *think* diddling bdflush
parameters will prevent disk writes for quite a while if you don't do
reads of uncached data. So far I'm just catting /proc/partitions once a
minute and doing a diff to the previous. looks like a write every ten
minutes or so, what I set in bdflush, probably of syslog mumbling, since
the system is relatively quiescent at the moment.

  Does anyone have a thought on power consumption of flash chips? I have a
20MB compact flash I use as an auxilary backup for critical stuff, "just
in case" and I bet I could put enough on a 64MB to keep the hard drive
spun down for hours, if I were interested in doing so.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

