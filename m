Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262975AbVCDSqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262975AbVCDSqN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 13:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbVCDSnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 13:43:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:24271 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262964AbVCDSiS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 13:38:18 -0500
Date: Fri, 4 Mar 2005 10:38:04 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       jgarzik@pobox.com, davem@davemloft.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050304183804.GB29857@kroah.com>
References: <422751C1.7030607@pobox.com> <20050303181122.GB12103@kroah.com> <20050303151752.00527ae7.akpm@osdl.org> <1109894511.21781.73.camel@localhost.localdomain> <20050303182820.46bd07a5.akpm@osdl.org> <1109933804.26799.11.camel@localhost.localdomain> <20050304032820.7e3cb06c.akpm@osdl.org> <1109940685.26799.18.camel@localhost.localdomain> <Pine.LNX.4.58.0503040959030.25732@ppc970.osdl.org> <Pine.LNX.4.58.0503041020130.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503041020130.25732@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 10:27:37AM -0800, Linus Torvalds wrote:
> Btw, I also think that this means that the sucker-tree should never aim to 
> be a "2.6.x.y" kind of release tree. If we do a "2.6.x.y" release, the 
> sucker tree would be _included_ in that release (and it may indeed be all 
> of it - most of the time it probably would be), but we should not assume 
> that "2.6.x.y" _has_ to be just the sucker tree.

Ah crap, I just called the first release of such a tree, 2.6.11.1.

> We might want to release a "2.6.x.y" that contains a patch that is too big
> or too intrusive (or otherwise controversial) to really be valid in the
> sucker-tree.

Are you sure we would ever do that?  We never have before...

I think we should call it the 2.6.x.y tree, as that way users can easily
understand it.  They see it and say, "Ah look, it's 2.6.x with only
real bugfixes in it."  It's very simple to explain to others.

And if you disagree, what _should_ we call it?  "-sucker" isn't good, as
it only describes the people creating the tree, not any of the users :)

thanks,

greg k-h
