Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262469AbUKDWBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbUKDWBN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 17:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262468AbUKDWAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:00:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:1983 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262451AbUKDV4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 16:56:04 -0500
Date: Thu, 4 Nov 2004 13:55:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adam Heath <doogie@debian.org>
cc: Chris Wedgwood <cw@f00f.org>, Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
In-Reply-To: <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com>
Message-ID: <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org>
References: <41894779.10706@techsource.com> <20041103211353.GA24084@infradead.org>
 <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
 <20041103233029.GA16982@taniwha.stupidest.org>
 <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org>
 <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Nov 2004, Adam Heath wrote:
> >
> > First off, for some people that is literally where _most_ of the CPU
> > cycles go.
> 
> So find a fast machine.  As I have already said, you don't need to compile a
> kernel for a slow machine/arch *on* a slow machine/arch.

I _have_ a fast machine. Others don't. And quite frankly, even I tend to 
prioritize things like "nice and quiet" over absolute speed.

> I don't doubt these are issues.  That's not what I am discussing.

Sure it is. You're complaining that developers use old versions of gcc. 
They do so for a reason. Old versions of gcc are sometimes better. They 
are better in many ways.

Your "use new versions of gcc even if it is slower" argument doesn't make 
any _sense_. If the new versions aren't any better, why would you want to 
use them?

		Linus
