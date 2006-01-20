Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWATRdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWATRdH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 12:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWATRdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 12:33:07 -0500
Received: from www.clearcore.com ([69.20.152.109]:59831 "EHLO
	sam.clearcore.com") by vger.kernel.org with ESMTP id S1751111AbWATRdF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 12:33:05 -0500
Message-ID: <43D11ED0.4070809@clearcore.com>
Date: Fri, 20 Jan 2006 10:33:04 -0700
From: Joe George <joeg@clearcore.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Michael Loftis <mloftis@wgops.com>,
       James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com> <43D10FF8.8090805@superbug.co.uk> <6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com> <43D1159A.1070904@clearcore.com> <Pine.LNX.4.58.0601200858010.19264@shark.he.net>
In-Reply-To: <Pine.LNX.4.58.0601200858010.19264@shark.he.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Fri, 20 Jan 2006, Joe George wrote:
> 
>> Michael Loftis wrote:
>>>
>>> --On January 20, 2006 4:29:44 PM +0000 James Courtier-Dutton
>>> <James@superbug.co.uk> wrote:
>>>
>>>> It is unclear what you are really ranting about here. The "stable" kernel
>>>> is stable or at least as stable as it is going to be. It is left to
>>>> distros to make it even more stable. The interface to user land has not
>>>> changed.
>>>> If all you are ranting about is the move from devfs to udevd, then all
>>>> the user land tools dealing with them have been updated already.
>>> That's the nail on the head exactly.  Why is this being done in an even
>>> numbered kernel?  This represents an API change that has knock on well
>>> outside of the kernel, and should be done in development releases.  Why
>>> is it LK is the only major project (that I know of) that does this?
>>> This is akin to apache changing the format of httpd.conf and saying in
>>> say 1.3.38 and saying 'well we made the userland tools too.'
>>>
>>>> What is the real specific problem you are having?
>>> Well there's a whole grab bag of them that I'll be getting to over the
>>> next few months, but the most immediate is the fact that I've gotten new
>>> hardware from a venduh that requires me to build a new Debian installer
>>> and new debian kernels.  I also have custom packages that depend on
>>> devfs being there and now it's not.
>>>
>>> Yes I realise this change isn't out of the blue or anything, but it's in
>>> a 'stable' kernel.  Why bother calling 2.6 stable?  We may as well have
>>> stayed at 2.5 if this sort of thing is going to continue to be pulled.
>>>
>> I don't think that kernel developers are calling 2.6 a stable kernel
>> series.  There was an evolution into another development model without
>> a corresponding change in the kernel numbering.  I think the main
>> reason the numbering wasn't changed was that it would break thousands
>> of scripts people are using all over the world.
>>
>> What would be nice is to go, for example, from 2.6.17 to 3.1, 3.2,
>> 3.3, ...  And have what is currently called the stable series start at
>> 3.1.1.  This would make it clear that the 2.4/2.5 way of doing business
>> is over.  Someone would have to decide whether it is worth it to break
>> all the scripts, however.
> 
> The problems AFAICT are:
> 
> 1.  We did (for 2.5/2.4) or would (for 3.3/3.2) spend tons of time
> in backporting new features or drivers from the development tree
> to the stable tree.  The current model saves that duplication
> (or even worse if multiple distros do that same work).
> 
> 2.  If we did have a separate development tree, we would need
> to clone Andrew. 8:)  IMO there aren't a lot of choices for qualified
> tree maintainers, although I'm sure we could find someone if we
> had to.
> 
> Anyway, to summarize, it's about manpower and efficient use of it.
> 

I agree with all that and I would not want to change the way things
work at all.  I just wish that the number could be changed so the
rest of the world would realize it changed and wouldn't keep saying
2.6 is a stable series.

Joe

