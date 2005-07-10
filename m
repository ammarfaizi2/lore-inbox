Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVGJTOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVGJTOy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 15:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVGJTOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 15:14:53 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:50626 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261160AbVGJTOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 15:14:52 -0400
Date: Sun, 10 Jul 2005 21:14:08 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Pekka Enberg <penberg@cs.helsinki.fi>
cc: Bryan Henderson <hbryan@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       bfields@fieldses.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxram@us.ibm.com, mike@waychison.com,
       Miklos Szeredi <miklos@szeredi.hu>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: share/private/slave a subtree - define vs enum
In-Reply-To: <1121019702.20821.17.camel@localhost>
Message-ID: <Pine.LNX.4.61.0507102047380.3728@scrub.home>
References: <OFB01287B5.D35EDB80-ON88257038.005DEE97-88257038.005EDB8B@us.ibm.com>
  <courier.42CEC422.00001C6C@courier.cs.helsinki.fi> 
 <Pine.LNX.4.61.0507082108530.3728@scrub.home>  <1120851221.9655.17.camel@localhost>
  <Pine.LNX.4.61.0507082154090.3728@scrub.home> <1121019702.20821.17.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 10 Jul 2005, Pekka Enberg wrote:

> > The point of a review is to comment on things that _need_ fixing. Less 
> > experienced hackers take this a requirement for their drivers to be 
> > included.
> 
> Hmm. So we disagree on that issue as well. I think the point of review
> is to improve code and help others conform with the existing coding
> style which is why I find it strange that you're suggesting me to limit
> my comments to a subset you agree with.
> 
> Would you please be so kind to define your criteria for things that
> "need fixing" so we could see if can reach some sort of an agreement on
> this. My list is roughly as follows:
> 
>   - Erroneous use of kernel API
>   - Bad coding style
>   - Layering violations
>   - Duplicate code
>   - Hard to read code

I don't generally disagree with that, I just think that defines are not 
part of that list.
Look, it's great that you do reviews, but please keep in mind it's the 
author who has to work with code and he has to be primarily happy with, 
so you don't have to point out every minor issue.
Although it also differs between core and driver code, we don't have to be 
that strict with driver code as longs as it "looks" ok and is otherwise 
correct. The requirements for core kernel code are higher, but even here 
defines are a well accepted language construct.

bye, Roman
