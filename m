Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135550AbREBOzA>; Wed, 2 May 2001 10:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135574AbREBOyu>; Wed, 2 May 2001 10:54:50 -0400
Received: from norma.kjist.ac.kr ([203.237.41.18]:12673 "EHLO
	norma.kjist.ac.kr") by vger.kernel.org with ESMTP
	id <S135550AbREBOym>; Wed, 2 May 2001 10:54:42 -0400
Date: Wed, 2 May 2001 10:24:18 +0900
From: Maintaniner on duty <hugh@norma.kjist.ac.kr>
Message-Id: <200105020124.f421OIG01555@norma.kjist.ac.kr>
To: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Both 2.4.4aa2 and 2.4.4aa3 fail to compile
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With gcc-2.95.2 provided by SuSE-7.0 for Alpha on UP2000 SMP with 2GB memory


gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mno-fp-regs -ffixed-8 -mcpu=ev6 -Wa,-mev6    -c -o extable.o extable.c
extable.c: In function `search_exception_table_without_gp':
extable.c:54: `modlist_lock' undeclared (first use in this function)
extable.c:54: (Each undeclared identifier is reported only once
extable.c:54: for each function it appears in.)
make[2]: *** [extable.o] Error 1
make[2]: Leaving directory `/usr/src/linux/arch/alpha/mm'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux/arch/alpha/mm'
make: *** [_dir_arch/alpha/mm] Error 2


Regards,

G. Hugh Song

ghsong at kjist dot ac dot kr
