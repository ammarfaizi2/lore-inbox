Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132052AbQKBOsb>; Thu, 2 Nov 2000 09:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132088AbQKBOsW>; Thu, 2 Nov 2000 09:48:22 -0500
Received: from chaos.analogic.com ([204.178.40.224]:44548 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S132052AbQKBOsK>; Thu, 2 Nov 2000 09:48:10 -0500
Date: Thu, 2 Nov 2000 09:47:45 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Thomas Sailer <sailer@ife.ee.ethz.ch>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Poll and OSS API
In-Reply-To: <3A0179BC.670CEE77@ife.ee.ethz.ch>
Message-ID: <Pine.LNX.3.95.1001102094721.9063A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2000, Thomas Sailer wrote:

> "Richard B. Johnson" wrote:
> 
> > The specification is bogus and should be fixed. select() is not
> 
> Don't tell me, I didn't write that spec.
> 
> > side-affects is patently wrong. ioctl() was designed to control
> > things.
> 
> It already exists, ioctl(fd, SNDCTL_DSP_SETTRIGGER, PCM_ENABLE_INPUT).
> If we officially declare the poll/select side effect to be
> unacceptable, I'm happy with it, as my sound drivers already
> work that way 8-)
> 

Of course!


Cheers,
Dick Johnson

Penguin : Linux version 2.2.17 on an i686 machine (801.18 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
