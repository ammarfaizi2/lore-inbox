Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267538AbUHJSDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267538AbUHJSDe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 14:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267603AbUHJSBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 14:01:00 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:62352 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267470AbUHJR6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 13:58:31 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040810075130.GA25238@elte.hu>
References: <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu>
	 <20040809130558.GA17725@elte.hu> <20040809190201.64dab6ea@mango.fruits.de>
	 <1092071169.13668.23.camel@mindpipe>  <20040810075130.GA25238@elte.hu>
Content-Type: text/plain
Message-Id: <1092160730.782.16.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 13:58:51 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 03:51, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Ingo, do you plan to maintain the voluntary preempt patch against the
> > -mm series?  From looking at Andrew's announcement yesterday it looks
> > like many latency issues fixed in the voluntary preemption patches are
> > also fixed in -mm, so it seems like the patch would be much smaller. 
> 
> yeah, and in addition we've already pushed 99% of our might_sleep()
> additions to -mm too so that reduces the patch size too, quite
> significantly.
> 
> time is the only limiting factor. Due to these partial merges (we are
> trying to get all uncontroversial bits into -mm, hence into upstream)
> the merge to -mm is hard. Especially for lock-breaks that i've done
> differently than Andrew. I sent a consolidation patch yesterday but this
> is still work in progress. So i'll do an -mm merge very time i get to do
> it, but the primary testing still remains on the vanilla kernel (which
> most people use).
> 

Rather than having to maintain the voluntary preempt patch for the -mm
series, after the next -mm merge, maybe you could just post or send me
an incremental diff against the last voluntary preempt patch for the
vanilla kernel when you update it, and I or someone else from the Linux
audio community could maintain the patch against the -mm series.  It
seems that lately the changes from one version of the patch to the next
are small and easy enough to comprehend.  We could also filter the bug
reports a bit.  Maybe a voluntary preemption mailing list is in order,
if this gets to be a constant source of huge log postings to LKML.

This would also improve the ability of the Linux audio community to
influence the direction of the kernel, by separately analyzing the
impact of different changes, especially if the -mm series is going to
function as 2.7 for the time being.

Lee

