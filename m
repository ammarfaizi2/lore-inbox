Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267823AbTBJMRO>; Mon, 10 Feb 2003 07:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267836AbTBJMQ6>; Mon, 10 Feb 2003 07:16:58 -0500
Received: from [195.223.140.107] ([195.223.140.107]:25986 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267823AbTBJMQP>;
	Mon, 10 Feb 2003 07:16:15 -0500
Date: Mon, 10 Feb 2003 13:25:38 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, reiser@namesys.com,
       jakob@unthought.net, david.lang@digitalinsight.com,
       riel@conectiva.com.br, ckolivas@yahoo.com.au,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210122538.GH31401@dualathlon.random>
References: <20030210010937.57607249.akpm@digeo.com> <3E4779DD.7080402@namesys.com> <20030210101539.GS31401@dualathlon.random> <3E4781A2.8070608@cyberone.com.au> <20030210111017.GV31401@dualathlon.random> <3E478C09.6060508@cyberone.com.au> <20030210113923.GY31401@dualathlon.random> <20030210034808.7441d611.akpm@digeo.com> <3E4792B7.5030108@cyberone.com.au> <20030210041245.68665ff6.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030210041245.68665ff6.akpm@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 04:12:45AM -0800, Andrew Morton wrote:
> traffic, etc would be expected.   Could be that sending out a
> request which is larger than a track is saving a rev of the disk
> for some reason.

I'm guessing something on those lines yes, I doubt it's purerely in core
overhead that makes that much difference. Just for completeness, I never
read this in literature or data sheets, this is all out of pratical
experience, so we can't exclude something odd in the scsi layer, but I
very much doubt, the only thing that might explain it is to waste cpu
and we know it's not wasting it.

Andrea
