Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261599AbSKRHqE>; Mon, 18 Nov 2002 02:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbSKRHqE>; Mon, 18 Nov 2002 02:46:04 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.10]:15373 "EHLO
	net.cc.swin.edu.au") by vger.kernel.org with ESMTP
	id <S261599AbSKRHqD>; Mon, 18 Nov 2002 02:46:03 -0500
Date: Mon, 18 Nov 2002 18:53:01 +1100 (EST)
From: Tim Connors <tconnors@astro.swin.edu.au>
To: Mike Galbraith <EFAULT@gmx.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.47 scheduler problems?
In-Reply-To: <001201c28ed4$4c4079a0$6400a8c0@mikeg>
Message-ID: <Pine.LNX.4.33.0211181849240.26151-100000@hexane.ssi.swin.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Mike Galbraith wrote:

> > > If I do the same in 2.5.47, I have no control of my box.  Setting
> all tasks
> > > to SCHED_FIFO or SCHED_RR prior to starting make -j10 bzImage, I can
> regain
> > > control, but interactivity under load is basically not present.
> >
> > Funny that.
> >
> > > I used to be able to wave a window poorly at make -j25 (swapping
> heftily),
> > > fairly smoothly at make -j20, and smoothly at make -j15 or below.
> This
> > > with no SCHED_RR/SCHED_FIFO.  (I haven't done much testing like this
> in
> > > quite a while though)
> >
> > Perhaps you should consider buying an extra 29 CPU's for you desktop?
>
> I have neither the need for 30 CPUs, nor the cash to pay for such a
> beast :)
>
> I gather you think my test is silly?

Well, yes, 30 processes at a time on a single CPU does seem a bit silly -
given that (under the old system), you would not expect X to get more than
3% of the CPU time.
Also sceduling normal processes (ie, not real-time processes) as RR/FIFO
seemed also pretty bad.

However....

But I have to now admit that I haven't yet played with 2.5.47 seriously,
and wansn't aware of the problems which Andrew just posted.

mea culpa.


-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/

If you ever fear that machines will surpass humans in intelligence,
just ask Microsoft to write the OS.     -- POTU in RHOD

