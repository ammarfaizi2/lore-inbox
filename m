Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263440AbUDVF6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263440AbUDVF6I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 01:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUDVF6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 01:58:08 -0400
Received: from [61.11.60.89] ([61.11.60.89]:27407 "EHLO
	gateway.prodigylabs.net") by vger.kernel.org with ESMTP
	id S263440AbUDVF6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 01:58:04 -0400
Message-ID: <4087588C.2010303@prodigylabs.com>
Date: Thu, 22 Apr 2004 11:30:52 +0600
From: manu <manu@prodigylabs.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: thanx: Re: booting problem ?
References: <4086424B.9070206@prodigylabs.com> <c66hp3$5sv$1@terminus.zytor.com>
In-Reply-To: <c66hp3$5sv$1@terminus.zytor.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


thanx for ur reply.
if u dont mind u want little more information about the problem.
wht do u mean by legacy floppy drive. if kernel can boot in that why not 
on IDE floppy drive. i think booting process is done by bios program, i 
dont think it depends up on kernel.why i cannot install & boot kernel 
from the compact flash in newer kernels.can u pls give some information 
about this.
-manu



H. Peter Anvin wrote:
The builtin boot sector can only be used to boot from legacy floppy
drives, not even USB or IDE floppy drives. It's use is deprecated
(and removed in 2.6.)
Use a bootloader.
-hpa


>Followup to:  <4086424B.9070206@prodigylabs.com>
>By author:    manu <manu@prodigylabs.com>
>In newsgroup: linux.dev.kernel
>  
>
>>hi all  iam new to this list.
>>i am trying to install the linux without bootloader.
>>i used dd  to write kernel image to /dev/hdc.
>>but when i try to boot from it. it is saying
>> 
>> Loading.
>> 4000
>> AX:0208
>> BX:0200
>> CX:0002
>> DX:0000
>> 4000
>>iam using  2.4.22 kernel.
>>
>>can anybody tell me whts the problem. when i tried same with /dev/fd0 (floppy) it  is booting fine.but i dont know
>>whts the prolem with the compact flash,any ideas.
>>
>>    
>>
>
>  
>


