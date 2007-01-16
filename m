Return-Path: <linux-kernel-owner+w=401wt.eu-S1751020AbXAPLgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbXAPLgR (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 06:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbXAPLgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 06:36:17 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:55461 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013AbXAPLgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 06:36:16 -0500
Date: Tue, 16 Jan 2007 12:35:05 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: vatsa@in.ibm.com, clameter@sgi.com, tglx@linutronix.de,
       arjan@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Patch: dynticks: idle load balancing
Message-ID: <20070116113505.GA6294@elte.hu>
References: <20061211155304.A31760@unix-os.sc.intel.com> <20061213224317.GA2986@elte.hu> <20061213231316.GA13849@elte.hu> <20061213150314.B12795@unix-os.sc.intel.com> <20061213233157.GA20470@elte.hu> <20061213151926.C12795@unix-os.sc.intel.com> <20061219201247.GA12648@elte.hu> <20061219131223.E23105@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061219131223.E23105@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0007]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Suresh,

on the latest -rt kernel, when the dynticks load-balancer is enabled, 
then a dual-core Core2 Duo test-system increases its irq rate from the 
normal 15/17 per second to 300-400/sec - on a completely idle system(!). 
Any idea what's going on? I'll disable the load balancer for now.

	Ingo
