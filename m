Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWHPTP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWHPTP4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 15:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWHPTP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 15:15:56 -0400
Received: from post-25.mail.nl.demon.net ([194.159.73.195]:15299 "EHLO
	post-25.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S1750916AbWHPTPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 15:15:54 -0400
Message-ID: <44E36F5B.905@rebelhomicide.demon.nl>
Date: Wed, 16 Aug 2006 21:17:47 +0200
From: Michiel de Boer <x@rebelhomicide.demon.nl>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Milton Mobley <miltmobley@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: need source for lspci, lsusb, etc.
References: <af203d350608152014i475899cet53d21e07db42d4a2@mail.gmail.com>	 <44E29546.904@rebelhomicide.demon.nl> <af203d350608161137l7b0b1e74i94c4480aecbd4f3d@mail.gmail.com>
In-Reply-To: <af203d350608161137l7b0b1e74i94c4480aecbd4f3d@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Milton Mobley wrote:
> Thanks for your suggestions. My Linux computers are not connected to 
> the net,
> so I am focussing on getting tarballs which I can then move from
> Windows to Linux
>
> On 8/15/06, x@rebelhomicide.demon.nl <x@rebelhomicide.demon.nl> wrote:
>> Milton Mobley wrote:
>> > Hi, I am building kernels from kernel.org sources, and am having 
>> problems
>> > detecting certain pci and usb devices (I didn't change the kernel code
>> > much yet).
>> > Where can I find the sources for programs that live in /sbin,
>> > /usr/sbin, etc.,
>> > especially lspci, lsusb, lsmod?
>> > -
>> > To unsubscribe from this list: send the line "unsubscribe
>> > linux-kernel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> > Please read the FAQ at  http://www.tux.org/lkml/
>> >
>> Milton, your distribution of Linux should provide those.
>> For Debian Linux for example, you'd do:
>>
>> $ dpkg -S lspci
>> pciutils: /usr/bin/lspci
>>
>> ..and you note that lspci is in the 'pciutils' package.
>> You could then do as follows:
>>
>> $ apt-get update
>> ....
>> $ apt-get source pciutils
>>
>> The source would be downloaded and unpacked in the current working
>> directory.
>>
>> Regards, Michiel de Boer
>>
>
In that case, google for:
source pciutils
source usbutils
source module-init-tools

You should get your hands on a tarball quickly.

Regards, Michiel de Boer

PS:
two tips:
- use "reply to all" when you reply to a message in the lkml
- when you quote previous discussion, place your answer below the quote, 
instead of above ;)
These things are common courtesy & practice on the lkml.
(see: http://kernel.org/pub/linux/docs/lkml/ for reference)
