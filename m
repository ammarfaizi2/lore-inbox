Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268590AbRG3Otq>; Mon, 30 Jul 2001 10:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268839AbRG3Otg>; Mon, 30 Jul 2001 10:49:36 -0400
Received: from chaos.analogic.com ([204.178.40.224]:5248 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268590AbRG3OtZ>; Mon, 30 Jul 2001 10:49:25 -0400
Date: Mon, 30 Jul 2001 10:48:58 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: kumar M <kumarm4@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: GPL issuefor run time kernel function overwrite
In-Reply-To: <F56FOSPUPeKljq65Rn800008a48@hotmail.com>
Message-ID: <Pine.LNX.3.95.1010730104556.1947A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001, kumar M wrote:

> Hi,
> 
> I have a query regarding the GPL for Linux kernel.
> We were having a heated discussion regarding
> opening up / disclosing  source code for features
> added to  kernel (as per GPL) if we do the following  :
> 
> * We implement a driver which will overwrite any existing
> (global kernel data strcuture) function pointer in linux
> kernel space run-time.
> * No kernel source code is modified in the process.
> 
> regards,
> Kumar
> 

Not only is the wording of GPL, but also its intentions important.
If the intentions of the GPL are to help promote the free flow
of ideas, and to show explicitly how some software is implemented,
then any attempt to obscure, disguise or hide the implementation
details is contrary to its intent.

It is my opinion that any software that is provided without its
source-code is contrary to the intent of GPL. However, I'm sure
that there are lawyers who will disagree.

We already have so-called "proprietary" code being included into
the kernel. This started with "harmless" bits of binary which is
uploaded into the hardware when some drivers are installed.
Including such binary is also contrary to GPL, but without this
secret goo, the hardware won't run.

This exception to GPL, in my opinion, opened the door to future
corruption and exploitation. Time will tell.

Now, if your code attacks and destroys, replaces, or otherwise
modifies a kernel, I think that's fine as long as the source-code
is provided. You can even develop modules that are designed to
do harm.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


