Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129223AbQKFXiF>; Mon, 6 Nov 2000 18:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129531AbQKFXhz>; Mon, 6 Nov 2000 18:37:55 -0500
Received: from mail.tripledental.com ([208.129.192.28]:55557 "EHLO
	imail.ipns.com") by vger.kernel.org with ESMTP id <S129223AbQKFXhj>;
	Mon, 6 Nov 2000 18:37:39 -0500
From: "Dan Browning" <danb@cyclonecomputers.com>
To: <linux-kernel@vger.kernel.org>
Cc: <mingo@redhat.com>
Subject: 2.2.18pre19 + raid-2.2.18-AX?
Date: Mon, 6 Nov 2000 15:37:32 -0800
Message-ID: <002601c0484a$894eda80$6700000a@danb>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't get raid-2.2.18-A2 to apply cleanly on 2.2.18pre19.  Does
anyone know of a newer raid-2.2.18preX patch?  (pre18 or pre19 would
be great).

Here's the output I get...

[root@server linux]# patch -p1 < raid-2.2.18-A2
patching file init/main.c
Hunk #4 succeeded at 1631 (offset 4 lines).
patching file include/linux/raid/hsm.h
patching file include/linux/raid/hsm_p.h
patching file include/linux/raid/linear.h
patching file include/linux/raid/md.h
patching file include/linux/raid/md_compatible.h
patching file include/linux/raid/md_k.h
patching file include/linux/raid/md_p.h
patching file include/linux/raid/md_u.h
patching file include/linux/raid/raid0.h
patching file include/linux/raid/raid1.h
patching file include/linux/raid/raid5.h
patching file include/linux/raid/translucent.h
patching file include/linux/raid/xor.h
patching file include/linux/blkdev.h
Hunk #1 succeeded at 91 (offset -2 lines).
patching file include/linux/fs.h
Hunk #2 succeeded at 781 (offset 9 lines).
Hunk #4 succeeded at 828 (offset 9 lines).
Hunk #6 succeeded at 938 (offset 9 lines).
patching file include/linux/md.h
patching file include/linux/raid0.h
patching file include/linux/raid1.h
patching file include/linux/raid5.h
patching file include/linux/sysctl.h
Hunk #1 succeeded at 433 (offset 2 lines).
patching file include/asm-i386/md.h
patching file include/asm-alpha/md.h
patching file include/asm-m68k/md.h
patching file include/asm-sparc/md.h
patching file include/asm-ppc/md.h
patching file include/asm-sparc64/md.h
patching file drivers/block/Config.in
patching file drivers/block/Makefile
patching file drivers/block/genhd.c
patching file drivers/block/hsm.c
patching file drivers/block/linear.c
patching file drivers/block/linear.h
patching file drivers/block/ll_rw_blk.c
Hunk #3 succeeded at 589 (offset -68 lines).
Hunk #4 succeeded at 908 (offset -2 lines).
Hunk #5 succeeded at 862 (offset -68 lines).
patching file drivers/block/md.c
patching file drivers/block/raid0.c
patching file drivers/block/raid1.c
Hunk #7 FAILED at 146.
Hunk #10 FAILED at 287.
2 out of 15 hunks FAILED -- saving rejects to file
drivers/block/raid1.c.rej
patching file drivers/block/raid5.c
patching file drivers/block/translucent.c
patching file drivers/block/xor.c
patching file arch/i386/defconfig
patching file arch/sparc/config.in
patching file arch/sparc/defconfig
Hunk #1 succeeded at 88 with fuzz 2.
patching file arch/sparc64/config.in
patching file arch/sparc64/defconfig
Hunk #1 succeeded at 107 with fuzz 2 (offset 1 line).
patching file Documentation/Configure.help
Hunk #1 succeeded at 1017 (offset 44 lines).
patching file Makefile
Hunk #1 FAILED at 1.
1 out of 1 hunk FAILED -- saving rejects to file Makefile.rej


Best regards,

Dan Browning
Network/DB Admin
Cyclone Computer Systems

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
