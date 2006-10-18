Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161171AbWJRPwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161171AbWJRPwM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161217AbWJRPwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:52:12 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:18659 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161194AbWJRPwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:52:09 -0400
Date: Wed, 18 Oct 2006 17:43:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Joe Korty <joe.korty@ccur.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.18-rt6 sysctl conflict
Message-ID: <20061018154356.GA3547@elte.hu>
References: <20061018132530.GA30767@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018132530.GA30767@tsunami.ccur.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Joe Korty <joe.korty@ccur.com> wrote:

> Repair conflict between 2.6.18 and preempt-rt's sysctl(2) addition.

thanks - the -rt tree just got rebased to latest -hrt-dynticks, which 
doesnt have the sysctl anymore. (but we might reintroduce it in the 
future, i'll pick up your fix in that case.)

	Ingo
