Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315530AbSEHFqY>; Wed, 8 May 2002 01:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315531AbSEHFqY>; Wed, 8 May 2002 01:46:24 -0400
Received: from [203.199.93.15] ([203.199.93.15]:23827 "EHLO
	WS0005.indiatimes.com") by vger.kernel.org with ESMTP
	id <S315530AbSEHFqX>; Wed, 8 May 2002 01:46:23 -0400
From: "pavankvk" <pavankvk@indiatimes.com>
Message-Id: <200205080524.KAA02787@WS0005.indiatimes.com>
To: <linux-kernel@vger.kernel.org>
Reply-To: "pavankvk" <pavankvk@indiatimes.com>
Subject: Unable to handle kernel paging request at virtual address 
Date: Wed, 08 May 2002 11:12:02 +0530
X-URL: http://indiatimes.com
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reference to my previous mail..the actual error message on console is given below..
Unable to handle kernel paging request at virtual address c2acc6d8
current->tss.cr3 = 0116e000, ^Pr3 = 0116e000
*pde = 0009e067
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[dev_close+52/184]
EFLAGS: 00010206
eax: 00000000   ebx: 02acc6d8   ecx: 00000002   edx: 73cb2605
esi: 00000000   edi: 0001fdfc   ebp: 00001143   esp: 00b38ef8
ds: 0018   es: 0018   fs: 002b   gs: 002b   ss: 0018
Process ifconfig (pid: 4602, process nr: 98, stackpage=00b38000)
Stack: 02acc6d8 00000002 0001fdfc 0001fdfc bffff9b8 00b38f60 001397e8 0001fdfc
       bffff998 00008914 0804c983 00b47810 00000000 0098a1d4 40075000 010c0c98
       0006d000 ffffffed 31687465 0804e000 0804c921 08048bc8 08041142 0804cdef
Call Trace: [<02acc6d8>] [dev_ifsioc+708/1628] [dev_ioctl+439/508] [inet_ioctl+871/960] [sock_ioctl+33/40] [sys_ioctl+255/272] [system_call+85/124] 

Code: 8b 03 ff d0 83 c4 0c 66 85 c0 7c 07 8b 5b 04 85 db 75 e9 57





Get Your Private, Free E-mail from Indiatimes at http://email.indiatimes.com

 Buy Music, Video, CD-ROM, Audio-Books and Music Accessories from http://www.planetm.co.in

