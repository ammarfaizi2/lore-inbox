Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267287AbUHDHEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267287AbUHDHEV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 03:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267302AbUHDHEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 03:04:21 -0400
Received: from mx1.elte.hu ([157.181.1.137]:50655 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267287AbUHDHEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 03:04:20 -0400
Date: Wed, 4 Aug 2004 09:05:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michal Kaczmarski <fallow@op.pl>, Shane Shrybman <shrybman@aei.ca>
Subject: Re: [PATCH] V-3.0 Single Priority Array O(1) CPU Scheduler Evaluation
Message-ID: <20040804070525.GA4719@elte.hu>
References: <20040802134257.GE2334@holomorphy.com> <410EDD60.8040406@bigpond.net.au> <20040803020345.GU2334@holomorphy.com> <410F08D6.5050200@bigpond.net.au> <20040803104912.GW2334@holomorphy.com> <41102FE5.9010507@bigpond.net.au> <20040804005034.GE2334@holomorphy.com> <41103DBB.6090100@bigpond.net.au> <20040804015115.GF2334@holomorphy.com> <41104C8F.9080603@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41104C8F.9080603@bigpond.net.au>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Williams <pwil3058@bigpond.net.au> wrote:

> >>Unfortunately, to ensure no starvation, promotion has to continue even 
> >>when there are tasks in MAX_RT_PRIO's slot.
> >
> >One may either demote to evict MAX_RT_PRIO immediately prior to
> >rotation or rely on timeslice expiry to evict MAX_RT_PRIO. Forcibly
> >evicting MAX_RT_PRIO undesirably accumulates tasks at the fencepost.
> 
> It's starting to get almost as complex as the current scheme :-)

hey, it's 'complex' for a reason ;)

	Ingo
