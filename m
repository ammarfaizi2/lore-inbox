Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266377AbRHMUCi>; Mon, 13 Aug 2001 16:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266696AbRHMUC1>; Mon, 13 Aug 2001 16:02:27 -0400
Received: from chaos.analogic.com ([204.178.40.224]:21634 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266377AbRHMUCO>; Mon, 13 Aug 2001 16:02:14 -0400
Date: Mon, 13 Aug 2001 16:02:06 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Mircea Ciocan <mirceac@interplus.ro>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Is there something that can be done against this ???
In-Reply-To: <3B7822E5.9AE35D4A@interplus.ro>
Message-ID: <Pine.LNX.3.95.1010813155456.3825A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2001, Mircea Ciocan wrote:

> 	The attached piece of script kiddie shit is the first one that worked
> flawlessly on my Mandrake box :((( ( kernel 2.4.7ac2, glibc-2.2.3 ),
> instant root access !!!.
> 	I was stunned, and it seem that is the beginning of a Linux Code Red
> lookalike worm :(((( using that exploit, probably this is not the most
> apropriate place to send this, but I'm not subscribed to the glibc
> mailing list and I just hope that some glibc hackers are on linux kernel
> list also and they see that and do something before we join the ranks of
> M$.
> 
> 		Dead worried,
> 
> 		Mircea C.
> 

It's a neat trick. It just replaces some 'C' runtime library functions
with do-nothing functions that return success for the user. It could
even replace file I/O stuff so the user changes directory, but what
`ls` shows, never changes (or is blank). A nice preload object library
could be created that could make a good April-fool joke. You've got
about 1/2 year to work on it! Install it in /lib, and when you want
to cause havoc, modify the target's ~/.bashrc file.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


