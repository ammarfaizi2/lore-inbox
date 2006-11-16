Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031158AbWKPLTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031158AbWKPLTJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 06:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031160AbWKPLTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 06:19:08 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:18363 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1031158AbWKPLTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 06:19:07 -0500
Date: Thu, 16 Nov 2006 12:17:52 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc6] x86_64: UP build fix, arch/x86_64/kernel/mce_amd.c
Message-ID: <20061116111752.GD14245@elte.hu>
References: <20061116102115.GA8379@elte.hu> <200611161129.56502.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200611161129.56502.ak@suse.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -3.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.3 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_05 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-0.4 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0229]
	0.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> >  arch/x86_64/kernel/mce_amd.c: In function ‘threshold_remove_bank’:
> >  arch/x86_64/kernel/mce_amd.c:597: error: ‘shared_bank’ undeclared (first use in this function)
> >  arch/x86_64/kernel/mce_amd.c:597: error: (Each undeclared identifier is reported only once
> >  arch/x86_64/kernel/mce_amd.c:597: error: for each function it appears in.)
> >  make[1]: *** [arch/x86_64/kernel/mce_amd.o] Error 1
> >  make: *** [arch/x86_64/kernel/mce_amd.o] Error 2
> > 
> > Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> Hmm, it builds for me.

sorry - this is ontop of:

Subject: [patch] hotplug CPU: clean up hotcpu_notifier() use

	Ingo
