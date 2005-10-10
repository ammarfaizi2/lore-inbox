Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbVJJToB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbVJJToB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 15:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbVJJToB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 15:44:01 -0400
Received: from main.gmane.org ([80.91.229.2]:58074 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751182AbVJJToA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 15:44:00 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: [PATCH 1/3] Gujin linux.kgz boot format
Date: Tue, 11 Oct 2005 04:35:06 +0900
Message-ID: <diefs3$v2s$1@sea.gmane.org>
References: <2031.192.168.201.6.1128591983.squirrel@pc300>    <20051007144631.GA1294@elf.ucw.cz>    <2520.192.168.201.6.1128943428.squirrel@pc300>    <20051010115641.GA2983@elf.ucw.cz>    <3125.192.168.201.6.1128949772.squirrel@pc300>    <20051010131925.GA19256@atrey.karlin.mff.cuni.cz> <3768.192.168.201.6.1128954688.squirrel@pc300>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050913)
X-Accept-Language: en-us, en
In-Reply-To: <3768.192.168.201.6.1128954688.squirrel@pc300>
X-Enigmail-Version: 0.92.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Etienne Lorrain wrote:
>>>>It seems to work okay here. Now, rewriting current boot system into C
>>>>may be good goal...
>>>
>>>  At least that is a way which does not involve modifying assembler
>>> files. Slowly everybody switches to the C version which continue
>>> to evolve (i.e. removing old BIOS calls), then the tree under
>>> arch/i386/boot is removed and we can begin to rearrange the mapping
>>> of "struct linux_param".
>>
>>Will your C version work with lilo and grub?
> 
> 
>   Tricky question. In short no, it cannot.

[snip a long explaination of why this is practically impossible]

>  Sorry I cannot be compatible with them, please note that
>  Gujin is also GPL.

So you are saying: "Dump GRUB and lilo, use Gujin!" ??

I don't think anybody will agree with that even if it is a better way in some way.
Until some level of compatibility is guaranteed with the currently de facto loaders, at least I 
cannot support this idea in any way. Discussing that with GRUB and lilo devs, might be an idea, but 
who knows.

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

