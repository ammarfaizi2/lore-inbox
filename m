Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVCCUNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVCCUNb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 15:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVCCUJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 15:09:44 -0500
Received: from fire.osdl.org ([65.172.181.4]:14737 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262280AbVCCUHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 15:07:46 -0500
Date: Thu, 3 Mar 2005 12:07:18 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, Rene Rebe <rene@exactcode.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/ Altivec
Message-ID: <20050303200718.GR28536@shell0.pdx.osdl.net>
References: <422751D9.2060603@exactcode.de> <422756DC.6000405@pobox.com> <20050303191840.GA12916@kroah.com> <42276A0C.9080505@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42276A0C.9080505@pobox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jeff Garzik (jgarzik@pobox.com) wrote:
> Greg KH wrote:
> 
> Two procedural suggestions...
> 
> >Ok, I've fixed up the patch and applied it to a local tree that I've set
> >up to catch these things (it will live at
> >bk://kernel.bkbits.net:gregkh/linux-2.6.11.y until Chris Wright and I
> >set up how we are going to handle all of this.)
> 
> My suggestion would be one of two alternatives:
> 
> 1) At each release, Linus clones
> 	linux.bkbits.net/linux-2.6
> 		to
> 	linux.bkbits.net/linux-2.6.11
> 
> and gives the "release team" access to push to linux-2.6.11 repo.

My recollection of the bkbits interface is that it's keys are good for a
"project" dir.  So I don't know if it would work like you suggested.

> 2) Create linux-release.bkbits.net, and some non-Linus person clones 
> linux-2.6 at release time to linux-2.6.11.

This is closer to what I suggested to Greg (although I like your name
better).

> This accomplishes two [minor] goals:
> a) the tree lives at bkbits.net, as has a name associated with the goal 
> of the project
> 
> b) The repo has the _exact_ name of the kernel release.  None of this 
> "linux-2.6.11.y" stuff.  Just "linux-2.6.11".  Anything else violates 
> the Principle of Least Surprise.
> 
> 
> >Feel free to start pointing stuff like this at me and chris (we'll also
> >be setting up an alias for it.)
> 
> I was wondering if it would be possible to setup a list on vger that is 
> public, but read-only to everyone but the $sucker team.

Don't see why not, we were thinking of making it just an alias at
kernel.org.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
