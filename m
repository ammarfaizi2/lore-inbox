Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276558AbRJPRnM>; Tue, 16 Oct 2001 13:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276538AbRJPRmp>; Tue, 16 Oct 2001 13:42:45 -0400
Received: from ip-216-23-53-86.adsl.one.net ([216.23.53.86]:62879 "EHLO
	chinchilla.toadis.porkis") by vger.kernel.org with ESMTP
	id <S276522AbRJPRmN>; Tue, 16 Oct 2001 13:42:13 -0400
From: Dale E Martin <dmartin@cliftonlabs.com>
Date: Tue, 16 Oct 2001 13:42:40 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4.12-ac3 compilation error
Message-ID: <20011016134240.A32454@cliftonlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  I'm trying to run 2.4.12-ac3 and I get the following compilation
error:
make[2]: Entering directory `/usr/src/linux.ac/mm'
gcc -D__KERNEL__ -I/usr/src/linux.ac/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=i686    -c -o mmap.o mmap.c
mmap.c: In function `vm_enough_memory':
mmap.c:68: `shmem_nrpages' undeclared (first use in this function)
mmap.c:68: (Each undeclared identifier is reported only once
mmap.c:68: for each function it appears in.)
make[2]: *** [mmap.o] Error 1
make[2]: Leaving directory `/usr/src/linux.ac/mm'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/usr/src/linux.ac/mm'
make: *** [_dir_mm] Error 2

I've grepped around and I don't see a definition for shmem_nrpages,
although it is used in a number of places.  Thanks for any tips - btw, I'm
not currently subscribed to this list so please Cc me any answers.

Thanks,
	Dale
-- 
Dale E. Martin, Clifton Labs, Inc.
Senior Computer Engineer
dmartin@cliftonlabs.com
http://www.cliftonlabs.com
pgp key available
