Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbTEUSDG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 14:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbTEUSDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 14:03:06 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:14246 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262235AbTEUSDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 14:03:05 -0400
Date: Wed, 21 May 2003 11:18:00 -0700
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] USB speedtouch update
Message-ID: <20030521181800.GA1929@kroah.com>
References: <200305210049.24619.baldrick@wanadoo.fr> <20030521020732.GA7939@kroah.com> <200305211024.38553.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305211024.38553.baldrick@wanadoo.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 10:24:38AM +0200, Duncan Sands wrote:
> > I've applied all of these to my tree, but I didn't apply the following
> > to Linus's tree because they just didn't apply.  I tried to fix up a few
> > by hand, and got some of them to work, but eventually gave up on the
> > rest.  So here's a list of the ones that didn't go into Linus's tree:
> > 	USB speedtouch: use optimally sized reconstruction buffers
> > 	USB speedtouch: send path micro optimizations
> > 	USB speedtouch: kfree_skb -> dev_kfree_skb
> > 	USB speedtouch: receive code rewrite
> >
> > Also this one didn't go into Linus's tree, as it's already there:
> > 	USB speedtouch: remove MOD_XXX_USE_COUNT
> >
> > So, any patches against Linus's latest bk tree to bring the above into
> > sync would be appreciated.
> 
> I think the problem is that you forgot to apply this one to Linus's tree:
> 
> [PATCH 02/14] USB speedtouch: trivial whitespace and name changes

Bleah, you're right.  I'll fix this up and push the remaining fixes to
Linus.

Thanks for figuring this out, and sorry for messing it up.

greg k-h
