Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbUKEU2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbUKEU2e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 15:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbUKEU2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 15:28:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:30093 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261208AbUKEU22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 15:28:28 -0500
Date: Fri, 5 Nov 2004 12:28:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
cc: Andries Brouwer <aebr@win.tue.nl>, Adam Heath <doogie@debian.org>,
       Christoph Hellwig <hch@infradead.org>,
       Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
In-Reply-To: <20041105195045.GA16766@taniwha.stupidest.org>
Message-ID: <Pine.LNX.4.58.0411051203470.2223@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411031706350.1229@gradall.private.brainfood.com>
 <20041103233029.GA16982@taniwha.stupidest.org>
 <Pine.LNX.4.58.0411041050040.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041133210.2187@ppc970.osdl.org>
 <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org>
 <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com>
 <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org> <20041105014146.GA7397@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org> <20041105195045.GA16766@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Nov 2004, Chris Wedgwood wrote:

> On Fri, Nov 05, 2004 at 07:41:03AM -0800, Linus Torvalds wrote:
> 
> > > -rw-r--r--   1 root     root       281572 Jul 30  1995 zImage-1.2.11
> > > -rw-r--r--   1 root     root       277476 Apr  1  1995 zImage-1.2.2
> 
> > Ok, you da man. What do you use it for? Or is it just lying around
> > for nostalgic reasons?
> 
> to remind us how large the kernel is getting? :)

Yeah, I know. Damn, it's scary. We should probably have some
per-object-file statistics, and try to make people more aware of big bad
things.

The kernel does do more these days than it did in '95. But 6 times more? I 
dunno..

		Linus
