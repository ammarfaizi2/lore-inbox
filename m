Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbVLCRaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbVLCRaF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 12:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbVLCRaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 12:30:05 -0500
Received: from solarneutrino.net ([66.199.224.43]:23045 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S932096AbVLCRaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 12:30:03 -0500
Date: Sat, 3 Dec 2005 12:29:46 -0500
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kai Makisara <Kai.Makisara@kolumbus.fi>, Andrew Morton <akpm@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       ryan@tau.solarneutrino.net
Subject: Re: Fw: crash on x86_64 - mm related?
Message-ID: <20051203172946.GC7679@tau.solarneutrino.net>
References: <20051129092432.0f5742f0.akpm@osdl.org> <Pine.LNX.4.63.0512012040390.5777@kai.makisara.local> <Pine.LNX.4.64.0512011136000.3099@g5.osdl.org> <20051201195657.GB7236@tau.solarneutrino.net> <Pine.LNX.4.61.0512012008420.28450@goblin.wat.veritas.com> <20051202180326.GB7634@tau.solarneutrino.net> <Pine.LNX.4.61.0512021856170.4940@goblin.wat.veritas.com> <20051202194447.GA7679@tau.solarneutrino.net> <Pine.LNX.4.61.0512022037230.6058@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512022037230.6058@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 08:40:56PM +0000, Hugh Dickins wrote:
> On Fri, 2 Dec 2005, Ryan Richter wrote:
> > 
> > OK, I guess I'll stick with 2.6.14.3 for now, plus your patch.  Should I
> > keep Kai's st.c patch?  There was some mention of other patches, are
> > those relevant?  Most of that discussion went over my head...
> 
> For the "Bad page state" premature freeing you were seeing, only my
> patch should be relevant.  There are other patches in the works, yes,
> and we have good reasons for them; but don't worry about them for this.

OK, I've booted 2.6.14.3+mpt fusion patch+your patch.  Memtest86 found
nothing overnight, so it's not that easy.  Also the backups will run
daily for at least the next week or two, so I'll pipe up if anything
happens.

Thanks,
-ryan
