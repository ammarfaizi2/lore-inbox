Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbWHFDHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWHFDHx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 23:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWHFDHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 23:07:53 -0400
Received: from [219.153.9.10] ([219.153.9.10]:57272 "EHLO iblink.com.cn")
	by vger.kernel.org with ESMTP id S1751501AbWHFDHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 23:07:53 -0400
Message-ID: <44D55CE8.3090202@idccenter.cn>
Date: Sun, 06 Aug 2006 11:07:20 +0800
From: "Tony.Ho" <linux@idccenter.cn>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3-git3 - XFS - BUG: unable to handle kernel NULL pointer
 dereference at virtual address 00000078
References: <9a8748490608040122l69ff139dtaae27e8981022dae@mail.gmail.com> <20060804200549.A2414667@wobbly.melbourne.sgi.com>
In-Reply-To: <20060804200549.A2414667@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=GB18030; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'vs tested this patch, but the XFS panic is also reproducible, error 
message is same as before.


Nathan Scott wrote:
> On Fri, Aug 04, 2006 at 10:22:21AM +0200, Jesper Juhl wrote:
>   
>> I just hit a BUG that looks XFS related.
>>
>> The machine is running 2.6.18-rc3-git3
>>
>> (more info below the BUG messages)
>>
>>     
>
> Thanks for reporting, Jesper - is it reproducible?  Could you try this
> patch for me?  We had a couple of other reports of this, but the earlier
> reporters have vanished ... could you let me know if this helps?
>
> cheers.
>
>   
