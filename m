Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316246AbSEQOhQ>; Fri, 17 May 2002 10:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316245AbSEQOhN>; Fri, 17 May 2002 10:37:13 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:26474 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316246AbSEQOf4>; Fri, 17 May 2002 10:35:56 -0400
Date: Fri, 17 May 2002 16:35:38 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@zip.com.au>, Paul Faure <paul@engsoc.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Process priority in 2.4.18 (RedHat 7.3)
Message-ID: <20020517143537.GG11512@dualathlon.random>
In-Reply-To: <20020517125529.GC11512@dualathlon.random> <E178j4i-0006eT-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 03:51:20PM +0100, Alan Cox wrote:
> > > For a 10Mbit ne2k it ought to be if its done with sched fifo. For serious
> > > devices its not. The ksoftirqd bounce blows everything out of cache and is
> > > easily measured
> > 
> > if you're under a flood of irq ksoftirqd or not won't make differences
> 
> I didnt mention a flood of irqs. If stuff falls back to softirqd it 
> materially harms throughput

You did implicitly becuse if there's not a flood of irq or recursive
softirqs it cannot fall to sofitrqd.

Andrea
