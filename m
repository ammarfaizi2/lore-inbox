Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbULAPi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbULAPi1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 10:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbULAPi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 10:38:27 -0500
Received: from alog0242.analogic.com ([208.224.222.18]:2176 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261279AbULAPiW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 10:38:22 -0500
Date: Wed, 1 Dec 2004 10:38:04 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: John Que <qwejohn@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: intird.img file missing - cannot boot.
In-Reply-To: <BAY14-F2141AE33478CA464C1B3C7AFBF0@phx.gbl>
Message-ID: <Pine.LNX.4.61.0412011031460.4358@chaos.analogic.com>
References: <BAY14-F2141AE33478CA464C1B3C7AFBF0@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2004, John Que wrote:

> Hello,
>
> I had made some tests with mkinitrd , I deleted /boot/intird-2.6.7.img
> and booted (without renaming the /boot/intird-2.6.7.img.old I have to 
> intird-2.6.7.img).
>
> I use this intird-2.6.7.img image in boot (ext3 is not part of the kernel 
> image).
> (I am working with Fedora with 2.6.7 , and with grub).
>
> So when booting I get the mesages:
> ....
> /intrd/intird-2.6.7.img
> error 15: File Mot Fount
> ...
>
> what should I do ? can I use a Fedora boot diskette and then
> mount the boot partition and rename the file ? (the intird-2.6.7.img.old is , 
> as
> I said,under boot)
> How can I do this mounting?
> (If I remember well , a boot CD like KNPOIX does not have write permissions.)
>
> Regards,
> John
>

When you get to the blue boot screen, just select another boot image
and boot that.

If you have mucked with the original and have no others, boot
from the installation CD. Follow the "repair" prompts. Eventually
your partition will be mounted somewhere and you can fix it.
If you have a seperate /boot partition, just mount that and
rename the file back or edit grub.conf to show the right one
that goes with the right image.

FYI, this is not a kernel problem.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
