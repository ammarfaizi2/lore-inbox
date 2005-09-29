Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964829AbVI2Thy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbVI2Thy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbVI2Thx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:37:53 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:43526 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S964829AbVI2Thu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:37:50 -0400
Date: Thu, 29 Sep 2005 21:32:25 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into the kernel
Message-ID: <20050929193225.GA16171@alpha.home.local>
References: <43384E28.8030207@adaptec.com> <4339BFE9.1060604@pobox.com> <4339CCD6.5010409@adaptec.com> <4339F9A8.2030709@pobox.com> <433AFEB2.7090003@adaptec.com> <433B0457.7020509@pobox.com> <433B14E1.6080201@adaptec.com> <433B217F.4060509@pobox.com> <20050929040403.GE18716@alpha.home.local> <1127979848.2918.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127979848.2918.7.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2005 at 09:44:08AM +0200, Arjan van de Ven wrote:
> On Thu, 2005-09-29 at 06:04 +0200, Willy Tarreau wrote:
> > On Wed, Sep 28, 2005 at 07:04:31PM -0400, Jeff Garzik wrote:
> > > Linux is about getting things done, not being religious about 
> > > specifications.  You are way too focused on the SCSI specs, and missing 
> > > the path we need to take to achieve additional flexibility.
> > > 
> > > With Linux, it's all about evolution and the path we take.
> > 
> > Hmmm... I'm fine with "not being religious about specs", but I hope we
> > try to respect them as much as possible
> 
> a spec describes how the hw works... how we do the sw piece is up to
> us ;)

No Arjan, you cannot say that ! (well, of course you can but in this case
you may be wrong). A spec describes any process, whether it's soft or hard,
and BTW, the frontier between soft and hard is diminishing. When I designed
a PI-Bus-PCI bridge 10 years ago, I used PCI 2.1 Specification. And it was
more related to software than hardware (FSMs, config registers, etc...).

It's the *implementation* which is up to us, not the spec. A spec will never
tell you that you have to be compliant with 4k stacks or things like this.
This is implementation. What it tells you is when interrupt X strikes and
you read bit Y from reg Z, then you must reset bit Y before leaving. And this
is software specs, not hardware.

> (I know the scsi stuff also provides sort of a reference "here is how
> you can do it in sw" but I see that more as you "you need this
> functionality" not "you need this exact architecture in your software")

Keeping close to an accepted standard model makes it far easier to upgrade
later, but you're right, the spec does not tell you what your implementation
must look like.

I think we agree but just don't give the exact same meaning to words.

Regards,
Willy

