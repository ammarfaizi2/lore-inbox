Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130318AbRBLNk0>; Mon, 12 Feb 2001 08:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131188AbRBLNkR>; Mon, 12 Feb 2001 08:40:17 -0500
Received: from tux.rsn.hk-r.se ([194.47.143.135]:15307 "EHLO tux.rsn.hk-r.se")
	by vger.kernel.org with ESMTP id <S131116AbRBLNkB>;
	Mon, 12 Feb 2001 08:40:01 -0500
Date: Mon, 12 Feb 2001 14:37:51 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
cc: Colonel <klink@clouddancer.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-pre2(&3) loopback fs hang
In-Reply-To: <20010212153452.B11083@niksula.cs.hut.fi>
Message-ID: <Pine.LNX.4.21.0102121435150.16301-100000@tux.rsn.hk-r.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2001, Ville Herva wrote:

> On Mon, Feb 12, 2001 at 01:54:46AM -0800, you [Colonel] claimed:
> > 
> > >mount -o loop=/dev/loop1 net.i /var/mnt/image/
> > 
> > ends up in an uninterruptable sleep state (system cannot umount /
> > during shutdown).
> > 
> > How do I track this down?
> 
> This is becoming a FAQ.
> 
> Go to 
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/axboe/patches
> 
> and get the newest Jens Axboe's loopback fs patch (seems to be
> 2.4.1-pre10/loop-3.bz2 atm, though I thought Jens was going to release
> loop-4 sortly.)
> 
> See if the problem goes away with it.
> 
> I'm not sure if Alan has any plans to merge this to ac-series. It would
> appear a worthy candidate...

2.4.2-pre1/loop-4.bz2 is the newest one, but I think I saw that there's
still a bug in it which can hang the kernel.
I think he said that he was going to release loop-5 soon.

/Martin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
