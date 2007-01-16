Return-Path: <linux-kernel-owner+w=401wt.eu-S1750726AbXAPPmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbXAPPmD (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 10:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbXAPPmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 10:42:03 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53604 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750726AbXAPPmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 10:42:01 -0500
Date: Tue, 16 Jan 2007 16:40:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Pierre Peiffer <pierre.peiffer@bull.net>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH 2.6.20-rc4 0/4] futexes functionalities and improvements
Message-ID: <20070116154054.GA21786@elte.hu>
References: <45A3BFAC.1030700@bull.net> <45A67830.4050207@redhat.com> <20070111134615.34902742.akpm@osdl.org> <45A73E90.7050805@bull.net> <20070112075816.GA23341@elte.hu> <45AC8E2A.3060708@bull.net> <45ACEBDF.60602@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45ACEBDF.60602@redhat.com>
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


* Ulrich Drepper <drepper@redhat.com> wrote:

> Pierre Peiffer wrote:
> > I've run this bench 1000 times with pipe and 800 groups.
> > Here are the results:
> 
> This is not what I'm mostly concerned about.  The patches create a 
> bottleneck since _all_ processes use the same resource. [...]

what do you mean by that - which is this same resource?

	Ingo
