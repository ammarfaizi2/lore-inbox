Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267595AbUIVUmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267595AbUIVUmp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 16:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267651AbUIVUmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 16:42:44 -0400
Received: from chaos.analogic.com ([204.178.40.224]:25472 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267595AbUIVUmd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 16:42:33 -0400
Date: Wed, 22 Sep 2004 16:42:02 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Dave Aubin <daubin@actuality-systems.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a user space pci rescan method?
In-Reply-To: <E8F8DBCB0468204E856114A2CD20741F2C13D2@mail.local.ActualitySystems.com>
Message-ID: <Pine.LNX.4.53.0409221640550.1479@chaos.analogic.com>
References: <E8F8DBCB0468204E856114A2CD20741F2C13D2@mail.local.ActualitySystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2004, Dave Aubin wrote:

> Hi,
>
>   Is there a user space or perhaps simple kernel module way to
> rescan the pci bus?  I currently have a user mode program modify
> the pci bus, but I can not push the user mode program to the
> bios for reasons I can't get in to.
>   Currently I use this user mode program, then do a big hammer
> approach of a reboot to get the kernel to see the pci device.  Is there
> a nicer way of doing this?  Can someone kindly educate me.
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

