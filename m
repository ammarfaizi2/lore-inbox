Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290473AbSAYBK2>; Thu, 24 Jan 2002 20:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290475AbSAYBKL>; Thu, 24 Jan 2002 20:10:11 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:59655 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S290470AbSAYBJ4>; Thu, 24 Jan 2002 20:09:56 -0500
Message-ID: <3C50AEE1.2300BB05@zip.com.au>
Date: Thu, 24 Jan 2002 17:03:29 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: J Sloan <jjs@lexus.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Testing the effects of the low latency patch
In-Reply-To: <3C50AC22.7090203@lexus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan wrote:
> 
> I had earlier posted reports about the low latency patch in terms
> that are too subjective - e.g. saying that "quake 3 arena feels much
> smoother and I frag a lot more" isn't the kind of hard statistical
> evidence demanded by some. I have attempted to quanitify the latency
> differences in one of the workloads where I see and feel a difference.

mm.  Numbers.  Nice.

> 
> 2.4.18-pre6+tux+nfs-fixes
> -------------
> ...
> 7.6 1
> 7.8 1
> 21.1 1

This is the stock kernel.  In twenty minutes you suffered
precisely *one* scheduling overrun which is perceptible
by a human.  The rest are much shorter than your monitor's
refresh interval.  Interesting, yes?

These results are better than the ones I normally measure.

> ...
> The dbench results:
> 
> 2.4.18-pre6+tux+nfs-fixes
> ---------------------------------
> ...
> Throughput 48.9432 MB/sec (NB=61.179 MB/sec   489.432 MBit/sec)  16 procs
> ...
> 
> 2.4.18-pre6+tux+nfs-fixes + low latency patch
> ---------------------------------
> ...
> Throughput 106.361 MB/sec (NB=132.951 MB/sec  1063.61 MBit/sec)  16 procs
> ...

Now that's odd.

-
