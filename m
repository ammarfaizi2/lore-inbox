Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282966AbRLCIvn>; Mon, 3 Dec 2001 03:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284408AbRLCIuH>; Mon, 3 Dec 2001 03:50:07 -0500
Received: from suphys.physics.usyd.edu.au ([129.78.129.1]:64171 "EHLO
	suphys.physics.usyd.edu.au") by vger.kernel.org with ESMTP
	id <S284839AbRLCHEO>; Mon, 3 Dec 2001 02:04:14 -0500
Date: Mon, 3 Dec 2001 18:03:55 +1100 (EST)
From: Tim Connors <tcon@Physics.usyd.edu.au>
To: Derek Glidden <dglidden@illusionary.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kapm-idled no longer idling CPU?
In-Reply-To: <3C06855F.22AD79C4@illusionary.com>
Message-ID: <Pine.SOL.3.96.1011203175756.21427A-100000@suphys.physics.usyd.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2001, Derek Glidden wrote:

> I posted this question about a month ago, but haven't seen a response
> since, so I'm reposting.
> 
> I'm having a problem with all recent 2.4 systems that when any
> application that uses more than very minor system resources is running,
> (i.e. mozilla, netscape, xemacs, apache, Tomcat, just to name a few
> common ones I've seen this behaviour with) kapm-idled no longer receives
> scheduling time from what I can tell and I assume that means my CPU is
> never getting idled when nothing is scheduled.

I always had that problem though. Doesn't it only set kapmd-idled running
if the CPU has been idle for at least 1/3 second, though?

> I'm pretty sure this is a legit problem and not just kapm-idled
> reporting its time incorrectly since my laptop has gone from about 2-1/2
> hours of battery life in early 2.4 versions to less than 1 hour of
> battery life under the same conditions for recent kernels.  Plus, if I
> exit everything until I'm just sitting at a shell prompt, I'll see
> kapm-idled start to receive time again.  (Of course, the laptop isn't
> much fun when it's not running anything...)
> 
> I've seen this on a number of laptops and desktop machines since about
> 2.4.9 or so.

Mmmm, my dell insp. 4000 is now running at 53 degrees (2.4.16 - mozilla
and xemacs open) - it used to run a lot cooler, even with just 2.4.13-ac4.
This is with me doing absolutely nothing.

And integrated over the uptime of the laptop, kapmd-idled seems to only be
using about 30% CPU compared to the old 50% (and 90% with an old kernel -
but that could have been that bug detected a while back)

Of course, I just remembered we have just entered summer, and this room is
damn hot - but I wouldn't expect a laptop getting so hot it needs to turn
the fan on, when doing _nothing_!


-- 
TimC -- http://www.physics.usyd.edu.au/~tcon/

The other day I overheard that a friend of the family had called their
new kid "Noah". I thinks "Noah? I 'ardly -" and then I bursts out
laughing..  -- Screwtape in RHOD

