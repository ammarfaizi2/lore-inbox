Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283922AbRLAErx>; Fri, 30 Nov 2001 23:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283921AbRLAEro>; Fri, 30 Nov 2001 23:47:44 -0500
Received: from mgr2.xmission.com ([198.60.22.202]:8964 "EHLO mgr2.xmission.com")
	by vger.kernel.org with ESMTP id <S281463AbRLAErZ>;
	Fri, 30 Nov 2001 23:47:25 -0500
Message-ID: <3C0860DB.60905@xmission.com>
Date: Fri, 30 Nov 2001 21:47:23 -0700
From: Frank Jacobberger <f1j@xmission.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: More problems with 2.5.0-pre5 than pre4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What do you make of this from a attempted compile of 2.5.0-pre5:

gcc -D__KERNEL__ -I/usr/src/linux-2.5.0/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686    -c -o rd.o rd.c
rd.c:561: `rd_cleanup' undeclared here (not in a function)
make[3]: *** [rd.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5.0/drivers/block'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5.0/drivers/block'
make[1]: *** [_subdir_block] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.0/drivers'
make: *** [_dir_drivers] Error 2

Thanks,

Frank

