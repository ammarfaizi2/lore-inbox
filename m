Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129749AbRACUF3>; Wed, 3 Jan 2001 15:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129853AbRACUFU>; Wed, 3 Jan 2001 15:05:20 -0500
Received: from femail1.rdc1.on.home.com ([24.2.9.88]:2981 "EHLO
	femail1.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S129601AbRACUFC>; Wed, 3 Jan 2001 15:05:02 -0500
Message-ID: <3A537EA8.45889173@home.net>
Date: Wed, 03 Jan 2001 14:34:01 -0500
From: Shawn Starr <shawn.starr@home.net>
Reply-To: shawn.starr@home.net
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SHM Not working in 2.4.0-prerelease
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have created the shm directory in /dev

drwxrwxrwt   1 root     root            0 Jan  3 09:51 shm/

in my fstab i have:

shmfs /dev/shm shm defaults 0 0


when I display with top:


Mem:    62496K av,   61248K used,    1248K free,       0K shrd,    1868K
buff
Swap:   64252K av,   20016K used,   44236K free                   27900K
cached

[spstarr@coredump /etc]$ free
             total       used       free     shared    buffers
cached
Mem:         62496      61264       1232          0       1248
28848


There's no shared memory being used?

mount
...
shmfs on /dev/shm type shm (rw)

the shmfs is mounted. Is there any configuration i need to get shm
memory activiated?

Thanks,

Shawn Starr.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
