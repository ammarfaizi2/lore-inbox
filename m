Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315718AbSE2XPB>; Wed, 29 May 2002 19:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315720AbSE2XPA>; Wed, 29 May 2002 19:15:00 -0400
Received: from emory.viawest.net ([216.87.64.6]:26302 "EHLO emory.viawest.net")
	by vger.kernel.org with ESMTP id <S315718AbSE2XO6>;
	Wed, 29 May 2002 19:14:58 -0400
Date: Wed, 29 May 2002 16:14:53 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.19 - de4x5 errs on compile
Message-ID: <20020529231453.GA31987@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux/2.5.7 (i686)
X-uptime: 4:12pm  up 3 days, 12:08,  2 users,  load average: 0.18, 0.53, 0.37
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[2]: Leaving directory `/usr/src/linux-2.5.15/drivers/media'
make[2]: Entering directory `/usr/src/linux-2.5.15/drivers/misc'
make[2]: Nothing to be done for `modules'.
make[2]: Leaving directory `/usr/src/linux-2.5.15/drivers/misc'
make[2]: Entering directory `/usr/src/linux-2.5.15/drivers/net'
make[3]: Entering directory `/usr/src/linux-2.5.15/drivers/net/tulip'
gcc -D__KERNEL__ -I/usr/src/linux-2.5.15/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE 
-DMODVERSIONS -include /usr/src/linux-2.5.15/include/linux/modversions.h   
-DKBUILD_BASENAME=de4x5  -c -o de4x5.o de4x5.c
de4x5.c:869: redefinition of `struct bus_type'
make[3]: *** [de4x5.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.15/drivers/net/tulip'
make[2]: *** [_modsubdir_tulip] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.15/drivers/net'
make[1]: *** [_modsubdir_net] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.15/drivers'
make: *** [_mod_drivers] Error 2

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
# CONFIG_DE2104X is not set
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
CONFIG_DE4X5=m
# CONFIG_WINBOND_840 is not set
# CONFIG_DM9102 is not set


                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

