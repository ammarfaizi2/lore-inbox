Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbSKRH2V>; Mon, 18 Nov 2002 02:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261595AbSKRH2U>; Mon, 18 Nov 2002 02:28:20 -0500
Received: from mail.gmx.net ([213.165.65.60]:37424 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261594AbSKRH2S>;
	Mon, 18 Nov 2002 02:28:18 -0500
Message-ID: <001201c28ed4$4c4079a0$6400a8c0@mikeg>
From: "Mike Galbraith" <EFAULT@gmx.de>
To: "Tim Connors" <tconnors@astro.swin.edu.au>, <linux-kernel@vger.kernel.org>
References: <5.1.1.6.2.20021118070215.00cb8f98@wen-online.de> <slrn-0.9.7.4-16621-21084-200211181750-j.$random.luser@swin.edu.au>
Subject: Re: 2.5.47 scheduler problems?
Date: Mon, 18 Nov 2002 08:29:57 +0100
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
To: <linux-kernel@vger.kernel.org>; "Mike Galbraith" <efault@gmx.de>
Sent: Monday, November 18, 2002 7:51 AM
Subject: Re: 2.5.47 scheduler problems?


> In linux.kernel, you wrote:
> > Greetings,
> >
> > For testing swap throughput, I like to run make -j30 bzImage on my
500Mhz
> > PIII w. 128Mb ram.  For testing interactivity, I fire up KDE, start
a
> > smaller make -j, grab a window, and wave it around.
> >
> > With 2.4.20rc2+rc1aa1, running a -j10 build (not swapping) is very
very
> > bad.  However, if I set all tasks in the system to SCHED_FIFO or
SCHED_RR
> > prior to this light make -j, I have a ~pretty smooth system.
> >
> > If I do the same in 2.5.47, I have no control of my box.  Setting
all tasks
> > to SCHED_FIFO or SCHED_RR prior to starting make -j10 bzImage, I can
regain
> > control, but interactivity under load is basically not present.
>
> Funny that.
>
> > I used to be able to wave a window poorly at make -j25 (swapping
heftily),
> > fairly smoothly at make -j20, and smoothly at make -j15 or below.
This
> > with no SCHED_RR/SCHED_FIFO.  (I haven't done much testing like this
in
> > quite a while though)
>
> Perhaps you should consider buying an extra 29 CPU's for you desktop?

I have neither the need for 30 CPUs, nor the cash to pay for such a
beast :)

I gather you think my test is silly?

    -Mike

