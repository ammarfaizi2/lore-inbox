Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbVC2Knz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVC2Knz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 05:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbVC2KYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 05:24:23 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55457 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262274AbVC2KVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 05:21:20 -0500
Date: Tue, 29 Mar 2005 12:21:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Jeff Garzik <jgarzik@pobox.com>,
       David McCullough <davidm@snapgear.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>
Subject: Re: [PATCH] API for true Random Number Generators to add entropy (2.6.11)
Message-ID: <20050329102104.GB6496@elf.ucw.cz>
References: <4242B712.50004@pobox.com> <20050324132342.GD7115@beast> <1111671993.23532.115.camel@uganda> <42432972.5020906@pobox.com> <1111725282.23532.130.camel@uganda> <42439839.7060702@pobox.com> <1111728804.23532.137.camel@uganda> <4243A86D.6000408@pobox.com> <1111731361.20797.5.camel@uganda> <20050325061311.GA22959@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050325061311.GA22959@gondor.apana.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 25-03-05 17:13:11, Herbert Xu wrote:
> On Fri, Mar 25, 2005 at 09:16:01AM +0300, Evgeniy Polyakov wrote:
> > On Fri, 2005-03-25 at 00:58 -0500, Jeff Garzik wrote:
> >
> > > If its disabled by default, then you and 2-3 other people will use this 
> > > feature.  Not enough justification for a kernel API at that point.
> > 
> > It is only because there are only couple of HW crypto devices
> > in the tree, with one crypto framework inclusion there will be
> > at least redouble.
> 
> You missed the point.  This has nothing to do with the crypto API.
> Jeff is saying that if this is disabled by default, then only a few
> users will enable it and therefore use this API.
> 
> Since we can't afford to enable it by default as hardware RNG may
> fail which can lead to catastrophic consequences, there is no point
> for this API at all.

What catastrophic consequences? Noone is likely to even *notice*, and
it does not help practical attack at all. Unless hardware RNGs are
*very* flakey (like, more flakey than harddrives), this is not a problem.

I can assure you that failing hdd will have more catastrophic
consequences.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
