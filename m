Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269143AbRHFXFe>; Mon, 6 Aug 2001 19:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269133AbRHFXFY>; Mon, 6 Aug 2001 19:05:24 -0400
Received: from zeus.kernel.org ([209.10.41.242]:42215 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S269143AbRHFXFH>;
	Mon, 6 Aug 2001 19:05:07 -0400
Message-ID: <3B6F14E2.3030209@ftel.co.uk>
Date: Mon, 06 Aug 2001 23:06:26 +0100
From: Paul Flinders <ptf@ftel.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010725
X-Accept-Language: en-us
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: SIS 630E perf problems?
In-Reply-To: <200108061713.f76HDaj16575@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

>I use bookpcs - all in one, really nice form factor - for build machines,
>firewalls (with a USB ethernet), etc.  I used the first generation which
>had intel i810 graphics (sucked) but had fairly typical performance, 
>competitive for kernel builds with other current platforms at the time.
>
>I recently bought a couple of the second generation of these boxes, these
>have an SIS 630E based motherboard.  This has a much better graphics interface,
>quite reasonable at 1280x1024, and all the other bits work fine under RH 7.1
>without tweaking.
>
>Performance sucks, however.  I did an LMbench run to try and figure out why
>and it's obvious - the memory latencies are 430 ns - that's 2x more than
>what is reasonable.  I tweaked the various bios settings a bit and could
>not get it to change much, maybe 20ns but not the 200ns I was looking for.
>The fact that this system is running a celeron with a dinky cache makes it
>feel really slow.  These boxes with a 633Mhz celeron feel slower than the
>old boxes with a 400Mhz celeron.
>
If there is a problem it appears to be OS, and even processor independent.

I have one of these and had made essentially the same observation as Larry
- that memory bandwidth seems extremely poor.

Larry's mail prompted me to have another look so I installed Win 2k and
ran the Sandra benchmarks - which came up with a memory bandwidth of
130MB/s, about 1/3 of it's reference value for a SiS 630S.

Disk throughput was poor as well, about 8MB/s for a 10G 5400 Seagate
running in Ultra DMA 66. Presumably this is secondary to the lousy memory
bandwidth and (?) points to a bottleneck between chipset & RAM

Mine has a 667Mhz Citrix (Samual I core) and normally runs RH 7.1,

Does anybody else have one?


