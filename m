Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWFSMzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWFSMzY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWFSMzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:55:24 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:7631 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932434AbWFSMzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:55:23 -0400
Date: Mon, 19 Jun 2006 14:50:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@timesys.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and dynamic HZ
Message-ID: <20060619125018.GA20549@elte.hu>
References: <1150643426.27073.17.camel@localhost.localdomain> <Pine.LNX.4.64.0606190144560.17704@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606190144560.17704@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > Bugreports and suggestions are welcome,
> 
> Could you please document the patches? I know it sucks compared to 
> hacking, but it would make a review a lot simpler.

yeah, we'll add some description to the patches themselves, but 
otherwise i'm afraid it will be like with almost all patch submissions 
on lkml: 99% of the details are in the code and people have to ask 
specifically if one area or another is unclear :-|

Meanwhile the patch names should provide you with some initial info 
(also, we reuse GTOD which is documented in -mm) and the splitup is 
pretty clean too - but in any case please feel free to ask pointed 
questions! (we happily accept documentation patches as well.)

	Ingo
