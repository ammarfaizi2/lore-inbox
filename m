Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263081AbVCDUls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbVCDUls (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 15:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263080AbVCDUdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 15:33:09 -0500
Received: from fire.osdl.org ([65.172.181.4]:52619 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263093AbVCDU04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:26:56 -0500
Date: Fri, 4 Mar 2005 12:28:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nicolas Pitre <nico@cam.org>
cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       tglx@linutronix.de, lkml <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <Pine.LNX.4.62.0503041352480.15953@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0503041223210.11349@ppc970.osdl.org>
References: <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
 <422751C1.7030607@pobox.com> <20050303181122.GB12103@kroah.com>
 <20050303151752.00527ae7.akpm@osdl.org> <20050303234523.GS8880@opteron.random>
 <20050303160330.5db86db7.akpm@osdl.org> <20050304025746.GD26085@tolot.miese-zwerge.org>
 <20050303213005.59a30ae6.akpm@osdl.org> <1109924470.4032.105.camel@tglx.tec.linutronix.de>
 <20050304005450.05a2bd0c.akpm@osdl.org> <20050304091612.GG14764@suse.de>
 <20050304012154.619948d7.akpm@osdl.org> <Pine.LNX.4.58.0503040956420.25732@ppc970.osdl.org>
 <Pine.LNX.4.62.0503041352480.15953@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Mar 2005, Nicolas Pitre wrote:
> 
> It might still be worth a try, especially since so many people are 
> convinced this is the way to go (your fault or not is not the point).

Making releases is actually a fair bit of work. Not the script itself, but 
just deciding and trying to synchronize. The fatc that people won't really 
appreciate it anyway, and just complain about "that's not stable anyway" 
just makes me even less interested.

The undeniable _fact_ in this discussion is that we're merging a lot of
patches - which is good, because that's how we keep 2.6.x relevant, and
not just a dead branch. And that is also what makes it fundamentally
different from 2.4.x, and I think a lot of people are just ignoring that
fact.

If people want a stable branch, they have to freeze their own thing. I and
Andrew do a lot of work to keep 2.6.x releases high-quality, and I think
we've been very successful in it too. The _whining_ from people who don't
realize that we can't just stop running (because if we did, quality would
go _down_ when we're then overwhelmed afterwards) is really quite grating,
though.

		Linus
