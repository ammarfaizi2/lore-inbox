Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753370AbWKRNut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbWKRNut (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 08:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754265AbWKRNut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 08:50:49 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:1678 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1753370AbWKRNut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 08:50:49 -0500
Date: Sat, 18 Nov 2006 14:49:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-rt3, yum repo
Message-ID: <20061118134928.GA25913@elte.hu>
References: <20061117200357.GA736@elte.hu> <455EFD37.4080100@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455EFD37.4080100@stud.feec.vutbr.cz>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4141]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:

> Ingo Molnar wrote:
> 
> >i've released the 2.6.18-rc6-rt3 tree
> Hi Ingo,
> lockdep doesn't compile on UP. per_cpu_offset only makes sense on SMP.

yeah - i'll remove the offset printing instead. (fixed the bug for which 
it was helpful)

	Ingo
