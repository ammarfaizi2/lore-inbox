Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVBXGil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVBXGil (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 01:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVBXGeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 01:34:14 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:20201 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261835AbVBXGcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 01:32:04 -0500
Subject: Re: More latency regressions with 2.6.11-rc4-RT-V0.7.39-02
From: Lee Revell <rlrevell@joe-job.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0502240441260.5427@goblin.wat.veritas.com>
References: <1109182061.16201.6.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502231908040.13491@goblin.wat.veritas.com>
	 <1109187381.3174.5.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502231952250.14603@goblin.wat.veritas.com>
	 <Pine.LNX.4.61.0502232048330.14747@goblin.wat.veritas.com>
	 <1109196824.4009.1.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502240441260.5427@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Thu, 24 Feb 2005 01:32:04 -0500
Message-Id: <1109226724.4957.16.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-24 at 04:56 +0000, Hugh Dickins wrote:
> On Wed, 23 Feb 2005, Lee Revell wrote:
> > On Wed, 2005-02-23 at 20:53 +0000, Hugh Dickins wrote:
> > > On Wed, 23 Feb 2005, Hugh Dickins wrote:
> > > > Please replace by new patch below, which I'm now running through lmbench.
> > > 
> > > That second patch seems fine, and I see no lmbench regression from it.
> > 
> > Should go into 2.6.11, right?
> 
> That's up to Andrew (and Linus).
> 
> I was thinking that way when I rushed you the patch.  But given that
> you have remaining unresolved latency issues nearby (zap_pte_range,
> clear_page_range), and given the warning shot that I screwed up my
> first attempt, I'd be inclined to say hold off.
> 
> It's a pity: for a while we were thinking 2.6.11 would be a big step
> forward for mainline latency; but it now looks to me like these tests
> have come too late in the cycle to be dealt with safely.
> 
> In other mail, you do expect people still to be using Ingo's patches,
> so probably this patch should stick there (and in -mm) for now.

Well all of these were fixed in the past so it may not be unreasonable
to fix them for 2.6.11.

Lee

