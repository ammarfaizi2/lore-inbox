Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262897AbUJ1Vfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbUJ1Vfp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 17:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262890AbUJ1Vfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 17:35:45 -0400
Received: from [129.105.5.125] ([129.105.5.125]:50071 "EHLO
	delta.ece.northwestern.edu") by vger.kernel.org with ESMTP
	id S263089AbUJ1VTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 17:19:01 -0400
Message-ID: <418162A6.80808@ece.northwestern.edu>
Date: Thu, 28 Oct 2004 16:20:38 -0500
From: Lei Yang <lya755@ece.northwestern.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, kernelnewbies <kernelnewbies@nl.linux.org>
Subject: Re: set blksize of block device
References: <417FE6A8.5090803@ece.northwestern.edu> <41804F04.4000300@ece.northwestern.edu> <418058A8.5080706@ece.northwestern.edu> <200410280911.15756.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200410280911.15756.vda@port.imtp.ilyichevsk.odessa.ua>
X-Enigmail-Version: 0.76.8.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

>On Thursday 28 October 2004 05:25, Lei Yang wrote:
>  
>
>>Or in other words, is there generic routines for block devices such that 
>>we could:
>>
>>get (set) block size of a block device;
>>read an existing block (e.g. block 4);
>>write an existing block (e.g. block 5);
>>    
>>
>
>Can you stick to "reply below quote" style please?
>  
>
OK

>  
>
>>>If nobody could answer this question, what about another one? Is there 
>>>a system call or a kernel interface that would allow me to write a 
>>>      
>>>
>
>Can you use read, write and seek system calls?
>--
>vda
>
>
>  
>
Not really, as I've explained, I want to do all these stuff in kernel 
space. More specifically, I want to write a newbie kernel module. In 
this module, I'll do something with a raw block device (with no 
filesystem). For example, I want to do block I/O operations on ramdisk, 
and I want to set the block size of ramdisk to whatever value I want 
(power of 2 of course).

Any comments?

Thanks,
Lei

