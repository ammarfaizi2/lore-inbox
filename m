Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318297AbSHPLHD>; Fri, 16 Aug 2002 07:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318299AbSHPLHD>; Fri, 16 Aug 2002 07:07:03 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:41968 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318297AbSHPLHA>; Fri, 16 Aug 2002 07:07:00 -0400
Date: Fri, 16 Aug 2002 13:10:53 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Alan Cox <alan@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre2-ac3
In-Reply-To: <200208151918.g7FJI6J04061@devserv.devel.redhat.com>
Message-ID: <Pine.NEB.4.44.0208161309240.6334-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

the following compile error is still present when trying compiling a
kernel with CONFIG_BLK_DEV_HD enabled:

<--  snip  -->

...
        /home/bunk/linux/kernel-2.4/linux-2.4.19-full/arch/i386/lib/lib.a
/home/bunk/linux/kernel-2.4/linux-2.4.19-full/lib/lib.a
/home/bunk/linux/kernel-2.4/linux-2.4.19-full/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/ide/idedriver.o: In function `dump_status':
drivers/ide/idedriver.o(.text+0x68): undefined reference to `IN_BYTE'
drivers/ide/idedriver.o: In function `reset_controller':
drivers/ide/idedriver.o(.text+0x55e): undefined reference to `IN_BYTE'
make: *** [vmlinux] Error 1

<--  snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


