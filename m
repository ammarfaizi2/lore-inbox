Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267175AbTAUSt0>; Tue, 21 Jan 2003 13:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267176AbTAUSt0>; Tue, 21 Jan 2003 13:49:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:9102 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267175AbTAUStY>; Tue, 21 Jan 2003 13:49:24 -0500
Date: Tue, 21 Jan 2003 14:01:14 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Electroniks New <elektr_new@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Bios interrupts
In-Reply-To: <20030121184202.44314.qmail@web14705.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1030121135642.22169A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2003, Electroniks New wrote:

> Hi,
>   1) i don't exactly understand the ports (Bios data).
>    I also understand that linux does override the bios
>    functions so that more functionality is acheived.
> 
>   2) Can you send the standard ports for use and i may
> later use inb and 
>      oub on  those ports for data exchange.
>
>   3) Also what does jmp short $+2 instruction do ?How
> can i change it into   AT&T syntax or inline assembly
> ? Also what does instruction "in al,64h" do .
>    I found these on the net.They are dos code i
> assume. Is "in" same as mov .
[SNIPPED...]

Linux is an operating system that does all that stuff for you.
In fact, it prevents user code from touching hardware ar all.
If you learn the Unix/Posix stuff, you will never have to play
with assembly language again.

Linux operates all of the standard PC hardware in a standard
way that allows programs to use open()/close()/read()/write()/
and ioctl() to "talk" to hardware in a standard high-efficiency
way. If you have additional hardware that Linux doesn't "know"
about, then you can write a device-driver (module) for it.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


