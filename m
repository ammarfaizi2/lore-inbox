Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261560AbTCGN2A>; Fri, 7 Mar 2003 08:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbTCGN2A>; Fri, 7 Mar 2003 08:28:00 -0500
Received: from 213-156-58-135.fastres.net ([213.156.58.135]:2944 "EHLO
	galileo.homenet.lan") by vger.kernel.org with ESMTP
	id <S261560AbTCGN16>; Fri, 7 Mar 2003 08:27:58 -0500
Subject: LKML
From: alx <alexs81@libero.it>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1047033306.1753.22.camel@galileo.homenet.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 07 Mar 2003 14:36:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mar  7 11:32:10 galileo kernel: Linux Kernel Card Services 3.1.22
Mar  7 11:32:10 galileo kernel:   options:  [pci] [cardbus] [pm]
Mar  7 11:32:10 galileo kernel: Unable to handle kernel NULL pointer
dereference at virtual address 00000018
Mar  7 11:32:10 galileo kernel:  printing eip:
Mar  7 11:32:10 galileo kernel: e28a400f
Mar  7 11:32:10 galileo kernel: *pde = 00000000
Mar  7 11:32:10 galileo kernel: Oops: 0000
Mar  7 11:32:10 galileo kernel: CPU:    0
Mar  7 11:32:10 galileo kernel: EIP:    0010:[<e28a400f>]    Not tainted
Mar  7 11:32:10 galileo kernel: EFLAGS: 00210202
Mar  7 11:32:10 galileo kernel: eax: 00000000   ebx: de4b5000   ecx:
de4b5008   edx: 00000000
Mar  7 11:32:10 galileo kernel: esi: de4b5008   edi: c1663f40   ebp:
c1662000   esp: c1663f10
Mar  7 11:32:10 galileo kernel: ds: 0018   es: 0018   ss: 0018
Mar  7 11:32:10 galileo kernel: Process keventd (pid: 2,
stackpage=c1663000)
Mar  7 11:32:10 galileo kernel: Stack: 00000000 de4b5008 e28a45a7
de4b5000 de4b5008 de4b5000 00000064 e28a457b
Mar  7 11:32:10 galileo kernel:        de4b5000 00000028 de4b5000
de4b5008 00001880 de4b5000 00000080 c1662568
Mar  7 11:32:10 galileo kernel:        e28a483a de4b5000 00001880
c1663f78 c1663f78 e28abf1e de4b5000 00000080
Mar  7 11:32:10 galileo kernel: Call Trace:    [<e28a45a7>] [<e28a457b>]
[<e28a483a>] [<e28abf1e>] [<c011a489>]
Mar  7 11:32:10 galileo kernel:   [<e28ad040>] [<e28ad07c>] [<e28ad07c>]
[<c0121b71>] [<c0121a50>] [<c0105000>]
Mar  7 11:32:10 galileo kernel:   [<c0105606>] [<c0121a50>]
Mar  7 11:32:10 galileo kernel:
Mar  7 11:32:10 galileo kernel: Code: ff 52 18 5a 59 c3 8d 74 26 00 8d
bc 27 00 00 00 00 8b 44 24
Mar  7 11:32:10 galileo kernel:  <5>ds: no socket drivers loaded!




