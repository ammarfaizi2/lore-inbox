Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965126AbWBGPGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbWBGPGB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 10:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbWBGPGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 10:06:00 -0500
Received: from ns.suse.de ([195.135.220.2]:35213 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965117AbWBGPF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 10:05:59 -0500
Date: Tue, 7 Feb 2006 16:05:57 +0100
From: Nick Piggin <npiggin@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Suresh B <suresh.b.siddha@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [rfc][patch] sched: remove smpnice
Message-ID: <20060207150557.GB20930@wotan.suse.de>
References: <20060207142828.GA20930@wotan.suse.de> <200602080157.07823.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602080157.07823.kernel@kolivas.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 01:57:06AM +1100, Con Kolivas wrote:
> On Wednesday 08 February 2006 01:28, Nick Piggin wrote:
> >
> > I'd like to hear any other suggestions though. Patch included to aid
> > discussion at this stage, rather than to encourage any rash decisions.
> 
> I see the demonstrable imbalance but I was wondering if there is there a real 
> world benchmark that is currently affected?
> 

Other than the hackbench lock latency that Ingo believes is quite
important (and I wouldn't disagree at all if it turns out to be a
regression), I have not had much time to test things out. I don't
think we can chance it in the SUSE kernel.

The other thing is that it causes headaches when trying to analyse
and review proposed scheduler changes (eg. Suresh's power saving
work).

Nick

