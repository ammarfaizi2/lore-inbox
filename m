Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282213AbRK2AcE>; Wed, 28 Nov 2001 19:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280832AbRK2Abx>; Wed, 28 Nov 2001 19:31:53 -0500
Received: from outmail6.pacificnet.net ([207.171.0.134]:62982 "EHLO
	outmail6.pacificnet.net") by vger.kernel.org with ESMTP
	id <S282213AbRK2Abo>; Wed, 28 Nov 2001 19:31:44 -0500
Message-ID: <009101c1786d$3809a890$03910404@Molybdenum>
From: "Jahn Veach" <V64@Galaxy42.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.1-pre3 Build Failure
Date: Wed, 28 Nov 2001 18:31:41 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems I'm not the only one with this problem either.

gcc -D__KERNEL__ -I/root/linux/linux-2.5/include -Wall -Wstrict-prototypes -
Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pip
e -mpreferred-stack-boundary=2 -march=i686    -c -o pc_keyb.o pc_keyb.c
pc_keyb.c:423: macro `spin_unlock' used with too many (2) args
pc_keyb.c:1059: macro `spin_unlock_irqrestore' used with just one arg
pc_keyb.c:1079: macro `spin_unlock_irqrestore' used with just one arg
pc_keyb.c: In function `release_aux':
pc_keyb.c:1059: parse error before `)'
pc_keyb.c: In function `open_aux':
pc_keyb.c:1079: parse error before `)'
make[3]: *** [pc_keyb.o] Error 1
make[3]: Leaving directory `/root/linux/linux-2.5/drivers/char'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/root/linux/linux-2.5/drivers/char'
make[1]: *** [_subdir_char] Error 2
make[1]: Leaving directory `/root/linux/linux-2.5/drivers'
make: *** [_dir_drivers] Error 2


