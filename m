Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132796AbRDDLYz>; Wed, 4 Apr 2001 07:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132788AbRDDLYp>; Wed, 4 Apr 2001 07:24:45 -0400
Received: from pop.gmx.net ([194.221.183.20]:13609 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S132796AbRDDLYa>;
	Wed, 4 Apr 2001 07:24:30 -0400
Message-ID: <3ACB0447.3DBAEAE3@gmx.de>
Date: Wed, 04 Apr 2001 13:23:51 +0200
From: ernte23@gmx.de
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: de-DE, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at page_alloc.c:75! / exit.c
In-Reply-To: <20010403125115Z131730-407+5789@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I'm running the 2.4.3 kernel and my system always (!) crashes when I try
to generate the "Linux kernel poster" from lgp.linuxcare.com.au. After
working for one hour, the kernel printed this message:

kernel BUG at page_alloc.c:75!
invalid operand: 0000
CPU:    0
EIP:    0010:[__free_pages_ok+62/784]
EFLAGS: 00010296
eax: 0000001f   ebx: c137dbb8   ecx: 00000000   edx: ffffffff
esi: c137dbb8   edi: c0223fb8   ebp: 00000000   esp: c1475f78
ds: 0018   es: 0018   ss: 0018
Process bdflush (pid: 5, stackpage=c1475000)
Stack: c01f6ec5 c01f6fd3 0000004b c137dbe0 c137dbb8 c0223fb8 0000003c
c0223fb8
       0000003b c48a1a40 00000003 c0128a89 c012a29a c0128c85 c1474000
c01f852e
       0000000a 0008e000 00000000 00000000 00000004 00000000 00007a13
c0132ae0
Call Trace: [page_launder+793/2064] [__free_pages+26/32]
[page_launder+1301/2064] [bdflush+128/208] [kernel_thread+35/48]

Code: 0f 0b 83 c4 0c 89 d8 2b 05 78 ea 27 c0 69 c0 f1 f0 f0 f0 c1
kernel BUG at exit.c:458!
invalid operand: 0000
CPU:    0
EIP:    0010:[do_exit+526/544]
EFLAGS: 00010282
eax: 0000001a   ebx: c0220920   ecx: 00000000   edx: ffffffff

I think there should be more, but it stopped at this point.

Do you need more information about the system?

Thank you, Felix
