Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282784AbRLBGM1>; Sun, 2 Dec 2001 01:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282779AbRLBGMR>; Sun, 2 Dec 2001 01:12:17 -0500
Received: from [164.77.245.138] ([164.77.245.138]:29377 "HELO smtp2.vtr.net")
	by vger.kernel.org with SMTP id <S282781AbRLBGMH>;
	Sun, 2 Dec 2001 01:12:07 -0500
Message-ID: <3C09C616.241C7290@vtr.net>
Date: Sun, 02 Dec 2001 03:11:34 -0300
From: "George of the Jungle." <iblood@vtr.net>
Reply-To: iblood@vtr.net
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: es, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel 2.2.19 bug
Content-Type: multipart/mixed;
 boundary="------------90EDDE1882526F951152330F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------90EDDE1882526F951152330F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

 
--------------90EDDE1882526F951152330F
Content-Type: text/plain; charset=us-ascii;
 name="kernel-bug.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel-bug.txt"

Unable to handle kernel paging request at virtual address c0066080
current->tss.cr3 = 00aee000, %cr3 = 00aee000
*pde = 00102067
*pte = bc25a9d4
Oops: 0000
CPU:    0
EIP:    0010:[<c014a2b4>]
EFLAGS: 00010286
eax: 00002000   ebx: 0004a000   ecx: 00048000   edx: 08448000
esi: c0066080   edi: 0004a000   ebp: 00000000   esp: c2831e9c
ds: 0018   es: 0018   ss: 0018
Process ps (pid: 15881, process nr: 12, stackpage=c2831000)
Stack: 00000000 00000000 c1aa4220 c0066084 08448000 c012fc6a c1aa4220
c2831f08
       c290d7b0 c014a48a c0066080 08048000 0804a000 c2831f14 c2831f18
c2831f1c
       c2831f20 c012fded c195c000 0000000c c02264e0 000001ff c242e7e0
ffffffe9
Call Trace: [<c012fc6a>] [<c014a48a>] [<c012fded>] [<c014aaba>]
[<c014ab91>] [<c014aafa>] [<c0127cd7>]
       [<c010a331>] [<c010a214>]
Code: 8b 16 8d 46 04 29 cb 8d a9 00 00 40 00 89 44 24 1c 85 d2 0f
Segmentation fault


--------------90EDDE1882526F951152330F--

