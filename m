Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130005AbRBERQS>; Mon, 5 Feb 2001 12:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130444AbRBERQI>; Mon, 5 Feb 2001 12:16:08 -0500
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:42503 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S130005AbRBERPy>; Mon, 5 Feb 2001 12:15:54 -0500
Date: Mon, 5 Feb 2001 09:15:52 -0800 (PST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Linux2.4.1-pre1, Kernel is too big for standalone boot from floppy
In-Reply-To: <E14PoSf-0003dV-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.32.0102050908380.8640-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello All ,  I like the warning Ladies & Gents .  But when did it
	first appear ?  I seem to have missed the announcement in the
	change logs .  Tia ,  JimL

make[2]: Leaving directory
`/usr/src/linux-2.4.2-pre1/arch/i386/boot/compressed'
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o tools/build
tools/build.c -I/usr/src/linux/include
objcopy -O binary -R .note -R .comment -S compressed/bvmlinux
compressed/bvmlinux.out
tools/build -b bbootsect bsetup compressed/bvmlinux.out CURRENT > bzImage
Root device is (8, 1)
Boot sector 512 bytes.
Setup is 4512 bytes.
System is 1418 kB
warning: kernel is too big for standalone boot from floppy

       +----------------------------------------------------------------+
       | James   W.   Laferriere | System  Techniques | Give me VMS     |
       | Network        Engineer | 25416      22nd So |  Give me Linux  |
       | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
       +----------------------------------------------------------------+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
