Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVAMCwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVAMCwI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 21:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVAMCwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 21:52:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:55254 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261306AbVAMCwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 21:52:03 -0500
Date: Wed, 12 Jan 2005 18:51:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: davej@redhat.com, marcelo.tosatti@cyclades.com, greg@kroah.com,
       chrisw@osdl.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: thoughts on kernel security issues
In-Reply-To: <20050112182838.2aa7eec2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0501121847410.2310@ppc970.osdl.org>
References: <20050112094807.K24171@build.pdx.osdl.net>
 <Pine.LNX.4.58.0501121002200.2310@ppc970.osdl.org> <20050112185133.GA10687@kroah.com>
 <Pine.LNX.4.58.0501121058120.2310@ppc970.osdl.org> <20050112161227.GF32024@logos.cnet>
 <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com>
 <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050112182838.2aa7eec2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Jan 2005, Andrew Morton wrote:
> 
> That sounds a bit over-the-top to me, sorry.

Maybe a bit pointed, but the question is: would a user perhaps want to 
know about a security fix a month earlier (knowing that bad people might 
guess at it too), or want the security fix a month later (knowing that the 
bad guys may well have known about the problem all the time _anyway_)?

Being public is different from being known about. If vendor-sec knows 
about it, I don't find it at all unbelievable that some spam-virus writer 
might know about it too.

>  All of these are of exactly the same severity as the rlimit bug,
> and nobody cares, nobody is hurt.

The fact is, 99% of the time, nobody really does care. 

> The fuss over the rlimit problem occurred simply because some external
> organisation chose to make a fuss over it.

I agree. And if i thad been out in the open all the time, the fuss simply 
would not have been there.

I'm a big believer in _total_ openness. Accept the fact that bugs will 
happen. Be open about them, and fix them as soon as possible. None of this 
cloak-and-dagger stuff.

		Linus
