Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVBWULE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVBWULE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 15:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVBWULE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 15:11:04 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:60803 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261556AbVBWUKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 15:10:55 -0500
Subject: Re: More latency regressions with 2.6.11-rc4-RT-V0.7.39-02
From: Lee Revell <rlrevell@joe-job.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0502231952250.14603@goblin.wat.veritas.com>
References: <1109182061.16201.6.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502231908040.13491@goblin.wat.veritas.com>
	 <1109187381.3174.5.camel@krustophenia.net>
	 <Pine.LNX.4.61.0502231952250.14603@goblin.wat.veritas.com>
Content-Type: text/plain
Date: Wed, 23 Feb 2005 15:10:52 -0500
Message-Id: <1109189453.3174.23.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-23 at 20:06 +0000, Hugh Dickins wrote:
> On Wed, 23 Feb 2005, Lee Revell wrote:
> > On Wed, 2005-02-23 at 19:16 +0000, Hugh Dickins wrote:
> > > 
> > > I'm just about to test this patch below: please give it a try: thanks...
> 
> I'm very sorry, there's two things wrong with that version: _must_
> increment addr before breaking out, and better to check after pte_none
> too (we can question whether it might be checking too often, but this
> replicates what Ingo was doing).  Please replace by new patch below,
> which I'm now running through lmbench.

OK, I will report any interesting results with the new patch.

Lee

