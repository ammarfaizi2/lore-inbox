Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932200AbWFDInp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWFDInp (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 04:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWFDInp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 04:43:45 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:42639 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932200AbWFDIno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 04:43:44 -0400
Date: Sun, 4 Jun 2006 10:43:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Deepak Saxena <dsaxena@plexity.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, dwalker@mvista.com,
        James Perkins <james.perkins@windriver.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH-rt] ARM: Fix dump_stack() config dependencies
Message-ID: <20060604084308.GC8418@elte.hu>
References: <20060601233925.GA23811@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060601233925.GA23811@plexity.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Deepak Saxena <dsaxena@plexity.net> wrote:

> DEBUG_ERRORS does not depend on DEBUG_MUTEXES and the kernel will not 
> build if the former is enabled and the later disables. Other option is 
> to make DEBUG_ERRORS automatically enabled DEBUG_MUTEXES in the RT 
> case.
> 
> Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

thanks, applied.

	Ingo
