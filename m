Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbTEUH7E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 03:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbTEUH4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 03:56:00 -0400
Received: from zeus.kernel.org ([204.152.189.113]:37591 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261780AbTEUHn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 03:43:26 -0400
Date: Tue, 20 May 2003 19:07:32 -0700
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] USB speedtouch update
Message-ID: <20030521020732.GA7939@kroah.com>
References: <200305210049.24619.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305210049.24619.baldrick@wanadoo.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 12:49:24AM +0200, Duncan Sands wrote:
> The following patches are against Greg's 2.5 USB tree.
> They contain a rewrite of the packet reception code and
> many tweaks.

I've applied all of these to my tree, but I didn't apply the following
to Linus's tree because they just didn't apply.  I tried to fix up a few
by hand, and got some of them to work, but eventually gave up on the
rest.  So here's a list of the ones that didn't go into Linus's tree:
	USB speedtouch: use optimally sized reconstruction buffers
	USB speedtouch: send path micro optimizations
	USB speedtouch: kfree_skb -> dev_kfree_skb
	USB speedtouch: receive code rewrite

Also this one didn't go into Linus's tree, as it's already there:
	USB speedtouch: remove MOD_XXX_USE_COUNT

So, any patches against Linus's latest bk tree to bring the above into
sync would be appreciated.

thanks,

greg k-h
