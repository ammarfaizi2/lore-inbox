Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVL2QXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVL2QXN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 11:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVL2QXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 11:23:13 -0500
Received: from cantor2.suse.de ([195.135.220.15]:2450 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750797AbVL2QXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 11:23:11 -0500
Date: Thu, 29 Dec 2005 17:23:10 +0100
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
Subject: Re: [2.6.15-rc7 patch] Reject SRAT tables that don't cover all memory
Message-ID: <20051229162310.GJ11515@wotan.suse.de>
References: <Pine.LNX.4.64.0512241930370.14098@g5.osdl.org> <20051229133902.GD3811@stusta.de> <20051229160741.GI11515@wotan.suse.de> <20051229162020.GK3811@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051229162020.GK3811@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 05:20:20PM +0100, Adrian Bunk wrote:
> On Thu, Dec 29, 2005 at 05:07:41PM +0100, Andi Kleen wrote:
> > On Thu, Dec 29, 2005 at 02:39:02PM +0100, Adrian Bunk wrote:
> > > Below is a patch by Andi Kleen from kernel Bugzilla #5758 fixing a 
> > > post-2.6.14 regression.
> > 
> > WTF are you submitting my patches? Please don't do this - I am perfectly
> > capable to do this on my own when the time is ripe for them. For this
> > patch that's post 2.6.15 and after more testing.
> 
> According to the bug logs this is a regression in 2.6.15-rc, and it's 
> not good if 2.6.15 will not boot on some machines where 2.6.14 did.

The risk at this stage of breaking more than fixing is too high.

Especially since it's only one relatively obscure machine with totally
broken BIOS. And a workaround exists. 

Please leave the decision of what patches are release critical and what
not for x86-64 to me. Thanks.

-Andi

