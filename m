Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbSKRKvd>; Mon, 18 Nov 2002 05:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262314AbSKRKvd>; Mon, 18 Nov 2002 05:51:33 -0500
Received: from mail.gmx.de ([213.165.65.60]:3504 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262289AbSKRKvY>;
	Mon, 18 Nov 2002 05:51:24 -0500
Message-ID: <005b01c28ef0$abdd56a0$6400a8c0@mikeg>
From: "Mike Galbraith" <EFAULT@gmx.de>
To: "Tim Connors" <tconnors@astro.swin.edu.au>
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0211181849240.26151-100000@hexane.ssi.swin.edu.au>
Subject: Re: 2.5.47 scheduler problems?
Date: Mon, 18 Nov 2002 11:52:58 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
From: "Tim Connors" <tconnors@astro.swin.edu.au>
To: "Mike Galbraith" <EFAULT@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, November 18, 2002 8:53 AM
Subject: Re: 2.5.47 scheduler problems?


> On Mon, 18 Nov 2002, Mike Galbraith wrote:
>
> > > > If I do the same in 2.5.47, I have no control of my box.
Setting
> > all tasks
> > > > to SCHED_FIFO or SCHED_RR prior to starting make -j10 bzImage, I
can
> > regain
> > > > control, but interactivity under load is basically not present.
> > >
> > > Funny that.
> > >
> > > > I used to be able to wave a window poorly at make -j25 (swapping
> > heftily),
> > > > fairly smoothly at make -j20, and smoothly at make -j15 or
below.
> > This
> > > > with no SCHED_RR/SCHED_FIFO.  (I haven't done much testing like
this
> > in
> > > > quite a while though)
> > >
> > > Perhaps you should consider buying an extra 29 CPU's for you
desktop?
> >
> > I have neither the need for 30 CPUs, nor the cash to pay for such a
> > beast :)
> >
> > I gather you think my test is silly?
>
> Well, yes, 30 processes at a time on a single CPU does seem a bit
silly -
> given that (under the old system), you would not expect X to get more
than
> 3% of the CPU time.

I don't try -j30 with X/KDE running.. that's much too heavy for my
little box.  The whole point of doing -j30 on my box without X/KDE is
that it juuuust fills up capacity.  It generally adds a minute to build
time despite quite hefty swapping.  With aa kernels or heavily twiddled
stock kernels, it's more like 30 seconds.  (with new gcc, -j30 is way
too much too.. oink oink;)

> Also sceduling normal processes (ie, not real-time processes) as
RR/FIFO
> seemed also pretty bad.

That was only to see if I _could_ get some CPU, and with (only:) 10
copies of gcc running.

>
> However....
>
> But I have to now admit that I haven't yet played with 2.5.47
seriously,
> and wansn't aware of the problems which Andrew just posted.
>
> mea culpa.
>
>
> --
> TimC -- http://astronomy.swin.edu.au/staff/tconnors/

    -Mike

