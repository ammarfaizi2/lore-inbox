Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318756AbSH1HBb>; Wed, 28 Aug 2002 03:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318758AbSH1HBb>; Wed, 28 Aug 2002 03:01:31 -0400
Received: from cartero.austria.eu.net ([193.154.160.153]:48585 "EHLO
	cartero.austria.eu.net") by vger.kernel.org with ESMTP
	id <S318756AbSH1HBa>; Wed, 28 Aug 2002 03:01:30 -0400
Date: Wed, 28 Aug 2002 09:05:46 +0200
From: "Clemens 'Gullevek' Schwaighofer" <schwaigl@eunet.at>
X-Mailer: The Bat! (v1.61) Personal
Reply-To: "Clemens 'Gullevek' Schwaighofer" <schwaigl@eunet.at>
Organization: Chaos is just another way of organisation
X-Priority: 3 (Normal)
Message-ID: <46344979984.20020828090546@eunet.at>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: still ati fb errors with 2.5.31, thought patch applied
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linux,
it's 09:04 on 28.08.2002 

aty128fb.c: In function `aty128_pci_register':
aty128fb.c:1730: too many arguments to function `aty128find_ROM'
aty128fb.c:1736: warning: passing arg 1 of `aty128_get_pllinfo' from incompatible pointer type
aty128fb.c:1749: structure has no member named `mtrr'
aty128fb.c:1750: structure has no member named `vram_size'
aty128fb.c:1751: structure has no member named `mtrr'
aty128fb.c: At top level:
aty128fb.c:1402: warning: `aty128fb_rasterimg' defined but not used
make[3]: *** [aty128fb.o] Error 1
make[3]: Leaving directory `/usr/src/kernel/2.5.32/linux-2.5.32/drivers/video'
make[2]: *** [video] Error 2
make[2]: Leaving directory `/usr/src/kernel/2.5.32/linux-2.5.32/drivers'
make[1]: *** [drivers] Error 2
make[1]: Leaving directory `/usr/src/kernel/2.5.32/linux-2.5.32'
make: *** [bzImage] Error 2

gcc 3.2

I have applied the atifb patch postet earlier (19th august by Paul
Mackerras), but still get this error ...

Best regards, Clemens
-- 
_________/\_____________________              ^_^             ()~()
Clemens 'Gullevek' Schwaighofer \_______ @_@       ^_~       //@ @\\
ICQ#: 9646646        I AM FROM AUSTRIA! \______________ °_° //\ ~ /\\
http://www.animeundmanga.at | http://www.gullevek.org  \_____________

