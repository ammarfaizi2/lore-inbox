Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130649AbQLWTOh>; Sat, 23 Dec 2000 14:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130670AbQLWTO2>; Sat, 23 Dec 2000 14:14:28 -0500
Received: from f1j.dsl.xmission.com ([166.70.20.140]:56879 "EHLO
	f1j.dsl.xmission.com") by vger.kernel.org with ESMTP
	id <S130649AbQLWTOP>; Sat, 23 Dec 2000 14:14:15 -0500
Message-ID: <3A44F25E.6FE2ECBD@xmission.com>
Date: Sat, 23 Dec 2000 11:43:43 -0700
From: Frank Jacobberger <f1j@xmission.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RH 7 update of 2.96 gcc and make
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems stable enough... the following are excerpts of some of the
warnings on make bzImage:

-------------

-boundary=2 -march=i686    -c -o tcp_input.o tcp_input.c
tcp_input.c:1944:78: warning: pasting would not give a valid
preprocessing token
tcp_input.c:2478:76: warning: pasting would not give a valid
preprocessing token
tcp_input.c:2485:52: warning: pasting would not give a valid
preprocessing token
tcp_input.c:2591:52: warning: pasting would not give a valid
preprocessing token
tcp_input.c:2604:79: warning: pasting would not give a valid
preprocessing token
tcp_input.c:2733:61: warning: pasting would not give a valid
preprocessing token

-------------

make[3]: Entering directory `/usr/src/linux-2.4.0-test12/fs/smbfs'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686  -DSMBFS_PARANOIA  -c -o proc.o
proc.c
In file included from proc.c:27:
smb_debug.h:14:56: warning: nothing can be pasted after this token
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686  -DSMBFS_PARANOIA  -c -o dir.o
dir.c
In file included from dir.c:20:
smb_debug.h:14:56: warning: nothing can be pasted after this token
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686  -DSMBFS_PARANOIA  -c -o
cache.o cache.c
In file included from cache.c:23:
smb_debug.h:14:56: warning: nothing can be pasted after this token
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686  -DSMBFS_PARANOIA  -c -o sock.o
sock.c
In file included from sock.c:29:
smb_debug.h:14:56: warning: nothing can be pasted after this token
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686  -DSMBFS_PARANOIA  -c -o
inode.o inode.c
In file included from inode.c:33:
smb_debug.h:14:56: warning: nothing can be pasted after this token
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686  -DSMBFS_PARANOIA  -c -o file.o
file.c
In file included from file.c:26:
smb_debug.h:14:56: warning: nothing can be pasted after this token

-----------

-boundary=2 -march=i686    -c -o pci-pc.o pci-pc.c
{standard input}: Assembler messages:
{standard input}:802: Warning: indirect lcall without `*'
{standard input}:887: Warning: indirect lcall without `*'
{standard input}:973: Warning: indirect lcall without `*'
{standard input}:1011: Warning: indirect lcall without `*'
{standard input}:1043: Warning: indirect lcall without `*'
{standard input}:1075: Warning: indirect lcall without `*'
{standard input}:1106: Warning: indirect lcall without `*'
{standard input}:1135: Warning: indirect lcall without `*'
{standard input}:1164: Warning: indirect lcall without `*'
{standard input}:1451: Warning: indirect lcall without `*'
{standard input}:1547: Warning: indirect lcall without `*'


There! It still compiled alright and life moves on....

Frank :) Merry Christmas

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
