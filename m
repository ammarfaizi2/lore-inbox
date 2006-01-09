Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWAIUF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWAIUF3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWAIUF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:05:29 -0500
Received: from solarneutrino.net ([66.199.224.43]:20740 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1751278AbWAIUF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:05:28 -0500
Date: Mon, 9 Jan 2006 15:05:21 -0500
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, ryan@tau.solarneutrino.net
Subject: Re: Fw: crash on x86_64 - mm related?
Message-ID: <20060109200521.GH283@tau.solarneutrino.net>
References: <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local> <20060104172727.GA320@tau.solarneutrino.net> <Pine.LNX.4.63.0601042334310.5087@kai.makisara.local> <20060105201249.GB1795@tau.solarneutrino.net> <Pine.LNX.4.64.0601051312380.3169@g5.osdl.org> <20060109033149.GC283@tau.solarneutrino.net> <Pine.LNX.4.64.0601082000450.3169@g5.osdl.org> <Pine.LNX.4.61.0601090933160.7632@goblin.wat.veritas.com> <20060109185350.GG283@tau.solarneutrino.net> <Pine.LNX.4.61.0601091922550.15426@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601091922550.15426@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 07:31:11PM +0000, Hugh Dickins wrote:
> On Mon, 9 Jan 2006, Ryan Richter wrote:
> > To get the backups back, I just ran a recent kernel with
> > try_direct_io=0.  If there's nothing further for me to test at this
> > time, I guess I'll go back to doing that until there's something to try.
> > Is that OK?
> 
> I think we'll allow you the luxury of making successful backups for now ;)
> 
> Thanks for all your work on this, I'm sure it's irritating to you that
> we haven't found the answer yet.  I'm still clueless about it (despite
> the excellent clues you've provided).  And personally I don't like
> asking someone "try this, try that" until I've a pretty good hypothesis
> to devise a patch to test out.  Still thinking it over.  Someone else
> may have a better idea of what to try next.

The episode where I blew through half the tapes was mostly my fault.  I
can avoid that in the future while still doing destructive testing, so
you don't have to be too reluctant to give me things to test.  I just
wanted to make sure there was no further utility in getting oopses from
Linus's patch.

And try_direct_io=0 works just fine, and doesn't seem to have any
performance impact or anything, so at this point I'm not losing any
sleep.

Thanks,
-ryan
