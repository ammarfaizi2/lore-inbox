Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbUKFLEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbUKFLEw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 06:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbUKFLEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 06:04:52 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:5124 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261367AbUKFLEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 06:04:50 -0500
Date: Sat, 6 Nov 2004 12:04:28 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Hua Zhong <hzhong@cisco.com>, "'Grzegorz Kulewski'" <kangur@polcom.net>,
       "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Chris Wedgwood'" <cw@f00f.org>, "'Andries Brouwer'" <aebr@win.tue.nl>,
       "'Adam Heath'" <doogie@debian.org>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'Timothy Miller'" <miller@techsource.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: support of older compilers
Message-ID: <20041106110427.GA1260@alpha.home.local>
References: <20041106083824.GB783@alpha.home.local> <Pine.LNX.4.44.0411060939580.2721-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0411060939580.2721-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 09:43:57AM +0000, Hugh Dickins wrote:
> On Sat, 6 Nov 2004, Willy Tarreau wrote:
> > On Fri, Nov 05, 2004 at 02:08:45PM -0800, Hua Zhong wrote:
> > > At least in 2.4.17 I couldn't loopback mount an (ext2) image from tmpfs and
> > > had to use ramfs. Has this been fixed?
> 
> Yes, fixed in 2.4.22.
> 
> > I believe it works now (2.4.27) but at least some external add-ons such as
> > Tux cannot serve pages on tmpfs but are OK on ramfs.
> 
> Oh, I thought that was fixed at the same time in 2.4.22.
> Seems nobody complained it wasn't.  Probably easily done,
> but really too late now to be adding features to 2.4.

I don't understand what causes the problem, otherwise I would have been
happy to propose a patch.

> The 2.6 tmpfs has no problem there, does it?

I don't know. I essentially use tux as a target for network stress testing,
and since 2.6 is a lot slower in this area, I have not done extensive tests.

Cheers,
Willy

