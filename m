Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290475AbSAYBPI>; Thu, 24 Jan 2002 20:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290477AbSAYBO7>; Thu, 24 Jan 2002 20:14:59 -0500
Received: from freeside.toyota.com ([63.87.74.7]:14609 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S290475AbSAYBOx>; Thu, 24 Jan 2002 20:14:53 -0500
Message-ID: <3C50B185.40006@lexus.com>
Date: Thu, 24 Jan 2002 17:14:45 -0800
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020123
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Testing the effects of the low latency patch
In-Reply-To: <3C50AC22.7090203@lexus.com> <3C50AEE1.2300BB05@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>J Sloan wrote:
>
>>I had earlier posted reports about the low latency patch in terms
>>that are too subjective - e.g. saying that "quake 3 arena feels much
>>smoother and I frag a lot more" isn't the kind of hard statistical
>>evidence demanded by some. I have attempted to quanitify the latency
>>differences in one of the workloads where I see and feel a difference.
>>
>
>mm.  Numbers.  Nice.
>
>>2.4.18-pre6+tux+nfs-fixes
>>-------------
>>...
>>7.6 1
>>7.8 1
>>21.1 1
>>
>
>This is the stock kernel.  In twenty minutes you suffered
>precisely *one* scheduling overrun which is perceptible
>by a human.  The rest are much shorter than your monitor's
>refresh interval.  Interesting, yes?
>
Yes, the stock kernel is much improved from
say 6 months ago. I will take a look at the
kernel that shipped with my distro just for
giggles as well...

>>
>>The dbench results:
>>
>>2.4.18-pre6+tux+nfs-fixes
>>---------------------------------
>>...
>>Throughput 48.9432 MB/sec (NB=61.179 MB/sec   489.432 MBit/sec)  16 procs
>>...
>>
>>2.4.18-pre6+tux+nfs-fixes + low latency patch
>>---------------------------------
>>...
>>Throughput 106.361 MB/sec (NB=132.951 MB/sec  1063.61 MBit/sec)  16 procs
>>...
>>
>
>Now that's odd.
>
Yes this smells like a statistical anomaly -

Will run mulitple tests tonight and see if
there's an actual trend there or just a
blip on the screen.

Joe

>

