Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268275AbUIKSaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268275AbUIKSaP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 14:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268278AbUIKSaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 14:30:15 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:40845 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S268275AbUIKSaE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 14:30:04 -0400
Subject: [PPC32] 2.6.9-rc1-bk18 5 warnings, 1 error
From: =?ISO-8859-1?Q?Beno=EEt?= Dejean <benoit.dejean@placenet.org>
Reply-To: TazForEver@dlfp.org
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Date: Sat, 11 Sep 2004 20:29:51 +0200
Message-Id: <1094927391.28584.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

gcc (GCC) 3.3.4 (Debian 1:3.3.4-11)

make defconfig && make

  CC      drivers/char/random.o
drivers/char/random.c: In function `add_timer_randomness':
drivers/char/random.c:822: warning: right shift count >= width of type

  CC      drivers/cpufreq/proc_intf.o
drivers/cpufreq/proc_intf.c:15:2: warning: #warning This module will be
removed from the 2.6. kernel series soon after 2005-01-01
 
  CC      drivers/ide/ide-iops.o
drivers/ide/ide-iops.c: In function `ide_mm_insw':
drivers/ide/ide-iops.c:125: warning: passing arg 1 of `__ide_mm_insw'
makes integer from pointer without a cast
drivers/ide/ide-iops.c: In function `ide_mm_insl':
drivers/ide/ide-iops.c:135: warning: passing arg 1 of `__ide_mm_insl'
makes integer from pointer without a cast
drivers/ide/ide-iops.c: In function `ide_mm_outsw':
drivers/ide/ide-iops.c:155: warning: passing arg 1 of `__ide_mm_outsw'
makes integer from pointer without a cast
drivers/ide/ide-iops.c: In function `ide_mm_outsl':
drivers/ide/ide-iops.c:165: warning: passing arg 1 of `__ide_mm_outsl'
makes integer from pointer without a cast

  CC [M]  sound/oss/dmasound/tas3001c.o
sound/oss/dmasound/tas3001c.c:162: warning: `tas3001c_read_register'
defined but not used

  CC [M]  sound/oss/dmasound/tas3004.o
sound/oss/dmasound/tas3004.c:330: warning: `tas3004_read_register'
defined but not used

  AR      arch/ppc/boot/lib/lib.a
ar: arch/ppc/boot/lib/infblock.o: No such file or directory
make[2]: *** [arch/ppc/boot/lib/lib.a] Error 1
make[1]: *** [arch/ppc/boot/lib] Error 2
make: *** [zImage] Error 2

-- 
Benoît Dejean
JID: TazForEver@jabber.org
gDesklets http://gdesklets.gnomedesktop.org
LibGTop http://directory.fsf.org/libgtop.html
http://www.paulla.asso.fr

