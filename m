Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWH2IWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWH2IWs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 04:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWH2IWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 04:22:48 -0400
Received: from web25224.mail.ukl.yahoo.com ([217.146.176.210]:33181 "HELO
	web25224.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750831AbWH2IWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 04:22:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=GRVJSjE9U1KAswdbSmh8HL85odGRz8rYwz3KtHLwX2gRlKzy91oPOKpc6ABTWfHp1OhRW60oibmj9oRSJ7G0Xb6w72GoAECr0YkalrmxlGbivZjdwUxvJU0VBMjGMdt9aRE8laVCfBEUmdVT0v9nir5l0F0gfVflnkxz9bMB5uw=  ;
Message-ID: <20060829082246.92663.qmail@web25224.mail.ukl.yahoo.com>
Date: Tue, 29 Aug 2006 10:22:45 +0200 (CEST)
From: Paolo Giarrusso <blaisorblade@yahoo.it>
Subject: Re: [PATCH RFP-V4 00/13] remap_file_pages protection support - 4th attempt
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
       user-mode-linux-devel@lists.sourceforge.net,
       Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Val Henson <val.henson@intel.com>
In-Reply-To: <20060828134915.f7787422.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> ha scritto: 

> On Sat, 26 Aug 2006 19:33:35 +0200
> Blaisorblade <blaisorblade@yahoo.it> wrote:
> 
> > Again, about 4 month since last time (for lack of time) I'm
> sending for final 
> > review and for inclusion into -mm protection support for
> remap_file_pages (in 
> > short "RFP prot support"), i.e. setting per-pte protections
> (beyond file 
> > offset) through this syscall.

> This all looks a bit too fresh and TODO-infested for me to put it
> in -mm at
> this time.

It is possible, subsequent rounds of review should be near to each
other, but calling the code "new" is maybe exaggerate. I do not
remember all these TODOs but I may forget (and I don't have my box
right now, so I can't check).

> I could toss them in to get some testing underway, but that makes
> life
> complex for other ongoing MM work.  (And there's a _lot_ of that -
> I
> presently have >180 separate patches which alter ./mm/*).

That's fine. If this can help I could try to base next version
against -mm.

> Also, it looks like another round of detailed review is needed
> before this
> work will really start to settle into its final form.

That's ok, I prefer reviews to testing right now. Almost all but 1
patch (which is marked) is unit tested on i386, x86_64 and uml (but
if I don't have a multithreaded concurrent fault tester), so it's
time to catch remaining bugs by review.

> So..   I'll await version 5, sorry.   Please persist.

I'll try. I just hope we'll not have it next summer (I know it's my
problem, I'm not complaining on you).

Thanks!
Bye
--
Paolo Giarrusso 

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
