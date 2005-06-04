Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVFDU7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVFDU7m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 16:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbVFDU7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 16:59:41 -0400
Received: from mail.dvmed.net ([216.237.124.58]:58050 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261251AbVFDU7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 16:59:38 -0400
Message-ID: <42A21635.70702@pobox.com>
Date: Sat, 04 Jun 2005 16:59:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12?
References: <42A0D88E.7070406@pobox.com> <20050603233756.GA27081@electric-eye.fr.zoreil.com> <42A167FE.2020008@pobox.com> <20050604113316.GA3883@electric-eye.fr.zoreil.com>
In-Reply-To: <20050604113316.GA3883@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> Jeff Garzik <jgarzik@pobox.com> :
> [...]
> 
>>>Any chance the r8169 queue could be merged in mainline before ?
>>
>>I'll push the length check.
> 
> 
> Cool.
> 
> 
>>Everything else is a new feature.
> 
> 
> Hmmmm... Ok, let's have some r8169 handwaving/advocacy/explanation to
> tell what is going on.
> 
> - From a usability viewpoint, the PCI ID for the USRobotics adapter
>   should be included. It has been reported around 10/04/2005.
>   Consider the usual july/LKS/conf period and it will not be available
>   in a stable serie before september (it is not a bugfix, it will not
>   be in 2.6.12.x either). USR has cut the price: it will have some
>   effect.
> 
> - The new features are not really new:
>   o 03/2005 for Stephen Hemminger's stats + other changes
>     -> it does not collide with existing functions. 
>   o 03/2005 for the message level support
>     -> not new but it will be noticed, yes.
> 
> - Some of the usual suspects on netdev know the code and even if your
>   favorite r8169 maintainer has a real day job like everyone, I usually
>   manage to dig the issues when something hits the fan (no engagement in
>   sight, it helps :o) ).
> 
> Of course, you are free to ignore these points if you already took them
> into consideration.

For Release Candidate I really want to keep things down to 
absolutely-required bug fixes, as 2.6.12 is apparently a week or so 
away.  Standard pragmatism:  anything else just introduces new 
possiblities for new bugs, and increases the time required to review 
each Release Candidate.

	Jeff


