Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264653AbSLVBjU>; Sat, 21 Dec 2002 20:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264697AbSLVBjU>; Sat, 21 Dec 2002 20:39:20 -0500
Received: from chaos.analogic.com ([204.178.40.224]:42639 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264653AbSLVBjT>; Sat, 21 Dec 2002 20:39:19 -0500
Date: Sat, 21 Dec 2002 20:48:17 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Lists (lst)" <linux@lapd.cj.edu.ro>
cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] Kernel 2.4.20 ...
In-Reply-To: <Pine.LNX.4.43L0.0212211945090.9863-100000@lapd.cj.edu.ro>
Message-ID: <Pine.LNX.3.95.1021221204450.25703A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Dec 2002, Lists (lst) wrote:

> 
> Hi all,
> 
> I receive this oops from the begining of 2.4.19. Now I'm running a 2.4.20 
> in SMP mode. Is there anyone who can tell me what is the problem of my 
> kernel?
> 
> Thank you,
> Cosmin


You are using some module that the linux-2.4.20 developers don't
want you to use. Either it's not been converted to current conventions
or it's proprietary an therefore can't be converted.

To wit:

> EIP:    0010:[<c011f86b>]  Tainted: P
> kernel BUG at /usr/src/linux-2.4.20-SMP/include/asm/spinlock.h:86!


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


