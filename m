Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262483AbUKDWnb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbUKDWnb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 17:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbUKDWlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:41:01 -0500
Received: from alog0209.analogic.com ([208.224.220.224]:3456 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262483AbUKDWjX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 17:39:23 -0500
Date: Thu, 4 Nov 2004 17:38:53 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: Giuseppe Bilotta <bilotta78@hotpop.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.9 won't allow a write to a NTFS file-system.
In-Reply-To: <Pine.LNX.4.60.0411042216340.5130@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.61.0411041721110.9510@chaos.analogic.com>
References: <Pine.LNX.4.61.0411041054370.4818@chaos.analogic.com>
 <MPG.1bf47baa1b621da0989706@news.gmane.org> <Pine.LNX.4.61.0411041158010.5193@chaos.analogic.com>
 <Pine.LNX.4.60.0411042216340.5130@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2004, Anton Altaparmakov wrote:

> On Thu, 4 Nov 2004, linux-os wrote:
>> On Thu, 4 Nov 2004, Giuseppe Bilotta wrote:
>>> linux-os wrote:
>>>>
>>>> Hello anybody maintaining NTFS,
>>>>
>>>> I can't write to a NTFS file-system.
>>>>
>>>> /proc/mounts shows it's mounted RW:
>>>> /dev/sdd1 /mnt ntfs
>>>> rw,uid=0,gid=0,fmask=0177,dmask=077,nls=utf8,errors=continue,mft_zone_multiplier=1
>>>> 0 0
>>>>
>>>> .config shows RW support.
>>>>
>>>> CONFIG_NTFS_FS=m
>>>> # CONFIG_NTFS_DEBUG is not set
>>>> CONFIG_NTFS_RW=y
>>>>
>>>> Errno is 1 (Operation not permitted), even though root.
>>>
>>> What are trying to write? AFAIK, the (new) NTFS module only
>>> allows one kind of writing: overwriting an existing file, as
>>> long as its size doesn't change.
>>
>> Huh? Are we talking about the same thing? I'm talking about
>> the NTFS that Windows/NT and later versions puts on its
>> file-systems. I use an USB external disk with my M$ Laptop
>> and I have always been able to transfer data to/from
>> my machines using that drive. Now I can't. The drive it
>> writable under M$, but I can't even delete anything
>> (no permission for root) under Linux.
>
> You must have had it formatted as VFAT in the past.  There is now way you
> were writing to an NTFS drive from Linux (unless you were using Captive
> NTFS or one of the commercially available drivers).
>
> Best regards,
>
> 	Anton

I thought maybe that was so, so I tried to format it as a
FAT-32 drive and W$ complained that it was too large. So
I thought, I would just partition it, but I never partitioned
it to two logical drives before before so I don't know
what's changed (it's W/2000). Right now, I am partitioning
it to two slices and formatting it with FAT-32.

I've been using this since linux had USB and Firewire
controllers. I really don't know what has changed.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
