Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965187AbWJBRt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965187AbWJBRt4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 13:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbWJBRt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 13:49:56 -0400
Received: from brick.kernel.dk ([62.242.22.158]:37442 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S965184AbWJBRtz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 13:49:55 -0400
Date: Mon, 2 Oct 2006 19:49:22 +0200
From: Jens Axboe <axboe@kernel.dk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] BLOCK: Fix linux/compat.h's use sigset_t
Message-ID: <20061002174919.GL5670@kernel.dk>
References: <20061002131231.19879.19860.stgit@warthog.cambridge.redhat.com> <20061002131234.19879.34671.stgit@warthog.cambridge.redhat.com> <20061002165137.GK5670@kernel.dk> <Pine.LNX.4.64.0610021004090.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610021004090.3952@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02 2006, Linus Torvalds wrote:
> 
> 
> On Mon, 2 Oct 2006, Jens Axboe wrote:
> 
> > On Mon, Oct 02 2006, David Howells wrote:
> > > From: David Howells <dhowells@redhat.com>
> > > 
> > > Make linux/compat.h #include asm/signal.h to gain a definition of
> > > sigset_t so that it can externally declare sigset_from_compat().
> > > 
> > > This has been compile-tested for i386, x86_64, ia64, mips, mips64,
> > > frv, ppc and ppc64 and run-tested on frv.
> > 
> > Ack both patches, thanks David.
> 
> Well, I already applied them, but I applied them as a single patch (since 
> 1/2 wasn't actually usable on its own _or_ even just a plain revert, and 
> 2/2 was really required for 1/2 to even compile).

Works for me, thanks Linus.

-- 
Jens Axboe

