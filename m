Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbWEOTrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbWEOTrI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbWEOTrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:47:08 -0400
Received: from ns.suse.de ([195.135.220.2]:42961 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964999AbWEOTrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:47:06 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86 NUMA panic compile error
Date: Mon, 15 May 2006 21:47:01 +0200
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, haveblue@us.ibm.com, apw@shadowen.org,
       linux-kernel@vger.kernel.org
References: <20060515005637.00b54560.akpm@osdl.org> <20060515192614.GA24887@elte.hu> <20060515123929.76b9b693.akpm@osdl.org>
In-Reply-To: <20060515123929.76b9b693.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605152147.02232.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[... feels the love ...]

On Monday 15 May 2006 21:39, Andrew Morton wrote:
> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > Nevertheless for hard-to-debug bugs i prefer if they can be reproduced 
> > and debugged on 32-bit too, because x86_64 debugging is still quite a 
> > PITA and wastes alot of time: for example it has no support for exact 
> > kernel stacktraces. Also, the printout of the backtrace is butt-ugly and 
> > as un-ergonomic to the human eye as it gets
> 
> Yes, I find x86_64 traces significantly harder to follow.  And I miss the
> display of the length of the functions (do_md_run+1208 instead of
> do_md_run+1208/2043).  The latter form makes it easier to work out
> whereabouts in the function things happened.
> 
> That, plus the mix of hex and decimal numbers..
> 
> > who came up with that 
> > "two-maybe-one function entries per-line" nonsense? [Whoever did it he 
> > never had to look at (and make sense of) hundreds of stacktraces in a 
> > row.]
> 
> Plus they're wide enough to get usefully wordwrapped when someone mails
> them to you.

Hmm, I didn't realize they were _that_ unpopular. If you got the i386 
like space wasting backtraces would you guys all switch your development machines
to x86-64 ? @)

-Andi
