Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293076AbSD1L3w>; Sun, 28 Apr 2002 07:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSD1L3v>; Sun, 28 Apr 2002 07:29:51 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:47348 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S293076AbSD1L3v>; Sun, 28 Apr 2002 07:29:51 -0400
Date: Sun, 28 Apr 2002 13:25:55 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Phil Blundell <philb@gnu.org>, <linux-i2c@pelican.tk.uni-linz.ac.at>,
        <kraxel@bytesex.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.10-dj1: i2c-parport.c:23: linux/i2c-old.h: No such file or
 directory
Message-ID: <Pine.NEB.4.44.0204281321560.3103-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while trying to compile kernel 2.5.10-dj1 the compilation of i2c-parport.c
failed with the following error message:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.5/linux-2.5.10/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=k6
-nostdinc -I /usr/lib/gcc-lib/i386-linux/2.95.4/include
-DKBUILD_BASENAME=i2c_parport  -c -o i2c-parport.o i2c-parport.c
i2c-parport.c:23: linux/i2c-old.h: No such file or directory
i2c-parport.c:33: field `i2c' has incomplete type
i2c-parport.c: In function `i2c_setlines':
i2c-parport.c:45: dereferencing pointer to incomplete type
i2c-parport.c: In function `i2c_getdataline':
i2c-parport.c:52: dereferencing pointer to incomplete type
i2c-parport.c: At top level:
i2c-parport.c:56: variable `parport_i2c_bus_template' has initializer but
incomplete type
i2c-parport.c:58: warning: excess elements in struct initializer
i2c-parport.c:58: warning: (near initialization for
`parport_i2c_bus_template')
i2c-parport.c:59: `I2C_BUSID_PARPORT' undeclared here (not in a function)
i2c-parport.c:59: warning: excess elements in struct initializer
i2c-parport.c:59: warning: (near initialization for
`parport_i2c_bus_template')
i2c-parport.c:60: warning: excess elements in struct initializer
i2c-parport.c:60: warning: (near initialization for
`parport_i2c_bus_template')
i2c-parport.c:62: warning: excess elements in struct initializer
i2c-parport.c:62: warning: (near initialization for
`parport_i2c_bus_template')
i2c-parport.c:64: warning: excess elements in struct initializer
i2c-parport.c:64: warning: (near initialization for
`parport_i2c_bus_template')
i2c-parport.c:65: warning: excess elements in struct initializer
i2c-parport.c:65: warning: (near initialization for
`parport_i2c_bus_template')
i2c-parport.c:67: warning: excess elements in struct initializer
i2c-parport.c:67: warning: (near initialization for
`parport_i2c_bus_template')
i2c-parport.c:68: warning: excess elements in struct initializer
i2c-parport.c:68: warning: (near initialization for
`parport_i2c_bus_template')
i2c-parport.c:69: warning: excess elements in struct initializer
i2c-parport.c:69: warning: (near initialization for
`parport_i2c_bus_template')
i2c-parport.c:70: warning: excess elements in struct initializer
i2c-parport.c:70: warning: (near initialization for
`parport_i2c_bus_template')
i2c-parport.c: In function `i2c_parport_attach':
i2c-parport.c:88: warning: implicit declaration of function
`i2c_register_bus'
i2c-parport.c: In function `i2c_parport_detach':
i2c-parport.c:106: warning: implicit declaration of function
`i2c_unregister_bus'
make[4]: *** [i2c-parport.o] Error 1
make[4]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.10/drivers/media/video'

<--  snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

