Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264983AbTANTeL>; Tue, 14 Jan 2003 14:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265012AbTANTeL>; Tue, 14 Jan 2003 14:34:11 -0500
Received: from chaos.analogic.com ([204.178.40.224]:57222 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264983AbTANTeK> convert rfc822-to-8bit; Tue, 14 Jan 2003 14:34:10 -0500
Date: Tue, 14 Jan 2003 14:43:51 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: DervishD <raul@pleyades.net>
cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
In-Reply-To: <20030114191420.GA162@DervishD>
Message-ID: <Pine.LNX.3.95.1030114143919.13702A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2003, DervishD wrote:

>     Hi Richard :)
> 
> > > libc, but I think that is more on the kernel side, that's why I ask
> > Last time I checked argv[0] was 512 bytes. Many daemons overwrite
> > it with no problem.
> 
>     Any header where I can see the length for argv[0] or is this some
> kind of unoficial standard? Just doing strcpy seems dangerous to me
> (you can read 'paranoid'...).
> 
>     Thanks a lot for your answer, Richard :)
>     Raúl
> 

They need to have space for _POSIX_PATH_MAX (512 bytes), to
claim POSIX compatibility so any POSIX system will have at
least 512 bytes available because the pathname of the executable
normally goes there.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


