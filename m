Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVGMRzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVGMRzn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVGMRxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:53:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20386 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261919AbVGMRv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:51:56 -0400
Date: Wed, 13 Jul 2005 10:51:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.13-rc3
In-Reply-To: <1121275893.4435.47.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0507131045530.17536@g5.osdl.org>
References: <Pine.LNX.4.58.0507122157070.17536@g5.osdl.org>
 <1121275893.4435.47.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Jul 2005, Lee Revell wrote:

> On Tue, 2005-07-12 at 22:05 -0700, Linus Torvalds wrote:
> > I think the shortlog speaks for itself.
> 
> HZ still defaults to 250.  As was explained in another thread, this will
> break apps like MIDI sequencers and won't really save much battery
> power.

Stop bothering with this, I've seen the thread, and no, I disagree totally 
with "as explained in another thread". That's simply not true.

The only thing that is true is that 100Hz is too low for some use, and 
1000Hz is too high for some uses. NOBODY has shown that 250Hz isn't good 
enough, there's only been people whining and complaining and saying it 
might not be.

The fact is, engineering is about finding something that works "well 
enough". If _you_ think that 1000Hz is the right answer, then _you_ select 
that. But if you cannot accept the fact that other people are of a 
different opinion, then why would anybody want to discuss the issue with 
you?

This is a fundamental fact of engineering (and, in fact, pretty much any 
other area in life): 

	If you cannot accept that other people have other aims and 
	needs than than you, then why are you talking to other people in 
	the first place?

So get on with your lives. Realize that there is no "perfect" value for 
HZ. 250 right now is somewhere reasonable, and for the extreme ends you 
can always chose your own. Don't try to force your ideas on others.

And btw, the next time somebody complains about HZ, I want HARD DATA. I 
don't want whining. Stop cc'ing me in you don't have a real datapoint, and 
if you cannot accept that other people have _other_ real datapoints.

		Linus
