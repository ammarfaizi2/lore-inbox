Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262738AbVAQJZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbVAQJZJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 04:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbVAQJZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 04:25:09 -0500
Received: from news.suse.de ([195.135.220.2]:5014 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262738AbVAQJZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 04:25:05 -0500
Date: Mon, 17 Jan 2005 10:25:04 +0100
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] x86_64: kill stale mtrr_centaur_report_mcr
Message-ID: <20050117092504.GA29270@wotan.suse.de>
References: <20050116074817.GX4274@stusta.de> <20050117055040.GE19187@wotan.suse.de> <20050117060746.GW4274@stusta.de> <20050117061633.GJ19187@wotan.suse.de> <20050117084349.GH4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117084349.GH4274@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 09:43:49AM +0100, Adrian Bunk wrote:
> On Mon, Jan 17, 2005 at 07:16:33AM +0100, Andi Kleen wrote:
> > On Mon, Jan 17, 2005 at 07:07:46AM +0100, Adrian Bunk wrote:
> > > I haven't tried to compile it, [...]
> > 
> > Please only submit compile tested patches in the future.
> > 
> > A cross compiler for x86-64 from i386 can be found at 
> > ftp://ftp.suse.com/pub/suse/x86_64/supplementary/CrossTools/8.1-i386/
> > (work with alien or rpm2cpio on non rpm systems too) 
> 
> I tried this, but wasn't able to repruduce the compile error you 
> observed.
> 
> Could you send me the .config you observed the problem with?

I didn't see a problem, just asked if it really compiles. You're
right that centaur is not linked in so it'll probably work. 

I'll apply the patch, thanks.
-Andi
