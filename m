Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263084AbVCDUp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbVCDUp5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 15:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263105AbVCDUnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 15:43:10 -0500
Received: from fire.osdl.org ([65.172.181.4]:35213 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263095AbVCDUfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:35:52 -0500
Date: Fri, 4 Mar 2005 12:37:05 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rene Herman <rene.herman@keyaccess.nl>
cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <4228B514.4020704@keyaccess.nl>
Message-ID: <Pine.LNX.4.58.0503041230020.11349@ppc970.osdl.org>
References: <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>
 <422751C1.7030607@pobox.com> <20050303181122.GB12103@kroah.com>
 <20050303151752.00527ae7.akpm@osdl.org> <20050303234523.GS8880@opteron.random>
 <20050303160330.5db86db7.akpm@osdl.org> <20050304025746.GD26085@tolot.miese-zwerge.org>
 <20050303213005.59a30ae6.akpm@osdl.org> <1109924470.4032.105.camel@tglx.tec.linutronix.de>
 <20050304005450.05a2bd0c.akpm@osdl.org> <20050304091612.GG14764@suse.de>
 <20050304012154.619948d7.akpm@osdl.org> <Pine.LNX.4.58.0503040956420.25732@ppc970.osdl.org>
 <4228B514.4020704@keyaccess.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Mar 2005, Rene Herman wrote:
>
> Linus Torvalds wrote:
> 
> > I've long since decided that there's no point to making "-pre". What's the 
> > difference between a "-pre" and a daily -bk snapshot? Really?
> 
> The fact that not a script, but Linus Torvalds, decides that the tree is 
> in a state he likes to share with others. You have been doing -pre's all 
> this time, it's just that you are calling them -rc's.

No.

I used to do "-pre", a long time ago. Exactly because they were 
synchronization points for developers.

These days, that's pointless. We keep the tree in pretty good working
order (certainly as good as my -pre's ever were) constantly, and
developers who need to can synchronize with either the BK tree or the
nightly snapshots. The fact is, 99% of the developers don't even need to 
do that, since most of the development process is quite well parallellised 
by now, and there is seldom any serious overlap.

So the point of -pre's are gone. Have people actually _looked_ at the -rc
releases? They are very much done when I reach the point and say "ok,
let's calm down". The first one is usually pretty big and often needs some
fixing, simply because the first one is _inevitably_ (and by design) the
one that gets the pent-up demand from the previous calming down period. 

But it's very much a call to "ok, guys, calm down now".

And if you aren't calming down, it's _your_ problem. Complaining about 
naming of -pre vs -rc is pointless. 

The even/odd situation would have made for a situation that some people
seem to be arguing for (more explicit calming-down period), but with the
difference that I think the odd ones should definitely have been
user-release quality already. But that one was apparently hated by so many
people that it's not even worth trying.

The fact is, there is no perfect way of doing things, and this discussion 
has degenerated into nothing but whining. Which is kind of expected, but 
let's hope that the only non-whining that came out of this (Greg & co's 
trials with 2.6.x.y) ends up being worthwhile.

		Linus
