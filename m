Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265900AbUIVV7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUIVV7b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 17:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266189AbUIVV7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 17:59:30 -0400
Received: from mr02.conversent.net ([204.17.65.6]:11698 "EHLO
	mr02.conversent.net") by vger.kernel.org with ESMTP id S265900AbUIVV71 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 17:59:27 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: Is there a user space pci rescan method?
Date: Wed, 22 Sep 2004 17:58:44 -0400
Message-ID: <E8F8DBCB0468204E856114A2CD20741F2C13E1@mail.local.ActualitySystems.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Is there a user space pci rescan method?
thread-index: AcSg5KAIw9ypWN7hRMOjSBP0rLW0XQACnf5g
From: "Dave Aubin" <daubin@actuality-systems.com>
To: <root@chaos.analogic.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lspci shows me that my new pci device is not present.
Scanpci does show the device.  What I'd like to do
Is get the kernel to know about it and then be able to
See it with an lspci.

Can you tell me how with lspci or setpci?

Thanks again,
Dave:) 

-----Original Message-----
From: Richard B. Johnson [mailto:root@chaos.analogic.com] 
Sent: Wednesday, September 22, 2004 4:42 PM
To: Dave Aubin
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a user space pci rescan method?

On Wed, 22 Sep 2004, Dave Aubin wrote:

> Hi,
>
>   Is there a user space or perhaps simple kernel module way to rescan 
> the pci bus?  I currently have a user mode program modify the pci bus,

> but I can not push the user mode program to the bios for reasons I 
> can't get in to.
>   Currently I use this user mode program, then do a big hammer 
> approach of a reboot to get the kernel to see the pci device.  Is 
> there a nicer way of doing this?  Can someone kindly educate me.
>
> Huge Thanks,
> Dave:)
> -

Did you try `setpci` and `lspci`?
You can sometimes get things working without resorting to a boot.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.

