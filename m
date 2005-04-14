Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVDNIXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVDNIXL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 04:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVDNIXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 04:23:11 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:47343 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261460AbVDNIXG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 04:23:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LxzlNqXlNIa7ZH5G6DzrvHSpJ9hdsmhCz5ezW7Bv0H1rUkkoo/mTi8/z7OWuTFPVs+ciCiWNFTjrrDuwkWLD388CZnwEnbeA3emJPW8ZQ0MxOmzT/T94xWhRwC1d6i5OF1e3u2QH72l9oDhmHSv+IFItw0sNBpNKKBksRGYrAUg=
Message-ID: <2cd57c900504140123181cd94c@mail.gmail.com>
Date: Thu, 14 Apr 2005 16:23:02 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: Coywolf Qi Hunt <coywolf@gmail.com>
To: Iwan Sanders <iwan.sanders@tuxproject.info>
Subject: Re: Kernel messages
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <425E23CC.2010509@tuxproject.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <425E23CC.2010509@tuxproject.info>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/05, Iwan Sanders <iwan.sanders@tuxproject.info> wrote:
> Can someone explain to me what just happend? I would really like to know
>   :-)
> I think that the machine ran out of memory and the OOM killer shot some
> processes, this is what I found
> in my logfiles:
> 
> 1 Time(s): Active:48588 inactive:152 dirty:0 writeback:7 unstable:0 free:502 slab:13664 mapped:48620 pagetables:325
> 1 Time(s): DMA free:1008kB min:28kB low:56kB high:84kB active:7364kB inactive:0kB present:16384kB
> 1 Time(s): DMA per-cpu:
> 1 Time(s): DMA: 0*4kB 0*8kB 1*16kB 7*32kB 4*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1008kB
> 1 Time(s): Free pages:        2008kB (0kB HighMem)
> 1 Time(s): HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
> 1 Time(s): HighMem per-cpu: empty
> 1 Time(s): HighMem: empty
> 1 Time(s): Normal free:1000kB min:476kB low:952kB high:1428kB active:186988kB inactive:608kB present:245120kB
> 1 Time(s): Normal per-cpu:
> 1 Time(s): Normal: 14*4kB 2*8kB 0*16kB 1*32kB 2*64kB 0*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1000kB
> 1 Time(s): Swap cache: add 0, delete 0, find 0/0, race 0+0
> 1 Time(s): cpu 0 cold: low 0, high 2, batch 1
> 1 Time(s): cpu 0 cold: low 0, high 28, batch 14
> 1 Time(s): cpu 0 hot: low 2, high 6, batch 1
> 1 Time(s): cpu 0 hot: low 28, high 84, batch 14
> 1 Time(s): oom-killer: gfp_mask=0x1d2
> 1 Time(s): protections[]: 0 0 0
> 1 Time(s): protections[]: 0 238 238
> 1 Time(s): protections[]: 14 252 252
> 
> Cheers,
> 
> Iwan Sanders
> 

Yes, oom, and your kernel is a bit old.

-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
