Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132432AbQKSPtn>; Sun, 19 Nov 2000 10:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132418AbQKSPtd>; Sun, 19 Nov 2000 10:49:33 -0500
Received: from hog.ctrl-c.liu.se ([130.236.252.129]:34576 "HELO
	hog.ctrl-c.liu.se") by vger.kernel.org with SMTP id <S132380AbQKSPt0>;
	Sun, 19 Nov 2000 10:49:26 -0500
Cc: linux-kernel@vger.kernel.org
To: goemon@anime.net
Subject: Re: BTTV detection broken in 2.4.0-test11-pre5
In-Reply-To: <Pine.LNX.4.30.0011190710440.13087-100000@anime.net>
Message-Id: <20001119150837.8EF2737237@hog.ctrl-c.liu.se>
Date: Sun, 19 Nov 2000 16:08:37 +0100 (CET)
From: wingel@hog.ctrl-c.liu.se (Christer Weinigel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.30.0011190710440.13087-100000@anime.net> you write:
>On Sun, 19 Nov 2000, Alexander Viro wrote:
>> On Sun, 19 Nov 2000, David Lang wrote:
>> > there is a rootkit kernel module out there that, if loaded onto your
>> > system, can make it almost impossible to detect that your system has been
>> > compramised. with module support disabled this isn't possible.
>> Yes, it is. Easily. If you've got root you can modify the kernel image and
>> reboot the bloody thing. And no, marking it immutable will not help. Open
>> the raw device and modify relevant blocks.
>
>Kernel on writeprotected floppy disk...

So change the CMOS-settings so that the BIOS changes the boot order
from A, C, CD-ROM to C first instead.  *grin*  How long do you want
to keep playing Tic-Tac-Toe?

Of course, using capabilities and totally disabling access to the raw 
disk devices and to any I/O ports might be the solution, provided that 
there are no bugs or thinkos in the capabilities code.

   /Christer
-- 
"Just how much can I get away with and still go to heaven?"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
