Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267131AbTBIItZ>; Sun, 9 Feb 2003 03:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267180AbTBIItZ>; Sun, 9 Feb 2003 03:49:25 -0500
Received: from [212.71.168.94] ([212.71.168.94]:22750 "HELO ghost.cybernet.cz")
	by vger.kernel.org with SMTP id <S267131AbTBIItY>;
	Sun, 9 Feb 2003 03:49:24 -0500
Date: Sun, 9 Feb 2003 09:59:06 +0100 (MET)
From: <brain@artax.karlin.mff.cuni.cz>
To: <linux-kernel@vger.kernel.org>
Subject: 3c509 driver doesn't compile in 2.5.59
Message-ID: <Pine.LNX.4.30.0302090957570.12534-100000@ghost.cybernet.cz>
X-Echelon: GRU Vatutinki Chodynka Khodinka Putin Suvorov USA Aquarium Russia Ladygin Lybia China Moscow missile reconnaissance agent spetsnaz security tactical target operation military nuclear force defense spy attack bomb explode tap MI5 IRS KGB CIA FBI NSA AK-47 MOSSAD M16 plutonium smuggle intercept plan intelligence war analysis president
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

When I turn on 3c509 support in 2.5.59 kernel and try to compile, I get:

gcc -Wp,-MD,drivers/net/.3c509.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=k6 -Iinclude/asm-i386/mach-default
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=3c509
-DKBUILD_MODNAME=3c509   -c -o drivers/net/3c509.o drivers/net/3c509.c
drivers/net/3c509.c: In function `el3_probe':
drivers/net/3c509.c:479: warning: `__check_region' is deprecated (declared at
include/linux/ioport.h:111)
drivers/net/3c509.c: In function `el3_close':
drivers/net/3c509.c:1083: structure has no member named `edev'
make[2]: *** [drivers/net/3c509.o] Error 1
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

I'm not able to attach my config file because you'r mailing system rejects the
mail even when I put the config into body of the message.

Brain

--------------------------------
Petr `Brain' Kulhavy
<brain@artax.karlin.mff.cuni.cz>
http://artax.karlin.mff.cuni.cz/~brain
Faculty of Mathematics and Physics, Charles University Prague, Czech Republic

---
Mr. Cole's Axiom:
        The sum of the intelligence on the planet is a constant; the
        population is growing.




