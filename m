Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262895AbSJAXOj>; Tue, 1 Oct 2002 19:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262904AbSJAXOj>; Tue, 1 Oct 2002 19:14:39 -0400
Received: from cibs9.sns.it ([192.167.206.29]:51466 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S262897AbSJAXOh>;
	Tue, 1 Oct 2002 19:14:37 -0400
Date: Wed, 2 Oct 2002 01:19:37 +0200 (CEST)
From: venom@sns.it
To: Jens Axboe <axboe@suse.de>
cc: Joe Thornber <joe@fib011235813.fsnet.co.uk>,
       Dave Jones <davej@codemonkey.org.uk>,
       Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] Remove LVM from 2.5 (resend)
In-Reply-To: <20021001164136.GG5755@suse.de>
Message-ID: <Pine.LNX.4.43.0210020117280.16927-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That was exactky what I was meaning with my first post.

LVM should stay included untill LVM2 is ready
to be merged. That would be metodologically and logically correct.
What is LVM2 is not ready for 2.6? then you could still fix old LVM.

Luigi


On Tue, 1 Oct 2002, Jens Axboe wrote:

> Date: Tue, 1 Oct 2002 18:41:36 +0200
> From: Jens Axboe <axboe@suse.de>
> To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
> Cc: Dave Jones <davej@codemonkey.org.uk>, venom@sns.it,
>      Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org,
>      Linus Torvalds <torvalds@transmeta.com>
> Subject: Re: [PATCH] Remove LVM from 2.5 (resend)
>
> On Tue, Oct 01 2002, Joe Thornber wrote:
> > On Tue, Oct 01, 2002 at 06:06:08PM +0200, Jens Axboe wrote:
> > > On Tue, Oct 01 2002, Dave Jones wrote:
> > > > Consider it patch 1/2 of the device mapper merge 8-)
> > >
> > > Indeed, the patches are also arriving out of order though, LVM remove
> > > patch should be 2/2 not 1/2. IMO.
> >
> > If LVM remotely worked I would agree with you.
>
> No matter the state of lvm, it's much better to day "1, here's the
> replacement - 2, rip the old one out". What if device mapper for 2.5
> really sucks? Maybe it's so bad that we'd rather fix up lvm1? Apparently
> davej has patches that sort-of makes lvm work.
>
> It's not likely, but still :-)
>
> --
> Jens Axboe
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

