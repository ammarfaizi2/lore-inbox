Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262493AbUKDXji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbUKDXji (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 18:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbUKDXje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 18:39:34 -0500
Received: from brown.brainfood.com ([146.82.138.61]:28296 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S262493AbUKDXjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 18:39:32 -0500
Date: Thu, 4 Nov 2004 17:39:08 -0600 (CST)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Chris Wedgwood <cw@f00f.org>, Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
In-Reply-To: <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com>
References: <41894779.10706@techsource.com> <20041103211353.GA24084@infradead.org>
 <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
 <20041103233029.GA16982@taniwha.stupidest.org>
 <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org>
 <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2004, Linus Torvalds wrote:

>
>
> On Thu, 4 Nov 2004, Adam Heath wrote:
> > >
> > > First off, for some people that is literally where _most_ of the CPU
> > > cycles go.
> >
> > So find a fast machine.  As I have already said, you don't need to compile a
> > kernel for a slow machine/arch *on* a slow machine/arch.
>
> I _have_ a fast machine. Others don't. And quite frankly, even I tend to
> prioritize things like "nice and quiet" over absolute speed.
>
> > I don't doubt these are issues.  That's not what I am discussing.
>
> Sure it is. You're complaining that developers use old versions of gcc.
> They do so for a reason. Old versions of gcc are sometimes better. They
> are better in many ways.

Using an old version of gcc because it is faster at compiling is a
non-argument.  If people don't bother using newer compilers, complaining
about their inefficiencies, then the issues will never be resolved.

I have no problem with older gccs if they produce more correct code.

> Your "use new versions of gcc even if it is slower" argument doesn't make
> any _sense_. If the new versions aren't any better, why would you want to
> use them?

That's not my argument.  Never has been.  I am against people who say not to
use newer gccs only on the grounds that they are slower.

If they produce bad code, then that's a valid reason.
If they produce larger code, that is a valid reason.

But slowness doesn't mean wrong, just by being slow.

ps: it seldom makes sense to use a single metric as a measure of the quality
    of some specific item in some specific situation.
