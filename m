Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132488AbQKSQPw>; Sun, 19 Nov 2000 11:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132564AbQKSQPc>; Sun, 19 Nov 2000 11:15:32 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:39052 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132488AbQKSQPQ>;
	Sun, 19 Nov 2000 11:15:16 -0500
Date: Sun, 19 Nov 2000 10:45:15 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Christer Weinigel <wingel@hog.ctrl-c.liu.se>
cc: goemon@anime.net, linux-kernel@vger.kernel.org
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5
In-Reply-To: <20001119150837.8EF2737237@hog.ctrl-c.liu.se>
Message-ID: <Pine.GSO.4.21.0011191036370.24634-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Nov 2000, Christer Weinigel wrote:

> In article <Pine.LNX.4.30.0011190710440.13087-100000@anime.net> you write:
> >On Sun, 19 Nov 2000, Alexander Viro wrote:
> >> On Sun, 19 Nov 2000, David Lang wrote:
> >> > there is a rootkit kernel module out there that, if loaded onto your
> >> > system, can make it almost impossible to detect that your system has been
> >> > compramised. with module support disabled this isn't possible.
> >> Yes, it is. Easily. If you've got root you can modify the kernel image and
> >> reboot the bloody thing. And no, marking it immutable will not help. Open
> >> the raw device and modify relevant blocks.
> >
> >Kernel on writeprotected floppy disk...

Cute. And when (not if) we get hit by new bug in the net/*/* you will drive
to the location of said router to upgrade the thing.
 
> So change the CMOS-settings so that the BIOS changes the boot order
> from A, C, CD-ROM to C first instead.  *grin*  How long do you want
> to keep playing Tic-Tac-Toe?

Now, _that_ can be taken care of (custom boot code burnt into the thing)

> Of course, using capabilities and totally disabling access to the raw 
> disk devices and to any I/O ports might be the solution, provided that 
> there are no bugs or thinkos in the capabilities code.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
