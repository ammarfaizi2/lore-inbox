Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268332AbRG3Fuu>; Mon, 30 Jul 2001 01:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268330AbRG3Fuj>; Mon, 30 Jul 2001 01:50:39 -0400
Received: from [195.139.232.25] ([195.139.232.25]:40971 "HELO
	redbull.speedroad.net") by vger.kernel.org with SMTP
	id <S267984AbRG3Fu3>; Mon, 30 Jul 2001 01:50:29 -0400
Date: Mon, 30 Jul 2001 07:48:19 +0200
From: Arnvid Karstad <arnvid@karstad.org>
To: linux-kernel@vger.kernel.org
Subject: Problems compiling 2.4.7 with DAC960
Message-Id: <20010730073901.A59C.ARNVID@karstad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hiya,

I can't seem to be getting 2.4.7 to compile on one of our boxes.
I get this error:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.7/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686    -DEXPORT_SYMTAB -c DAC960.c
DAC960.c: In function `DAC960_ProcessRequest':
DAC960.c:2771: structure has no member named `sem'
make[3]: *** [DAC960.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.7/drivers/block'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.7/drivers/block'
make[1]: *** [_subdir_block] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.7/drivers'
make: *** [_dir_drivers] Error 2
[root@x linux]# 

I get the same error when trying to compile it as a module..
Is it broken, or is something else broken?

regards,

Arnvid Karstad
