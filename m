Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290237AbSAXUnM>; Thu, 24 Jan 2002 15:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290247AbSAXUnC>; Thu, 24 Jan 2002 15:43:02 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:58120 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S290237AbSAXUmp>;
	Thu, 24 Jan 2002 15:42:45 -0500
Date: Thu, 24 Jan 2002 10:55:05 +0100
From: Pavel Machek <pavel@suse.cz>
To: Daniel Nofftz <nofftz@castor.uni-trier.de>
Cc: Timothy Covell <timothy.covell@ashavan.org>,
        Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Dave Jones <davej@suse.de>, Andreas Jaeger <aj@suse.de>,
        Martin Peters <mpet@bigfoot.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
Message-ID: <20020124095504.GA297@elf.ucw.cz>
In-Reply-To: <200201231813.g0NID5r15047@home.ashavan.org.> <Pine.LNX.4.40.0201232021440.2202-100000@infcip10.uni-trier.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0201232021440.2202-100000@infcip10.uni-trier.de>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Hey, don't get me wrong.  I'm all for power-saving.  That's
> > why I own a Via C3 based system.   The Via C3 works
> > great as an NFS server and draws 12 Watts max (avg.
> > is 6 watts).   For just email and web browsing, I'd definitely
> > recommend it.   I'd also recommend it for a small firewall/router
> > system.   However, for A/V apps and heavy compiling, it's
> > definitely not the way to go [BeOS C3 can handle one
> > A/V app at a time, but not several].
> >
> >
> > If the patch is really the way to go, then we should get it
> > put into the main distribution.  But if it is going to hurt
> > my performance, then I'd be happy to stick with vanilla
> > kapmd (hlt based) power saving.
> 
> eenabling the discconect function causes a performance drop of about 2-3 %
> as far as i heared ... but this patch is only for athlon processors
> on an

You could look for how long CPU was idle, and only if it was mostly
idle in last 10 seconds enable the bit ;-).
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
