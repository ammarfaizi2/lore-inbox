Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131415AbRANBjN>; Sat, 13 Jan 2001 20:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131578AbRANBjD>; Sat, 13 Jan 2001 20:39:03 -0500
Received: from d136.as5200.mesatop.com ([208.164.122.136]:58252 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S131415AbRANBi4>; Sat, 13 Jan 2001 20:38:56 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
Date: Sat, 13 Jan 2001 18:40:40 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: Re: Linux 2.4.0-ac9
MIME-Version: 1.0
Message-Id: <01011318404000.18233@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following error while building 2.4.0-ac9:

shmem.c:971: `shmem_readlink' undeclared here (not in a function)
shmem.c:971: initializer element is not constant
shmem.c:971: (near initialization for 
`shmem_symlink_inode_operations.readlink')
shmem.c:972: `shmem_follow_link' undeclared here (not in a function)
shmem.c:972: initializer element is not constant
shmem.c:972: (near initialization for 
`shmem_symlink_inode_operations.follow_link')
shmem.c:973: initializer element is not constant
shmem.c:973: (near initialization for `shmem_symlink_inode_operations')
shmem.c:973: initializer element is not constant
shmem.c:973: (near initialization for `shmem_symlink_inode_operations')
make[2]: *** [shmem.o] Error 1

It looks like changes were recently made to linux/mm/shmem.c.

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
