Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267180AbUHOWQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267180AbUHOWQr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 18:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267182AbUHOWQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 18:16:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18059 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267180AbUHOWQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 18:16:46 -0400
Date: Sun, 15 Aug 2004 17:10:11 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Willy Tarreau <willy@w.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matthew Wilcox <willy@debian.org>
Subject: Re: Linux v2.6.8 - Oops on NFSv3
Message-ID: <20040815201011.GG9500@logos.cnet>
References: <Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org> <20040814101039.GA27163@alpha.home.local> <Pine.LNX.4.58.0408140336170.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408140344110.1839@ppc970.osdl.org> <20040814115548.A19527@infradead.org> <Pine.LNX.4.58.0408140404050.1839@ppc970.osdl.org> <20040814172008.GD5414@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040814172008.GD5414@waste.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 12:20:08PM -0500, Matt Mackall wrote:
> On Sat, Aug 14, 2004 at 04:05:56AM -0700, Linus Torvalds wrote:
> > 
> > 
> > On Sat, 14 Aug 2004, Christoph Hellwig wrote:
> > > 
> > > Cane we make this 2.6.9 to avoid breaking all kinds of scripts expecting
> > > three-digit kernel versions?
> > 
> > Well, we've been discussing the 2.6.x.y format for a while, so I see this 
> > as an opportunity to actually do it... Will it break automated scripts? 
> > Maybe. But on the other hand, we'll never even find out unless we try it 
> > some time.
> 
> We might avoid some of this (and communicate more to end users) by
> using the 2.4 -pre and -rc nomenclature, where a release is made by
> renaming an -rc kernel. As it stands, the current 2.6 "release
> candidate" naming is a lie - there's no intent to make it a final
> release.

I agree. The renaming is done by hpa's "bless-as-final" script on master.kernel.org.
