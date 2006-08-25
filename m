Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWHYKf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWHYKf7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 06:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWHYKf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 06:35:59 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:41117 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932411AbWHYKf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 06:35:58 -0400
Date: Fri, 25 Aug 2006 12:28:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 1/3] futex_find_get_task: remove an obscure EXIT_ZOMBIE check
Message-ID: <20060825102802.GB25035@elte.hu>
References: <20060821170604.GA1640@oleg> <20060822104327.GA28183@elte.hu> <20060822191037.GA493@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822191037.GA493@oleg>
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


* Oleg Nesterov <oleg@tv-sign.ru> wrote:

> But probably you are talking about these patches
> 
> 	http://marc.theaimsgroup.com/?t=113284375800003&r=1
> 	http://marc.theaimsgroup.com/?t=113284375800005&r=1
> 
> ? It was abandoned by Linus. It is not clear was he convinced or not, 
> but I'd be happy to re-send this patch (on weekend) if you wish.

sure, please do. I'm not sure how and why they were dropped - it's the 
author (you) who is supposed to push it! :-) (Sometimes patches can drop 
out of -mm due to logistical clashes or due to bugs - just re-merge / 
fix them in that case.) These patches certainly make alot of sense.

	Ingo
