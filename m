Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280838AbRL0VPU>; Thu, 27 Dec 2001 16:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282271AbRL0VPM>; Thu, 27 Dec 2001 16:15:12 -0500
Received: from ns.suse.de ([213.95.15.193]:48912 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281836AbRL0VO4>;
	Thu, 27 Dec 2001 16:14:56 -0500
Date: Thu, 27 Dec 2001 22:14:53 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Philip Harvey <harveyp@coventry.ac.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: replacing strtok() with strsep()
In-Reply-To: <1009487046.8811.0.camel@arrakis>
Message-ID: <Pine.LNX.4.33.0112272211480.15706-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Dec 2001, Philip Harvey wrote:

> i've decided its high time someone removed every last trace of strtok()
> from the kernel source (replacing with strsep() for thread safety), so
> i've decided to do it myself.  quite simple stuff, but requires
> extensive testing to be sure.  therefore, i'm not too keen on patching
> 2.4.x, but instead cleaning out 2.5.x.  if someone else is doing this,
> or has any objections, shout my way please.

Someone (I forget who) took a run-through about 6 months back.
AFAIK, they still sit in the last -ac tree, and not all (if any) of them
got merged. If I get bored/desperate for patches to merge, I'll resurrect
them for -dj. There are some other bits I keep meaning to dig out of
Alans old tree, so if you decide to go do this and just bring these in
sync for 2.5, I've no problem putting them in -dj until such a time
for them to get maintainer-review/testing/merging.

The kernel-janitor list archives should hold copies of some of them.
(See the sf page for details)

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

