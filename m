Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbTITT4c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 15:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTITT4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 15:56:32 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:42624 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261946AbTITT4b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 15:56:31 -0400
Date: Sat, 20 Sep 2003 20:56:10 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Larry McVoy <lm@work.bitmover.com>, Bernd Schmidt <bernds@redhat.com>,
       Larry McVoy <lm@bitmover.com>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Gateways (was Re: Fix for wrong OOM killer trigger?)
Message-ID: <20030920195610.GB8953@mail.jlokier.co.uk>
References: <20030919191613.36750de3.bless@tm.uka.de> <20030919192544.GC1312@velociraptor.random> <20030919203538.D1919@flint.arm.linux.org.uk> <20030919200117.GE1312@velociraptor.random> <20030919205220.GA19830@work.bitmover.com> <20030920033153.GA1452@velociraptor.random> <20030920043026.GA10836@work.bitmover.com> <Pine.LNX.4.55.0309201305430.21919@host140.cambridge.redhat.com> <20030920135430.GA17559@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030920135430.GA17559@work.bitmover.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> Nonsense.  This isn't closed source issue at all because the issue is the
> CVS gateway.  You don't need source to write that gateway and you could
> have (and recall that Linus said you should have) written the gateway 
> yourself, hosted it yourself, and maintained it yourself.

I was prepared to write such a gatway.

We discussed it, and found that the combination of BitKeeper license
and BitMover's control over the kernel repository prevents it.  This
was the subject of a heated debate.

I believe that debate was the reason BitMover wrote and now host the
BK->CVS gateway, which other gateways are built upon.

It's a brilliant solution, and thank you, I am glad of your work,
but let's not pretend that a 3rd party is in a position to offer such
a gateway.

(You need either the BK protocol, the right to run BK, or a copy of
the BK repository files to extract data from, and none of these are
available to a 3rd party who wants to write and support a BK->whatever
gateway for the kernel tree.  I asked; all 3 were refused).

-- Jamie
