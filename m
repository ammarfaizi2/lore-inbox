Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbVBYKop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbVBYKop (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 05:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbVBYKop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 05:44:45 -0500
Received: from ns.suse.de ([195.135.220.2]:4815 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262431AbVBYKoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 05:44:44 -0500
Date: Fri, 25 Feb 2005 11:44:31 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: Hugh Dickins <hugh@veritas.com>, nickpiggin@yahoo.com.au, ak@suse.de,
       benh@kernel.crashing.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] page table iterators
Message-ID: <20050225104431.GE14026@verdi.suse.de>
References: <20050217235719.GB31591@wotan.suse.de> <4218840D.6030203@yahoo.com.au> <Pine.LNX.4.61.0502210619290.7925@goblin.wat.veritas.com> <421B0163.3050802@yahoo.com.au> <Pine.LNX.4.61.0502230136240.5772@goblin.wat.veritas.com> <421D1737.1050501@yahoo.com.au> <Pine.LNX.4.61.0502240457350.5427@goblin.wat.veritas.com> <1109224777.5177.33.camel@npiggin-nld.site> <Pine.LNX.4.61.0502241143001.6630@goblin.wat.veritas.com> <20050224113350.3b6ebdd9.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050224113350.3b6ebdd9.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 11:33:50AM -0800, David S. Miller wrote:
> On Thu, 24 Feb 2005 11:58:42 +0000 (GMT)
> Hugh Dickins <hugh@veritas.com> wrote:
> 
> > Has anyone _ever_ seen a p??_ERROR message?
> 
> It triggers when you're writing new platform pagetable support
> or making drastric changes in same.  But on sparc64 I've set
> them all to nops to make the code output smaller. :-)

I don't think it's useful except for early debugging.

Also at least on i386/x86-64 the CPU sets a bit in the page fault
handler when it encounters a corrupted page table. On x86-64 
it is handled (not on i386) 


-Andi
