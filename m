Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268601AbUHNLdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268601AbUHNLdN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 07:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268305AbUHNLdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 07:33:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38553 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268639AbUHNLbj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 07:31:39 -0400
Date: Sat, 14 Aug 2004 12:31:38 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Willy Tarreau <willy@w.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matthew Wilcox <willy@debian.org>
Subject: Re: Linux v2.6.8 - Oops on NFSv3
Message-ID: <20040814113138.GZ12308@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org> <20040814101039.GA27163@alpha.home.local> <Pine.LNX.4.58.0408140336170.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408140344110.1839@ppc970.osdl.org> <20040814115548.A19527@infradead.org> <Pine.LNX.4.58.0408140404050.1839@ppc970.osdl.org> <1092482311.9028.4.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092482311.9028.4.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2004 at 01:18:32PM +0200, Arjan van de Ven wrote:
> On Sat, 2004-08-14 at 13:05, Linus Torvalds wrote:
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
> well... I'll volunteer to keep a 2.6.X-postY series.. this fix could be
> part of that.
> 
> For me the -post series should be
> * Only patches that are in later head kernels (maybe lightly touched to
> resolve patch conflicts)
> * Only patches that fix something critical/important
>   (where critical is of course a gray area but I'm sure a decent balance
> will be found)

2.6.X-paperbagY?

Said that, if you start doing that - count on my help.
