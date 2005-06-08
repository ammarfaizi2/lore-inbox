Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVFHV0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVFHV0o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 17:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261799AbVFHV0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 17:26:44 -0400
Received: from polyester.arl.wustl.edu ([128.252.153.32]:27850 "EHLO
	polyester.arl.wustl.edu") by vger.kernel.org with ESMTP
	id S261791AbVFHV0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 17:26:42 -0400
Date: Wed, 8 Jun 2005 16:26:33 -0500 (CDT)
From: Manfred Georg <mgeorg@arl.wustl.edu>
To: Alexander Nyberg <alexn@telia.com>
cc: gregkh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capabilities not inherited
In-Reply-To: <1118263314.969.3.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0506081612490.11409@polyester.arl.wustl.edu>
References: <Pine.GSO.4.58.0506081513340.22095@chewbacca.arl.wustl.edu>
 <1118263314.969.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 Jun 2005, Alexander Nyberg wrote:

> ons 2005-06-08 klockan 15:27 -0500 skrev Manfred Georg:
>> I was working with passing capabilities through an exec and it
>> didn't do what I expected it to.  That is, if I set a bit in
>> the inherited capabilities, it is not "inherited" after an
>> exec().  After going through the code many times, and still not
>> understanding it, I hacked together this patch.  It probably
>> has unforseen side effects and there was probably some
>> reason it was not done in the first place.
>
> Please read the thread at
> http://www.ussg.iu.edu/hypermail/linux/kernel/0503.1/1571.html
>
> Basically it says that because a broken interface was accepted from the
> beginning it can't be changed due to the security aspect.

Ok, that's what I figured, however, there seems to be some framework
for configuring different security modules.  Why isn't there one
that enables the non-broken interface?  feature creep?

> The whole thing sucks, sorry.
yep. :(
Especially since the current functionality doesn't make the
system any more secure.

Manfred
