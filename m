Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310437AbSCBUUr>; Sat, 2 Mar 2002 15:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310439AbSCBUUi>; Sat, 2 Mar 2002 15:20:38 -0500
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:10461 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S310437AbSCBUUW>;
	Sat, 2 Mar 2002 15:20:22 -0500
Message-ID: <3C813400.8080001@candelatech.com>
Date: Sat, 02 Mar 2002 13:20:16 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.19-pre2 compile bug
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/home/greear/kernel/2.4/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /home/greear/kernel/2.4/linux/include/linux/modversions.h  -DKBUILD_BASENAME=cciss  -c -o cciss.o cciss.c
cciss.c: In function `cciss_remove_one':
cciss.c:2129: too few arguments to function `sendcmd'
make[2]: *** [cciss.o] Error 1
make[2]: Leaving directory `/home/greear/kernel/2.4/linux/drivers/block'
make[1]: *** [_modsubdir_block] Error 2
make[1]: Leaving directory `/home/greear/kernel/2.4/linux/drivers'
make: *** [_mod_drivers] Error 2

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


