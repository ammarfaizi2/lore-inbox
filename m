Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263235AbVCJVlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263235AbVCJVlf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 16:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263238AbVCJVld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 16:41:33 -0500
Received: from fire.osdl.org ([65.172.181.4]:59856 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263235AbVCJVjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 16:39:35 -0500
Date: Thu, 10 Mar 2005 13:39:17 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Netdev <netdev@oss.sgi.com>,
       stable@kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
       Roger Luethi <rl@hellgate.ch>
Subject: Re: [stable] [BK PATCHES] 2.6.x net driver oops fixes
Message-ID: <20050310213917.GW5389@shell0.pdx.osdl.net>
References: <422F59E8.2090707@pobox.com> <20050310202548.GV5389@shell0.pdx.osdl.net> <4230AE24.602@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4230AE24.602@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeff Garzik (jgarzik@pobox.com) wrote:
> Chris Wright wrote:
> >* Jeff Garzik (jgarzik@pobox.com) wrote:
> >
> >
> >>This will update the following files:
> >>
> >>drivers/net/sis900.c    |   41 +++++++++++++++++++++--------------------
> >>drivers/net/via-rhine.c |    3 +++
> >
> >
> >The via-rhine fix is already in the stable queue.  But the sis900 oops
> >fix does not apply to the stable tree.  It relies on a few intermediate
> >patches.  Appears to still be an issue for the older version which is in
> >2.6.11.  Here's a stab at a backport.  Would you like to review/validate
> >or drop this one?
> 
> The backport looks correct to me, though it would be nice to get a 
> via-rhine owner to ACK the patch before it goes in...

OK, thanks.  ITYM sis900 maintainer, is that still Ollie Lho as listed in
MAINTAINERS (that's looking old)?

thanks,
-chris
