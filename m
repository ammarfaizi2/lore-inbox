Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268787AbTCCUaV>; Mon, 3 Mar 2003 15:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268788AbTCCUaU>; Mon, 3 Mar 2003 15:30:20 -0500
Received: from chaos.analogic.com ([204.178.40.224]:13958 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S268787AbTCCUaR>; Mon, 3 Mar 2003 15:30:17 -0500
Date: Mon, 3 Mar 2003 15:43:27 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Elie <welie@bezeqint.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: wait_on_buffer 
In-Reply-To: <JLEOIKOLJCFPEIJOOOECOEIHCEAA.welie@bezeqint.net>
Message-ID: <Pine.LNX.3.95.1030303153625.24250A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Mar 2003, Elie wrote:

> It has been 40 hours since my post about cp -a hanging on my drive. I
> haven't gotten a response, and I assume based on the traffic on this list, I
> am not going to get one. So I really could use some help, and if anyone can
> help me to get this hard disk to work I would appreiciate it. If there is
> another list I can try for more help please let me know. To sum up, I cp -a
> hangs at random times. ps shows wait_on_buffer on etx3/ get_grequest after I
> reformatted the partitions to ext2. One time the entire system froze. There
> are no errors in any logs. The hd is a Maxtor 91360U4 with 13g. Kernel is
> 2.4-18. Red Hat 8.0.
> 
> The drive worked well on a mac just a few days ago. Formated it for Windows
> and tested copying many files and had no problems. Scandisk reports no
> problems. So it seems to me to be a problem with linux, but I couldn't begin
> to figure what I should do.
> 
> Thanks,
> Elie.
> 
Is it an IDE drive or a SCSI drive? If it's IDE, check out `hdparm`.

In other words, execute:
	man hdparm

There are lots of parameters to be set. Most likely, your drive
defaulted to some DMA setting it really can't handle. Check it out,
first, then contact the Red-Hat people because they got paid for
suppling your distribution. The Linux-kernel list isn't really
the place to inquire so don't be surprised if you are ignored.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


