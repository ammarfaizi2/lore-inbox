Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbUKHS1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbUKHS1G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 13:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbUKHSZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 13:25:28 -0500
Received: from alog0232.analogic.com ([208.224.220.247]:4992 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261159AbUKHSYq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 13:24:46 -0500
Date: Mon, 8 Nov 2004 12:52:18 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Colin Leroy <colin.lkml@colino.net>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: insmod module-loading errors, Linux-2.6.9
In-Reply-To: <20041108175638.2b3da7b3.colin.lkml@colino.net>
Message-ID: <Pine.LNX.4.61.0411081242240.5779@chaos.analogic.com>
References: <Pine.LNX.4.61.0411081007530.3682@chaos.analogic.com>
 <20041108175638.2b3da7b3.colin.lkml@colino.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2004, Colin Leroy wrote:

> On 08 Nov 2004 at 10h11, linux-os wrote:
>
> Hi,
>
>> Please restore the "-f" parameter passed to insmod. It
>> was there for a very good reason. This allows one
>> who encounters the module-loading error while installing
>> the kernel to force the module loading. In this way, the
>> correct modules are used to generate the new `initrd` image.
>
> Wouldn't using the EXTRAVERSION field save you from such hassles?
>
> -- 
> Colin
>

There are certainly work-arounds for problems that shouldn't
exist at all. So, every time I do something to a kernel, I
have to change whatever the EXTRAVERSION field is?  Then, when
a customer demands that the kernel version be exactly the
same that was shipped with Fedora or whatever, I'm screwed.

They simply should not have removed the "-f" option of
insmod. It's just that simple. This option allowed transient
(possible) incompatibilities so that one could be productive
and not spend a whole day reinstalling from a distribution
CD because the new modules wouldn't work because somebody
decided that their special VERMAGIC_STRING was so ")@*&#$%)"
important that they preempted my work. Don't get me started....

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
