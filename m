Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131386AbRDFJ0g>; Fri, 6 Apr 2001 05:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131392AbRDFJ00>; Fri, 6 Apr 2001 05:26:26 -0400
Received: from alpha.zarz.agh.edu.pl ([149.156.122.231]:38920 "HELO
	alpha.zarz.agh.edu.pl") by vger.kernel.org with SMTP
	id <S131386AbRDFJ0P> convert rfc822-to-8bit; Fri, 6 Apr 2001 05:26:15 -0400
Date: Fri, 6 Apr 2001 10:21:58 +0200 (CEST)
From: "Wojciech \"Sas\" Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.3 compile error - why ??
In-Reply-To: <19da01c0be78$f9106c90$0a070d0a@axis.se>
Message-ID: <Pine.LNX.4.21.0104061016210.4148-100000@alpha.zarz.agh.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I try to compile kernel downloaded from
ftp.kernel.org.
I have all programs that this kernel require.
But I can't compile kernel :(

Ooops, can't compile kernel modules:

[...]
make[3]: Opuszczam katalog `/users/cieciwa/rpm/BUILD/linux/drivers/media/radio'
make -C video modules
make[3]: Wchodzê katalog `/users/cieciwa/rpm/BUILD/linux/drivers/media/video'
ld -m elf_i386  -r -o bttv.o bttv-driver.o bttv-cards.o bttv-if.o
ld -m elf_i386  -r -o zoran.o zr36120.o zr36120_i2c.o zr36120_mem.o
gcc -D__KERNEL__ -I/users/cieciwa/rpm/BUILD/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -c -o buz.o buz.c
buz.c: In function `v4l_fbuffer_alloc':
buz.c:188: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:188: (Each undeclared identifier is reported only once
buz.c:188: for each function it appears in.)
buz.c: In function `jpg_fbuffer_alloc':
buz.c:262: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:256: warning: `alloc_contig' might be used uninitialized in this function
buz.c: In function `jpg_fbuffer_free':
buz.c:322: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:316: warning: `alloc_contig' might be used uninitialized in this function
buz.c: In function `zoran_ioctl':
buz.c:2837: `KMALLOC_MAXSIZE' undeclared (first use in this function)
make[3]: *** [buz.o] B³±d 1
make[3]: Opuszczam katalog `/users/cieciwa/rpm/BUILD/linux/drivers/media/video'
make[2]: *** [_modsubdir_video] B³±d 2
make[2]: Opuszczam katalog `/users/cieciwa/rpm/BUILD/linux/drivers/media'
make[1]: *** [_modsubdir_media] B³±d 2
make[1]: Opuszczam katalog `/users/cieciwa/rpm/BUILD/linux/drivers'
make: *** [_mod_drivers] B³±d 2

What's wrong ??

Thanx.
					Sas.
P.S.
Sorry for my "language".
-- 
{Wojciech 'Sas' Cieciwa}  {Member of PLD Team                               }
{e-mail: cieciwa@alpha.zarz.agh.edu.pl, http://www2.zarz.agh.edu.pl/~cieciwa}

