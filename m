Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425340AbWLHKpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425340AbWLHKpl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 05:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425345AbWLHKpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 05:45:41 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:38686 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1425340AbWLHKpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 05:45:40 -0500
Date: Fri, 8 Dec 2006 11:44:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Suresh Siddha <suresh.b.siddha@intel.com>,
       "Li, Shaohua" <shaohua.li@intel.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: What was in the x86 merge for .20
Message-ID: <20061208104429.GA16697@elte.hu>
References: <200612080401.25746.ak@suse.de> <20061208020804.c5e5e176.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061208020804.c5e5e176.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> My old 4-way Intel Nocona-based SDV panics during boot with "APIC mode 
> must be flat on this system" and I don't know how to make it stop.  
> Help.
> 
> It didn't do this with your tree in 2.6.19-rc6-mm1 or 2.6.19-rc6-mm2, 
> both of which included 
> x86_64-mm-fix-the-irqbalance-quirk-for-e7320-e7520-e7525.patch.  It 
> still reverts cleanly, so there might be something else in -mm (apart 
> from 
> revert-x86_64-mm-fix-the-irqbalance-quirk-for-e7320-e7520-e7525.patch 
> ;)) which fixes it up.
> 
> Also, we weren't supposed to merge that patch at all.  It is 
> supposedly obsoleted by Ingo's new genapic work.

yes. Andi, would you be so kind to only send for merge stuff that went 
through Andrew, so that there is at least some minimal review protocol 
over what goes in? "Oh, sorry, Linus already merged it" doesnt really 
cut it as a sane maintainance/review model ...

	Ingo
