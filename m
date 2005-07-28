Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbVG1LSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbVG1LSt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 07:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVG1LSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 07:18:49 -0400
Received: from tornado.reub.net ([202.89.145.182]:46047 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S261205AbVG1LSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 07:18:48 -0400
Message-ID: <42E8BF18.1070607@reub.net>
Date: Thu, 28 Jul 2005 23:18:48 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Mail/News 1.0+ (Windows/20050727)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm2
References: <fa.gdh870p.1pmsr31@ifi.uio.no>	<42E89F4C.5010507@reub.net> <20050728021048.53bf56c9.akpm@osdl.org>
In-Reply-To: <20050728021048.53bf56c9.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/07/2005 9:10 p.m., Andrew Morton wrote:
> Reuben Farrelly <reuben-lkml@reub.net> wrote:
>> On 27/07/2005 9:45 a.m., Andrew Morton wrote:
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm2/
>>>
>>>
>>> - Lots of fixes and updates all over the place.  There are probably over 100
>>>   patches here which need to go into 2.6.13.
>>>
>>> - A reminder that -mm commit activity may be monitored by subscribing to
>>>   the mm-commits list.  Do
>>>
>>> 	echo subscribe mm-commits | mail majordomo@vger.kernel.org
>>>
>> Also seeing this during boot-up:
> 
> This was happening in earlier -mm's was it not?

Hadn't seen it anytime recently..

>> last sysfs file:
> 
> grr, I need to fix that.
> 
>>   [<c0103983>] show_stack+0x94/0xca
>>   [<c0103b37>] show_registers+0x165/0x1f9
>>   [<c0103d5d>] die+0x108/0x183
>>   [<c0318c3a>] do_page_fault+0x1ea/0x63d
>>   [<c0103657>] error_code+0x4f/0x54
>>   [<c018b5c3>] fill_read_buffer+0x2e/0x74
>>   [<c018b6fe>] sysfs_read_file+0x46/0x76
> 
> some dud sysfs file.

Didn't appear after a reboot of 2.6.13-rc3-mm2, and doesn't appear with 
2.6.13-rc3-mm3, so not too sure what to make of it now.  Will see if it 
reappears (box is otherwise stable).

Thanks,
reuben

