Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311650AbSCXHBM>; Sun, 24 Mar 2002 02:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311664AbSCXHAw>; Sun, 24 Mar 2002 02:00:52 -0500
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:43486 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S311650AbSCXHAo>;
	Sun, 24 Mar 2002 02:00:44 -0500
Message-ID: <3C9D799C.3070300@candelatech.com>
Date: Sun, 24 Mar 2002 00:00:44 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: bk repository compile bug (zoran)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just in case this has not been caught yet, from repository:
  bk://linux.bkbits.net/linux-2.4


gcc -D__KERNEL__ -I/home/greear/kernel/2.4/bk/linux-2.4/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon  -DMODULE -DMODVERSIONS -include /home/greear/kernel/2.4/bk/linux-2.4/include/linux/modversions.h  -DKBUILD_BASENAME=zr36067  -c -o zr36067.o zr36067.c
zr36067.c: In function `zoran_open':
zr36067.c:3268: structure has no member named `busy'
zr36067.c: At top level:
zr36067.c:4405: warning: initialization makes integer from pointer without a cast
zr36067.c:4406: warning: initialization makes integer from pointer without a cast
zr36067.c:4407: warning: initialization from incompatible pointer type
zr36067.c:4408: warning: initialization from incompatible pointer type
zr36067.c:4410: warning: initialization from incompatible pointer type
zr36067.c:4411: warning: initialization from incompatible pointer type
zr36067.c:4412: warning: initialization from incompatible pointer type
make[3]: *** [zr36067.o] Error 1
make[3]: Leaving directory `/home/greear/kernel/2.4/bk/linux-2.4/drivers/media/video'

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


