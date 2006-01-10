Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWAJKl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWAJKl4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 05:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWAJKl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 05:41:56 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:12765 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932089AbWAJKl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 05:41:56 -0500
Date: Tue, 10 Jan 2006 11:41:43 +0100
From: Andreas Mohr <andim2@users.sourceforge.net>
To: acx100-devel@lists.sourceforge.net
Cc: Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Acx100-devel] Re: State of the Union: Wireless
Message-ID: <20060110104143.GA28119@rhlx01.fht-esslingen.de>
Reply-To: andi@lisas.de
References: <20060106042218.GA18974@havoc.gtf.org> <200601100839.26052.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601100839.26052.vda@ilport.com.ua>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 10, 2006 at 08:39:25AM +0200, Denis Vlasenko wrote:
> On Friday 06 January 2006 06:22, Jeff Garzik wrote:
> > 
> > 		State of the Union - Wireless
> > 		      January 5, 2006
> 
> [ snip ]
> 
> > * Wireless drivers and the wireless stack need to be maintained IN-TREE
> >   as a COLLECTIVE ENTITY, not piecemeal maintenance as its done now.
> > 
> > The whole point of working in-tree, the whole point of this open source
> > thing is that everybody works on the same code, and the entire Internet
> > is your test bed.  Quality improves the more people work together.
> > The entire Linux kernel engineering process is focused on getting core
> > kernel code out to distributions (then to end users) and power users.
> > Out-of-tree code breaks that model, breaking the It Just Works(tm)
> > theme applicable to other Linux-supported hardware.
> 
> Cool, so may I please know why acx driver is not included in the mainline?
> In case it needs more work, well, (a) at least tell us what exactly
> you want improved, and (b) why do you think that in-tree acx would not
> be improved? It will get more visibility, maybe some people will
> get interested and will send a patch or two to us...

I think wording is a tad bit too aggressive here, since we (well, at least me)
haven't made many efforts to get it included, since we had to work out
some things. However at this point we should really go for inclusion,
the sooner the better (right?).

> > * Release early, release often.  Pushing from an external repository to
> >   the official kernel tree every few months creates more problems
> >   than it solves.  Out-of-tree drivers fail to take advantage of
> >   recent kernel changes and coding practices, which leads to bugs and
> >   incompatibilities.  Slow pushing leads to huge periodic updates,
> >   which are awful for debugging, testing, and general use.
> 
> I want to avoid exactly this, and therefore want acx in mainline.

ACK.

> How are we going to find out which stack is best and which stack
> we should concentrate our efforts on? In an absense of wifi maintainer,
> maybe we should throw _all stacks_ (currently two) into the mainline,
> and evolution will find the best one. Yes, it would be a bit ugly
> at first, but I hope it will speed up evolution a lot.

I have to admit that a big item on our acx ToDo list was the missing ieee80211
integration, but now that there's a second stack on the horizon and things
look less decided I'm not that much troubled by our lack of ieee80211 use
any more ;)
That said, of course we should try to get rid of our own, historic (originating
from binary TI driver!) in-driver stack very soon.

I won't do any comments on which stack to use, though, I will do research first
and then work out which one to use depending on popularity and features
matching our chips' properties.

Andreas Mohr
