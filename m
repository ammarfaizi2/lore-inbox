Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265714AbRGOCkZ>; Sat, 14 Jul 2001 22:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265754AbRGOCkQ>; Sat, 14 Jul 2001 22:40:16 -0400
Received: from fe030.worldonline.dk ([212.54.64.197]:6924 "HELO
	fe030.worldonline.dk") by vger.kernel.org with SMTP
	id <S265714AbRGOCkD>; Sat, 14 Jul 2001 22:40:03 -0400
Message-ID: <3B512034.7080903@eisenstein.dk>
Date: Sun, 15 Jul 2001 06:46:44 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4-ac8 i586; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en, da
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: FYI: asm/amigahw.h: No such file or directory (2.4.7-pre6)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just build kernel 2.4.7-pre6 and noticed the following message about a 
missing file:

make -C zorro fastdep
make[4]: Entering directory `/usr/src/linux-2.4.7-pre6/drivers/zorro'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.7-pre6/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i586  -E 
-D__GENKSYMS__ zorro.c
| /sbin/genksyms  -k 2.4.7 > 
/usr/src/linux-2.4.7-pre6/include/linux/modules/zorro.ver.tmp
zorro.c:20: asm/amigahw.h: No such file or directory

I have no idea what this is about, and the kernel build fine - I just 
thought that perhaps someone more knowlegeable than me might want to 
know about it.


Best regards,
Jesper Juhl - juhl@eisenstein.dk

