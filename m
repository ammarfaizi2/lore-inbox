Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313377AbSDPMgC>; Tue, 16 Apr 2002 08:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313665AbSDPMgB>; Tue, 16 Apr 2002 08:36:01 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:60898 "EHLO
	swan.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S313377AbSDPMgB>; Tue, 16 Apr 2002 08:36:01 -0400
Date: Tue, 16 Apr 2002 08:42:23 -0400
To: joe@tmsusa.com, akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.8 final - another data point
Message-ID: <20020416084223.A1817@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>Patience.  2.5.later-on will perform well.  :)

> It's already quite usable for some workloads, and the
> latency for workstation use is quite good -  I am looking
> forward to the maturation of this diamond in the rough

I noticed a dbench regression in 2.5.8 too.  The light at 
the end of the tunnel looks bright and close though. :)
(reference to near-death experience - not a train. :)

Running dbench 128 on ext2 mounted with delalloc and Andrew's
patches from http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.8/
was 7.5x faster than 2.5.8 vanilla and 1.5x faster than 
2.4.19pre6aa1.

It will be fun to see what the other i/o benchmarks
and OSDB do with Andrew's delalloc patches.

-- 
Randy Hron

