Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030460AbVKIWoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030460AbVKIWoJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030459AbVKIWoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:44:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2783 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030453AbVKIWoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:44:07 -0500
Date: Wed, 9 Nov 2005 14:43:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>, Jeff Garzik <jgarzik@pobox.com>,
       "Luck, Tony" <tony.luck@intel.com>, Ben Collins <bcollins@debian.org>,
       Jody McIntyre <scjody@modernduck.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Roland Dreier <rolandd@cisco.com>, Dave Jones <davej@codemonkey.org.uk>,
       Jens Axboe <axboe@suse.de>, Dave Kleikamp <shaggy@austin.ibm.com>,
       Steven French <sfrench@us.ibm.com>
Subject: Re: merge status
In-Reply-To: <1131575124.8541.9.camel@mulgrave>
Message-ID: <Pine.LNX.4.64.0511091437100.4627@g5.osdl.org>
References: <20051109133558.513facef.akpm@osdl.org>  <1131573041.8541.4.camel@mulgrave>
  <Pine.LNX.4.64.0511091358560.4627@g5.osdl.org> <1131575124.8541.9.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Nov 2005, James Bottomley wrote:
> 
> > If that keeps happening, I think I'll just make sure that I don't always 
> > merge on the last day or two. Just to make sure that submaintainers don't 
> > "game" the system the wrong way. Maybe my "two weeks" are sometimes just 
> > ten days long, who knows..
> 
> That's a nice theory, except that it's my contributors who drop me in it
> by leaving their patch sets until you declare a kernel, dumping the
> integration testing on me in whatever time window is left.

My point is that if that keeps on happening, then you miss the window, and 
are hopefully ready EARLY next time around, four weeks later, when the 
next window opens.

And if your submaintainers keep screwing _you_, then you tell them to stop 
it, and stop accepting their patches in that window, so that it's _their_ 
code that gets delayed, not yours.

The development SHOULD NOT happen during the merge window. The development 
should have happened in the tree you wait to merge /while waiting/ for the 
window to open.

If you're doing the development during the merge window, not only do you 
get in late in the window, you also do a hurried job and thus almost 
certainly have a worse process.

The whole point of having timely merge windows is that we _can_ just say 
"sorry, you missed the bus, wait for the next one".

And trust me, I _will_ say that. People always complain that I'm being too 
soft. Not so this time. If people miss the merge window or start abusing 
it with hurried last-minute things that just cause problems for -rc1, I'll 
just refuse to merge, and laugh in their faces derisively when they whine 
plaintively at me, and tell them there's going to be a new opening soon 
enough.

If two weeks of merge window is too short, maybe the four weeks _between_ 
the windows is long enough to sort things out.

		Linus
