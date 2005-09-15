Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbVIOCEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbVIOCEI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 22:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030336AbVIOCEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 22:04:08 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:63657 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S1030334AbVIOCEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 22:04:07 -0400
Date: Wed, 14 Sep 2005 19:03:54 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Hua Zhong <hzhong@gmail.com>
cc: marekw1977@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: Automatic Configuration of a Kernel
In-Reply-To: <924c288305091417375fea4ec2@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0509141900280.8469@qynat.qvtvafvgr.pbz>
References: <20050914223836.53814.qmail@web51011.mail.yahoo.com><6bffcb0e05091415533d563c5a@mail.gmail.com><4328B710.5080503@in.tum.de><200509151009.59981.marekw1977@yahoo.com.au>
 <924c288305091417375fea4ec2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

another advantage of having an auto-config for the kernel is that people 
who are experimenting may have the auto-config find hardware that they 
didn't realize they had (or they didn't realize that support had been 
added)

I know that most of my kernels don't have support for everything the 
motherboards have on them (mostly I don't care much about the other 
features, but in some cases they weren't supported, or weren't worth the 
hassle of figureing the correct config for when I started, and I've never 
gone back to try and figure it out)

and while I'm not a kernel hacker, I've been compiling my own kernels 
since about '94 so I'm not exactly a newbe :-)

David Lang

  On Wed, 14 Sep 2005, Hua Zhong wrote:

> Date: Wed, 14 Sep 2005 17:37:41 -0700
> From: Hua Zhong <hzhong@gmail.com>
> To: marekw1977@yahoo.com.au
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Automatic Configuration of a Kernel
> 
> I concur.
>
> There seems to be a trend that discourages normal users from running
> kernel.org kernels, but I rarely find myself agree with such mind set.
> Do we want more people to test vanilla kernels or not?
>
> On 9/14/05, Marek W <marekw1977@yahoo.com.au> wrote:
>> On Thu, 15 Sep 2005 09:49, Daniel Thaler wrote:
>>> Michal Piotrowski wrote:
>>>> Hi,
>>>>
>>>> On 15/09/05, Ahmad Reza Cheraghi <a_r_cheraghi@yahoo.com> wrote:
>>>>> Hi
>>>>>
>>>>> I wrote this Framework for making a .config based on
>>>>> the System Hardwares. It would be a great help if some
>>>>> people would give me their opinion about it.
>>>>>
>>>>> Regards
>>>>
>>>> It's for new linux users? They should use distributions kernels.
>>>> It's for "power users"? They just do make menuconfig...
>>>> It's for kernel developers? They just do vi .config.
>>>
>>> I like the idea.
>>> I'm a power user and of course I can do make menuconfig, but it would be
>>> useful when building a kernel for new hardware for example.
>>>
>>> Currently that involves looking at dmesg output to figure out the correct
>>> options; this would provide a nice base config to work with and reduce the
>>> amount of effort.
>>
>> I second that. Unlike majority of users I suppose, I upgrade the kernel often
>> and I am on the bleeding edge (laptop user with some drivers still being in
>> development). Even with oldconfig it's easy to miss a useful driver
>> (sometimes there's no help or the volume of new options is too large).
>>
>> Something that can do the hardware detection, then maps that to drivers would
>> be very useful.
>>
>>
>> --
>>
>> Marek W
>> Send instant messages to your online friends http://au.messenger.yahoo.com
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
