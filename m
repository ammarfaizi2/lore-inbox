Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267622AbUHPN2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267622AbUHPN2R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 09:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267623AbUHPN2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 09:28:17 -0400
Received: from pD9517D3C.dip.t-dialin.net ([217.81.125.60]:12680 "EHLO
	undata.org") by vger.kernel.org with ESMTP id S267622AbUHPN2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 09:28:15 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P2
From: Thomas Charbonnel <thomas@undata.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816120933.GA4211@elte.hu>
References: <20040816023655.GA8746@elte.hu>
	 <1092624221.867.118.camel@krustophenia.net>
	 <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu>
	 <1092627691.867.150.camel@krustophenia.net>
	 <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
	 <20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>
	 <20040816113131.GA30527@elte.hu>  <20040816120933.GA4211@elte.hu>
Content-Type: text/plain
Message-Id: <1092662814.5082.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 15:26:55 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote :
> here's -P2:
> 
>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P2
> 
> Changes since -P1:
> 
>  - trace interrupted kernel code (via hardirqs, NMIs and pagefaults)
> 
>  - yet another shot at trying to fix the IO-APIC/USB issues.
> 
>  - mcount speedups - tracing should be faster
> 
> 	Ingo

Same do_IRQ problem with P2, trace is here :
http://www.undata.org/~thomas/swapper-P2.trace

Thomas


