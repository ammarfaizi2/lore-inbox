Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318334AbSHUOaQ>; Wed, 21 Aug 2002 10:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318342AbSHUOaQ>; Wed, 21 Aug 2002 10:30:16 -0400
Received: from chaos.analogic.com ([204.178.40.224]:3460 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318334AbSHUOaP>; Wed, 21 Aug 2002 10:30:15 -0400
Date: Wed, 21 Aug 2002 10:36:13 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: lists@corewars.org
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bad Network SIGIO on Linux-2.4.19
In-Reply-To: <20020821162406.C10368@corewars.org>
Message-ID: <Pine.LNX.3.95.1020821103155.31858B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Aug 2002 lists@corewars.org wrote:

> This is a fix included since 2.4.19-pre5-aa1. 
> 

Well if this is a 'fix' there is a lot of legacy software that
just got broken. It was discovered when the new kernel was booted
on some very reliable file-servers.

> You're assuming that every SIGIO coming your way
> 1) is coming via fd 0
> 2) is a POLL_IN interrupt
> 
> You should either be polling the file descriptor (0) from the signal
> handler, or using SA_SIGINFO (see sigaction(2)) to determine
> which interrupt it is.
> 

I wrote the software to demonstrate the problem, not as an example
of how to poll the keyboard.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

