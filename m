Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbVCDFbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVCDFbf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 00:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVCDFbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 00:31:34 -0500
Received: from fire.osdl.org ([65.172.181.4]:50588 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262717AbVCDFab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 00:30:31 -0500
Date: Thu, 3 Mar 2005 21:30:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jochen Striepe <jochen@tolot.escape.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-Id: <20050303213005.59a30ae6.akpm@osdl.org>
In-Reply-To: <20050304025746.GD26085@tolot.miese-zwerge.org>
References: <20050302205826.523b9144.davem@davemloft.net>
	<4226C235.1070609@pobox.com>
	<20050303080459.GA29235@kroah.com>
	<4226CA7E.4090905@pobox.com>
	<Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
	<422751C1.7030607@pobox.com>
	<20050303181122.GB12103@kroah.com>
	<20050303151752.00527ae7.akpm@osdl.org>
	<20050303234523.GS8880@opteron.random>
	<20050303160330.5db86db7.akpm@osdl.org>
	<20050304025746.GD26085@tolot.miese-zwerge.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Striepe <jochen@tolot.escape.de> wrote:
>
>     Hi,
> 
> On 03 Mar 2005, Andrew Morton wrote:
> > 2.6.x is making good progress but there have been a handful of prominent
> > regressions which seem to be making people think that the whole process is
> > bust.  I don't believe that this has been proven yet.
> 
> Sorry -- what you (with the vision of a kernel developer) are seeing
> here surely is interesting, but it's not the point:
> 
> The point is what the *users* think. Just in case it still hasn't been
> made clear enough in this thread: If your user base gets the impression
> the development process isn't reliable any longer, you won't get your
> kernel tested as much as you want.

You cannot have it both ways.  Either the kernel needs testers, or it is
"stable".  See how these are opposites?

We don't _need_ people to test stable kernels, because they're stable. 
(OK, we'll pick up on a few things, but we'd pick up on them if people were
testing tip-of-tree, as well).

The 2.6.x.y thing is a service to people who want 2.6.x with kinks ironed
out.  It's not particularly interesting or useful from a development POV,
apart from its potential to attract a few people who are presently stuck on
2.4 or 2.6.crufty.

> 
> So I hope the latest proposal really helps making releases contain fewer
> surprises.
> 

It won't help that at all.  None of these proposals will increase testing
of tip-of-tree.  In fact the 2.6.x proposal may decrease that level of
that testing, although probably not much.

There is no complete answer to all of this, because there are competing
needs.  It's a question of balance.

