Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270339AbRHSLD4>; Sun, 19 Aug 2001 07:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270343AbRHSLDq>; Sun, 19 Aug 2001 07:03:46 -0400
Received: from pD95171C3.dip.t-dialin.net ([217.81.113.195]:44111 "EHLO
	mousehomenet.homenet") by vger.kernel.org with ESMTP
	id <S270339AbRHSLD1>; Sun, 19 Aug 2001 07:03:27 -0400
Message-ID: <3B7F9D0A.3070805@rz.uni-potsdam.de>
Date: Sun, 19 Aug 2001 13:03:38 +0200
From: Juergen Rose <rose@rz.uni-potsdam.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010728
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Can't compile ntfs modules with 2.4.9
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

compiling linux-2.4.9 I get:
gcc -D__KERNEL__ -I/usr/src_mousehomenet/linux-2.4.9/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include 
/usr/src_mousehomenet/linux-2.4.9/include/linux/modversions.h 
-DNTFS_VERSION=\"1.1.16\"   -c -o unistr.o unistr.c
unistr.c: In function `ntfs_collate_names':
unistr.c:99: warning: implicit declaration of function `min'
unistr.c:99: parse error before `unsigned'
unistr.c:99: parse error before `)'
unistr.c:97: warning: `c1' might be used uninitialized in this function
unistr.c: At top level:
unistr.c:118: parse error before `if'
unistr.c:123: warning: type defaults to `int' in declaration of `c1'
unistr.c:123: `name1' undeclared here (not in a function)
unistr.c:123: warning: data definition has no type or storage class
unistr.c:124: parse error before `if'
make[2]: *** [unistr.o] Error 1

Is there any help?

With best regards
        Juergen


