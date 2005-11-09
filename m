Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030432AbVKIALo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030432AbVKIALo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 19:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030435AbVKIALo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 19:11:44 -0500
Received: from smtp.rdslink.ro ([193.231.236.97]:34531 "EHLO smtp.rdslink.ro")
	by vger.kernel.org with ESMTP id S1030432AbVKIALn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 19:11:43 -0500
X-Mail-Scanner: Scanned by qSheff 1.0 (http://www.enderunix.org/qsheff/)
Date: Wed, 9 Nov 2005 02:11:40 +0200 (EET)
From: caszonyi@rdslink.ro
X-X-Sender: sony@grinch.ro
Reply-To: Calin Szonyi <caszonyi@rdslink.ro>
To: jerome lacoste <jerome.lacoste@gmail.com>
cc: Edgar Hucek <hostmaster@ed-soft.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New Linux Development Model
In-Reply-To: <5a2cf1f60511060543m5edc8ba8i920a3005b95a556d@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0511090202030.2383@grinch.ro>
References: <436C7E77.3080601@ed-soft.at>  <20051105122958.7a2cd8c6.khali@linux-fr.org>
  <436CB162.5070100@ed-soft.at>  <5a2cf1f60511060252t55e1a058o528700ea69826965@mail.gmail.com>
  <436DEEFC.4020301@ed-soft.at> <5a2cf1f60511060543m5edc8ba8i920a3005b95a556d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Nov 2005, jerome lacoste wrote:

> On 11/6/05, Edgar Hucek <hostmaster@ed-soft.at> wrote:
>> jerome lacoste wrote:
> [...]
>>> I will ask you just one question: as a user, why did you want to
>>> upgrade your kernel?
>>>
>>>
>> Depends on the user and what he wants to do. There are several
>> reasons why a user wanna upgrade to new kernel. Maybe new supported
>> hardware and so on. It's frustrating for the user, have on the one side the
>> new hardware supported but on the other side, mybe broken support for
>> the existing hardware.
>
> New kernel feature and new supported hardware would be the only reason
> for me to upgrade. Personally that doesn't come that often. My
> hardware configurations don't change that much. I make sure it's well
> supported, not just recently. When one buys a non supported hardware,
> one should know the path chosen won't be the easiest.
>

There are other reasons for using a new kernel. One of them is 
interactivity. In the days of 2.4 one could achieve decent interactivity 
for the desktop using preempt and low latency patches. For 2.6 
interactivity was a real issue (possibly because of the new development 
model).

>> And why should dirstribution makers always backport new security fixes ?
>
> Because they want to ensure maximum stability. That's what users are
> (sometimes) paying for.
>

Maximum stability of what ? If the distribution kernels are based on 
vanila kernel (i.e. are based on unstable kernel) how stable will they be 
?
  On lkml someone said that "stable means it won't crash very often".
This sounds like Windows(TM)

> And second 90% of the security issues will not affect the majority of
> the home users (because they are restricted to a particular area of
> the kernel not affecting the user, or because they already require
> access on the machine to be exploitable). You will have much more
> risks using a box with an unpatched php or apache than with an
> unpached kernel, or without a proper firewall configuration.
>

Some holes are remote ;-)

>>> On a desktop, there are probably a bunch of out of kernel modules that will need
>>> upgrading with each new kernel modules. Just on the laptop I am using
>>> right now, I will have to upgrade the vmware bridge, nvidia driver,
>>> madwifi wireless driver, etc. And that's normal. The new development
>>> model didn't change that.
>>>
>>>
>>  From my point of view, it makes a difference if i have to recompile
>> a module or realy upgrade it.
>
> That only happens for out ot tree modules, which shouldn't be really
> out of tree in the first place. That's the issue. If they are out of
> tree, it's for a reason. Either they cannot be in tree, or they are
> not stable enough.
>
> There you see the issue.
>
>> [...]
>> cu
>>
>> ED.
>
> Jerome

Calin

--


