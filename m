Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287502AbSAMHUD>; Sun, 13 Jan 2002 02:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287997AbSAMHTx>; Sun, 13 Jan 2002 02:19:53 -0500
Received: from flrtn-4-m1-156.vnnyca.adelphia.net ([24.55.69.156]:25984 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S287502AbSAMHTn>;
	Sun, 13 Jan 2002 02:19:43 -0500
Message-ID: <3C41350D.9070407@pobox.com>
Date: Sat, 12 Jan 2002 23:19:41 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: My end user testing of 2.4.8-ish kernels
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did some testing today on the mini-low-latency patch.

I must admit that I was totally biased towards it from the start.

While it certainly didn't hurt anything, the bottom line is that
after hours of mp3/dbench tests, I was unable to quantify any real
difference between 2.4.18-pre3 vanilla and with mini low latency.
They exhibit pretty much the same behaviour in terms of how much
dbench it takes to start hearing audio dropouts in xmms - they were
both smooth up to dbench 40, but started exhibiting sporadic audio
dropouts at dbench 64.

Out of curiosity I booted up 2.4.18pre2-aa2 and found it a real gem.
To my pleasant suprise I was able to run dbench 128 without hearing
a _single_ audio dropout. (the dbench 128 result was 19.75 MB/sec)

With dbench 192 I did start to hear some occasional dropouts, but
they were generally short, e.g. 100ms or so.

In any event, all the 2.4.18-pre-ish kernels I tested today are much
better at this than e.g. 2.4.7 - at least on my hardware, I am now
getting excellent interactive performance under load without preempt
or low-latency patches, and that's a good thing.

IMHO the -aa kernel seems to the clear winner here -

Good for server use, good for desktop use...

Regards

jjs





