Return-Path: <linux-kernel-owner+willy=40w.ods.org-S381983AbUKBIRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S381983AbUKBIRu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 03:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S451497AbUKBIRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 03:17:49 -0500
Received: from wasp.net.au ([203.190.192.17]:10419 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S451036AbUKBIRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 03:17:30 -0500
Message-ID: <418742BE.4040200@wasp.net.au>
Date: Tue, 02 Nov 2004 12:18:06 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.8+ (X11/20041029)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc1-bk page allocation failure. order:2, mode:0x20
References: <41873452.8040804@wasp.net.au> <41873F38.7030609@yahoo.com.au>
In-Reply-To: <41873F38.7030609@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Brad Campbell wrote:
> 
>> G'day all,
>>
>> I'm still getting quite a lot of these come up in the logs when the 
>> system is under mild load.
>> I suspect it might have something to do with running an MTU of 9000 on 
>> the main ethernet port which is directly feeding a workstation with an 
>> NFS root (and thus gets quite a high load at times)
>>
>> It's not so much an issue but it does cause the workstation to stall 
>> for up to a second while it waits for data every time it occurs.
>>
>> The loaded ethernet port is this one on an PCI card
>>
>> 0000:00:0d.0 Ethernet controller: Marvell Technology Group Ltd. Yukon 
>> Gigabit Ethernet 10/100/1000Base-T Adapter (rev 12)
>>
>> This started rearing its ugly head when I moved from 2.6.5 to 
>> 2.6.9-preX and persists with BK as of about 2 days ago.
>>
> 
> There are patches in the newest -mm kernels that should help the
> problem. If you're willing to test them, the feedback would be
> welcome.

Always willing to test specific patches. Can I just grab the broken out patches, or pull some 
specific csets from a bk tree? I'm not particularly keen on running an -mm kernel on this box if I 
can avoid it (It's a server in 24hr use with 2.5TB of data where the backup media is 7,000km away).

Regards,
Brad
