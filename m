Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262478AbTCROw3>; Tue, 18 Mar 2003 09:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262479AbTCROw3>; Tue, 18 Mar 2003 09:52:29 -0500
Received: from chaos.analogic.com ([204.178.40.224]:7814 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S262478AbTCROw2>; Tue, 18 Mar 2003 09:52:28 -0500
Date: Tue, 18 Mar 2003 10:05:18 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Sparks, Jamie" <JAMIE.SPARKS@cubic.com>
cc: DervishD <raul@pleyades.net>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: select() stress
In-Reply-To: <Pine.WNT.4.44.0303180946120.1424-100000@GOLDENEAGLE.gameday2000>
Message-ID: <Pine.LNX.4.53.0303180958320.27113@chaos>
References: <Pine.WNT.4.44.0303180946120.1424-100000@GOLDENEAGLE.gameday2000>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Mar 2003, Sparks, Jamie wrote:

> This message uses a character set that is not supported by the Internet
> Service.  To view the original message content,  open the attached message.
> If the text doesn't display correctly, save the attachment to disk, and then
> open it using a viewer that can display the original character set.
> <<message.txt>>
>

Please don't use that goddam M$ mailer. I can't see what you
wrote without saving to a file, etc. Most use 'pine'  or
something compatible with __text__ !


Anyway you advised to do something like:

	fd = open("/", O_RDONLY);
        close(fd);

        fd is now supposed to contain the largest process fd + 1.
        I don't think this is correct! You can do open thousands
         of fds, ultimately more than the max fd value. It will
        eventually wrap.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

