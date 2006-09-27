Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030746AbWI0UQv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030746AbWI0UQv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030753AbWI0UQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:16:51 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:24481 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030754AbWI0UQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:16:49 -0400
Date: Wed, 27 Sep 2006 22:08:33 +0200
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] exponential update_wall_time
Message-ID: <20060927200832.GB20282@elte.hu>
References: <1159385734.29040.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159385734.29040.9.camel@localhost>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* john stultz <johnstul@us.ibm.com> wrote:

> Accumulate time in update_wall_time exponentially. This avoids long 
> running loops seen with the dynticks patch as well as the problematic 
> hang" seen on systems with broken clocksources.
> 
> This applies on top of 2.6.18-mm1
> 
> Signed-off-by: John Stultz <johnstul@us.ibm.com>

Acked-by: Ingo Molnar <mingo@elte.hu>

works fine and is included in 2.6.18-rt too.

	Ingo
