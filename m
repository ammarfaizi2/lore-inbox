Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbQKSViE>; Sun, 19 Nov 2000 16:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129913AbQKSVhx>; Sun, 19 Nov 2000 16:37:53 -0500
Received: from james.kalifornia.com ([208.179.0.2]:64296 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S129413AbQKSVhk>; Sun, 19 Nov 2000 16:37:40 -0500
Message-ID: <3A1840E8.2A66FDD9@kalifornia.com>
Date: Sun, 19 Nov 2000 13:06:49 -0800
From: Ben Ford <ben@kalifornia.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Christer Weinigel <wingel@hog.ctrl-c.liu.se>,
        lkm <linux-kernel@vger.kernel.org>
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5
In-Reply-To: <20001119150837.8EF2737237@hog.ctrl-c.liu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christer Weinigel wrote:

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
>
> So change the CMOS-settings so that the BIOS changes the boot order
> from A, C, CD-ROM to C first instead.  *grin*  How long do you want
> to keep playing Tic-Tac-Toe?
>

The way we do it is to boot from a CDROM with no onboard hard drive.  (logging is
provided by an external server)  Beat that.

-b



>
> Of course, using capabilities and totally disabling access to the raw
> disk devices and to any I/O ports might be the solution, provided that
> there are no bugs or thinkos in the capabilities code.
>
>    /Christer
> --
> "Just how much can I get away with and still go to heaven?"
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
