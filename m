Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129595AbQK1JdV>; Tue, 28 Nov 2000 04:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129702AbQK1JdL>; Tue, 28 Nov 2000 04:33:11 -0500
Received: from fw.pvt.cz ([194.149.101.194]:9996 "EHLO fw.pvt.cz")
        by vger.kernel.org with ESMTP id <S129595AbQK1Jc4>;
        Tue, 28 Nov 2000 04:32:56 -0500
Date: Tue, 28 Nov 2000 10:02:47 +0100 (CET)
From: Tom Mraz <t8m@centrum.cz>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Status of the NTFS driver in 2.4.0 kernels?
In-Reply-To: <5.0.2.1.2.20001128084055.042262b0@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.30.0011280954450.16938-100000@p38mraz.cbu.pvt.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's not a real bug. - It's a call to BUG() in ntfs_get_block which is
> there because the function is not actually implemented. - I have only ever
> seen this happen when using midnight commander to browse through an NTFS
> partition. - It seems to never happen if I am just in bash typing away or
> ftp-ing into the machine with the mounted NTFS partitions.
>
> When are you hitting this? - If you are using mc just refrain from using it
> for now for ntfs filesystems and all will be fine.
>
> Anton

I just login and then try to play mp3 file from the mounted NTFS partition
using mpg123 program. I'm calling it directly from bash. It immediately
reports the bug and it's 100% reproducible. I understand that this is due to
unimplemented part of the driver. Will it be implemented someday? Because
I don't use the NTFS partition too often it isn't of too much importance to
me but it would be nice to be able to read it (if I don't convert it to
ext2fs sooner ;-)).

Tomas Mraz

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
