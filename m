Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285065AbRLQJoO>; Mon, 17 Dec 2001 04:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285084AbRLQJoF>; Mon, 17 Dec 2001 04:44:05 -0500
Received: from mx04.nexgo.de ([151.189.8.80]:30227 "EHLO mx04.nexgo.de")
	by vger.kernel.org with ESMTP id <S285065AbRLQJn5>;
	Mon, 17 Dec 2001 04:43:57 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Jan Tim Schueszler <Jan.Tim.Schueszler@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: {Kernel 2.4.17-pre8] kernel-oops
Date: Mon, 17 Dec 2001 10:41:57 +0000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01121710415700.00636@erde>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just another kernel-oops with kernel 2.4.17-pre8. It occured while 
installing a successfully build XServer from CVS-Sources.

Dec 17 10:32:22 erde kernel:  <1>Unable to handle kernel NULL 
pointer dereference at virtual address 00000028
Dec 17 10:32:22 erde kernel: c01571b2
Dec 17 10:32:22 erde kernel: *pde = 00000000
Dec 17 10:32:22 erde kernel: Oops: 0000
Dec 17 10:32:22 erde kernel: CPU:    0
Dec 17 10:32:22 erde kernel: EIP:    
0010:[journal_try_to_free_buffers+82/144]    Not tainted
Dec 17 10:32:22 erde kernel: EFLAGS: 00010207
Dec 17 10:32:22 erde kernel: eax: 0000004d   ebx: 00000000   ecx: 
000001d2   edx: 00000000
Dec 17 10:32:22 erde kernel: esi: c575b340   edi: 00000001   ebp: 
00000050   esp: cf195e0c
Dec 17 10:32:22 erde kernel: ds: 0018   es: 0018   ss: 0018
Dec 17 10:32:22 erde kernel: Process install (pid: 13842, 
stackpage=cf195000)
Dec 17 10:32:22 erde kernel: Stack: c1285f80 000001d2 00000004 
000010e3 00000000 c014f8b2 cfad0200 c1285f80
Dec 17 10:32:22 erde kernel:        000001d2 c0131dba c1285f80 
000001d2 c575b340 c1285f80 c0129da2 c1285f80 
Dec 17 10:32:22 erde kernel:        000001d2 00000020 000001d2 
00000020 00000006 00000006 cf194000 00000100
Dec 17 10:32:22 erde kernel: Call Trace: [ext3_releasepage+34/48] 
[try_to_release_page+42/80] [shrink_cache+450/720] 
[shrink_caches+86/128] [try_to_free_pages+29/64]
Dec 17 10:32:22 erde kernel: Code: 8b 5b 28 f6 42 19 02 74 17 8d 44 
24 10 50 52 e8 0a ff ff ff

Code;  d0d373f1 <END_OF_CODE+3c7bb0/????>
00000000 <_EIP>:
Code;  d0d373f1 <END_OF_CODE+3c7bb0/????>
   0:   8b 5b 28                  mov    0x28(%ebx),%ebx
Code;  d0d373f4 <END_OF_CODE+3c7bb3/????>
   3:   f6 42 19 02               testb  $0x2,0x19(%edx)
Code;  d0d373f8 <END_OF_CODE+3c7bb7/????>
   7:   74 17                     je     20 <_EIP+0x20> d0d37411 
<END_OF_CODE+3c7bd0/????>
Code;  d0d373fa <END_OF_CODE+3c7bb9/????>
   9:   8d 44 24 10               lea    0x10(%esp,1),%eax
Code;  d0d373fe <END_OF_CODE+3c7bbd/????>
   d:   50                        push   %eax
Code;  d0d373ff <END_OF_CODE+3c7bbe/????>
   e:   52                        push   %edx
Code;  d0d37400 <END_OF_CODE+3c7bbf/????>
   f:   e8 0a ff ff ff            call   ffffff1e <_EIP+0xffffff1e> 
d0d3730f <END_OF_CODE+3c7ace/????>


1 warning issued.  Results may not be reliable.

Don't hesitate to contact me for further information.

Jan Tim Schüszler
