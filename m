Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290773AbSARSOh>; Fri, 18 Jan 2002 13:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290774AbSARSO3>; Fri, 18 Jan 2002 13:14:29 -0500
Received: from chaos.analogic.com ([204.178.40.224]:14208 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S290773AbSARSOY>; Fri, 18 Jan 2002 13:14:24 -0500
Date: Fri, 18 Jan 2002 13:15:01 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Brian Gerst <bgerst@didntduck.org>
cc: Raman S <raman_s_@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: int 0x40
In-Reply-To: <3C485FB5.FC5CB8C3@didntduck.org>
Message-ID: <Pine.LNX.3.95.1020118131406.1503A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002, Brian Gerst wrote:

> Raman S wrote:
> > 
> > Hi,
> >   I relatively new to the kernel and am trying to understand how the linux
> > kernel handles interrupts. For this I attempted to

[SNIPPED...]
> 
> The IRQ setup code is probably overwriting it.  You'll need to make the
> code in i8259.c skip over vector 0x40 as well as SYSCALL_VECTOR (0x80).
> 
> --
> 
> 				Brian Gerst

Yes. It looks like this is what is happening.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


