Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264944AbSK0XrN>; Wed, 27 Nov 2002 18:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264946AbSK0XrN>; Wed, 27 Nov 2002 18:47:13 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.223]:2218 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S264944AbSK0XrN>; Wed, 27 Nov 2002 18:47:13 -0500
Date: Wed, 27 Nov 2002 18:47:23 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@linux-dev
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: 2.5.50 : fs/hugetlbfs/inode.c error
Message-ID: <Pine.LNX.4.44.0211271845410.4018-100000@linux-dev>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  While 'make bzImage', I received the following error:

Regards,
Frank

fs/hugetlbfs/inode.c: In function `hugetlbfs_delete_inode':
fs/hugetlbfs/inode.c:212: `security_ops' undeclared (first use in this function)
fs/hugetlbfs/inode.c:212: (Each undeclared identifier is reported only once
fs/hugetlbfs/inode.c:212: for each function it appears in.)
fs/hugetlbfs/inode.c: In function `hugetlbfs_setattr':
fs/hugetlbfs/inode.c:336: `security_ops' undeclared (first use in this function)
make[2]: *** [fs/hugetlbfs/inode.o] Error 1
make[1]: *** [fs/hugetlbfs] Error 2
make: *** [fs] Error 2

