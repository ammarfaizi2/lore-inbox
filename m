Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbVCDIV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbVCDIV1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 03:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbVCDIV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 03:21:26 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:61354
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S262650AbVCDIVM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 03:21:12 -0500
Subject: Re: RFD: Kernel release numbering
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050303213005.59a30ae6.akpm@osdl.org>
References: <20050302205826.523b9144.davem@davemloft.net>
	 <4226C235.1070609@pobox.com> <20050303080459.GA29235@kroah.com>
	 <4226CA7E.4090905@pobox.com>
	 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	 <422751C1.7030607@pobox.com> <20050303181122.GB12103@kroah.com>
	 <20050303151752.00527ae7.akpm@osdl.org>
	 <20050303234523.GS8880@opteron.random>
	 <20050303160330.5db86db7.akpm@osdl.org>
	 <20050304025746.GD26085@tolot.miese-zwerge.org>
	 <20050303213005.59a30ae6.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 04 Mar 2005 09:21:10 +0100
Message-Id: <1109924470.4032.105.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-03 at 21:30 -0800, Andrew Morton wrote:
> You cannot have it both ways.  Either the kernel needs testers, or it is
> "stable".  See how these are opposites?

I don't see a contradiction. You need testers for release candidates to
make them stable. The problem is that Linux release candidates are not
release candidates. 

> We don't _need_ people to test stable kernels, because they're stable. 
> (OK, we'll pick up on a few things, but we'd pick up on them if people were
> testing tip-of-tree, as well).

I don't see that the releases are stable. They are defined stable by
proclamation. 

> The 2.6.x.y thing is a service to people who want 2.6.x with kinks ironed
> out.  It's not particularly interesting or useful from a development POV,
> apart from its potential to attract a few people who are presently stuck on
> 2.4 or 2.6.crufty.

This 2.6.x.y tree will change nothing as long as the underlying problem
is not solved.
 
> It won't help that at all.  None of these proposals will increase testing
> of tip-of-tree.  In fact the 2.6.x proposal may decrease that level of
> that testing, although probably not much.
> There is no complete answer to all of this, because there are competing
> needs.  It's a question of balance.

A clearly defined switch from -preX to -rc will give the avarage user a
clear sign where he might jump in and test. 

2.6.11-rc5 (which is -pre5 in disguise) would have been the real point
for a -rc1 ...-rcX freeze and testing phase.

tglx


