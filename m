Return-Path: <linux-kernel-owner+w=401wt.eu-S1751487AbXAHMJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbXAHMJt (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 07:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbXAHMJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 07:09:49 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:44283 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751487AbXAHMJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 07:09:47 -0500
Date: Mon, 8 Jan 2007 13:05:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Tomasz Kvarsin <kvarsin@gmail.com>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.20-rc3-mm1: can not mount root: i386: sched_clock using init data tsc_disable fix
Message-ID: <20070108120525.GA21999@elte.hu>
References: <5157576d0701080318t69f55d4as312c2015c4f3ee3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5157576d0701080318t69f55d4as312c2015c4f3ee3c@mail.gmail.com>
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


* Tomasz Kvarsin <kvarsin@gmail.com> wrote:

> If anybody interesting this changes by Vivek Goyal:
> 
> -int tsc_disable __cpuinitdata = 0;
> +int tsc_disable = 0;

ok, indeed.

	Ingo
