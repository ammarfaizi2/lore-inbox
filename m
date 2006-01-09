Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWAITbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWAITbD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWAITbC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:31:02 -0500
Received: from silver.veritas.com ([143.127.12.111]:24104 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751226AbWAITa7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:30:59 -0500
Date: Mon, 9 Jan 2006 19:31:11 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Ryan Richter <ryan@tau.solarneutrino.net>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
In-Reply-To: <20060109185350.GG283@tau.solarneutrino.net>
Message-ID: <Pine.LNX.4.61.0601091922550.15426@goblin.wat.veritas.com>
References: <1134705703.3906.1.camel@mulgrave> <20051226234238.GA28037@tau.solarneutrino.net>
 <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local>
 <20060104172727.GA320@tau.solarneutrino.net> <Pine.LNX.4.63.0601042334310.5087@kai.makisara.local>
 <20060105201249.GB1795@tau.solarneutrino.net> <Pine.LNX.4.64.0601051312380.3169@g5.osdl.org>
 <20060109033149.GC283@tau.solarneutrino.net> <Pine.LNX.4.64.0601082000450.3169@g5.osdl.org>
 <Pine.LNX.4.61.0601090933160.7632@goblin.wat.veritas.com>
 <20060109185350.GG283@tau.solarneutrino.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Jan 2006 19:30:59.0403 (UTC) FILETIME=[381559B0:01C61553]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006, Ryan Richter wrote:
> 
> One thing I forgot to mention was that 2.6.11.3 had the problem too when
> I reverted to it.  I remember now that the person who made the debian
> bug report for this said it only happened with a 64-bit userspace - and
> I switched from a 32- to 64-bit userspace when I did 2.6.11 -> 2.6.14
> (and I'm too lazy to switch back).

I remembered you reported it originally on 2.6.14.N, so I wasn't
searching amongst the 2.6.15 changes at all.  Thanks for the info
that it's at least as old as 2.6.11.3.

> To get the backups back, I just ran a recent kernel with
> try_direct_io=0.  If there's nothing further for me to test at this
> time, I guess I'll go back to doing that until there's something to try.
> Is that OK?

I think we'll allow you the luxury of making successful backups for now ;)

Thanks for all your work on this, I'm sure it's irritating to you that
we haven't found the answer yet.  I'm still clueless about it (despite
the excellent clues you've provided).  And personally I don't like
asking someone "try this, try that" until I've a pretty good hypothesis
to devise a patch to test out.  Still thinking it over.  Someone else
may have a better idea of what to try next.

Hugh
