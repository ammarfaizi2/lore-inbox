Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbVCIUyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVCIUyn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 15:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbVCIUmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 15:42:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59366 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262396AbVCIUbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:31:37 -0500
Message-ID: <422F5D0E.7020004@pobox.com>
Date: Wed, 09 Mar 2005 15:31:10 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: current linus bk, error mounting root
References: <9e47339105030909031486744f@mail.gmail.com>	 <422F2F7C.3010605@pobox.com> <9e4733910503091023474eb377@mail.gmail.com>
In-Reply-To: <9e4733910503091023474eb377@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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

Well, there are no changes in libata from bk4 to present.  The only 
thing I see in the -bk4-bk5 increment diff that's immediately noticeable 
is the barrier stuff.

	Jeff


