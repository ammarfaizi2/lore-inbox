Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143618AbRAHMvZ>; Mon, 8 Jan 2001 07:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143633AbRAHMvP>; Mon, 8 Jan 2001 07:51:15 -0500
Received: from DKBH-T-002-p-251-187.tmns.net.au ([203.54.251.187]:37903 "EHLO
	eyal.emu.id.au") by vger.kernel.org with ESMTP id <S143618AbRAHMvC>;
	Mon, 8 Jan 2001 07:51:02 -0500
Message-ID: <3A59B76D.9C8163A@eyal.emu.id.au>
Date: Mon, 08 Jan 2001 23:49:49 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0-ac4
In-Reply-To: <E14FS17-0003lC-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> Handle with care. I think the fs updates are right but I don't guarantee it.

The .config selectes everything as 'm' when possible.


make[2]: Entering directory `/data2/usr/local/src/linux-2.4/fs/qnx4'
gcc -D__KERNEL__ -I/usr/local/src/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE
-DMODVERSIONS -include
/usr/local/src/linux/include/linux/modversions.h   -c -o inode.o inode.c
inode.c: In function `qnx4_read_super':
inode.c:372: `sb' undeclared (first use in this function)
inode.c:372: (Each undeclared identifier is reported only once
inode.c:372: for each function it appears in.)
make[2]: *** [inode.o] Error 1

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
