Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263732AbUCXOwD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 09:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263734AbUCXOwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 09:52:03 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:11151
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263732AbUCXOwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 09:52:00 -0500
Date: Wed, 24 Mar 2004 15:52:53 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
       mjy@geizhals.at, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-ID: <20040324145253.GG2065@dualathlon.random>
References: <40591EC1.1060204@geizhals.at> <20040318060358.GC29530@dualathlon.random> <20040318015004.227fddfb.akpm@osdl.org> <20040318145129.GA2246@dualathlon.random> <405A584B.40601@cyberone.com.au> <20040319050948.GN2045@holomorphy.com> <20040320121423.GA9009@dualathlon.random> <20040320145111.GD2045@holomorphy.com> <20040320150311.GN9009@dualathlon.random> <s5hfzby1h6n.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hfzby1h6n.wl@alsa2.suse.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 02:57:20PM +0100, Takashi Iwai wrote:
> At Sat, 20 Mar 2004 16:03:11 +0100,
> Andrea Arcangeli wrote:
> > 
> > On Sat, Mar 20, 2004 at 06:51:11AM -0800, William Lee Irwin III wrote:
> > > I may have missed one of his posts where he gave the results from the
> > > RT test suite. I found a list of functions with some kind of numbers,
> > > though I didn't see a description of what those numbers were and was
> > > looking for something more detailed (e.g. the output of the RT
> > > instrumentation things he had with and without preempt). This is all
> > > mostly curiosity and sort of hoping this gets carried out vaguely
> > > scientifically anyway, so I'm not really arguing one way or the other.
> > 
> > agreed. what I've seen so far is a great number of graphs, they were
> > scientific enough for my needs and covering real life different
> > workloads, but I'm not sure what Takashi published exactly, you may want
> > to discuss it with him.
> 
> sorry, there is no exact descrption (yet) in public, except for the
> pdf of slides i presented ago:
> 
> 	http://www.alsa-project.org/~iwai/audio-latency.pdf

this is what I meant. To be fair I've also seen lots of raw input data,
but you represented all the interesting points in the presentation.

> it uses its own kernel module to generate irqs from RTC and to trace
> stacks.
> 
> i'll show the results of the recent kernels tomorrow...

cool ;)
