Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264938AbSK0X10>; Wed, 27 Nov 2002 18:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264939AbSK0X10>; Wed, 27 Nov 2002 18:27:26 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.223]:53921 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S264938AbSK0X1Z>; Wed, 27 Nov 2002 18:27:25 -0500
Date: Wed, 27 Nov 2002 18:27:36 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@linux-dev
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: 2.5.50 : arch/i386/mm/hugetblpage.c error
Message-ID: <Pine.LNX.4.44.0211271826270.2465-100000@linux-dev>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  While 'make bzImage', I received the following error.

Regards,
Frank

arch/i386/mm/hugetlbpage.c:610: parse error before `*'
arch/i386/mm/hugetlbpage.c: In function `hugetlb_sysctl_handler':
arch/i386/mm/hugetlbpage.c:611: number of arguments doesn't match prototype
include/linux/hugetlb.h:14: prototype declaration
arch/i386/mm/hugetlbpage.c:612: warning: implicit declaration of function `proc_dointvec'
arch/i386/mm/hugetlbpage.c:612: `table' undeclared (first use in this function)
arch/i386/mm/hugetlbpage.c:612: (Each undeclared identifier is reported only once
arch/i386/mm/hugetlbpage.c:612: for each function it appears in.)
arch/i386/mm/hugetlbpage.c:612: `write' undeclared (first use in this function)
arch/i386/mm/hugetlbpage.c:612: `file' undeclared (first use in this function)
arch/i386/mm/hugetlbpage.c:612: `buffer' undeclared (first use in this function)
arch/i386/mm/hugetlbpage.c:612: `length' undeclared (first use in this function)
make[1]: *** [arch/i386/mm/hugetlbpage.o] Error 1
make: *** [arch/i386/mm] Error 2

