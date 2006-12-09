Return-Path: <linux-kernel-owner+w=401wt.eu-S936563AbWLIJRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936563AbWLIJRB (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 04:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936564AbWLIJRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 04:17:01 -0500
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:1512 "EHLO
	anchor-post-35.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S936563AbWLIJRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 04:17:00 -0500
Message-ID: <457A7F13.6050002@ufomechanic.net>
Date: Sat, 09 Dec 2006 09:17:07 +0000
From: Amin Azez <azez@ufomechanic.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
CC: linux-kernel@vger.kernel.org, Michael.ODonnell@stratus.com,
       NetDEV list <netdev@vger.kernel.org>,
       Auke Kok <auke-jan.h.kok@intel.com>
Subject: Re: e100 breakage located
References: <45641A4E.6020505@ufomechanic.net> <4807377b0611301134q33d1cd78l5a1f2eda33da21bc@mail.gmail.com>
In-Reply-To: <4807377b0611301134q33d1cd78l5a1f2eda33da21bc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Brandeburg wrote:
> sorry for the delay, your mail got marked as spam.  In the future
> please copy networking issues to netdev@vger.kernel.org, and be sure
> to copy the maintainers of the driver you're having problems with
> (they are in the MAINTAINERS file)
>
> On 11/22/06, Amin Azez <azez@ufomechanic.net> wrote:
>> I notice a patch in 2005 from Micahel O'Donnel to the e100.c driver has
>> stopped auto-crossover working on some e100 devices we use.
>>
>> On one system the auto-negotiation was restored by commenting out:
>> (nic->mac == mac_82551_10) in function e100_phy_init where the MDI/MDI-X
>> is disabled.
>
> are you sure that patch did that?  What version of e100 are you using?
> we've since enabled MDI-X on most parts with this patch:
> http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=60ffa478759f39a2eb3be1ed179bc3764804b2c8;hp=09e590e5d5a93f2eaa748a89c623258e6bad1648 
>
>
> Please try the latest kernel or the latest e100 available from 
> e1000.sf.net
> if that doesn't work we'll need to know what kernel are you using?
Let me have another check and get back to you.

It will be at least a week though.

Thanks for your response.

Sam
