Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267011AbSLDSZM>; Wed, 4 Dec 2002 13:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267016AbSLDSZM>; Wed, 4 Dec 2002 13:25:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65030 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267011AbSLDSZJ>;
	Wed, 4 Dec 2002 13:25:09 -0500
Date: Wed, 4 Dec 2002 18:32:35 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: lkml, bugme.osdl.org?
Message-ID: <20021204183235.GA701@gallifrey>
References: <200212030724.gB37O4DL001318@turing-police.cc.vt.edu> <20021203121521.GB30431@suse.de> <20021204115819.GB1137@gallifrey> <20021204124227.GB647@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021204124227.GB647@suse.de>
User-Agent: Mutt/1.4i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 18:13:48 up 52 min,  1 user,  load average: 0.06, 0.06, 0.02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Jones (davej@codemonkey.org.uk) wrote in reply to my reply:
> 
> This was something that was brought up in a discussion at the kernel
> summit by (I think) Paul Mackerras. The question was how to make
> sure we get all arch's in sync before doing a release.
> It should be fairly straightforward thing to do for 2.6.x releases,
> but during 2.5.x when stuff is changing so rapidly, it doesn't make
> sense to hold up the majority of users just so the other archs can
> play catch up.

True; thats why I only started submitting these now we are feature
chilled. I reckoned it was important not to get into the misconception
we didn't have many bugs left because things were starting to chug along
nicely on x86.

>  > Don't forget that ia64, x86-64 and s390 are all potentially growing
>  > users of Linux.
> 
> ia64 and x86-64 maybe, but s390 is way out of the pricerange of most
> Linux users. Those who can afford it will likely use distro kernels anyway
> due to the added support they paid for.

True; but sometimes people have desires to run the same/similar kernel
versions on all their systems and/or use some patches without having to
have versions for all systems.

>  > Linux on ARM, MIPS and PPC also has a healthy band of
>  > productive (commercial and home) users.
> 
> Russell has done a great job at keeping ARM up to date in 2.5,
> as have the PPC folks.  For the most part, the archs aren't that
> out of sync. (Insert comedy remark here about m68k being more
> up to date than alpha).

Indeed - (Alpha is actually one of the few non-x86 architectures
that actually built fully for me in a recent 2.5.x - and made a passable
attempt at booting)

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
