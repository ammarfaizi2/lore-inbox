Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289099AbSBDRAU>; Mon, 4 Feb 2002 12:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289096AbSBDRAK>; Mon, 4 Feb 2002 12:00:10 -0500
Received: from vracs001.vrac.iastate.edu ([129.186.232.215]:60430 "EHLO
	vracs001.vrac.iastate.edu") by vger.kernel.org with ESMTP
	id <S289074AbSBDRAF>; Mon, 4 Feb 2002 12:00:05 -0500
Subject: Re: Linux 2.5.3-dj2
From: "Daniel E. Shipton" <dshipton@vrac.iastate.edu>
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020204154800.A13519@suse.de>
In-Reply-To: <20020204154800.A13519@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 04 Feb 2002 10:54:09 -0600
Message-Id: <1012841649.8335.6.camel@regatta>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.3dj-1 would make bzimage and then die on the modules.....

this is 2.5.3-dj2 and
make bzImage dies and results in the following below........



gcc -D__KERNEL__ -I/home/kernel/linux-2.5/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686   -DKBUILD_BASENAME=ptrace  -c -o ptrace.o ptrace.c
In file included from ptrace.c:13:
/home/kernel/linux-2.5/include/linux/highmem.h: In function `bh_kmap':
/home/kernel/linux-2.5/include/linux/highmem.h:21: dereferencing pointer
to incomplete type
/home/kernel/linux-2.5/include/linux/highmem.h:21: warning: implicit
declaration of function `bh_offset'
/home/kernel/linux-2.5/include/linux/highmem.h: In function `bh_kunmap':
/home/kernel/linux-2.5/include/linux/highmem.h:26: dereferencing pointer
to incomplete type
make[2]: *** [ptrace.o] Error 1
make[2]: Leaving directory `/home/kernel/linux-2.5/kernel'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/home/kernel/linux-2.5/kernel'
make: *** [_dir_kernel] Error 2

