Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbVKBAjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbVKBAjX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 19:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932074AbVKBAjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 19:39:23 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:24584 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932071AbVKBAjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 19:39:22 -0500
Date: Wed, 2 Nov 2005 01:28:21 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Grant Coady <gcoady@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.32-rc2
Message-ID: <20051102002821.GC13557@alpha.home.local>
References: <20051031175704.GA619@logos.cnet> <4366E9AA.4040001@gmail.com> <20051101074959.GQ22601@alpha.home.local> <20051101063402.GA3311@logos.cnet> <4367C95D.3050108@drugphish.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4367C95D.3050108@drugphish.ch>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roberto,

On Tue, Nov 01, 2005 at 09:00:29PM +0100, Roberto Nibali wrote:
> Marcelo, Willy,
> 
> > There is nothing else pending for v2.4.32 on my part. 
> > 
> > Will wait a couple of days and tag it as v2.4.32.
> 
> I'm checking on some IPVS related code "inconsistency" regarding the
> latest patches sent by Julian and a netfilter reference counting issue
> on SMP. Could you hold off until Sunday with the release, please. If I
> don't report back by then with either a bug report or bugfix, release it ;).
> 
> Willy, if you have time, could you check your non-i386 boxes with a
> 2.95.x compiled 2.4.x kernel, with IPVS enabled?

Yes, no problem, but you'll have to tell me what to test ! (a config
or script will save me some time). I have a Sun Ultra60 (ultrasparc SMP)
which matches your description. I just have a doubt about gcc-2.95
availability on this box, I know I have a 3.3.6, do you think that the
problem is gcc-related (too strong optimization or de-inlining, etc) ?

> Also I checked back
> with your hf7 series patches and I should like to note that the IPVS
> related patches have been merged upstream with Marcelo for 2.4.32-rc2.

Yes, the patches in hf7 are the same as in 2.4.32-rc2. If you want to try
without, you can download the -split.tgz archive, they're all there. 

Please keep us informed when you have more info.

> Thanks guys,
> Roberto Nibali, ratz

Cheers,
Willy

> -- 
> echo
> '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq' | dc
