Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVGYJuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVGYJuU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 05:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVGYJuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 05:50:20 -0400
Received: from ip3e83f6c9.speed.planet.nl ([62.131.246.201]:10901 "EHLO
	mail.pronexus.nl") by vger.kernel.org with ESMTP id S261177AbVGYJuR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 05:50:17 -0400
Message-ID: <20050725115015.zo345iawcqw0gws0@intranet.pronexus.loc>
Date: Mon, 25 Jul 2005 11:50:15 +0200
From: msmulders@pronexus.nl
To: linux-kernel@vger.kernel.org
Subject: help! kernel errors?
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.1)
X-VirusScanned-By: Pronexus BV
X-SpamScanned-By: Pronexus BV
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm getting loads and loads of kernel errors in my syslog, but am unable to
decipher them into anything meaningful. It occurs during a backup procedure and
looking at the error it's got something to do with process 'rsync' but I haven't
got a clue what's going wrong here (hardware? drivers? modules? kernel? what?).
I'm hoping you guys can help me out. The repeating error is attached below!

Thanks so much in advance,
- Mark

Jul 24 23:24:51 server kernel: Unable to handle kernel paging request at virtual
address 04003428
Jul 24 23:24:51 server kernel:  printing eip:
Jul 24 23:24:51 server kernel: c014f3e8
Jul 24 23:24:51 server kernel: *pde = 00000000
Jul 24 23:24:51 server kernel: Oops: 0000
Jul 24 23:24:51 server kernel: CPU:    0
Jul 24 23:24:51 server kernel: EIP:    0010:[<c014f3e8>]    Not tainted
Jul 24 23:24:51 server kernel: EFLAGS: 00010213
Jul 24 23:24:51 server kernel: eax: 0015422f   ebx: 04003400   ecx: 0000000f  
edx: c1440000
Jul 24 23:24:51 server kernel: esi: 00000000   edi: c1453fa8   ebp: 0015422e  
esp: c329de34
Jul 24 23:24:51 server kernel: ds: 0018   es: 0018   ss: 0018
Jul 24 23:24:51 server kernel: Process rsync (pid: 29653, stackpage=c329d000)
Jul 24 23:24:51 server kernel: Stack: 000000e4 d8a18040 00000002 0015422e
00000002 cf313000 c99e0b00 c014f641
Jul 24 23:24:51 server kernel:        cf313000 0015422e c1453fa8 00000000
00000000 fffffff3 c99e0b00 c329de8c
Jul 24 23:24:51 server kernel:        d8a1147a cf313000 00000002 0001075a
0001075a 00000286 00000020 00000000
Jul 24 23:24:51 server kernel: Call Trace:    [<c014f641>] [<d8a1147a>]
[<c0143bc7>] [<c01444a8>] [<c01448f9>]
Jul 24 23:24:51 server kernel:   [<c0144d60>] [<c0138e63>] [<c0139213>]
[<c0108c87>]
Jul 24 23:24:51 server kernel:
Jul 24 23:24:51 server kernel: Code: 39 6b 28 89 de 75 f1 8b 44 24 20 39 83 a0
00 00 00 75 e5 8b

