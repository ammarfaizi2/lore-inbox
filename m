Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262633AbREZLVv>; Sat, 26 May 2001 07:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262637AbREZLVl>; Sat, 26 May 2001 07:21:41 -0400
Received: from [213.97.199.90] ([213.97.199.90]:6016 "HELO fargo")
	by vger.kernel.org with SMTP id <S262633AbREZLVd> convert rfc822-to-8bit;
	Sat, 26 May 2001 07:21:33 -0400
From: "David =?ISO-8859-1?Q?G=F3mez" ?= <davidge@jazzfree.com>
Date: Sat, 26 May 2001 12:52:48 +0200 (CEST)
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: ov511 driver doesn't compile
Message-ID: <Pine.LNX.4.21.0105261250100.8159-100000@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On kernel 2.4.5, the ov511 usb driver shows a failure at compile
time. const version is not defined.

gcc -D__KERNEL__ -I/usr/src/linux-2.4.5/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686 -DMODULE   -c -o ov511.o ov511.c
ov511.c: In function `ov511_read_proc':
ov511.c:340: `version' undeclared (first use in this function)
ov511.c:340: (Each undeclared identifier is reported only once
ov511.c:340: for each function it appears in.)
make[2]: *** [ov511.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.5/drivers/usb'
make[1]: *** [_modsubdir_usb] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.5/drivers'
make: *** [_mod_drivers] Error 2




David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra


