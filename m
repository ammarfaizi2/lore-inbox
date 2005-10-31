Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbVJaJe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVJaJe5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 04:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbVJaJe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 04:34:57 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:3274 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S932267AbVJaJe5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 04:34:57 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: David Lang <david.lang@digitalinsight.com>
Subject: Re: [git patches] 2.6.x libata updates
Date: Mon, 31 Oct 2005 03:34:34 -0600
User-Agent: KMail/1.8
Cc: Junio C Hamano <junkio@cox.net>, linux-kernel@vger.kernel.org
References: <20051029182228.GA14495@havoc.gtf.org> <7vpspmhxhz.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.62.0510310109250.16065@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0510310109250.16065@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510310334.35597.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 03:13, David Lang wrote:
> > I was thinking about doing thatn in hidden input fields and
> > passing form back and forth.  After all what real git bisect
> > keeps locally are one bad commit ID and bunch of good commit
> > IDs.
>
> if it's kept in a file or cookie then it can survive a reboot and other
> distractions (remember that this process can take days if the problem
> doesn't show up at boot). a cookie can hold a couple K worth of data, a
> file has no size limit.

Actually, lots of Linux browsers these days treats all cookies as session 
cookies for security reasons.  So surviving a reboot still isn't guaranteed.  
But it's possible.

You can also have 'em bookmark a URL...

> it would also be a good idea if the web page could give an estimate
> estimate of how many additional tests may end up being required.

Bisect already says how many commits are left in the pool, so roughly log(2) 
of that...

> David Lang

Rob
