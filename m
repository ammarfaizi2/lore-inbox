Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161034AbVKIWtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161034AbVKIWtG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161037AbVKIWtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:49:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42465 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161034AbVKIWsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:48:54 -0500
Date: Wed, 9 Nov 2005 14:48:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jody McIntyre <scjody@modernduck.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>,
       "Brown, Len" <len.brown@intel.com>, Jeff Garzik <jgarzik@pobox.com>,
       "Luck, Tony" <tony.luck@intel.com>, Ben Collins <bcollins@debian.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Roland Dreier <rolandd@cisco.com>, Dave Jones <davej@codemonkey.org.uk>,
       Jens Axboe <axboe@suse.de>, Dave Kleikamp <shaggy@austin.ibm.com>,
       Steven French <sfrench@us.ibm.com>
Subject: Re: merge status
In-Reply-To: <20051109222356.GF14318@conscoop.ottawa.on.ca>
Message-ID: <Pine.LNX.4.64.0511091443310.4627@g5.osdl.org>
References: <20051109133558.513facef.akpm@osdl.org> <20051109221201.GE14318@conscoop.ottawa.on.ca>
 <Pine.LNX.4.64.0511091417540.4627@g5.osdl.org> <20051109222356.GF14318@conscoop.ottawa.on.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Nov 2005, Jody McIntyre wrote:
>
> On Wed, Nov 09, 2005 at 02:18:32PM -0800, Linus Torvalds wrote:
> 
> > If you have a 71kB patch, it definitely counts as new stuff and not just 
> > trivial bugfixes.
> 
> Fair enough.
> 
> Can I still send a 2k spinlock fix in ~2 weeks?  That's the only thing I
> really want to get in to 2.6.15.

Sure, there's nothing wrong with keeping "ongoing development" around, and 
then just asking me to pull the unrelated fixes. 

Either using separate patches to synchronize the bugfixes, or just using 
separate git branches for development and merging up to me. As usual, Jeff 
ends up the poster-boy for git branches (these days there are certainly 
others that do it too, but Jeff has done it more and for longer than 
most).

For example, going to Jeff's networking tree:

	http://www.kernel.org/git/?p=linux/kernel/git/jgarzik/netdev-2.6.git;a=summary

you can see

	15 hours ago 	ALL 		shortlog | log
	15 hours ago 	e100-sbit 	shortlog | log
	16 hours ago 	upstream-linus 	shortlog | log
	16 hours ago 	upstream 	shortlog | log
	20 hours ago 	master 		shortlog | log
	4 days ago 	sky2 		shortlog | log
	4 days ago 	sis900-wol 	shortlog | log
	4 days ago 	8139-thread 	shortlog | log

where "upstream-linus" is the part I merged today, while he has possibly 
other development work in the other branches.

			Linus
