Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbUKEUZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbUKEUZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 15:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUKEUZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 15:25:59 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:26118 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261204AbUKEUZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 15:25:51 -0500
Date: Fri, 5 Nov 2004 21:20:38 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Adam Heath <doogie@debian.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Chris Wedgwood <cw@f00f.org>,
       Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
Message-ID: <20041105202038.GC30993@alpha.home.local>
References: <41894779.10706@techsource.com> <20041103211353.GA24084@infradead.org> <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com> <20041103233029.GA16982@taniwha.stupidest.org> <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com> <Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org> <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com> <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org> <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 05:39:08PM -0600, Adam Heath wrote:
 
> Using an old version of gcc because it is faster at compiling is a
> non-argument.

If you can send to all of us for free some hardware which is twice as fast
as what we have, which does not generate more heat and noise, then perhaps
most of us will accept to use a twice as slow compiler. But not for long,
since some may realize that they can produce quality code twice as fast on
their new system ;-)

At least, with fast machines and fast compilers, people have no excuse not
testing the patches they send. A few years ago, broken & non-tested patches
were very common. This could become standard again if everyone jumped into
gcc 3.4 unconditionnaly.

> If they produce bad code, then that's a valid reason.
> If they produce larger code, that is a valid reason.

You can also ask the gcc people when they will decide to write a new version
which is able to compile some code which compiles with the previous release.
I have some tools which don't compile anymore with gcc 3 and error messages
look more like insults than information, and I don't even know how to "fix"
(adapt ?) them. This too is a valid reason to stick to older compilers.

Willy

