Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281300AbRKEUBk>; Mon, 5 Nov 2001 15:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281303AbRKEUBa>; Mon, 5 Nov 2001 15:01:30 -0500
Received: from domino1.resilience.com ([209.245.157.33]:32482 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S281300AbRKEUBU>; Mon, 5 Nov 2001 15:01:20 -0500
Mime-Version: 1.0
Message-Id: <p05100302b80c9aab7f40@[10.128.7.49]>
In-Reply-To: <4.3.2.7.2.20011105080435.00bc7620@10.1.1.42>
In-Reply-To: <200111042213.fA4MDoI229389@saturn.cs.uml.edu>
 <4.3.2.7.2.20011105080435.00bc7620@10.1.1.42>
Date: Mon, 5 Nov 2001 11:58:27 -0800
To: Stephen Satchell <satch@concentric.net>, dalecki@evision.ag,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Cc: Jakob =?iso-8859-1?Q?=D8stergaard?= <jakob@unthought.net>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Alexander Viro <viro@math.psu.edu>, John Levon <moz@compsoc.man.ac.uk>,
        linux-kernel@vger.kernel.org,
        Daniel Phillips <phillips@bonn-fries.net>, Tim Jansen <tim@tjansen.de>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 8:38 AM -0800 11/5/01, Stephen Satchell wrote:
>As for version fields:  I HATE THEM.  So much of my older code has 
>bloat because of "version fields" that require that I have multiple 
>blocks of code for the same damn thing.  POSIX code that has to 
>determine which version of POSIX is implemented, and tailor the code 
>at run-time to the whims of the OS gods.  BLOAT BLOAT BLOAT. 
>Besides, you already have a "version field", or is the release level 
>of Linux too coarse for you?

Either too coarse or too fine, often enough, when we're talking about 
a semi-independent module. Consider, though, a more legitimate 
non-bloating use of a version field. Rather than try to support all 
versions, use it to determine whether the two ends of the 
communication channel are compatible, and fail gracefully because of 
the incompatible version. Tell the user to update the app, or 
whatever.
-- 
/Jonathan Lundell.
