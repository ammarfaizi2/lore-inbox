Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289338AbSBNBxb>; Wed, 13 Feb 2002 20:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289342AbSBNBxV>; Wed, 13 Feb 2002 20:53:21 -0500
Received: from mgr2.xmission.com ([198.60.22.202]:12036 "EHLO
	mgr2.xmission.com") by vger.kernel.org with ESMTP
	id <S289338AbSBNBxI>; Wed, 13 Feb 2002 20:53:08 -0500
Message-ID: <3C6B1883.8080105@xmission.com>
Date: Wed, 13 Feb 2002 18:53:07 -0700
From: Frank Jacobberger <f1j@xmission.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.5-pre1 and rd.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying a make bzImage netted this nice little problem:
------------------------------------------------------------------------------------------------------------------------------
gcc -D__KERNEL__ -I/usr/src/linux-2.5.4/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe
-mpreferred-stack-boundary=2 -march=i686   -DKBUILD_BASENAME=rd  -c -o 
rd.o rd.c
rd.c: In function `rd_make_request':
rd.c:271: too many arguments to function
make[3]: *** [rd.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.4/drivers/block'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.4/drivers/block'
make[1]: *** [_subdir_block] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.4/drivers'
make: *** [_dir_drivers] Error 2

Any ideas?

Thanks,

Frank

