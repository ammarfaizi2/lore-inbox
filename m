Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265603AbRF1IuJ>; Thu, 28 Jun 2001 04:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265605AbRF1It7>; Thu, 28 Jun 2001 04:49:59 -0400
Received: from [212.171.138.189] ([212.171.138.189]:53377 "HELO castle.iws.it")
	by vger.kernel.org with SMTP id <S265603AbRF1Itn>;
	Thu, 28 Jun 2001 04:49:43 -0400
Subject: problem building 2.4.6 pre 6 + freevxfs
From: Giampaolo Gallo <gp@iws.it>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 28 Jun 2001 10:49:38 +0200
Message-Id: <993718178.8885.0.camel@castle>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/u1/usr.src/linux/include -Wall -Wstrict-prototypes
-Wno-traphs -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-bdary=2 -march=i686    -c -o vxfs_inode.o vxfs_inode.c
vxfs_inode.c:50: `generic_file_llseek' undeclared here (not in a
function)
vxfs_inode.c:50: initializer element is not constant
vxfs_inode.c:50: (near initialization for `vxfs_file_operations.llseek')
make[3]: *** [vxfs_inode.o] Error 1
make[3]: Leaving directory `/u1/usr.src/linux/fs/freevxfs'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/u1/usr.src/linux/fs/freevxfs'
make[1]: *** [_subdir_freevxfs] Error 2
make[1]: Leaving directory `/u1/usr.src/linux/fs'
make: *** [_dir_fs] Error 2


