Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131028AbRAQCeq>; Tue, 16 Jan 2001 21:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131240AbRAQCeh>; Tue, 16 Jan 2001 21:34:37 -0500
Received: from 209.102.21.2 ([209.102.21.2]:48907 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S131028AbRAQCeZ>;
	Tue, 16 Jan 2001 21:34:25 -0500
Message-ID: <3A64D444.CDC7DEB5@goingware.com>
Date: Tue, 16 Jan 2001 23:07:48 +0000
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Can't compile shmem.c in 2.4.0-ac9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following errors trying to build 2.4.0-ac9 just now.

I'll send you my .config upon request, or post it on my website

gcc -D__KERNEL__ -I/home/mike/Kernel/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686    -c -o shmem.o
shmem.c
shmem.c:971: `shmem_readlink' undeclared here (not in a function)
shmem.c:971: initializer element for `shmem_symlink_inode_operations.readlink'
is not constant
shmem.c:972: `shmem_follow_link' undeclared here (not in a function)
shmem.c:972: initializer element for
`shmem_symlink_inode_operations.follow_link' is not constant
shmem.c:973: initializer element for `shmem_symlink_inode_operations' is not
constant
shmem.c:973: initializer element for `shmem_symlink_inode_operations' is not
constant
make[2]: *** [shmem.o] Error 1
make[2]: Leaving directory `/home/mike/Kernel/linux/mm'
make[1]: *** [first_rule] Error 2
make[1]: Leaving directory `/home/mike/Kernel/linux/mm'
make: *** [_dir_mm] Er

Mike
-- 
Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

   Tilting at Windmills for a Better Tomorrow.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
