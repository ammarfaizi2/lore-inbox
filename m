Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbVIKSPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbVIKSPh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 14:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbVIKSPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 14:15:37 -0400
Received: from main.gmane.org ([80.91.229.2]:7340 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965002AbVIKSPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 14:15:37 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: Very strange Marvell/Yukon Gigabit NIC networking problems
Date: Mon, 12 Sep 2005 03:12:10 +0900
Message-ID: <dg1s37$kd4$1@sea.gmane.org>
References: <20050901212110.19192.qmail@web53605.mail.yahoo.com> <43244C33.1050502@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050804)
X-Accept-Language: en-us, en
In-Reply-To: <43244C33.1050502@gentoo.org>
X-Enigmail-Version: 0.92.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> Hi,
> 
> Steve Kieu wrote:
> 
>> If run 2.6.13 and up the NIC, it is working. Shuttdown
>> or reboot using /sbin/halt (means power completely off
>> and on) or /sbin/reboot all other OSs failed to enable
>> the NIC except 2.6.13.
>>
>> to restore the normal working of the NIC, boot 2.6.13
>> and do a hot power reset. (press the reset button)
> 
> 
> Stephen recently posted a patch which looks like it might solve this issue.
> 
> Steve, maybe you could test it out? I have attached it to this Gentoo bug:
> 
>     http://bugs.gentoo.org/100258
> 
> Stephen, thanks for your hard work!

I will try this one on a problematic ASUS board than now runs on 
2.11.11 with sk98lin-8.18.2.2.patch

Applied the patch from #100258 to 2.6.13.1 successfully (some lines 
offset) and recompiled. Will try it tomorrow when I am at the machine.

BTW, is this patch submitted to the Linus or -mm tree already?

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

