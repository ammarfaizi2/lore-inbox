Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269823AbUJHLUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269823AbUJHLUn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 07:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269837AbUJHLUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 07:20:42 -0400
Received: from holomorphy.com ([207.189.100.168]:4310 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269823AbUJHLQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 07:16:57 -0400
Date: Fri, 8 Oct 2004 04:16:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       "K.R. Foley" <kr@cybsft.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm2-T1
Message-ID: <20041008111645.GF9106@holomorphy.com>
References: <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu> <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu> <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041005134707.GA32033@elte.hu>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 03:47:07PM +0200, Ingo Molnar wrote:
> i've released the -T1 VP patch:
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm2-T1
> Changes since -T0:
>  - added the read-lock fix from Hugh that affects SMP systems. This 
>    could fix Rui's problem - i've checked -T1 on a P4/HT box and saw no 
>    problems, BYMMV.
>  - compilation fixes (for those who downloaded T0 early)
>  - small tracer improvement
> to build a -T1 tree from scratch the patching order is:
>    http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
>  + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc3.bz2
>  + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm2/2.6.9-rc3-mm2.bz2
>  + http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm2-T1

The version numbers are up to Chebyshev polynomials. Now I have to try it.


-- wli
