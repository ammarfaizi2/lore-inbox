Return-Path: <linux-kernel-owner+w=401wt.eu-S1751626AbWLMXf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626AbWLMXf5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 18:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751800AbWLMXf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 18:35:57 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:49317 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626AbWLMXf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 18:35:56 -0500
Date: Thu, 14 Dec 2006 00:34:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, suresh.b.siddha@intel.com,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] sched: remove __cpuinitdata anotation to cpu_isolated_map
Message-ID: <20061213233408.GA21604@elte.hu>
References: <1166048278.6772.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166048278.6772.20.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0005]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Tim Chen <tim.c.chen@linux.intel.com> wrote:

> The structure cpu_isolated_map is used not only during initialization. 
> Multi-core scheduler configuration changes and exclusive cpusets use 
> this during run time.  During setting of sched_mc_power_savings
>  policy, this structure is accessed to update sched_domains.
> 
> Thanks.
> 
> Tim Chen
> 
> Signed-off-by: Tim Chen <tim.c.chen@intel.com>
> Acked-by: Suresh Siddha <suresh.b.siddha@intel.com>

good catch. -stable candidate as well i guess.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
