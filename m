Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284246AbRLFUp0>; Thu, 6 Dec 2001 15:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284211AbRLFUpR>; Thu, 6 Dec 2001 15:45:17 -0500
Received: from chaos.analogic.com ([204.178.40.224]:49282 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S284245AbRLFUny>; Thu, 6 Dec 2001 15:43:54 -0500
Date: Thu, 6 Dec 2001 15:43:45 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Sebastian Roth <xsebbi@gmx.de>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: spurious interrupt with 2.4.10 and higher ?
In-Reply-To: <200112062048.45316@xsebbi.de>
Message-ID: <Pine.LNX.3.95.1011206153911.26428A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001, Sebastian Roth wrote:

> hi all!
> 
> For a long time, I receive at boot time (and in /var/log/warn) the following 
> message from the kernel:
> 
> Spurious 8259A interrupt: IRQ7
> 
> Could you tell me please, what is it? My System works fine but I hate this 
> message. :-)

I don't have your version of source here at the moment. If it was
2.4.1, you just comment out line 321 of ../linux/arch/i386/kernel/i8259.c
and re-compile, re-install. That gets rid of the message.

FYI, unless you get a burst of these things, they are harmless.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


