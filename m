Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271349AbRHXQeT>; Fri, 24 Aug 2001 12:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272245AbRHXQeJ>; Fri, 24 Aug 2001 12:34:09 -0400
Received: from james.kalifornia.com ([208.179.59.2]:45669 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S271349AbRHXQdt>; Fri, 24 Aug 2001 12:33:49 -0400
Message-ID: <3B8681FB.40403@blue-labs.org>
Date: Fri, 24 Aug 2001 12:34:03 -0400
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010823
X-Accept-Language: en-us
MIME-Version: 1.0
To: Brian Strand <bstrand@switchmanagement.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3ware: no cards found in 2.2.19, cards found in 2.4.x
In-Reply-To: <3B85E7E2.7000602@switchmanagement.com> <3B85FBC6.3080305@blue-labs.org> <3B867C6A.4000700@switchmanagement.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both of these address the VM issues.  I won't say VM is perfect, but you 
can't know if it works better for you like it does for me until you try 
it.  Upgrading a kernel is a pretty quick and painless job.  As to the 
corruption, I don't see enough below to make a start as to the cause.

David

Brian Strand wrote:

> Do either of these kernels fix the "2.4.x VM suckage" problems?  I 
> don't want to use a 2.4.x kernel because Oracle runs almost 2x slower 
> (with identical hardware config) on 2.4.4 and 2.4.6 versus 2.2.16 (and 
> I have 4G of swap for 2G of physical mem, so that is not the problem), 
> not to mention that one of these 2.4.x kernels caused Oracle 
> corruption.  I don't feel so comfortable testing new kernels with 
> several hundred GBs of customer data anymore :) .
>
> David Ford wrote:
>
>> I first suggest that you try kernel 2.4.9 or the latest of 2.4.8-acN.
>>
>> David
>>
>> Brian Strand wrote:
>>
>>> I have a quad xeon 2GB system running Oracle which I am reverting to 
>>> 2.2.x because of 2.4.x's less than desirable VM performance (causing 
>>> a 2x Oracle slowdown, reported about a month ago on linux-kernel).  
>>> I foolishly put a 3ware card in at the same time as I "upgraded" the 
>>> box to 2.4.4, so now I am in the undesirable position of needing to 
>>> go back to 2.2.19, but that kernel cannot find the card.  I get the 
>>> following message during boot:
>>>
>>> 3w-xxxx: tw_find_cards(): No cards found
>>> /lib/moduless/2.2.19-2GB-SMP/scsi/3w-xxxx.o: init_module: Device or 
>>> resource busy
>>>
>>> I have tried compiling the 3ware driver version 
>>> 1.02.00.{004,006,007} all with the same result.  Has anyone managed 
>>> to use a Suse 2.2.19 kernel with 3ware cards with any success?  The 
>>> 1.02.00.004 driver is from the stock 2.2.19 kernel, the .006 driver 
>>> is from 3ware's website, and the .007 driver is from 2.2.20pre9.
>>
>>



