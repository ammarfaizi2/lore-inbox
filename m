Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287794AbSBCWFs>; Sun, 3 Feb 2002 17:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287798AbSBCWF2>; Sun, 3 Feb 2002 17:05:28 -0500
Received: from suhkur.cc.ioc.ee ([193.40.251.100]:59823 "HELO suhkur.cc.ioc.ee")
	by vger.kernel.org with SMTP id <S287794AbSBCWFR>;
	Sun, 3 Feb 2002 17:05:17 -0500
Date: Mon, 4 Feb 2002 00:05:14 +0200 (GMT)
From: Juhan Ernits <juhan@cc.ioc.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: Machines misreporting Bogomips
In-Reply-To: <Pine.LNX.4.42.0202011831170.6556-100000@egg>
Message-ID: <Pine.GSO.4.21.0202032356340.21280-100000@suhkur.cc.ioc.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Feb 2002, Greg Boyce wrote:

> On Fri, 1 Feb 2002, Alan Cox wrote:
> 
> > > The machine is reporting that the cache is enabled.  Even if this was
> > > true, I have trouble believing that turning on the cache would result in a
> > > 50,000% increase in speed (4 bogomips compared to 500).
> >
> > L1 and L2 cache both disabled comes up as about 2.5 bogomips typically on
> > a Pentium II/III.
> >

> Would a machine with L1 cache disabled, but with 512K of L2 cache report
> around 4 Bogomips, or would the performance hit not be that strong?


May be the following experiences are relevant:

- a Pentium MMX 200 MHz with burned L1 cache. It was worse than a 386 with
turbo switch turned off (didn-t have time to measure bogomips, just had it
replaced). 

- a PIII 850 with L2 cache turned off appeared comparable to a 433
MHz Celeron (860 BogoMips) while with L2 cache turned on it showed 1684
BogoMips.

So that would confirm that the snaillike behaviour of your systems has
something to do with either _burned_ of disabled L1 cache, not L2 cache.

Best regards,

Juhan Ernits

