Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263246AbUCPQ5o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263538AbUCPQy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:54:29 -0500
Received: from ns.suse.de ([195.135.220.2]:65256 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263246AbUCPQve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:51:34 -0500
Date: Tue, 16 Mar 2004 17:51:27 +0100
From: Andi Kleen <ak@suse.de>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: ak@suse.de, akpm@osdl.org, davej@redhat.com, hpa@zytor.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] let EDD work on x86-64 too
Message-ID: <20040316165127.GB6145@wotan.suse.de>
References: <20040316162344.GA20289@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040316162344.GA20289@lists.us.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2004 at 10:23:44AM -0600, Matt Domsch wrote:
> Andi, I'm proposing allowing my BIOS Enhanced Disk Drive (EDD) code to
> work on x86-64 as it does on x86 today.  The patch below moves some
> files around out of arch/i386/kernel and include/asm-i386 into more
> generic locations, and allows EDD to work.  I've tested this against BK-current
> (from my POV it's 2.6.4 plus the edd-legacychs patch Andrew forwarded
> to Linus and is now in BK); I see there will be conflicts with the
> empty_zero_page-cleanup.patch which is in -mm right now - they're just
> comment conflicts, but I'll need to clean that up once it's in BK.

I have no problems with the x86-64 changes (assuming they work).

But I won't push the i386 changes. I would suggest you get that into
mainline first and when it's there send me a patch with just the x86-64
bits.

-Andi
