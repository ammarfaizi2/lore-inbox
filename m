Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130075AbRANX61>; Sun, 14 Jan 2001 18:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129792AbRANX6Q>; Sun, 14 Jan 2001 18:58:16 -0500
Received: from [62.81.160.68] ([62.81.160.68]:58874 "EHLO smtp2.alehop.com")
	by vger.kernel.org with ESMTP id <S129784AbRANX5z>;
	Sun, 14 Jan 2001 18:57:55 -0500
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
From: "Ignacio Monge" <ignaciomonge@navegalia.com>
To: linux-kernel@vger.kernel.org
Subject: Linux-2.4.0ac0 compile error
X-Mailer: Pronto v2.2.3 On linux/CSV
Date: 15 Jan 2001 00:52:55 CET
Reply-To: "Ignacio Monge" <ignaciomonge@navegalia.com>
Message-Id: <20010114235806Z129784-403+262@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Trying to compile this kernel I got this message:

	[...]

	make[2]: Cambiando a directorio `/usr/src/linux/mm'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o shmem.o shmem.c
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
make[2]: Saliendo directorio `/usr/src/linux/mm'
make[1]: *** [first_rule] Error 2
make[1]: Saliendo directorio `/usr/src/linux/mm'
make: *** [_dir_mm] Error 2

	[...]



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
