Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTLJOQC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 09:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbTLJOQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 09:16:01 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:29963
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263580AbTLJOPk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 09:15:40 -0500
Date: Wed, 10 Dec 2003 06:09:58 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: David Woodhouse <dwmw2@infradead.org>
cc: karim@opersys.com, Linus Torvalds <torvalds@osdl.org>,
       Kendall Bennett <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <1070669311.8421.35.camel@imladris.demon.co.uk>
Message-ID: <Pine.LNX.4.10.10312100606510.3805-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David,

How about this ...

If you impose EXPORT_SYMBOL_GPL or impose restrictions on binary only
drivers you are forbidden to use my work?

Last check 96% of all linux boxes have IDE/ATAPI/SATA in them.
Oh yeah that ATAPI stuff is shared with others, but the setup code for the
majority of the hba's I own copyright.

So the sword cuts two ways.

Can we stop with the stupidity?

Andre Hedrick
LAD Storage Consulting Group

On Sat, 6 Dec 2003, David Woodhouse wrote:

> On Thu, 2003-12-04 at 01:25 -0500, Karim Yaghmour wrote:
> > Since the last time this was mentioned, I have been thinking that this
> > argument can really be read as an invitation to do just what's being
> > described: first implement a driver/module in a non-Linux OS (this may even
> > imply requiring that whoever works on the driver/module have NO Linux
> > experience whatsoever; yes there will always be candidates for this) and then
> > have this driver/module ported to Linux by Linux-aware developers.
> 
> So you have a loadable module made of two sections; a GPL'd wrapper
> layer clearly based on the kernel, and your original driver. The latter
> is clearly an identifiable section of that compound work which is _not_
> derived from Linux and which can reasonably be considered an independent
> and separate work in itself.
> 
> The GPL and its terms do not apply to that section when you distribute
> it as a separate work.
> 
> But when you distribute the same section as part of a _whole_ which is a
> work based on the Linux kernel, the distribution of the whole must be on
> the terms of the licence, whose permissions for other licensees extend
> to the entire whole, and thus to each and every part regardless of who
> wrote it.
> 
> For the precise wording which I've paraphrased above, see §2 of the GPL.
>  
> Note that 'is this a derived work' is only part of the question you
> should be asking yourself. The GPL makes requirements about the
> licensing even of works which are _not_ purely derived.
> 
> Some claim that copyright law does not allow the GPL to do such a thing.
> That is incorrect. I can write a work and license it to you under _any_
> terms I see fit. I can, for example, license it to you _only_ on
> condition that you agree to release _all_ your future copyrightable
> work, including works of fiction and other completely unrelated things,
> under terms I decree.
> 
> You either do that or you don't have permission to use my work.  Whether
> your own work is derived or not is completely irrelevant; if you don't
> agree to the terms of _my_ licence, you don't get to use _my_ code.
> 
> -- 
> dwmw2
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

