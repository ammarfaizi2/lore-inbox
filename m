Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQLKHED>; Mon, 11 Dec 2000 02:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbQLKHDx>; Mon, 11 Dec 2000 02:03:53 -0500
Received: from pop.gmx.net ([194.221.183.20]:64291 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129314AbQLKHDo>;
	Mon, 11 Dec 2000 02:03:44 -0500
From: Norbert Breun <nbreun@gmx.de>
Reply-To: nbreun@gmx.de
Organization: private
Date: Mon, 11 Dec 2000 07:27:58 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: make modules exits on test12-pre8
MIME-Version: 1.0
Message-Id: <00121107275800.01122@nmb>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

tried to compile test12-pre8 and make modules exits with:


>make[2]: Entering directory `/usr/src/linux-2.4.0.12pre8/fs/smbfs'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 
-march=i586 -DMODULE -DMODVERSIONS -include 
/usr/src/linux/include/linux/modversions.h -DSMBFS_PARANOIA  -c -o sock.o 
sock.c
>sock.c: In function `smb_data_ready':
>sock.c:166: structure has no member named `next'
>make[2]: *** [sock.o] Error 1
>make[2]: Leaving directory `/usr/src/linux-2.4.0.12pre8/fs/smbfs'
>make[1]: *** [_modsubdir_smbfs] Error 2
>make[1]: Leaving directory `/usr/src/linux-2.4.0.12pre8/fs'
>make: *** [_mod_fs] Error 2

kind regards
Norbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
