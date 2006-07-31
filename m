Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWGaBa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWGaBa0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 21:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWGaBa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 21:30:26 -0400
Received: from [219.153.9.10] ([219.153.9.10]:19410 "EHLO iblink.com.cn")
	by vger.kernel.org with ESMTP id S964802AbWGaBaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 21:30:25 -0400
Message-ID: <44CD5D2A.1010607@idccenter.cn>
Date: Mon, 31 Jul 2006 09:30:18 +0800
From: kernel <linux@idccenter.cn>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>, jdi@l4x.org
CC: linux-kernel@vger.kernel.org
Subject: Re: XFS Bug null pointer dereference in xfs_free_ag_extent
References: <44BF29CD.1000809@l4x.org> <44CB0BF7.6030204@idccenter.cn> <44CB1303.7010303@l4x.org> <20060731094424.E2280998@wobbly.melbourne.sgi.com>
In-Reply-To: <20060731094424.E2280998@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=GB18030; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My hardware is dell 6650 and a FLX380 SAN storage,connected with a 
qlogic2422 FC card.
The another machine is dell 2850 with the same card.
I can reproduce this error with bonnie++ easily.Espacially bonnie++ 
delete small files and small directories.


Nathan Scott wrote:
> Hi there,
>
> On Sat, Jul 29, 2006 at 09:49:23AM +0200, Jan Dittmer wrote:
>   
>> kernel schrieb:
>>     
>>> I have the same problem, but it seems not have a patch right now.
>>>       
>> No, I got zero feedback, but let's cc the correct
>> mailing list. I also filed bug 6877 at kernel.org
>>
>>     
>
> Is this easily reproducible for you?  I've not seen it before, and
> the only possibly related recent changes I can think of are these:
>
> http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e63a3690013a475746ad2cea998ebb534d825704
>
> http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=d210a28cd851082cec9b282443f8cc0e6fc09830
>
> Could you try reverting each of those to see if either is the cause?
>
> thanks.
>
>   
