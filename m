Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131842AbRA3S1p>; Tue, 30 Jan 2001 13:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131891AbRA3S1f>; Tue, 30 Jan 2001 13:27:35 -0500
Received: from chaos.analogic.com ([204.178.40.224]:41600 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S131842AbRA3S1a>; Tue, 30 Jan 2001 13:27:30 -0500
Date: Tue, 30 Jan 2001 13:26:42 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jon Anderson <andersoj@mediaone.net>
cc: Ronald Lembcke <es186@fen-net.de>, linux-kernel@vger.kernel.org
Subject: Re: no boot with 2.4.x
In-Reply-To: <20010130131511.D22358@mediaone.net>
Message-ID: <Pine.LNX.3.95.1010130132123.13778A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001, Jon Anderson wrote:

> 
> After compiling 2.4 and 2.4ac11 I got failed boots as well, getting 
> either 
> 
>   LI
> 
> or 
> 
>   LIL
> 

LILO could not find all of your kernel, probably because you
overwrote it without executing lilo.

It is not sufficient to just copy the boot image to /boot or
wherever your distributor decided to put it. You must re-execute
lilo. Lilo builds a table containing the offsets to each of
the file pieces. When you are booting, there is no file-system
so the boot-loader uses these table entries to assemble the
pieces of linux during the boot.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
