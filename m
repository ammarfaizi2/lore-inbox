Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278189AbRJXGgP>; Wed, 24 Oct 2001 02:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279476AbRJXGgG>; Wed, 24 Oct 2001 02:36:06 -0400
Received: from fe070.worldonline.dk ([212.54.64.208]:57618 "HELO
	fe070.worldonline.dk") by vger.kernel.org with SMTP
	id <S278189AbRJXGfv>; Wed, 24 Oct 2001 02:35:51 -0400
Date: Wed, 24 Oct 2001 08:36:18 +0200
From: Jens Axboe <axboe@suse.de>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: More memory == better?
Message-ID: <20011024083617.B641@suse.de>
In-Reply-To: <20011023161340.02EAC9BD76@pop3.telenet-ops.be> <fRjB7.3865$bi5.656765064@newssvr17.news.prodigy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fRjB7.3865$bi5.656765064@newssvr17.news.prodigy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23 2001, bill davidsen wrote:
> In article <20011023161340.02EAC9BD76@pop3.telenet-ops.be>,
> DevilKin <DevilKin@gmx.net> wrote:
> 
> | Currently I've got myself a nice setup (amd 1.4ghz, abit kg7raid etc etc) 
> | with 512mb ram... (DDR). I'm wondering if increasing this to 1gb has 
> | advantages (speedwise or anything), since I can get my hands on it at a very 
> | low price...
> | 
> | I must say that even with most of my applications loaded/running, the system 
> | never even touches the swap partition.
> | 
> | So, would it be wise?
> 
> There are some good reasons to add memory.
> 
> - disk i/o rates. vmstat will tell you some disk i/o rates, if they are
> high you *may* get better performance with more memnory for cache.
> 
> - future applications. As you say it's cheap right now, if you think
> there's a good chance of larger images, more kernel compiles, whatever,
> buy now.
> 
> - memory bandwidth. This is very motherboard dependent, read your specs.
> Some systems will use two or four way interleave to increase bandwidth
> to memory or reduce access time. See what your m/b spec tells you.
> 
> - you have the money and want to spend it on {something}! Go ahead,
> memory is one of the best investments for any system.
> 
> Just remember that to use this memory you need a large memory kernel.

There's also the argument that you may slow down your system by adding
more memory, since with 1G you will have high memory which needs to be
kmap'ed to be accessed by the kernel. For I/O it needs to be bounced to
lower memory, which is even worse.

-- 
Jens Axboe

