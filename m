Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbVKIWZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbVKIWZg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbVKIWZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:25:36 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:42716 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1750970AbVKIWZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:25:34 -0500
Subject: Re: merge status
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>, Jeff Garzik <jgarzik@pobox.com>,
       "Luck, Tony" <tony.luck@intel.com>, Ben Collins <bcollins@debian.org>,
       Jody McIntyre <scjody@modernduck.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Roland Dreier <rolandd@cisco.com>, Dave Jones <davej@codemonkey.org.uk>,
       Jens Axboe <axboe@suse.de>, Dave Kleikamp <shaggy@austin.ibm.com>,
       Steven French <sfrench@us.ibm.com>
In-Reply-To: <Pine.LNX.4.64.0511091358560.4627@g5.osdl.org>
References: <20051109133558.513facef.akpm@osdl.org>
	 <1131573041.8541.4.camel@mulgrave>
	 <Pine.LNX.4.64.0511091358560.4627@g5.osdl.org>
Content-Type: text/plain
Date: Wed, 09 Nov 2005 17:25:23 -0500
Message-Id: <1131575124.8541.9.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-09 at 14:01 -0800, Linus Torvalds wrote:
> 
> On Wed, 9 Nov 2005, James Bottomley wrote:
> >
> > On Wed, 2005-11-09 at 13:35 -0800, Andrew Morton wrote:
> > > -rw-r--r--    1 akpm     akpm       339882 Nov  9 11:19 git-scsi-misc.patch
> > 
> > This one is all 2.6.15 material.  I think I now (as of one minute ago)
> > have it updated to the last of the 2.6.15 (barring bug fix) patches.
> > I'd like to regression test it for a day or two, so I plan to request
> > the final merger on Friday.
> 
> I'm hoping there aren't any infrastructure upheavals that break drivers 
> again, because if there are, I think we're going to have to make a 
> separate rule for things like that: they have to be merged early in the 
> sequence or not at all.

There are one or two.  Part of the delay is getting sign offs from all
the people involved.

> And in _general_ I find it very wrong to consciously leave the merge until 
> the last day of the merge window.

Well ... I can give you the URL to pull now if you want ... I'd just
prefer to give this lot another day or so of testing.

> If that keeps happening, I think I'll just make sure that I don't always 
> merge on the last day or two. Just to make sure that submaintainers don't 
> "game" the system the wrong way. Maybe my "two weeks" are sometimes just 
> ten days long, who knows..

That's a nice theory, except that it's my contributors who drop me in it
by leaving their patch sets until you declare a kernel, dumping the
integration testing on me in whatever time window is left.

James


