Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261376AbSJPUsi>; Wed, 16 Oct 2002 16:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261386AbSJPUsi>; Wed, 16 Oct 2002 16:48:38 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:56229 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261376AbSJPUsh>;
	Wed, 16 Oct 2002 16:48:37 -0400
Message-ID: <3DADD1F1.2030103@us.ibm.com>
Date: Wed, 16 Oct 2002 13:54:09 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: (2.5.43mm1) Unable to handle kernel paging request
References: <20021016220921.A16005@jaquet.dk> <3DADCEFC.7C17B1CC@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Rasmus Andersen wrote:
> 
>>Hi,
>>
>>Booting 2.5.43mm1, I get the following oops:
>>
>>Unable to handle kernel paging request at virtual address 00002004
>> printing eip:
>>c01a1ddd
>>*pde = 00000000
>>Oops: 0002
>>3c59x ide-scsi ide-cd rtc
>>CPU:    0
>>EIP:    0060:[<c01a1ddd>]    Not tainted
>>EFLAGS: 00010246
>>EIP is at nfs_proc_fsinfo+0x6d/0x110
> 
> Does it happen on 2.5.43?

I've been getting some strange NFS oopses too.  I haven't bothered to 
catch them yet, but they happen without the -mm changesets for me.

-- 
Dave Hansen
haveblue@us.ibm.com

