Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261419AbUCZXLs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 18:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUCZXLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 18:11:48 -0500
Received: from smtp-out1.blueyonder.co.uk ([195.188.213.4]:47701 "EHLO
	smtp-out1.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261419AbUCZXLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 18:11:46 -0500
Message-ID: <4064B8B1.6050501@blueyonder.co.uk>
Date: Fri, 26 Mar 2004 23:11:45 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm4
References: <4062E015.2000608@blueyonder.co.uk> <40633278.9060503@blueyonder.co.uk>
In-Reply-To: <40633278.9060503@blueyonder.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Mar 2004 23:11:46.0100 (UTC) FILETIME=[B5926740:01C41387]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same as for -mm3.
SuSE 9.0 x86_64, gcc-3.3.1.
Regards
Sid.

Sid Boyce wrote:

> This doesn't appear to have gotten through to the list. As it builds 
> but doesn't boot fully on the Athlon XP2200+, I started with fresh 
> sources and applied the patches, results the same.
> Regards
> Sid.
>
> Sid Boyce wrote:
>
>>  HOSTCC  usr/gen_init_cpio
>>  CPIO    usr/initramfs_data.cpio
>>  GZIP    usr/initramfs_data.cpio.gz
>>  AS      usr/initramfs_data.o
>>  LD      usr/built-in.o
>>  CC      arch/x86_64/kernel/process.o
>>  CC      arch/x86_64/kernel/semaphore.o
>>  CC      arch/x86_64/kernel/signal.o
>> arch/x86_64/kernel/signal.c: In function `do_signal':
>> arch/x86_64/kernel/signal.c:426: warning: passing arg 2 of 
>> `get_signal_to_deliver' from incompatible poi
>> nter type
>> arch/x86_64/kernel/signal.c:426: error: too few arguments to function 
>> `get_signal_to_deliver'
>> make[1]: *** [arch/x86_64/kernel/signal.o] Error 1
>> make: *** [arch/x86_64/kernel] Error 2
>> Regards
>> Sid.
>>
>
>


-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
Linux Only Shop.

