Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133004AbREEUQe>; Sat, 5 May 2001 16:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133084AbREEUQY>; Sat, 5 May 2001 16:16:24 -0400
Received: from fsuj20.rz.uni-jena.de ([141.35.1.18]:63704 "EHLO
	fsuj20.rz.uni-jena.de") by vger.kernel.org with ESMTP
	id <S133004AbREEUQK>; Sat, 5 May 2001 16:16:10 -0400
>Received: (from pfk@localhost)
	by fuchs.offl.uni-jena.de (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) id VAA12117;
	Sat, 5 May 2001 21:08:02 +0200
Date: Sat, 5 May 2001 21:08:01 +0200
From: Frank Klemm <pfk@fuchs.offl.uni-jena.de>
To: linux-kernel@vger.kernel.org, linux-kernel@vger.rutgers.edu
Subject: Compile time error, Kernel 2.4.3
Message-ID: <20010505210801.A12000@fuchs.offl.uni-jena.de>
Mime-Version: 1.0
X-Mailer: Mutt 1.0.1i
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While compiling 2.4.3 I got the following message:

gcc -D__KERNEL__ -I/var/src/linux-2.4.3/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /var/src/linux-2.4.3/include/linux/modversions.h   -c -o inode.o inode.c
buz.c: In function `v4l_fbuffer_alloc':
buz.c:188: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:188: (Each undeclared identifier is reported only once
buz.c:188: for each function it appears in.)
buz.c: In function 
pg_fbuffer_alloc':
buz.c:262: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:256: warning: `alloc_contig' might be used uninitialized in this function
buz.c: In function 
pg_fbuffer_free':
buz.c:322: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:316: warning: `alloc_contig' might be used uninitialized in this function

-- 
Frank Klemm

