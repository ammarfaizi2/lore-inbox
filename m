Return-Path: <linux-kernel-owner+w=401wt.eu-S1751411AbXAFPmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbXAFPmG (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 10:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbXAFPmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 10:42:06 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:34004 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411AbXAFPmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 10:42:04 -0500
Date: Sat, 6 Jan 2007 16:38:33 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Aneesh Kumar <aneesh.kumar@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sysrq_always_enabled boot option ??
Message-ID: <20070106153833.GB20592@elte.hu>
References: <cc723f590701060342o2ea5016es1ab6faff45486dba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc723f590701060342o2ea5016es1ab6faff45486dba@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -0.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-0.4 required=5.9 tests=BAYES_05 autolearn=no SpamAssassin version=3.0.3
	-0.4 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0101]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Aneesh Kumar <aneesh.kumar@gmail.com> wrote:

> This is about commit 5d6f647fc6bb57377c9f417c4752e43189f56bb1. Why is 
> this change needed. As far as i understand from the the commit message 
> distro used to set sysrq_enabled = 0. But they if we need sysrq 
> support we can set it using sysctl why do we need a kernel command 
> line option ?

userspace occasionally disables it. Also, sometimes i want to boot 
distro images without changing anything in them.

	Ingo
