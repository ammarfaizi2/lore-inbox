Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130076AbQLWOnt>; Sat, 23 Dec 2000 09:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130142AbQLWOnk>; Sat, 23 Dec 2000 09:43:40 -0500
Received: from coruscant.franken.de ([193.174.159.226]:51973 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S130076AbQLWOnW>; Sat, 23 Dec 2000 09:43:22 -0500
Date: Sat, 23 Dec 2000 15:10:43 +0100
From: Harald Welte <laforge@gnumonks.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Rohloff <lundril@gmx.net>
Subject: Re: A way to crash an 2.4-test11 kernel
Message-ID: <20001223151043.X5858@coruscant.gnumonks.org>
In-Reply-To: <20001219032531.A1922@flashline.chipnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001219032531.A1922@flashline.chipnet>; from lundril@gmx.net on Tue, Dec 19, 2000 at 03:25:31AM +0000
X-Operating-System: 2.4.0-test11p4
X-Date: Today is Prickle-Prickle, the 62nd day of The Aftermath in the YOLD 3166
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2000 at 03:25:31AM +0000, Ingo Rohloff wrote:
> Hi,
> 
> I found a way to crash an SMP 2.4-test11 kernel:
> 
> 1. Create a BIG file (lets say about 300-400 MByte)
> 2. use losetup and the loop device to create an
>    ext2 filesystem within the file
> 3. mount the file
> 4. copy huge amounts of data into the file.
>    (for example copy your /usr directory into it.)
> 
> -> Kernel deadlocks after some time.
> 
> Could someone try to reproduce this behaviour ?

Well... I've once encountered this kind of problem while porting
the kerneli patch (loopback encryption, ...) and thought it is 
a problem of the kerneli patch. I've never thought about the 
possibility that this problem even occurs without encryption.

The other issue is: I wasn't able to reproduce this problem either :(

> so long
>   Ingo

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org                http://www.gnumonks.org
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
