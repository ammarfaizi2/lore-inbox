Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293703AbSCFRFy>; Wed, 6 Mar 2002 12:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293689AbSCFREJ>; Wed, 6 Mar 2002 12:04:09 -0500
Received: from agamemnon.cnchost.com ([207.155.252.31]:34723 "EHLO
	agamemnon.cnchost.com") by vger.kernel.org with ESMTP
	id <S293693AbSCFRDr>; Wed, 6 Mar 2002 12:03:47 -0500
Message-ID: <200203061703.MAA17490@agamemnon.cnchost.com>
Content-Type: text/plain; charset=US-ASCII
From: Elias Dagher <edagher@ditrans.com>
Organization: Ditrans Corp.
To: linux-kernel@vger.kernel.org
Subject: make bzImage fails on ram disk code in 2.5.5
Date: Wed, 6 Mar 2002 09:00:25 -0800
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am getting the following error when I do a make bzImage:

gcc -D__KERNEL__ -I/tmp/linux-2.5.5/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=athlon    -DKBUILD_BASENAME=rd  -c 
-o rd.o rd.c
rd.c: In function `rd_make_request':
rd.c:271: too many arguments to function
make[3]: *** [rd.o] Error 1
make[3]: Leaving directory `/tmp/linux-2.5.5/drivers/block'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/tmp/linux-2.5.5/drivers/block'
make[1]: *** [_subdir_block] Error 2
make[1]: Leaving directory `/tmp/linux-2.5.5/drivers'
make: *** [_dir_drivers] Error 2


Can some one please tell me what the problem is so that I can correct it?  I 
want to use this kernel because of its new scheduler.


ED
