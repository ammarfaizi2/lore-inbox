Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277034AbRJWTt3>; Tue, 23 Oct 2001 15:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278203AbRJWTtT>; Tue, 23 Oct 2001 15:49:19 -0400
Received: from newssvr17-ext.news.prodigy.com ([207.115.63.157]:17366 "EHLO
	newssvr17.news.prodigy.com") by vger.kernel.org with ESMTP
	id <S277034AbRJWTtB>; Tue, 23 Oct 2001 15:49:01 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
Newsgroups: linux.dev.kernel
Subject: Re: More memory == better?
In-Reply-To: <20011023161340.02EAC9BD76@pop3.telenet-ops.be>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: davidsen@deathstar.prodigy.com (Bill Davidsen)
Message-ID: <fRjB7.3865$bi5.656765064@newssvr17.news.prodigy.com>
NNTP-Posting-Host: 192.168.192.240
X-Complaints-To: abuse@prodigy.net
X-Trace: newssvr17.news.prodigy.com 1003866571 000 192.168.192.240 (Tue, 23 Oct 2001 15:49:31 EDT)
NNTP-Posting-Date: Tue, 23 Oct 2001 15:49:31 EDT
Date: Tue, 23 Oct 2001 19:49:31 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011023161340.02EAC9BD76@pop3.telenet-ops.be>,
DevilKin <DevilKin@gmx.net> wrote:

| Currently I've got myself a nice setup (amd 1.4ghz, abit kg7raid etc etc) 
| with 512mb ram... (DDR). I'm wondering if increasing this to 1gb has 
| advantages (speedwise or anything), since I can get my hands on it at a very 
| low price...
| 
| I must say that even with most of my applications loaded/running, the system 
| never even touches the swap partition.
| 
| So, would it be wise?

There are some good reasons to add memory.

- disk i/o rates. vmstat will tell you some disk i/o rates, if they are
high you *may* get better performance with more memnory for cache.

- future applications. As you say it's cheap right now, if you think
there's a good chance of larger images, more kernel compiles, whatever,
buy now.

- memory bandwidth. This is very motherboard dependent, read your specs.
Some systems will use two or four way interleave to increase bandwidth
to memory or reduce access time. See what your m/b spec tells you.

- you have the money and want to spend it on {something}! Go ahead,
memory is one of the best investments for any system.

Just remember that to use this memory you need a large memory kernel.

-- 
bill davidsen <davidsen@tmr.com>
  His first management concern is not solving the problem, but covering
his ass. If he lived in the middle ages he'd wear his codpiece backward.
