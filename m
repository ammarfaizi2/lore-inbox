Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286522AbRLUBv2>; Thu, 20 Dec 2001 20:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286523AbRLUBvT>; Thu, 20 Dec 2001 20:51:19 -0500
Received: from mtiwmhc21.worldnet.att.net ([204.127.131.46]:60614 "EHLO
	mtiwmhc21.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S286522AbRLUBvJ>; Thu, 20 Dec 2001 20:51:09 -0500
Date: Thu, 20 Dec 2001 20:47:15 -0500 (EST)
From: Goldencat <goldencat@ezdelivery.net>
X-X-Sender: <goldencat@goldencat.goldencat.com>
Reply-To: <ruili@worldnet.att.net>
To: <aia21@cus.cam.ac.uk>
cc: <linux-ntfs-dev@lists.sourceforge.net>
Subject: ntfs on 2.4.12-0.1
Message-ID: <Pine.LNX.4.33.0112202041560.25032-100000@goldencat.goldencat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mounting winXP file system with readonly.
cd /mnt/xp
cd WINDOWS
ls
segment fault


NTFS driver v<3>NTFS: Warning! NTFS volume version is Win2k+: Mounting
read-only
------------[ cut here ]------------
kernel BUG at fs.c:308!
invalid operand: 0000
CPU:    0
EIP:    0010:[<d095f539>]    Tainted: P
EFLAGS: 00010286
eax: 00000018   ebx: 00000000   ecx: 00000001   edx: 00002228
esi: c71c51fc   edi: c62a2b54   ebp: c45d3f4c   esp: c45d3ef4
ds: 0018   es: 0018   ss: 0018
Process ls (pid: 22472, stackpage=c45d3000)
Stack: d096a2dc 00000134 00060003 00000000 c71c51fc c0144800 00000002
00000006
       00000003 c45d3fa0 00000000 00000000 ffffffea 00000004 00000000
00030002
       c3e43ef4 c0126ab4 00000301 c71c51fc c71c5284 c71c5260 c62a2b54
c0144420
Call Trace: [<d096a2dc>] __insmod_ntfs_S.rodata_L640 [ntfs] 0x35c
[<c0144800>] filldir64 [kernel] 0x0
[<c0126ab4>] do_munmap [kernel] 0x64
[<c0144420>] vfs_readdir [kernel] 0x60
[<c0144800>] filldir64 [kernel] 0x0
[<c014498f>] sys_getdents64 [kernel] 0x4f
[<c0144800>] filldir64 [kernel] 0x0
[<c0106f2b>] system_call [kernel] 0x33


Code: 0f 0b 83 c4 10 83 7d d8 00 75 18 ff 77 24 ff 77 20 68 60 b2



