Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbUFNFsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUFNFsN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 01:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUFNFsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 01:48:13 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:6404 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261939AbUFNFsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 01:48:10 -0400
Date: Mon, 14 Jun 2004 07:45:26 +0200
From: Willy Tarreau <willy@w.ods.org>
To: ndiamond@despammed.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Panics need better handling
Message-ID: <20040614054525.GE29808@alpha.home.local>
References: <200406140519.i5E5JEk23773@mailout.despammed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406140519.i5E5JEk23773@mailout.despammed.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 12:19:15AM -0500, ndiamond@despammed.com wrote:
> Willy Tarreau replied to me:
> 
> >> Is there
> >> any chance in getting the 24 most
> >> important lines of panic information
> >> displayed last, and putting the cursor
> >> at the end of the 24th line thereof, so
> >> that 24 valuable lines of panic
> >> information can be visible?
> >
> > You could try kmsgdump, which Randy Dunlap ported to 2.6
> [...]
> > Clearly what you need it seems,
> 
> Partly, yes it looks clearly what I
> need (though I need it for 2.4).

OK, so download the original 2.4 version here : 

  http://w.ods.org/linux/kernel/kmsgdump/0.4.4/

It still applies to 2.4.27-pre5.

> But surely every developer or maintainer
> of every driver or other part of the
> kernel also has a clear need for every
> Linux user to install this.  I am not
> the only one who needs to get these
> reports, right?  Shouldn't this be in
> the main kernel tree by now, and enabled
> by default?

Well, yes and no. Yes because it's useful, no because there are so many
other useful tools which would largely replace it and be more complete
(kdb, lkcd, ...) that one could wonder why it's in the kernel at all.
Since it's mainly useful to developers, and not too much intrusive, people
who need it can easily apply it to their tree.

Cheers,
Willy

