Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280012AbRKVQfu>; Thu, 22 Nov 2001 11:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280016AbRKVQfl>; Thu, 22 Nov 2001 11:35:41 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:62275 "EHLO
	c0mailgw06.prontomail.com") by vger.kernel.org with ESMTP
	id <S280012AbRKVQf0>; Thu, 22 Nov 2001 11:35:26 -0500
Message-ID: <3BFD2915.D640C3CB@starband.net>
Date: Thu, 22 Nov 2001 11:34:29 -0500
From: war <war@starband.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: Swap vs No Swap.
In-Reply-To: <Pine.LNX.4.10.10111221006010.29736-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unworkable?
How is it unworkable for my situation?
I have 1GB of memory, even when I launch every application I can, I still have
350MB left over!

Mark Hahn wrote:

> > You can say whatever you want.
>
> gee, thanks.
>
> > When my box starts swapping, the shit hits the fan, slows down dramatically.
>
> then your disks are misconfigured.
>
> > If you have no need for swap, you shouldn't have it, it simply slows the
> > system down big time.
>
> sure, that's obvious.  it's also unworkable in general.
>
> >
> >
> > Mark Hahn wrote:
> >
> > > > How can having swap speed ANYTHING up?
> > >
> > > simple: under memory load, it's more efficient to scavenge
> > > idle pages so they can be used for some "hotter" purpose.
> > > there usually are *some* pages in any process which are
> > > only used at startup, or very rarely used.  if there's no
> > > memory pressure, sure, leave them there.  if there is some
> > > other use for the memory, even caching files, then it's more
> > > efficient to swap those pages (assuming they're dirty).
> > >
> > > swap is a sound way of making more efficient use of limited ram.
> > >
> > > > RAM = 1000MB/s.
> > > > DISK = 10MB/s
> > >
> > > well, modern disks are 40 MB/s, and a typical non-rambus PC
> > > has only around 600 MB/s dram bandwidth, depending on how you
> > > measure it, etc.
> > >
> > > > Ram is generally 1000x faster than a hard disk.
> > >
> > > no, more like 20x; it can be up to around 80x (1.6 GB/s pc800
> > > and a fairly pathetic 20 MB/s disk).  the *latency* ratio can
> > > be much higher (10 ms vs 200 ns).
> > >
> > > > No swap = fastest possible solution.
> > >
> > > false in general.  the only case where this is true is where
> > > you either have just the right amount of ram (unlikely, unless
> > > you can tune your apps rather carefully), or you have too much (your case).
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> --
> operator may differ from spokesperson.              hahn@coffee.mcmaster.ca
>                                               http://java.mcmaster.ca/~hahn

