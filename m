Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424003AbWKPNEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424003AbWKPNEJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 08:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424001AbWKPNEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 08:04:09 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:3243 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1423995AbWKPNEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 08:04:08 -0500
Date: Thu, 16 Nov 2006 13:29:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc6] x86_64: UP build fixes
Message-ID: <20061116122936.GA425@elte.hu>
References: <20061116084855.GA8848@elte.hu> <200611161022.04022.ak@suse.de> <20061116094852.GA19305@elte.hu> <200611161109.37172.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611161109.37172.ak@suse.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.4 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.5 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> > my hotplug-CPU cleanup patch solves this in a cleaner way: by 
> > removing all those #ifdefs as well.
> 
> Fine, but I suspect that late in the release it's better to go for 
> minimal "obvious" fixes. Later it can then be cleaned up properly.

we are not /that/ late to not apply trivial cleanups. If my patch breaks 
anything then it's easy enough to fix it. But 'lets clean this up later' 
is bound to be forgotten and puts the onus on the person doing the 
cleanups. You yourself have sent more complex partly-cleanup patches 
upstream just 2 days ago:

[PATCH for 2.6.19] [8/9] x86_64: Fix vgetcpu when CONFIG_HOTPLUG_CPU is disabled

	Ingo
