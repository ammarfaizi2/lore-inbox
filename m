Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316113AbSGASdK>; Mon, 1 Jul 2002 14:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316127AbSGASdJ>; Mon, 1 Jul 2002 14:33:09 -0400
Received: from chaos.analogic.com ([204.178.40.224]:39809 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316113AbSGASdI>; Mon, 1 Jul 2002 14:33:08 -0400
Date: Mon, 1 Jul 2002 14:35:18 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] Module removal
In-Reply-To: <Pine.LNX.3.96.1020701133907.23769A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.3.95.1020701142201.21922A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2002, Bill Davidsen wrote:

> Having read some notes on the Ottawa Kernel Summit, I'd like to offer some
> comments on points raied.
> 
> The suggestion was made that kernel module removal be depreciated or
> removed. I'd like to note that there are two common uses for this
> capability, and the problems addressed by module removal should be kept in
> mind. These are in addition to the PCMCIA issue raised.
> 

One of the best features of Linux is the ability to install and remove
modules. With this capability, designing drivers in Linux is much easier
than, for instance, Sun or NT. With Linux, one can make and test
individual portions of drivers much like writing and testing individual
procedures for user-mode code. As long as the programmer doesn't do
something that destroys the kernel, one can remove, code more, install,
then continue until done.

If the ability to remove modules is eliminated, we are degenerating
the kernel. I would have to write code that assumes that everything
works, i.e., a complete module, then throw it off the cliff to see if
it flies. I know this is the way many of the recent grads do it, but
they get promoted to management long before their code is tested and
I end up having to fix their stuff. So please don't eliminate module-
removal capability.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

