Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbVLMTtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbVLMTtN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 14:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbVLMTtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 14:49:13 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:36173 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932460AbVLMTtM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 14:49:12 -0500
Message-ID: <4395EE00.6020607@tmr.com>
Date: Tue, 06 Dec 2005 15:01:04 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <matthias.andree@gmx.de> <200512040106.jB415cqb023723@pincoya.inf.utfsm.cl>
In-Reply-To: <200512040106.jB415cqb023723@pincoya.inf.utfsm.cl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> Matthias Andree <matthias.andree@gmx.de> wrote:
> 
>>On Sat, 03 Dec 2005, David Ranson wrote:
>>
>>>Adrian Bunk wrote:
>>>
>>>
>>>>- support for ipfwadm and ipchains was removed during 2.6
> 
> 
>>>Surely this one had loads of notice though? I was using iptables with
>>>2.4 kernels.
> 
> 
> Sure had. They were scheduled for removal in march, 2005 a long time ago.
> 
> 
>>So was I. And now what? ipfwadm and ipchains should have been removed
>>from 2.6.0 if 2.6.0 was not to support these.
> 
> 
> Or in 2.6.10, or 2.6.27, or whatever.
> 
> 
>>                                              That opportunity was
>>missed, the removal wasn't made up for in 2.6.1, so the stuff has to
>>stick until 2.8.0.
> 
> 
> Sorry, but the new development model is that there is no "uneven" series
> anymore. Sure, it /might/ open for worldshattering changes, but nothing of
> that sort is remotely in sight right now, so...
> 
> 
>>>>- devfs support was removed during 2.6
>>>
>>>Did this affect many 'real' users?
> 
> 
>>This doesn't matter. A kernel that calls itself stable CAN NOT remove
>>features unless they had been critically broken from the beginning. And
>>this level of breakage is a moot point, so removal is not justified.
> 
> 
> devfs was broken, and very little used.

Perhaps there is a cause and effect relationship? If devfs worked I 
don't see the need for every distro to have it's own udev (or mdev or 
sdev or whatever the flavor is this month).
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

