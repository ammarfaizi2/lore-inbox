Return-Path: <linux-kernel-owner+w=401wt.eu-S932861AbWLSR7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932861AbWLSR7m (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 12:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932865AbWLSR7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 12:59:42 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:47689 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932861AbWLSR7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 12:59:41 -0500
Date: Tue, 19 Dec 2006 18:57:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Robert Crocombe <rcrocomb@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19.1-rt15: BUG in __tasklet_action at kernel/softirq.c:568
Message-ID: <20061219175728.GA20262@elte.hu>
References: <e6babb600612180948n7820c038k148a5a514d541b2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6babb600612180948n7820c038k148a5a514d541b2e@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Robert Crocombe <rcrocomb@gmail.com> wrote:

> Almost exactly 24 hours after booting 2.6.19.1-rt15, I encountered the
> following:
> 
> softirq-tasklet/49[CPU#3]: BUG in __tasklet_action at kernel/softirq.c:568

yeah. This is something that triggers very rarely on certain boxes. Not 
fixed yet, and it's been around for some time.

	Ingo
