Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161045AbWF0JLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161045AbWF0JLA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 05:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161047AbWF0JLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 05:11:00 -0400
Received: from etna.obsidian.co.za ([196.36.119.67]:62148 "EHLO
	etna.obsidianonline.net") by vger.kernel.org with ESMTP
	id S1161045AbWF0JK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 05:10:59 -0400
Message-ID: <44A0F617.6050106@rootcore.co.za>
Date: Tue, 27 Jun 2006 11:10:47 +0200
From: Charles Majola <chmj@rootcore.co.za>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Ben Martel <benm@symmetric.co.nz>
Cc: Patrick McFarland <diablod3@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
       stephen@blacksapphire.com, kernel list <linux-kernel@vger.kernel.org>,
       radek.stangel@gmsil.com
Subject: Re: IPWireless 3G PCMCIA Network Driver and GPL
References: <20060616094516.GA3432@elf.ucw.cz> <449BEABD.5010305@rootcore.co.za> <1151070837.4549.18.camel@localhost.localdomain> <200606270437.59454.diablod3@gmail.com> <44A0F4CC.2000606@symmetric.co.nz>
In-Reply-To: <44A0F4CC.2000606@symmetric.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Martel wrote:
> Y'all,
>
> I have had a look at the changes to the 2.6.1{6,7} kernel to do with 
> the buffering and I think that this driver will benefit greatly from 
> the changes away from the flip/flop scheme.
>
> When Steve and I originally wrote the driver it always seemed to be 
> limited throughput wise, due to the inefficient char handling it did.
>
> Good luck in the 'hacking it for 2.6.1{6,7} department' let me know if 
> I can help at all :)
>
> BTW: Can someone tell me the version that you are changing - I may 
> have a later version that fixes a problem with the V2 PCMCIA cards 
> from IPWireless/T-Mobile.
>

I have version 1.0.1 - 28 Mar 2004, working with the 2.6.15 kernel, with 
some minor changes I made.

--
chmj

>    ~benm
>
> Patrick McFarland wrote:
>> On Friday 23 June 2006 09:53, Alan Cox wrote:
>>> Ar Gwe, 2006-06-23 am 15:21 +0200, ysgrifennodd Charles Majola:
>>>> Alan, can you please give me pointers on the tty changes since 2.6.12?
>>> The newest kernels have a replacement set of tty receive functions that
>>> use a new buffering system.
>>>
>>> http://kerneltrap.org/node/5473
>>>
>>> covers the changes briefly. The internals of the buffering changes are
>>> quite complex because Paul did some rather neat things with SMP locking
>>> but the API is nice and simple.
>>>
>>> Its fairly easy to express the old API in terms of the new one if you
>>> are doing compat wrappers as well
>>
>> Actually, its rather neat that something as 'simple' as tty still 
>> gets heavily hacked on every once in awhile.
>>
>
>

