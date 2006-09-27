Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965479AbWI0Jh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965479AbWI0Jh2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 05:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965480AbWI0Jh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 05:37:28 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:36764 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965479AbWI0Jh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 05:37:27 -0400
Date: Wed, 27 Sep 2006 10:10:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       notting@redhat.com, Dave Jones <davej@redhat.com>,
       arjan <arjan@infradead.org>
Subject: Re: [PATCH] sysrq: disable lockdep on reboot
Message-ID: <20060927081000.GA9676@elte.hu>
References: <1159283602.5038.25.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159283602.5038.25.camel@lappy>
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


* Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:

> SysRq : Emergency Sync
> Emergency Sync complete
> SysRq : Emergency Remount R/O
> Emergency Remount complete
> SysRq : Resetting
> BUG: warning at kernel/lockdep.c:1816/trace_hardirqs_on() (Not tainted)

> Since we're shutting down anyway, don't bother being smart, just turn 
> the thing off.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

agreed,

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
