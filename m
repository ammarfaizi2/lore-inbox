Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278235AbRJWUir>; Tue, 23 Oct 2001 16:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278221AbRJWUih>; Tue, 23 Oct 2001 16:38:37 -0400
Received: from newssvr17-ext.news.prodigy.com ([207.115.63.157]:2019 "EHLO
	newssvr17.news.prodigy.com") by vger.kernel.org with ESMTP
	id <S278225AbRJWUi1>; Tue, 23 Oct 2001 16:38:27 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
Newsgroups: linux.dev.kernel
Subject: Re: More memory == better?
In-Reply-To: <20011023200715.AEF66217593@tartarus.telenet-ops.be>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: davidsen@deathstar.prodigy.com (Bill Davidsen)
Message-ID: <BzkB7.3883$Im6.661175312@newssvr17.news.prodigy.com>
NNTP-Posting-Host: 192.168.192.240
X-Complaints-To: abuse@prodigy.net
X-Trace: newssvr17.news.prodigy.com 1003869537 000 192.168.192.240 (Tue, 23 Oct 2001 16:38:57 EDT)
NNTP-Posting-Date: Tue, 23 Oct 2001 16:38:57 EDT
Date: Tue, 23 Oct 2001 20:38:57 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011023200715.AEF66217593@tartarus.telenet-ops.be>,
DevilKin <DevilKin@gmx.net> wrote:

| > There are some good reasons to add memory.
| >
| > - disk i/o rates. vmstat will tell you some disk i/o rates, if they are
| > high you *may* get better performance with more memnory for cache.
| >
| > - future applications. As you say it's cheap right now, if you think
| > there's a good chance of larger images, more kernel compiles, whatever,
| > buy now.
| >
| > - memory bandwidth. This is very motherboard dependent, read your specs.
| > Some systems will use two or four way interleave to increase bandwidth
| > to memory or reduce access time. See what your m/b spec tells you.
| >
| > - you have the money and want to spend it on {something}! Go ahead,
| > memory is one of the best investments for any system.
| >
| > Just remember that to use this memory you need a large memory kernel.
| 
| Ah, thats with HIGHMEM support? I've read a lot of awful things about it 
| here... how stable (aka usable) is it?

I have 12 machines using it, at seven location in six states... don't
see any problems with which I don't see without. They are all actively
using large files as well, typically 50-100GB.

Looks good to go on my systems.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
