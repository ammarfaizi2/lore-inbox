Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130317AbRBZQWl>; Mon, 26 Feb 2001 11:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130318AbRBZQWb>; Mon, 26 Feb 2001 11:22:31 -0500
Received: from [212.115.175.146] ([212.115.175.146]:63739 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S130317AbRBZQW1>; Mon, 26 Feb 2001 11:22:27 -0500
Message-ID: <27525795B28BD311B28D00500481B7601F0F12@ftrs1.intranet.ftr.nl>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: awe_ram.c
Date: Mon, 26 Feb 2001 17:31:10 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On http://helllabs.org/~claudio/awebd/awe_ram.c I found some code which
transforms the
RAM on an AWE32/64 into a block-device. I tried to compile it, but I did not
succeed.
The writer of this code doesn't respond to e-mails.
Anyone out there who has a clue what is going wrong with it? (using kernel
2.2.18)

Am getting the following errors:
bash-2.03# gcc -Wall -Wstrict-prototypes -Winline -O2 -fomit-frame-pointer
-I/usr/src/linux/include/ -c awe_ram.c -o awe_ram.o 2>&1 | more 
In file included from /usr/src/linux/include/linux/sched.h:74,
                 from awe_ram.c:26:
/usr/src/linux/include/asm/processor.h:287: warning: `struct task_struct'
declared inside parameter list
/usr/src/linux/include/asm/processor.h:287: warning: its scope is only this
definition or declaration,
/usr/src/linux/include/asm/processor.h:287: warning: which is probably not
what you want.
/usr/src/linux/include/asm/processor.h:291: warning: `struct task_struct'
declared inside parameter list
In file included from /usr/src/linux/include/linux/blk.h:4,
                 from awe_ram.c:42:
/usr/src/linux/include/linux/blkdev.h:23: parse error before `kdev_t'
/usr/src/linux/include/linux/blkdev.h:23: warning: no semicolon at end of
struct or union
/usr/src/linux/include/linux/blkdev.h:36: parse error before `}'
/usr/src/linux/include/linux/blkdev.h:39: parse error before `dev'
/usr/src/linux/include/linux/blkdev.h:39: warning: function declaration
isn't a prototype
/usr/src/linux/include/linux/blkdev.h:55: parse error before `unsigned'
/usr/src/linux/include/linux/blkdev.h:55: warning: function declaration
isn't a prototype
/usr/src/linux/include/linux/blkdev.h:75: field `plug' has incomplete type
/usr/src/linux/include/linux/blkdev.h:94: parse error before `kdev_t'
/usr/src/linux/include/linux/blkdev.h:94: warning: function declaration
isn't a prototype
/usr/src/linux/include/linux/blkdev.h:96: parse error before `mddev'
/usr/src/linux/include/linux/blkdev.h:96: warning: function declaration
isn't a prototype
<etc.>


Greetings,
Folkert van Heusden.
