Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRAYXIy>; Thu, 25 Jan 2001 18:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129367AbRAYXIp>; Thu, 25 Jan 2001 18:08:45 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8849 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129143AbRAYXIi>; Thu, 25 Jan 2001 18:08:38 -0500
Date: Thu, 25 Jan 2001 18:08:11 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Post codes during runtime, possibly OT
In-Reply-To: <3A70A989.EAEB7AF9@transmeta.com>
Message-ID: <Pine.LNX.3.95.1010125180648.24692A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2001, H. Peter Anvin wrote:

> Matthew Dharm wrote:
> > 
> > It occurs to me that it might be a good idea to pick a different port for
> > these things.  I know a lot of people who want to use port 80h for
> > debugging data, especially in embedded x86 systems.
> > 
> 
> Find a safe port, make sure it is tested the hell out of, and we'll
> consider it.
> 
> 	-hpa
> 

You could use the DMA scratch register at 0x19. I'm sure Linux doesn't
"save" stuff there when setting up the DMA controller.


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
