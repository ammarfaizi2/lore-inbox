Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268139AbRGZPtp>; Thu, 26 Jul 2001 11:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267484AbRGZPth>; Thu, 26 Jul 2001 11:49:37 -0400
Received: from chaos.analogic.com ([204.178.40.224]:47744 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268139AbRGZPtU>; Thu, 26 Jul 2001 11:49:20 -0400
Date: Thu, 26 Jul 2001 11:48:54 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: sentry21@cdslash.net
cc: Dan Podeanu <pdan@spiral.extreme.ro>, linux-kernel@vger.kernel.org
Subject: Re: Weird ext2fs immortal directory bug
In-Reply-To: <Pine.LNX.4.30.0107261136400.18300-100000@spring.webconquest.com>
Message-ID: <Pine.LNX.3.95.1010726114714.17653A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001 sentry21@cdslash.net wrote:

> > > sentry21@Petra:1:/$ sudo rm -rf lost+found/
> > > rm: cannot unlink `lost+found/#3147': Operation not permitted
> > > rm: cannot remove directory `lost+found': Directory not empty
> >
> > Perhaps:
> >
> > debugfs -w <your root filesystem>
> > unlink /lost+found/#3147
> 
> root@Petra:0:~# debugfs -w /
> debugfs 1.22, 22-Jun-2001 for EXT2 FS 0.5b, 95/08/09
> /: Is a directory while opening filesystem
> debugfs:  ^D
> 
> root@Petra:0:~# debugfs -w /dev/hda5
> debugfs 1.22, 22-Jun-2001 for EXT2 FS 0.5b, 95/08/09
> debugfs:  unlink /lost+found/#3147
> debugfs:  ^D
        ^^^^^^^^
> 
How about 'Q' so debugfs gets to write the modifications to the
drive?


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


