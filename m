Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWHFWCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWHFWCf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 18:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWHFWCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 18:02:23 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48397 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750738AbWHFWCU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 18:02:20 -0400
Date: Sat, 5 Aug 2006 10:45:07 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Zachary Amsden <zach@vmware.com>
Cc: Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, greg@kroah.com,
       Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>
Subject: Re: A proposal - binary
Message-ID: <20060805104507.GA4506@ucw.cz>
References: <44D1CC7D.4010600@vmware.com> <44D217A7.9020608@redhat.com> <44D24236.305@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44D24236.305@vmware.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >You're making a very good argument as to why we should 
> >probably
> >require that the code linking against such an 
> >interface, if we
> >decide we want one, should be required to be open 
> >source.
> 
> Personally, I don't feel a strong requirement that it be 
> open source, because I don't believe it violates the 
> intent of the GPL license by crippling free distribution 
> of the kernel, requiring some fee for use, or doing 
> anything unethical.  There have been charges that the 
> VMI layer is deliberately designed as a GPL 
> circumvention device, which I want to stamp out now 
> before we try to get any code for integrating to it 
> upstreamed.

Maybe it is not designed tobe evil, but...

> >>I think you will see why our VMI layer is quite 
> >>similar to a
> >>traditional ROM, and very dissimilar to an evil 
> >>GPL-circumvention
> >>device.
> >
> >>(?) There are only two reasonable objections I can see 
> >>to open
> >>sourcing the binary layer. 
> >
> >Since none of the vendors that might use such a 
> >paravirtualized
> >ROM for Linux actually have one of these reasons for 
> >keeping their
> >paravirtualized ROM blob closed source, I say we might 
> >as well
> >require that it be open source.
> 
> I think saying require at this point is a bit 
> preliminary for us -- I'm trying to prove we're not 
> being evil and subverting the GPL, but I'm also not 
> guaranteeing yet that we can open-source the code under 
> a specific license.  Sorry about having to doublespeak 

...it should be very easy to opensource simple 'something' layer. If
it is so complex it is 'hard' to opensource, it is missdesigned,
anyway... so fix the design.

My proposal would be: add open-source hypervisor interface, and keep
it updated for a while. If it is too hard to keep updated, we'll have
to solve it, somehow, but lets not overengineer it now.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
