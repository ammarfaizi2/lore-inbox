Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274198AbRIYM2v>; Tue, 25 Sep 2001 08:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274204AbRIYM2l>; Tue, 25 Sep 2001 08:28:41 -0400
Received: from mail.interware.hu ([195.70.32.130]:52949 "EHLO
	mail.interware.hu") by vger.kernel.org with ESMTP
	id <S274198AbRIYM23>; Tue, 25 Sep 2001 08:28:29 -0400
Message-ID: <3BB07884.E8BD8975@interware.hu>
Date: Tue, 25 Sep 2001 14:28:52 +0200
From: Hirling Endre <endre@interware.hu>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac15
In-Reply-To: <20010924164143.A11157@lightning.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *15lrKX-0006Ph-00*5DvpfyFXcYY* http://duncanthrax.net/exiscan/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

2.4.9-ac15 doesn't compile for me on alpha.

gcc -D__KERNEL__ -I/usr/src/k/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mno-fp-regs -ffixed-8 -mcpu=ev6 -Wa,-mev6    -c -o mmap.o mmap.c
mmap.c: In function `arch_get_unmapped_area':
mmap.c:418: `ADDR_LIMIT_32BIT' undeclared (first use in this function)
mmap.c:418: (Each undeclared identifier is reported only once
mmap.c:418: for each function it appears in.)
make[3]: *** [mmap.o] Error 1
make[3]: Leaving directory `/usr/src/k/linux/mm'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/k/linux/mm'
make[1]: *** [_dir_mm] Error 2
make[1]: Leaving directory `/usr/src/k/linux'
make: *** [stamp-build] Error 2

greetings
endre
