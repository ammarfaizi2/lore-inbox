Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162418AbWKQHk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162418AbWKQHk2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 02:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162420AbWKQHk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 02:40:28 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:28118 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1162418AbWKQHk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 02:40:27 -0500
Date: Fri, 17 Nov 2006 08:28:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] hotplug CPU: clean up hotcpu_notifier() use
Message-ID: <20061117072819.GA23132@elte.hu>
References: <20061116084855.GA8848@elte.hu> <20061116090330.GA11312@elte.hu> <20061116093228.GA15603@elte.hu> <Pine.LNX.4.64.0611161357380.3349@woody.osdl.org> <20061117035240.GA7484@elte.hu> <Pine.LNX.4.64.0611162201300.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611162201300.3349@woody.osdl.org>
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


* Linus Torvalds <torvalds@osdl.org> wrote:

> On Fri, 17 Nov 2006, Ingo Molnar wrote:
> > 
> > yeah - this could only be done cleanly if there was a 'set notifier 
> > parameters and register it' call, but there isnt. Find below the 
> > patch with this bit taken out. (and with the mce_amd.c fix merged 
> > in). It still removes ~25 #ifdef blocks total.
> 
> Ok, looks better, although I just don't feel comfy merging this at 
> this point, since it looks unlikely to fix any real bugs.
> 
> Will happily take it post-2.6.19 as a cleanup, though.

ok - we are closer to 2.6.19-final than i thought :-)

	Ingo
