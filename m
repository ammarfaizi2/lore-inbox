Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVHBV5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVHBV5y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 17:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVHBV5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 17:57:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40152 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261889AbVHBV5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 17:57:37 -0400
Date: Tue, 2 Aug 2005 14:57:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Greg KH <greg@kroah.com>, Manuel Lauss <mano@roarinelk.homelinux.net>,
       Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Erik Waling <erikw@acc.umu.se>
Subject: Re: 2.6.13-rc3-mm3
In-Reply-To: <20050803014757.B18001@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.58.0508021456070.3341@g5.osdl.org>
References: <Pine.LNX.4.58.0507311557020.14342@g5.osdl.org>
 <1122907067.31357.43.camel@localhost.localdomain> <1122976168.4656.3.camel@localhost.localdomain>
 <20050802103226.GA5501@roarinelk.homelinux.net> <20050802154022.A15794@jurassic.park.msu.ru>
 <Pine.LNX.4.58.0508020845520.3341@g5.osdl.org> <20050802205023.B16660@jurassic.park.msu.ru>
 <Pine.LNX.4.58.0508021002300.3341@g5.osdl.org> <20050803011337.A18001@jurassic.park.msu.ru>
 <20050802212143.GA8738@kroah.com> <20050803014757.B18001@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Aug 2005, Ivan Kokshaysky wrote:
>
> On Tue, Aug 02, 2005 at 02:21:44PM -0700, Greg KH wrote:
> > Nice, care to make up a single patch with these two changes in it?
> 
> Yep, I'll do it shortly, plus some minor additions as separate
> patches.

Actually, since everybody seems to like the "ignore 'min' if we have a
known bus resource" patch, and it was already in my tree, I just committed
it.

But you don't need to split up any patches you've already prepared: I can 
easily just edit away the part I already committed.

		Linus
