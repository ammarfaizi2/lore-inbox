Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266330AbSL1XBH>; Sat, 28 Dec 2002 18:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266347AbSL1XBH>; Sat, 28 Dec 2002 18:01:07 -0500
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.224]:410 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S266330AbSL1XBH>; Sat, 28 Dec 2002 18:01:07 -0500
Date: Sat, 28 Dec 2002 18:01:55 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@linux-dev
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <rusty@rustcorp.com.au>
Subject: 2.5.53 : modules_install warnings
Message-ID: <Pine.LNX.4.44.0212281758230.839-100000@linux-dev>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  I received the following warnings while a 'make modules_install'. It 
looks like there are a few more locking changes that need to be made. :)
Regards,
Frank

make -rR -f scripts/Makefile.modinst obj=arch/i386/lib
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.53; fi
WARNING: /lib/modules/2.5.53/kernel/net/atm/lec.ko needs unknown symbol cli
WARNING: /lib/modules/2.5.53/kernel/net/atm/lec.ko needs unknown symbol restore_flags
WARNING: /lib/modules/2.5.53/kernel/net/atm/lec.ko needs unknown symbol save_flags
WARNING: /lib/modules/2.5.53/kernel/drivers/net/wan/x25_asy.ko needs unknown symbol cli
WARNING: /lib/modules/2.5.53/kernel/drivers/net/wan/x25_asy.ko needs unknown symbol restore_flags
WARNING: /lib/modules/2.5.53/kernel/drivers/net/wan/x25_asy.ko needs unknown symbol save_flags
WARNING: /lib/modules/2.5.53/kernel/drivers/net/pcmcia/3c574_cs.ko needs unknown symbol cli
WARNING: /lib/modules/2.5.53/kernel/drivers/net/pcmcia/3c574_cs.ko needs unknown symbol restore_flags
WARNING: /lib/modules/2.5.53/kernel/drivers/net/pcmcia/3c574_cs.ko needs unknown symbol save_flags
WARNING: /lib/modules/2.5.53/kernel/drivers/char/ftape/lowlevel/ftape.ko needs unknown symbol cli
WARNING: /lib/modules/2.5.53/kernel/drivers/char/ftape/lowlevel/ftape.ko needs unknown symbol restore_flags
WARNING: /lib/modules/2.5.53/kernel/drivers/char/ftape/lowlevel/ftape.ko needs unknown symbol save_flags
WARNING: /lib/modules/2.5.53/kernel/drivers/char/ftape/lowlevel/ftape.ko needs unknown symbol sti

