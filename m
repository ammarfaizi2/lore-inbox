Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315628AbSECKrM>; Fri, 3 May 2002 06:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315629AbSECKrL>; Fri, 3 May 2002 06:47:11 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:56811 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315628AbSECKrK>; Fri, 3 May 2002 06:47:10 -0400
Date: Fri, 3 May 2002 12:42:46 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre8
In-Reply-To: <Pine.LNX.4.21.0205021845430.10896-100000@freak.distro.conectiva>
Message-ID: <Pine.NEB.4.44.0205031239430.2605-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I got the following compile error:

<--  snip  -->

...
ld -m elf_i386  -r -o ASLX.o 8253xini.o 8253xnet.o 8253xsyn.o crc32.o
8253xdbg.o 8253xplx.o 8253xtty.o 8253xchr.o 8253xint.o amcc5920.o
8253xmcs.o 8253xutl.o
make[4]: *** No rule to make target `8253xcfg.c', needed by `8253xcfg'.
Stop.
make[4]: Leaving directory
`/home/bunk/linux/kernel-2.4/linux/drivers/net/wan/8253x'

<--  snip  -->

It seems 8253xcfg.c was accidentially not included.

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

