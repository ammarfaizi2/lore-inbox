Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319846AbSINDHM>; Fri, 13 Sep 2002 23:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319847AbSINDHM>; Fri, 13 Sep 2002 23:07:12 -0400
Received: from tomts14-srv.bellnexxia.net ([209.226.175.35]:6864 "EHLO
	tomts14-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S319846AbSINDHL>; Fri, 13 Sep 2002 23:07:11 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Slava Polyakov <hackie@misato.prohost.org>
Reply-To: hackie@misato.prohost.org
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at page_alloc.c:102!
Date: Fri, 13 Sep 2002 23:10:20 -0400
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209132310.20585.hackie@misato.prohost.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux misato 2.4.20-pre2 #1 Wed Aug 14 18:36:46 EDT 2002 i686 unknown

kernel BUG at page_alloc.c:102!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0136c14>]    Not tainted
EFLAGS: 00010202
eax: 01000009   ebx: c141677c   ecx: c141677c   edx: c13d6b58
esi: 00000000   edi: 00000000   ebp: 00215c00   esp: df3c1e28
ds: 0018   es: 0018   ss: 0018
Process smbd (pid: 28639, stackpage=df3c1000)
Stack: c141677c 00215c00 00000000 00215c00 00001000 cb510f00 c141677c c013fad5
       c141677c c141677c 00000000 c141677c 00215c00 c0137827 c0137998 00215c00
       00000011 c141677c c013aafa c141677c 00215c00 00000052 c55d7400 c55d7520
Call Trace:    [<c013fad5>] [<c0137827>] [<c0137998>] [<c013aafa>] 
[<c013ba1f>]
  [<c012c6d9>] [<c012c85e>] [<c0119bc8>] [<c0119a68>] [<c01cb32a>] 
[<c01107e2>]
  [<c01108a0>] [<c010ab4c>]

Code: 0f 0b 66 00 f3 c0 34 c0 8b 43 18 a8 80 74 08 0f 0b 68 00 f3

The box is however is up.. and I'm still using it.. It's personal workstation, 
so no biggie.. if it's up I'm happy.  If anymore info is desired I will 
provide.... 
