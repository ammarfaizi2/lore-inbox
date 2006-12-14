Return-Path: <linux-kernel-owner+w=401wt.eu-S932288AbWLNKBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWLNKBq (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 05:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWLNKBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 05:01:46 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:46842 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932307AbWLNKBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 05:01:45 -0500
Date: Thu, 14 Dec 2006 10:59:26 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19.1-rt14-smp circular locking dependency
Message-ID: <20061214095926.GA19549@elte.hu>
References: <1166090243.7147.10.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166090243.7147.10.camel@Homer.simpson.net>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0072]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Galbraith <efault@gmx.de> wrote:

> Greetings,
> 
> Lockdep doesn't approve of cpufreq, and seemingly with cause... I had 
> to poke SysRq-O.

hm ... this must be an upstream problem too, right? -rt shouldnt change 
anything in this area (in theory).

	Ingo
