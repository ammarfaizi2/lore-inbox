Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271141AbTHLVLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 17:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271148AbTHLVLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 17:11:53 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:10253
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S271141AbTHLVLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 17:11:44 -0400
Date: Tue, 12 Aug 2003 14:11:37 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Mike Galbraith <efault@gmx.de>
Cc: Nick Piggin <piggin@cyberone.com.au>, rob@landley.net,
       Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [PATCH] O13int for interactivity
Message-ID: <20030812211137.GH1027@matchmail.com>
Mail-Followup-To: Mike Galbraith <efault@gmx.de>,
	Nick Piggin <piggin@cyberone.com.au>, rob@landley.net,
	Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <3F389221.6080202@cyberone.com.au> <200308110248.09399.rob@landley.net> <200308050207.18096.kernel@kolivas.org> <200308052022.01377.kernel@kolivas.org> <3F2F87DA.7040103@cyberone.com.au> <200308110248.09399.rob@landley.net> <5.2.1.1.2.20030812075224.01988de8@pop.gmx.net> <3F389221.6080202@cyberone.com.au> <5.2.1.1.2.20030812112325.01a06cb8@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.2.1.1.2.20030812112325.01a06cb8@pop.gmx.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 12, 2003 at 11:42:16AM +0200, Mike Galbraith wrote:
> At 05:18 PM 8/12/2003 +1000, Nick Piggin wrote:
> 
> >And no, X isn't intentionally sleeping. Its being preempted which is
> >obviously not intentional.
> 
> Right.  Every time X wakes the gl thread, he'll lose the cpu.  Once the gl 
> thread passes X in priority, X is pretty much doomed.  (hmm... sane [hard] 
> backboost will probably prevent that)

Isn't 2.4 doing exactly that for pipes and such?
