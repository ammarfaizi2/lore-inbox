Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbVBPVsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVBPVsd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 16:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVBPVsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 16:48:33 -0500
Received: from [64.4.37.34] ([64.4.37.34]:56495 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S262090AbVBPVsa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 16:48:30 -0500
Message-ID: <BAY10-F340B43C6A61C2D47ECC913D66C0@phx.gbl>
X-Originating-IP: [61.247.245.18]
X-Originating-Email: [agovinda04@hotmail.com]
In-Reply-To: <52vf8sw6no.fsf@topspin.com>
From: "govind raj" <agovinda04@hotmail.com>
To: roland@topspin.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Customized 2.6.10 kernel on a Compact Flash
Date: Thu, 17 Feb 2005 03:17:56 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 16 Feb 2005 21:48:01.0753 (UTC) FILETIME=[2FE82490:01C51471]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all the pointers.

We had taken the /sbin/init from the existing Linux installation from where 
we had created the customized image. We need to have a inittab and we 
believe that we have set it correctly. The GRUB detects the CF hard disk as 
hda0 when we boot the embedded board and so in both the kernel parameter in 
grub.conf as well as in the inittab file we have / (root) marked as 
/dev/hda0. But we are perplexed by the message that the kernel prints out on 
being booted from the flash and just before panic'ing...

------------

hda: max request size: 128KiB

hda: 250368 sectors (128 MB) w/2KiB Cache, CHS=978/8/32

hda: hda1

-----------

in which it prints out hda1 instead of it printing it out as hda0

Also, the same customized image is getting successfully booted from the PC 
from where we are building this image. This panic comes out only when we 
boot this image from the CF on the embedded board.

Regards

Govind

>From: Roland Dreier <roland@topspin.com>
>To: "govind raj" <agovinda04@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: Customized 2.6.10 kernel on a Compact Flash
>Date: Wed, 16 Feb 2005 13:12:43 -0800
>
>     govind> Thanks for your immediate response. We are just having a
>     govind> single partition (hda0) in Compact Flash. We are using
>     govind> /sbin/init as our init process (We have /linuxrc as a soft
>     govind> link to /sbin/init).
>
>OK, but where do you get your /sbin/init executable from?  Do you have
>your inittab set up correctly (if you need one)?  Can you think of
>some reason why your init process is exiting?
>
>  - Roland
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

_________________________________________________________________
MSN Spaces! Your space, your time. http://www.msn.co.in/spaces Your personal 
haven online.

