Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132285AbQKXJdV>; Fri, 24 Nov 2000 04:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132525AbQKXJdK>; Fri, 24 Nov 2000 04:33:10 -0500
Received: from tartu.cv.ee ([213.168.20.166]:55560 "EHLO tartu.cv.ee")
        by vger.kernel.org with ESMTP id <S132285AbQKXJdC>;
        Fri, 24 Nov 2000 04:33:02 -0500
Date: Fri, 24 Nov 2000 11:02:57 +0200 (EET)
From: Janek <janek@tartu.cv.ee>
To: linux-kernel@vger.kernel.org
Subject: attempt to access beyond end of device
Message-ID: <Pine.LNX.4.10.10011241051020.13372-100000@reigo.cvo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have dual P III 665 with 512 MB ram and IBM ServeRAID controller.
It has been running for 40 days without problems but yesterday during
system backup it gave me the following error to syslog:

kernel: attempt to access beyond end of device
kernel: 08:03: rw=0, want=631625768, limit=7912989
kernel: dev 08:03 blksize=4096 blocknr=1768519177 sector=1263251528 size=4096 count=1

with different want numbers.
After a while thise lines changed to :

kernel: EXT2-fs error (device sd(8,3)): ext2_free_blocks: Freeing blocks not in datazone - block = 1869575229, count = 1

After backup nothing else was printed. Machine did not crash or anything.
Only MySQL server hanged...

Is this serious ? What chould I do ?

Also I'm using RedHat 6.2 with kernel 2.2.16. MySQL 3.22.32


Thanks,
Janek Hiis


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
