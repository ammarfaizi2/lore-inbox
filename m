Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129363AbQKGVHh>; Tue, 7 Nov 2000 16:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129582AbQKGVHU>; Tue, 7 Nov 2000 16:07:20 -0500
Received: from chaos.analogic.com ([204.178.40.224]:5504 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129308AbQKGVHM>; Tue, 7 Nov 2000 16:07:12 -0500
Date: Tue, 7 Nov 2000 16:06:28 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Tim Riker <Tim@Rikers.org>
cc: Jes Sorensen <jes@linuxcare.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux? (was Re: Where did kgcc go in 2.4.0-test10?)
In-Reply-To: <3A086BAB.89A588EB@Rikers.org>
Message-ID: <Pine.LNX.3.95.1001107160112.2416A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2000, Tim Riker wrote:

> Jes,
> 
> Hey how's Itanium been lately?
> 
> As was mentioned before, there are nonproprietary compilers around as
> well that might be good choices. My point is that the ANSI C steering
> committee is probably a more balanced forum to determine C syntax than
> the gcc team. We should adopt c99 syntax where feasible, for example. I
> am not asking anyone to use a proprietary compiler of they do not choose
> to do so.
> 

But we __do__ use c99 syntax wherever possible. However, not all
of the kernel can be written strictly in 'C'. We need to use some
assembly language for the hardware-specific stuff. Gcc provides
those capabilities. We also need to control the alignment of
some structure members because networking, SCSI, and a few other
links to the outside world count on that. Gcc provides this
capability also. It's a damn good tool.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
