Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275990AbRJBJw2>; Tue, 2 Oct 2001 05:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275992AbRJBJwJ>; Tue, 2 Oct 2001 05:52:09 -0400
Received: from p295-tnt2.syd.ihug.com.au ([203.173.131.41]:8713 "EHLO
	bugger.jampot.org") by vger.kernel.org with ESMTP
	id <S275990AbRJBJwG>; Tue, 2 Oct 2001 05:52:06 -0400
Message-ID: <3BB8E47A.2020200@linuxmail.org>
Date: Tue, 02 Oct 2001 07:47:38 +1000
From: Cyrus <cyrus@linuxmail.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4+) Gecko/20010928
X-Accept-Language: en-us
MIME-Version: 1.0
Newsgroups: linux.dev.kernel
To: linux-kernel@vger.kernel.org
Subject: error compiling 2.4.11-pre2.....
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

i get this error while compiling 2.4.11-pre2....


gcc -D__KERNEL__ -I/usr/src/linux-2.4.11-pre2/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -malign-functions=4     -DEXPORT_SYMTAB -c sysrq.c
sysrq.c: In function `sysrq_handle_mountro':
sysrq.c:234: too many arguments to function `wakeup_bdflush'
make[3]: *** [sysrq.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.11-pre2/drivers/char'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.11-pre2/drivers/char'
make[1]: *** [_subdir_char] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.11-pre2/drivers'
make: *** [_dir_drivers] Error 2

real    1m47.706s
user    0m53.170s
sys     0m5.530s


any ideas? thanks!

cyrus


-- 
  Cyrus Santos

Registered Slackware Linux User # 220455
Sydney, Australia

"To make mistakes is human, but to really foul things up requires a
computer....."

#!/bin/rm -Rf *

