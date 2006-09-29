Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWI2Rwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWI2Rwl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 13:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWI2Rwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 13:52:41 -0400
Received: from rtr.ca ([64.26.128.89]:1291 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751186AbWI2Rwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 13:52:40 -0400
Message-ID: <451D5D66.8030501@rtr.ca>
Date: Fri, 29 Sep 2006 13:52:38 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Arrr! Linux 2.6.18
References: <Pine.LNX.4.64.0609192126070.4388@g5.osdl.org>	<451CDBE3.2080707@rtr.ca> <20060929014433.bc01e83c.akpm@osdl.org>
In-Reply-To: <20060929014433.bc01e83c.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 29 Sep 2006 04:40:03 -0400
> Mark Lord <lkml@rtr.ca> wrote:
> 
>> Linus Torvalds wrote:
>>> ..
>>> Cap'n Andrew Morton:
>>>       Blimey! hvc_console suspend fix
>> Mmm.. I wonder if this could be what killed resume-from-RAM
>> on my notebook, between -rc6 and -final ?
>>
>> Andrew, can you send me just that one patch, and I'll try reverting it.
..
> --- a/drivers/char/hvc_console.c~hvc_console-suspend-fix
> +++ a/drivers/char/hvc_console.c

ARrrgyeeematey.. the Adm'rl was right about this,
my kernel doesn't even use that source file.

I'll look through all of the post-rc6 changes and see if anything
else might be a candidate.

Thanks
