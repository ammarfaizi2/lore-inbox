Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288002AbSAMHg1>; Sun, 13 Jan 2002 02:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288005AbSAMHgS>; Sun, 13 Jan 2002 02:36:18 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:9225 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S288002AbSAMHgH>; Sun, 13 Jan 2002 02:36:07 -0500
Message-ID: <3C413793.F8F648B5@zip.com.au>
Date: Sat, 12 Jan 2002 23:30:27 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: J Sloan <jjs@pobox.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: My end user testing of 2.4.8-ish kernels
In-Reply-To: <3C41350D.9070407@pobox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan wrote:
> 
> I did some testing today on the mini-low-latency patch.
> 
> I must admit that I was totally biased towards it from the start.
> 
> While it certainly didn't hurt anything, the bottom line is that
> after hours of mp3/dbench tests, I was unable to quantify any real
> difference between 2.4.18-pre3 vanilla and with mini low latency.
> They exhibit pretty much the same behaviour in terms of how much
> dbench it takes to start hearing audio dropouts in xmms - they were
> both smooth up to dbench 40, but started exhibiting sporadic audio
> dropouts at dbench 64.

Oh well.   I must have missed one.

> Out of curiosity I booted up 2.4.18pre2-aa2 and found it a real gem.
> To my pleasant suprise I was able to run dbench 128 without hearing
> a _single_ audio dropout. (the dbench 128 result was 19.75 MB/sec)
> 
> With dbench 192 I did start to hear some occasional dropouts, but
> they were generally short, e.g. 100ms or so.
> 
> In any event, all the 2.4.18-pre-ish kernels I tested today are much
> better at this than e.g. 2.4.7 - at least on my hardware, I am now
> getting excellent interactive performance under load without preempt
> or low-latency patches, and that's a good thing.
> 
> IMHO the -aa kernel seems to the clear winner here -
> 

the -aa kernel basically includes everything that's in the mini-ll
patch.  If you merge -aa, you get mini-ll.  Plus the one I missed :)

-
