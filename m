Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754935AbWKQGCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754935AbWKQGCe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 01:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754936AbWKQGCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 01:02:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28293 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1754934AbWKQGCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 01:02:33 -0500
Date: Thu, 16 Nov 2006 22:02:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] hotplug CPU: clean up hotcpu_notifier() use
In-Reply-To: <20061117035240.GA7484@elte.hu>
Message-ID: <Pine.LNX.4.64.0611162201300.3349@woody.osdl.org>
References: <20061116084855.GA8848@elte.hu> <20061116090330.GA11312@elte.hu>
 <20061116093228.GA15603@elte.hu> <Pine.LNX.4.64.0611161357380.3349@woody.osdl.org>
 <20061117035240.GA7484@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 17 Nov 2006, Ingo Molnar wrote:
> 
> yeah - this could only be done cleanly if there was a 'set notifier 
> parameters and register it' call, but there isnt. Find below the patch 
> with this bit taken out. (and with the mce_amd.c fix merged in). It 
> still removes ~25 #ifdef blocks total.

Ok, looks better, although I just don't feel comfy merging this at this 
point, since it looks unlikely to fix any real bugs.

Will happily take it post-2.6.19 as a cleanup, though.

		Linus
