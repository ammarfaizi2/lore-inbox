Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935710AbWK1InU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935710AbWK1InU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 03:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935707AbWK1Imu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 03:42:50 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:35515 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S935695AbWK1ImR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 03:42:17 -0500
Date: Mon, 27 Nov 2006 11:16:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Don Mullis <dwm@meer.net>
Cc: Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-mm1 -- sched-improve-migration-accuracy.patch slows boot
Message-ID: <20061127101600.GB5812@elte.hu>
References: <20061123021703.8550e37e.akpm@osdl.org> <1164484124.2894.50.camel@localhost.localdomain> <1164522263.5808.12.camel@Homer.simpson.net> <1164591509.2894.76.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164591509.2894.76.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00,DATE_IN_PAST_12_24 autolearn=no SpamAssassin version=3.0.3
	0.7 DATE_IN_PAST_12_24     Date: is 12 to 24 hours before Received: date
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Don Mullis <dwm@meer.net> wrote:

> > This must be a bisection false positive.  The patch in question is
> > essentially a no-op for a UP kernel.
> 
> Testing alternately with 
> 	1) all -mm1 patches applied, and 
> 	2) all except sched-improve-migration-accuracy*.path applied,
> confirms the misbehavior.

could you run this utility:

  http://people.redhat.com/mingo/time-warp-test/time-warp-test.c

on your box for a while (10 minutes or so) - what does it print?

	Ingo
