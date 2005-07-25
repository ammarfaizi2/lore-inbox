Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVGYTBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVGYTBK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 15:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbVGYTBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 15:01:10 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:24079 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261430AbVGYTBJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 15:01:09 -0400
Message-ID: <42E52FD5.7050705@tmr.com>
Date: Mon, 25 Jul 2005 14:30:45 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tony Lindgren <tony@atomide.com>
CC: Pavel Machek <pavel@ucw.cz>, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3 Battery times at 100/250/1000 Hz = Zero difference
References: <20050721200448.5c4a2ea0.lista1@telia.com> <9a8748490507211114227720b0@mail.gmail.com> <20050722144855.GA2036@elf.ucw.cz> <20050722191510.5e120515.voluspa@telia.com> <20050722180236.GA615@atrey.karlin.mff.cuni.cz> <20050722204439.54a63a00.lista1@telia.com> <20050725102103.GG5837@atomide.com>
In-Reply-To: <20050725102103.GG5837@atomide.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Lindgren wrote:
> * Voluspa <lista1@telia.com> [050722 11:46]:
> 
>>On Fri, 22 Jul 2005 20:02:36 +0200 Pavel Machek wrote:
>>
>>>will not help. It seems like your machine is simply not able to do
>>>reasonable powersaving.
>>
>>Digging up this patch from last month regarding C2 on a AMD K7 implies
>>that the whole blame can be put on kernel acpi:
>>
>>http://marc.theaimsgroup.com/?l=linux-kernel&m=111933745131301&w=2
> 
> 
> AFAIK Linux ACPI expects BIOS to contain all the necessary stuff to enable
> C2 and C3. Otherwise they won't get enabled, and you have to create a custom
> module like the amd76x_pm is.

Does that imply that Windows actually has such non-BIOS code, or just 
knows how to find the BIOS code better, or knows how to do other things, 
or ???
> 
> There's been some talk on adding a module to enable C2 and C3 states for
> various chipsets, but nobody seems to have enough time to do it...

I like your first thought better, "Linux ACPI expects BIOS to contain 
all the necessary stuff" I have a bunch of laptops of various ages, and 
I would expect at least the most recent, an ASUS 16??, using a 
"Centrino" chipset, to be supported. It's one of the top few laptopl 
chipsets, and Windows can suspecd it. Can also not only detect but use 
the 1400x1050 screen, but that's another issue :-(

Is it possible that the code to find these capabilities is not fully 
functional? That seems more likely than the system not having the 
capability. NOTE: "seems" as in experienced guess unsupported by other 
relevant information.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

