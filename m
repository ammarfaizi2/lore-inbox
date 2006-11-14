Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933234AbWKNIYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933234AbWKNIYk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 03:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933244AbWKNIYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 03:24:40 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:52944 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S933234AbWKNIYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 03:24:39 -0500
Date: Tue, 14 Nov 2006 09:23:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: clameter@sgi.com, kenneth.w.chen@intel.com, akpm@osdl.org,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched domain: move sched group allocations to percpu area
Message-ID: <20061114082340.GA27271@elte.hu>
References: <Pine.LNX.4.64.0611122137190.2708@schroedinger.engr.sgi.com> <000201c706ee$a9992e80$a081030a@amr.corp.intel.com> <20061113170648.F17720@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061113170648.F17720@unix-os.sc.intel.com>
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


* Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:

> Move the sched group allocations to percpu area. This will minimize 
> cross node memory references and also cleans up the sched groups 
> allocation for allnodes sched domain.
> 
> Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

yeah, makes sense.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
