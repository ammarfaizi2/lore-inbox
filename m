Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTHXV6L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 17:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbTHXV6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 17:58:11 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:5003
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261326AbTHXV6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 17:58:09 -0400
Date: Sun, 24 Aug 2003 23:58:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Yoav Weiss <ml-lkml@unpatched.org>
Cc: Livio Baldini Soares <livio@ime.usp.br>, mason@suse.com, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: io-stalls again (was "Re: Bug in drivers/block/ll_rw_blk.c")
Message-ID: <20030824215840.GE1460@dualathlon.random>
References: <20030822153501.GB31360@ime.usp.br> <Pine.LNX.4.44.0308222028150.27026-100000@marcellos.corky.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308222028150.27026-100000@marcellos.corky.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 09:25:01PM +0300, Yoav Weiss wrote:
> It may be possible to reproduce the same stall with loop.o but takes much
> longer.  Could be related to the fact that cloop.o is a single thread
> while loop.o has a separate reader thread.  Could this affect the problem ?

It may not be related to cloop of course, but it would reduce the number
of variables for us to have an how-to-reproduce that doesn't involve
running kernel code outside the mainline kernel. If that's the only way
to reproduce we simply have to look into the whole cloop code first,
before we can actually look again into the mainline kernel code for
this.

Andrea
