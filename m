Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316021AbSEQM75>; Fri, 17 May 2002 08:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316216AbSEQM74>; Fri, 17 May 2002 08:59:56 -0400
Received: from chaos.analogic.com ([204.178.40.224]:129 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316021AbSEQM7z>; Fri, 17 May 2002 08:59:55 -0400
Date: Fri, 17 May 2002 09:01:01 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Halil Demirezen <halild@bilmuh.ege.edu.tr>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Just an offer
In-Reply-To: <20020517122946.18213.qmail@bilmuh.ege.edu.tr>
Message-ID: <Pine.LNX.3.95.1020517085300.4551A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 May 2002, Halil Demirezen wrote:

> 
> I wonder if there is a way of making the kernel decide
> whether it can boot successfully or not. For example, lets
> think of that i am compiling an update kernel not on the local
> machine but on any other pc using telnet or ssh emulators. And
> eventually it is time to reboot the machine and and run on the new
> kernel. However there has been an error during the compiling. - such
> as misconfiguration. Normally the machine will not boot and halt. So,
> is not there any way to reboot itself from the previous kernel
> after
> some time that it realizes it cannot boot properly. Maybe there is
> such
> a way. But, if not, this is an imaginary. Because i usually see these
> kind of problems ;)
> 
>    Bye.


Initially, I thought this was an dumb question, but it's not! If you
are doing a lot of work on kernels remotely, it just might be a
good reason to configure your remote machine(s) to boot off the network.

Then, since the kernel you are booting is local to your machine,
the boot-server, you can change it at will until you get it right.

The remaining problem is how one trips a reboot if the remote machine
doesn't come up correctly. That problem can be handled by temporarily
changing panic() to a hard reset.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

