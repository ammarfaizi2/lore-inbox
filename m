Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269105AbUJVMyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269105AbUJVMyw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 08:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270958AbUJVMyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 08:54:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38288 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271260AbUJVMus
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 08:50:48 -0400
Date: Thu, 21 Oct 2004 21:40:40 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Mark Lord <lkml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.28-pre4-bk6] delkin_cb: new driver for Cardbus IDE CF adaptor
Message-ID: <20041021234040.GA23511@logos.cnet>
References: <41780393.3000606@rtr.ca> <58cb370e041021121317083a3a@mail.gmail.com> <41781B13.3030803@rtr.ca> <58cb370e041021134269c05f17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e041021134269c05f17@mail.gmail.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 10:42:18PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Thu, 21 Oct 2004 16:24:51 -0400, Mark Lord <lkml@rtr.ca> wrote:
> > Okay, patch withdrawn.
> > 
> > I'll just apply it to my own kernels for my own use.
> 
> Just port it to 2.6.x...
> 
> > Whatever happended to the days when Linux *wanted* more
> > drivers and such?
> 
> New drivers are still welcomed... but days of applying
> new drivers without any complaints are long gone... ;-)
> 
> Now speaking seriously:
> * 2.4.x is deprecated (sorry, Marcelo ;)

Buaaaahhh...

Hehe.

People still use 2.4 because they are not prepared (for whatever reason) 
to or do not want a v2.6 upgrade, but yes, I agree it is deprecated.

> * this driver shouldn't require much work to port it to 2.6.x

As I said before in my opinion drivers in new v2.4.x releases for 
new devices are OK as long as they meet a decent coding and quality 
standard and are well tested.
And, very importantly, benefit a substantial amount of users. 

Having the driver in v2.6 first is pretty much required. 
It has the chance of being put under test, as well as 
passing Linus/Andrew "level of acceptance", plus reviewing 
from other people which is always good.

Mark, v2.4.28 is approaching -rc stage (-rc1 should be out tomorrow), 
we can include the driver during v2.4.29-pre.

In the meantime you can port it to v2.6 ?

> * ide_unregister() is disallowed, unless IDE locking is fixed




