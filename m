Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161254AbVKIWC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161254AbVKIWC2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:02:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161265AbVKIWC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:02:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25298 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161254AbVKIWC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:02:27 -0500
Date: Wed, 9 Nov 2005 14:01:54 -0800 (PST)
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
In-Reply-To: <1131573041.8541.4.camel@mulgrave>
Message-ID: <Pine.LNX.4.64.0511091358560.4627@g5.osdl.org>
References: <20051109133558.513facef.akpm@osdl.org> <1131573041.8541.4.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Nov 2005, James Bottomley wrote:
>
> On Wed, 2005-11-09 at 13:35 -0800, Andrew Morton wrote:
> > -rw-r--r--    1 akpm     akpm       339882 Nov  9 11:19 git-scsi-misc.patch
> 
> This one is all 2.6.15 material.  I think I now (as of one minute ago)
> have it updated to the last of the 2.6.15 (barring bug fix) patches.
> I'd like to regression test it for a day or two, so I plan to request
> the final merger on Friday.

I'm hoping there aren't any infrastructure upheavals that break drivers 
again, because if there are, I think we're going to have to make a 
separate rule for things like that: they have to be merged early in the 
sequence or not at all.

And in _general_ I find it very wrong to consciously leave the merge until 
the last day of the merge window.

If that keeps happening, I think I'll just make sure that I don't always 
merge on the last day or two. Just to make sure that submaintainers don't 
"game" the system the wrong way. Maybe my "two weeks" are sometimes just 
ten days long, who knows..

			Linus
