Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVBNXZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVBNXZY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 18:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVBNXZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 18:25:21 -0500
Received: from warden2-p.diginsite.com ([209.195.52.120]:61346 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261270AbVBNXZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 18:25:04 -0500
From: David Lang <david.lang@digitalinsight.com>
To: lm@bitmover.com
Cc: Gerold Jury <gjury@inode.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Sipek <jeffpc@optonline.net>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Mon, 14 Feb 2005 15:23:47 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [BK] upgrade will be needed
In-Reply-To: <20050214225704.GD16029@bitmover.com>
Message-ID: <Pine.LNX.4.60.0502141503400.30997@dlang.diginsite.com>
References: <20050214020802.GA3047@bitmover.com> <20050214194428.GC8763@merlin.emma.line.org>
 <20050214200544.GC16029@bitmover.com> <200502142324.43269.gjury@inode.at>
 <20050214225704.GD16029@bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry, I don't think he's talking about making the free bk be a striped 
down version, I think he's talking about having two different free 
versions.

version 1
what you have today with the license you need to protect yourself

version 2
a version with no check-in capability at all, all it can do is passivly 
mirror a repository to a local system and check-out a tree to a local 
system. since this version won't have any of your 'secret sauce merging 
stuff' in it it may be possible for you to use a license that doesn't need 
to include the non-compete clause.

anyone doing development would need version1, but there are a number of 
people who have bitkeeper installed but only use it to check out versions 
and really don't care about the differences between bk and cvs for this 
(and for this purpose the differences are mainly network efficiancies)

Assuming that this is techincaly posible (my memory is warning me that the 
pull from a remote repository may be a 'check-in' as things are currently 
written) I think the risk to you would that the new license would let some 
of the people who want to reverse-engineer things use this 'fetch-only' 
version and see some of the meta-data, I don't know if you can leave out 
enough of the stuff you care about to be willing to loose the rest.

As you acknowledged in your presentation this last weekend, the people at 
the bottom of the tree don't get much benifit from bitkeeper, this applies 
even more so to the people who are read-only to the system.

this does mean that there would be somehat of a commiter/non-commiter 
split, with the difference between them being those who agree to the 
non-compete license of #1 and those who don't and use #2 to have a local 
read-only copy and have to use normal patches to submit changes up the 
tree.

David Lang

  On Mon, 14 Feb 2005 lm@bitmover.com wrote:

> Date: Mon, 14 Feb 2005 14:57:04 -0800
> From: lm@bitmover.com
> To: Gerold Jury <gjury@inode.at>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
>     Jeff Sipek <jeffpc@optonline.net>,
>     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Subject: Re: [BK] upgrade will be needed
> 
> On Mon, Feb 14, 2005 at 11:24:43PM +0100, Gerold Jury wrote:
>> Hi Larry
>> Hi Everyone
>>
>> Do you think it is possible to make a split licence that will distinguish
>> between active changes and passive watching/tracking ?
>
> A lot of people have told us to create two products, the free product
> and the commercial product, and license the free product with standard
> licensing terms.  The expectation is that we would somehow make the free
> product less desirable so that people bought the commercial product.
>
> That's an excellent suggestion if our only goal is to make money, that
> makes the free product sort of a teaser and the commercial product the
> real deal.  However, the goal really is to help the open source
> community, Linux in particular.  If we give away crippled software then
> all the people who say we are just a money grubbing corporation are
> more or less correct.  At that point we aren't giving away the good
> stuff and it was always the goal that you got the latest and greatest
> because that's what can do you the most good.
>
> However, it sure sounds like the noisy people would be a lot happier
> with a stripped down BK that didn't have as many of the restrictions.
> And a possible out for even the open source users is that they buy seats
> if they really need the more powerful features.  Or we could donate
> some on a case by case basis.
>
> If the hackers who are using BK can reach agreement that it would be
> better if the BK they had didn't move forward unless they got commercial
> seats then we could start moving towards a license on the free product
> that was less restrictive.  What that would mean is that the BK you have
> is basically it, we'd not advance it other than keeping it up to date
> with the protocol and/or file formats of the commercial version.  If you
> think BK is good enough, fast enough, done enough that you don't want
> what we have coming down the pike we can go that route.
>
> I suspect that the heavy lifters really would like a faster BK with more
> features that help them get their job done but the rank and file could
> care less, they just want checkin/checkout.
> --
> ---
> Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
