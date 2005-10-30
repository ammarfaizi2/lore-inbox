Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbVJ3XcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbVJ3XcE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 18:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbVJ3XcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 18:32:04 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:65213
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932406AbVJ3XcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 18:32:01 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [git patches] 2.6.x libata updates
Date: Sun, 30 Oct 2005 17:31:46 -0600
User-Agent: KMail/1.8
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20051029182228.GA14495@havoc.gtf.org> <200510300644.20225.rob@landley.net> <Pine.LNX.4.64.0510301435520.27915@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510301435520.27915@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510301731.47825.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 October 2005 16:36, Linus Torvalds wrote:
> > Is this a viable option?
>
> No.
>
> There is no "ordering" in a distributed environment. We have things
> happening in parallel, adn you can't really linearize the patches.
>
> The closest you can get is "git bisect", which does the right thing.
>
>   Linus

I know there isn't an absolute or stable ordering, but can't a temporary 
ordering be exported?

I was under the impression that the bk->cvs gateway squashed changes into a 
sort of order, way back when.  Admittedly this order wasn't stable, and new 
changes perturbed the whole list.  But just for debugging purposes with a 
"patch vs last -rc"?

Rob
