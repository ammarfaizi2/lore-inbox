Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315654AbSECTAk>; Fri, 3 May 2002 15:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315655AbSECTAj>; Fri, 3 May 2002 15:00:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:27008 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315654AbSECTAi>; Fri, 3 May 2002 15:00:38 -0400
Date: Fri, 3 May 2002 15:01:48 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Tony Luck <aegl@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Virtual address space exhaustion (was  Discontigmem virt_to_page() )
In-Reply-To: <20020503183701.32163.qmail@web13505.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1020503144728.8291A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 May 2002, Tony Luck wrote:

> Richard B. Johnson wrote:
> > One of the Unix characteristics is that the kernel
> > address space is shared with each of the process
> > address space.
> 
> This hasn't been an absolute requirement. There have
> been 32-bit Unix implementations that gave separate
> 4G address spaces to the kernel and to each user
> process.  The only real downside to this is that
> copyin()/copyout() are more complex. Some processors
> provided special instructions to access user-mode
> addresses from kernel to mitigate this complexity.
> 
> -Tony
> 
Really? The only 32-bit Unix's I've seen the details of
are SCO Unix, Interactive Unix, Linux, and BSD Unix.
The other Unix's I've become familiar are Sun-OS, the
original AT&T(Unix System Labs)/SYS-V and DEC Ultrix.
All these Unix's share user address-space with kernel
address-space. This is supposed to be the very thing
that makes Unix different from other VMS/timeshare
Operating Systems.

I think that if this shared address-space doesn't exist
then you don't have "Unix". You have something (perhaps
better), but it's not Unix. For instance VAX/VMS doesn't
share address space. In fact, the VAX/VMS kernel is, itself,
a process. This means it has its own context. This can
be quite useful.

Would you please tell me what Unix has 32-bit address space
which is not shared with the kernel?

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

