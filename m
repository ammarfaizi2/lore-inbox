Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129601AbRANCdo>; Sat, 13 Jan 2001 21:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129604AbRANCde>; Sat, 13 Jan 2001 21:33:34 -0500
Received: from alex.intersurf.net ([216.115.129.11]:36359 "HELO
	alex.intersurf.net") by vger.kernel.org with SMTP
	id <S129601AbRANCd0>; Sat, 13 Jan 2001 21:33:26 -0500
Message-ID: <XFMail.20010113203319.markorr@intersurf.com>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <01011318404000.18233@localhost.localdomain>
Date: Sat, 13 Jan 2001 20:33:19 -0600 (CST)
Reply-To: Mark Orr <markorr@intersurf.com>
From: Mark Orr <markorr@intersurf.com>
To: Steven Cole <elenstev@mesatop.com>
Subject: Re: Linux 2.4.0-ac9 (shmem.c errors)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 14-Jan-2001 Steven Cole wrote:
> I got the following error while building 2.4.0-ac9:
> 
> shmem.c:971: `shmem_readlink' undeclared here (not in a function)
> shmem.c:971: initializer element is not constant
> shmem.c:971: (near initialization for 
> `shmem_symlink_inode_operations.readlink')
> shmem.c:972: `shmem_follow_link' undeclared here (not in a function)
> shmem.c:972: initializer element is not constant
> shmem.c:972: (near initialization for 
> `shmem_symlink_inode_operations.follow_link')
> shmem.c:973: initializer element is not constant
> shmem.c:973: (near initialization for `shmem_symlink_inode_operations')
> shmem.c:973: initializer element is not constant
> shmem.c:973: (near initialization for `shmem_symlink_inode_operations')
> make[2]: *** [shmem.o] Error 1
> 
> It looks like changes were recently made to linux/mm/shmem.c.

I'm getting the same errors here.  Christoph Rohland submitted
a series of shm patches to the list -- I tried --dry-run reapplying
them and at least a couple of them partially applied.  Looks like
it didnt all get integrated.

--
Mark Orr
markorr@intersurf.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
