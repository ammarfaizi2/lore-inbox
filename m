Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbULOLwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbULOLwO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 06:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbULOLwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 06:52:13 -0500
Received: from gprs215-247.eurotel.cz ([160.218.215.247]:65408 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262339AbULOLvu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 06:51:50 -0500
Date: Wed, 15 Dec 2004 12:51:30 +0100
From: Pavel Machek <pavel@suse.cz>
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Cc: Andi Kleen <ak@suse.de>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk
Subject: Re: arch/xen is a bad idea
Message-ID: <20041215115130.GC1232@elf.ucw.cz>
References: <p73acsg1za1.fsf@bragg.suse.de> <E1CeLLB-0000Sl-00@mta1.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CeLLB-0000Sl-00@mta1.cl.cam.ac.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Stunned silence I guess - merging an architecture is
> > > usually much more controversial ;)
> > 
> > In my opinion it's still an extremly bad idea to have arch/xen
> > an own architecture. It will cause a lot of work long term
> > to maintain it, especially when it gets x86-64 support too.
> > It would be much better to just merge it with i386/x86-64.
> 
> Andi, I totally agree that merging into i386 could be a long term
> goal. However, its just not feasible right now. The changes
> required are way too intrusive. We put considerable effort into
> investigating this approach, but came to the conclusion that with
> the current structure of arch i386 it was going to be way too
> messy. 

BTW if you merge xen as separate architecture, it will be *very* hard
to merge it back to i386. That patch would be huge, and would need to
go in "atomically".

							Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
