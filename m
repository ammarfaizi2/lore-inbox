Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262447AbVCIUp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbVCIUp7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 15:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVCIUoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 15:44:13 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:64143 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262447AbVCIUeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:34:25 -0500
Message-ID: <422F5DCD.3020700@mesatop.com>
Date: Wed, 09 Mar 2005 13:34:21 -0700
From: Steven Cole <elenstev@mesatop.com>
User-Agent: Thunderbird 1.0 (Multics)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Jeff Garzik <jgarzik@pobox.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: current linus bk, error mounting root
References: <9e47339105030909031486744f@mail.gmail.com>	 <422F2F7C.3010605@pobox.com> <9e4733910503091023474eb377@mail.gmail.com>
In-Reply-To: <9e4733910503091023474eb377@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On Wed, 09 Mar 2005 12:16:44 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>Jon Smirl wrote:
>>
>>>Something in the last 24hrs in linus bk broke my ability to mount root:
>>>
>>>Creating root device
>>>Mounting root filesystem
>>>mount: error 6 mounting ext3
>>>mount: error 2 mounting none
>>>Switching to new root
>>>Switchroot: mount failed 22
>>>umount /initrd/dev failed: 2
>>>
>>>If I back off a day everything works again.
>>>
>>>Root is on Intel ICH5 SATA drive.
>>
>>dmesg output?
>>
>>Can you verify that -bk4 works, and -bk5 breaks?
> 
> 
> bk4 works. I don't have a serial port hooked up so there is no way to
> get dmesg, but I don't see anything obvious on the screen scrolling
> by.
> 
> I'll check bk5 next.
> 
> It would be much more convenient if the bkN releases were tagged in Linus bk.

Yes, and name them -preN instead. ;)

I had a slightly different problem mounting root with an earlier -mm, which
was fixed by setting CONFIG_BASE_FULL=y.  I saw that option enter the
Linus tree recently, so that might be something you could try.

Steven
