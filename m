Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275012AbRJUAGv>; Sat, 20 Oct 2001 20:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275003AbRJUAGm>; Sat, 20 Oct 2001 20:06:42 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:47772 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S275012AbRJUAGa>;
	Sat, 20 Oct 2001 20:06:30 -0400
Message-ID: <3BD211A7.DFD4AD9C@candelatech.com>
Date: Sat, 20 Oct 2001 17:07:03 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Compile error with -pre5 (i2o & pdev)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[2]: Entering directory `/home/greear/kernel/2.4/linux/drivers/message/i2o'
gcc -D__KERNEL__ -I/home/greear/kernel/2.4/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /home/greear/kernel/2.4/linux/include/linux/modversions.h   -DEXPORT_SYMTAB -c i2o_pci.c
i2o_pci.c: In function `i2o_pci_install':
i2o_pci.c:165: structure has no member named `pdev'
make[2]: *** [i2o_pci.o] Error 1
make[2]: Leaving directory `/home/greear/kernel/2.4/linux/drivers/message/i2o'
make[1]: *** [_modsubdir_message/i2o] Error 2
make[1]: Leaving directory `/home/greear/kernel/2.4/linux/drivers'
make: *** [_mod_drivers] Error 2

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
