Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270221AbRHMOTt>; Mon, 13 Aug 2001 10:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270225AbRHMOTj>; Mon, 13 Aug 2001 10:19:39 -0400
Received: from sniip-netline.inet.ntl.ru ([213.247.145.170]:62468 "EHLO
	gw.sniip.ru") by vger.kernel.org with ESMTP id <S270222AbRHMOTb> convert rfc822-to-8bit;
	Mon, 13 Aug 2001 10:19:31 -0400
Content-Type: text/plain;
  charset="koi8-r"
From: Info <arling@sniip.ru>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: In addition to: Tulip on 2.4.7 stay unworkable both on 21041 and 21142 in 10M net + OOPS
Date: Mon, 13 Aug 2001 18:21:53 +0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Cc: linux-kernel@vger.kernel.org
Message-Id: <01081318215300.01213@sh.lc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I forgot to place in my previous letter compiler's message about Tulip;
it appeared while I compiled kernel without "new bus" configuration.
This message is (seperated by *********):
___________________________________________________

make[4]: Вход в каталог `/usr/src/linux/drivers/net/tulip'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o 
eeprom.o eeprom.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o 
interrupt.o interrupt.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o 
media.o media.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o 
timer.o timer.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o 
tulip_core.o tulip_core.c
****************************************
tulip_core.c: In function `tulip_init_one':
tulip_core.c:1768: warning: label `err_out_free_res' defined but not 
used
******************************************
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o 
21142.o 21142.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=k6    -c -o 
pnic.o pnic.c
rm -f tulip.o
ld -m elf_i386  -r -o tulip.o eeprom.o interrupt.o media.o timer.o 
tulip_core.o 21142.o pnic.o
make[4]: Выход из каталог `/usr/src/linux/drivers/net/tulip'
___________________________________________________

I don't know if this (or such) message appeares when compiling kernel 
with "new bus" configuration: I didn't notice it on compiling, and. 
sorry., have no oppotunity to repead compiling.

Best regards,

George Afanassew
