Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267810AbUJRXbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267810AbUJRXbp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 19:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267815AbUJRXbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 19:31:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:18885 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S267810AbUJRXbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 19:31:33 -0400
Message-ID: <41745034.40501@osdl.org>
Date: Mon, 18 Oct 2004 16:22:28 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: OOPS while loading a Linux-2.6.8 module
References: <Pine.LNX.4.61.0410151030490.25333@chaos.analogic.com> <200410161344.26932.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.61.0410180748100.18155@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0410180748100.18155@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Sat, 16 Oct 2004, Denis Vlasenko wrote:
> 
>> On Friday 15 October 2004 17:34, Richard B. Johnson wrote:
>>
>>>
>>> If you were to execute `strip` on a Linux-2.6.8 module,
>>> you can OOPS the kernel. Gotta patch? I'll test immediately.
>>>
>>>
>>> HeavyLink: falsely claims to have parameter shmem
>>> Unable to handle kernel NULL pointer dereference at virtual address 
>>> 00000000
>>>   printing eip:
>>> 00000000
>>> *pde = 07469001
>>> Oops: 0000 [#1]
>>> SMP
>>> Modules linked in: HeavyLink parport_pc lp parport autofs4 rfcomm
>>
>>                     ^^^^^^^^^
>> Is the source of this available anywhere?
>> -- 
>> vda
>>
> 
> Any module does this.  Here's one to experiment with since
> it contains practically nothing....

Yep.  Steve Hemminger posted patches that fix that problem and
they *should* show up in 2.6.10-pre/-rc.

-- 
~Randy
