Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbWG0LvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbWG0LvJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 07:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWG0LvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 07:51:09 -0400
Received: from host36-195-149-62.serverdedicati.aruba.it ([62.149.195.36]:44480
	"EHLO mx.cpushare.com") by vger.kernel.org with ESMTP
	id S932544AbWG0LvI (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Thu, 27 Jul 2006 07:51:08 -0400
Date: Thu, 27 Jul 2006 13:52:29 +0200
From: andrea@cpushare.com
To: Adrian Bunk <bunk@stusta.de>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, Hans Reiser <reiser@namesys.com>,
       Nikita Danilov <nikita@clusterfs.com>, Rene Rebe <rene@exactcode.de>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060727115229.GD32243@opteron.random>
References: <20060726132957.GH32243@opteron.random> <20060726134326.GD23701@stusta.de> <20060726142854.GM32243@opteron.random> <20060726145019.GF23701@stusta.de> <20060726160604.GO32243@opteron.random> <20060726170236.GD31172@fieldses.org> <20060726172029.GS32243@opteron.random> <20060726205022.GI23701@stusta.de> <20060726211741.GU32243@opteron.random> <20060727065603.GJ23701@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727065603.GJ23701@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 08:56:03AM +0200, Adrian Bunk wrote:
> On Wed, Jul 26, 2006 at 11:17:41PM +0200, andrea@cpushare.com wrote:
> > On Wed, Jul 26, 2006 at 10:50:22PM +0200, Adrian Bunk wrote:
> > > But depending on the nature of the error, the worst case might be the 
> > > common case (as I've already explained in another email).
> > > 
> > > If you can't ensure the quality of your data, please don't use this data 
> > > to wrongly draw any conclusions from them [1].
> > 
> > Please read the footer of the KLive pages:
> > 
> > "The use of the information and of the software in this website is at
> >  your own risk.  KLive probably doesn't represent a reliable sample of
> >  the real usage of the Linux Kernel."
> 
> It was you who wrongly said:
> "With KLive I can attempt to estimate market share of _kernel_ code"
> 
> Hadn't you read your own disclaimer?

There is no contradiction in the two statements. To attempt to
estimate something I don't need a reliable sample of the whole
population. Estimation is still a statistical thing. Also I said
attempt to estimate, it doesn't mean I will make it.

If you don't consider those results a positive for reiser4, it can
only mean you expected reiser4 to have a much higher share among the
KLive users. This is obvious.

> Every time someone will repeat the "1:5 ratio for reiser4:ext3 users", 
> this will be an additional proof it's really worse than no data.

If they say "1:5 ratio for reiser4:ext3 KLive users" everything will
be correct and nobody can object because it's a fact.

I said myself that I'm no reiserfs user, and I don't plan to become
one any time soon (especially on my production systems), I'm only
reporting plain numbers as KLive measured the stuff. I'm surprised as
much as you are, but then I've to report facts, and not my own
opinions.

As far as I'm concerned the thing I like less of reiser4 is the plugin
thing, I'd be less concerned if that was a microkernel (fuse-like)
userland plugin system. Anyway with time perhaps things can change and
become userland based, and the stuff can be moved into vfs if that
code really belongs there as some kernel developer says. That doesn't
mean reiser4 can't be merged first and the stuff moved into vfs
later. xfs when was merged also pratically rewrote a vfs internally
that was meant to work with irix, if Christoph didn't complain about
xfs being merged, I don't see what's the problem of reiser4 being
merged even if it rewrites some part of vfs. xfs is also still having
various special features like the pinhole one that only belongs to the
vfs instead but nobody complains.

And if reiser4 is really so bad as they say, once people starts losing
data they will spread the word of not using it. As long as it's marked
experimental I don't see a big issue, the wireless driver for broadcom
chip will eat your filesystem too if the reverse engineered dma
operations writes into a buffer header instead of an skb.
