Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262085AbTCRCcl>; Mon, 17 Mar 2003 21:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262094AbTCRCcl>; Mon, 17 Mar 2003 21:32:41 -0500
Received: from mail-6.tiscali.it ([195.130.225.152]:29138 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S262085AbTCRCck>;
	Mon, 17 Mar 2003 21:32:40 -0500
Date: Tue, 18 Mar 2003 03:43:38 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: David Mansfield <lkml@dm.cobite.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030318024338.GI30541@dualathlon.random>
References: <20030317233332.GC529@work.bitmover.com> <Pine.LNX.4.44.0303172037530.6286-100000@admin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303172037530.6286-100000@admin>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 08:48:16PM -0500, David Mansfield wrote:
> Not necessary, each changeset is available via cvsps with 'cvsps -s 
> <logical change number>' as well as searching by file, by date, by tag, by 
> log message etc.

what you did sounds great, thanks!

> > That means that *all* files get tags.  There would be 8300 x 15,000 files
> > times sizeof(tag).  That's too big.
> > 
> 
> Uggh.

;) but what kind of network overhead do you expect compared to the tag
in the tree? I hope it's minor.

NOTE: it is possible I'm missing something and you can do it much faster
than I thought w/o the tag, I'll try it now.

Andrea
