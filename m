Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130465AbQKSVjE>; Sun, 19 Nov 2000 16:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129913AbQKSViy>; Sun, 19 Nov 2000 16:38:54 -0500
Received: from james.kalifornia.com ([208.179.0.2]:1065 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S129404AbQKSVil>; Sun, 19 Nov 2000 16:38:41 -0500
Message-ID: <3A184158.4C818741@kalifornia.com>
Date: Sun, 19 Nov 2000 13:08:40 -0800
From: Ben Ford <ben@kalifornia.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Christer Weinigel <wingel@hog.ctrl-c.liu.se>, goemon@anime.net,
        linux-kernel@vger.kernel.org
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5
In-Reply-To: <Pine.GSO.4.21.0011191036370.24634-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:

> On Sun, 19 Nov 2000, Christer Weinigel wrote:
>
> > In article <Pine.LNX.4.30.0011190710440.13087-100000@anime.net> you write:
> > >On Sun, 19 Nov 2000, Alexander Viro wrote:
> > >> On Sun, 19 Nov 2000, David Lang wrote:
> > >> > there is a rootkit kernel module out there that, if loaded onto your
> > >> > system, can make it almost impossible to detect that your system has been
> > >> > compramised. with module support disabled this isn't possible.
> > >> Yes, it is. Easily. If you've got root you can modify the kernel image and
> > >> reboot the bloody thing. And no, marking it immutable will not help. Open
> > >> the raw device and modify relevant blocks.
> > >
> > >Kernel on writeprotected floppy disk...
>
> Cute. And when (not if) we get hit by new bug in the net/*/* you will drive
> to the location of said router to upgrade the thing.
>

No, I mail the customer a new operating CD.

-b


>
> > So change the CMOS-settings so that the BIOS changes the boot order
> > from A, C, CD-ROM to C first instead.  *grin*  How long do you want
> > to keep playing Tic-Tac-Toe?
>
> Now, _that_ can be taken care of (custom boot code burnt into the thing)
>
> > Of course, using capabilities and totally disabling access to the raw
> > disk devices and to any I/O ports might be the solution, provided that
> > there are no bugs or thinkos in the capabilities code.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
