Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268604AbRGYSHV>; Wed, 25 Jul 2001 14:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268605AbRGYSHL>; Wed, 25 Jul 2001 14:07:11 -0400
Received: from chaos.analogic.com ([204.178.40.224]:1664 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268604AbRGYSG5>; Wed, 25 Jul 2001 14:06:57 -0400
Date: Wed, 25 Jul 2001 14:06:47 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "TO. Wilderman Ceren" <wceren@cioh.org.co>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: problems with dmfe.o in 2.4.7 (fwd)
In-Reply-To: <Pine.LNX.4.33L2.0107251238260.7542-100000@sigma.cioh.org.co>
Message-ID: <Pine.LNX.3.95.1010725140313.551A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, 25 Jul 2001, TO. Wilderman Ceren wrote:

> Hello linux.kernel deja newsgroup &  mailing list users!!.
> 
> 
> I have a problem., i compile this morning the kernel 2.4.7, when i
> reboot and load the new compiled bzImage, the module is not loaded by
> insmod., errors found:
> 
> /lib/modules/2.4.7/kernel/drivers/net/dmfe.o: init_module: No such
> device
> Hint: insmod errors can be caused by incorrect module parameters,
> including invalid IO or IRQ parameters
> /lib/modules/2.4.7/kernel/drivers/net/dmfe.o: insmod
> /lib/modules/2.4.7/kernel/drivers/net/dmfe.o failed
> /lib/modules/2.4.7/kernel/drivers/net/dmfe.o: insmod dmfe failed
> 
[SNIPPED...]
In /etc/modules.conf, look at eth0 alias and/or eth1 alias. It
should be the name of the driver you intend to use. You don't
have to reboot for tests, just put the right stuff in and
do your `ifconfig` stuff by hand.

Also, sometime, with your new kernel running, do `depmod -a` this
will update the dependencies.



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


