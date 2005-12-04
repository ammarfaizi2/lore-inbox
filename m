Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbVLDPII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVLDPII (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 10:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVLDPII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 10:08:08 -0500
Received: from mail.gmx.de ([213.165.64.20]:28644 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932241AbVLDPIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 10:08:07 -0500
X-Authenticated: #428038
Date: Sun, 4 Dec 2005 16:08:04 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051204150804.GA17846@merlin.emma.line.org>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20051203162755.GA31405@merlin.emma.line.org> <1133630556.22170.26.camel@laptopd505.fenrus.org> <20051203230520.GJ25722@merlin.emma.line.org> <43923DD9.8020301@wolfmountaingroup.com> <20051204121209.GC15577@merlin.emma.line.org> <1133699555.5188.29.camel@laptopd505.fenrus.org> <20051204132813.GA4769@merlin.emma.line.org> <1133703338.5188.38.camel@laptopd505.fenrus.org> <20051204142551.GB4769@merlin.emma.line.org> <1133707855.5188.41.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133707855.5188.41.camel@laptopd505.fenrus.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Dec 2005, Arjan van de Ven wrote:

> > As I say, these aren't licensed for inclusion into the kernel, they bear
> > a (C) Copyright notice and "All rights reserved."
> 
> and
> MODULE_LICENSE("GPL");
> 
> so it *IS* gpl licensed!
> 
> the code is a bit horrible though and no surprise it breaks ;)

Yes. "extern type foo; static type foo;" is way stupid, but 10% of the
blame can be shifted on the GCC guys for being much too tolerant.

> you can always make drivers broken enough to break at the slightest
> change ;)
> 
> (it also seems to contain an entire ipmi layer, linux already has one so
> I wonder why they're not just using that as basis)

Perhaps the dates give a clue. Since when has Linux had IPMI in the
baseline code?

-- 
Matthias Andree
