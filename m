Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbWDKCW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWDKCW3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 22:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWDKCW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 22:22:28 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:4028 "EHLO pilet.ens-lyon.fr")
	by vger.kernel.org with ESMTP id S932257AbWDKCW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 22:22:28 -0400
Date: Tue, 11 Apr 2006 04:23:11 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Michael Buesch <mb@bu3sch.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, netdev@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org,
       linville@tuxdriver.com
Subject: Re: [RFC/PATCH] remove unneeded check in bcm43xx
Message-ID: <20060411022311.GB31118@ens-lyon.fr>
References: <20060410040120.GA4860@ens-lyon.fr> <20060410042228.GN27596@ens-lyon.fr> <1144719972.19353.24.camel@localhost.localdomain> <200604110353.52067.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604110353.52067.mb@bu3sch.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2006 at 03:53:51AM +0200, Michael Buesch wrote:
> On Tuesday 11 April 2006 03:46, you wrote:
> > 
> > 
> > Now, for ppc32, it should still sort-of work because all of lowmem is
> > below 1Gb and people generally don't hack their lowmem size (well, I do
> > but heh, that doesn't count :) and I don't think you'll get skb's in
> > highmem. But ppc64 hits the problem and at this point, there is nothing
> > I can do other than either implementing a split zone allocation mecanism
> > in the ppc64 architecture
> 
> > for the sole sake of bcm43xx (ick !)
> 
> Nope. For every broadcom device, which has this stupid DMA engine.
> That is b44 and bcm43xx, as far as I can tell. But likely there are more.

On the other hand, bcm43xx looks very common with apple hardware, so there
are probably a lot of users who cannot use their wifi card in G5's.

regards,

Benoit
-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
