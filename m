Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWEDHgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWEDHgx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 03:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWEDHgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 03:36:53 -0400
Received: from colin.muc.de ([193.149.48.1]:29197 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1751431AbWEDHgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 03:36:52 -0400
Date: 4 May 2006 09:36:50 +0200
Date: Thu, 4 May 2006 09:36:50 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Bernhard Rosenkraenzer <bero@arklinux.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.17-rc3-mm1 breaks AGP on amd64 boxes in 32 bit mode
Message-ID: <20060504073650.GA87692@muc.de>
References: <200605040033.33579.bero@arklinux.org> <20060503193650.1a8edf16.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060503193650.1a8edf16.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> x86_64 uses numerous x86 files in this manner, and now we we have x86 using
> a couple of x86_64 files in a siilar manner.  I think this is a bad thing,
> and that we should make all these cross-references operate in the same
> direction rather than in both directions.  x86_64 developers already have
> to deal with this problem, so why make start burdening x86 developers also?

So far the only complaints
I heard was from a few people who deleted everything but arch/i386. 
I wasn't very sympathetic to that particular problem because doing
so means they don't care about other architectures at all.

> 
> 
> Anyway.  Andi, I'll drop x86_64-mm-new-northbridge-fix.patch.  Please add
> these exports to your copy of x86_64-mm-new-northbridge.patch

It's already in the version on firstfloor. Just resync with that.

-Andi

P.S.: Since ff connectivity has been spotty in the past I'm also
working on mirroring the patches directly to ftp.x86-64.org
