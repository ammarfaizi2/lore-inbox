Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUIOKCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUIOKCx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 06:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUIOKCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 06:02:53 -0400
Received: from holomorphy.com ([207.189.100.168]:46234 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264246AbUIOKCk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 06:02:40 -0400
Date: Wed, 15 Sep 2004 02:57:23 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrea Arcangeli <andrea@novell.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040915095723.GK9106@holomorphy.com>
References: <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au> <20040914140905.GM4180@dualathlon.random> <41470021.1030205@yahoo.com.au> <20040914150316.GN4180@dualathlon.random> <1095210126.2406.70.camel@krustophenia.net> <20040915013925.GF9106@holomorphy.com> <20040915095614.GB1629@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915095614.GB1629@elte.hu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* William Lee Irwin III <wli@holomorphy.com> wrote:
>> The code we're most worried is buggy, not just nonperformant.

On Wed, Sep 15, 2004 at 11:56:14AM +0200, Ingo Molnar wrote:
> what code do you mean? The one i know about and which Lee is referring
> to above is the 6-lines tty unlocking change - the one which Alan
> objected to rightfully. I've zapped it from my tree.
> (nobody objected to the original thread on lkml weeks ago where the tty
> unlocking change was proposed, implemented, alpha-tested and beta-tested
> in -mm for several releases - that's why it showed up in my 20+
> latency-reduction patches.)
> No latency changes to the tty layer until someone fixes its locking. End
> of story.

I had the buggy code being associated with BKL use in mind as a motive
for the BKL sweeps etc., and wasn't referring to any pending changes.


-- wli
