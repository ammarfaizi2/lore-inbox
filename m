Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317034AbSGXV7l>; Wed, 24 Jul 2002 17:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317579AbSGXV7l>; Wed, 24 Jul 2002 17:59:41 -0400
Received: from the-penguin.otak.com ([216.122.56.136]:45458 "EHLO
	the-penguin.otak.com") by vger.kernel.org with ESMTP
	id <S317034AbSGXV7k>; Wed, 24 Jul 2002 17:59:40 -0400
Date: Wed, 24 Jul 2002 15:02:23 -0700
From: Lawrence Walton <lawrence@the-penguin.otak.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: CMIPCI
Message-ID: <20020724220223.GA761@the-penguin.otak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.5.24 on an i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like CMIPCI does not compile right now.

gcc -Wp,-MD,./.cmipci.o.d -D__KERNEL__ -I/usr/src/linux-2.5.28/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -g -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=cmipci   -c -o cmipci.o cmipci.c
cmipci.c:2482: macro `synchronize_irq' used without args
cmipci.c:2739: warning: `snd_cmipci_remove' defined but not used
make[2]: *** [cmipci.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.28/sound/pci'
make[1]: *** [pci] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.28/sound'
make: *** [sound] Error 2

-- 
*--* Mail: lawrence@otak.com
*--* Voice: 425.739.4247
*--* Fax: 425.827.9577
*--* HTTP://www.otak-k.com/~lawrence/
--------------------------------------
- - - - - - O t a k  i n c . - - - - - 


