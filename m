Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262815AbRFCGng>; Sun, 3 Jun 2001 02:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262816AbRFCGnZ>; Sun, 3 Jun 2001 02:43:25 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:61568 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S262815AbRFCGnW>;
	Sun, 3 Jun 2001 02:43:22 -0400
Message-ID: <3B19E4D0.885C50CA@candelatech.com>
Date: Sun, 03 Jun 2001 00:18:40 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Compile problem with ov511.c (Kernel 2.4.5)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/home/greear/kernel/2.4/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686
-DMODULE -DMODVERSIONS -include /home/greear/kernel/2.4/linux/include/linux/modversions.h   -c -o ov511.o ov511.c
ov511.c: In function `ov511_read_proc':
ov511.c:340: `version' undeclared (first use in this function)
ov511.c:340: (Each undeclared identifier is reported only once
ov511.c:340: for each function it appears in.)
make[2]: *** [ov511.o] Error 1
make[2]: Leaving directory `/home/greear/kernel/2.4/linux/drivers/usb'
make[1]: *** [_modsubdir_usb] Error 2
make[1]: Leaving directory `/home/greear/kernel/2.4/linux/drivers'
make: *** [_mod_drivers] Error 2

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
