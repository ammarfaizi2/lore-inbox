Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261404AbTCOGVa>; Sat, 15 Mar 2003 01:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261406AbTCOGVa>; Sat, 15 Mar 2003 01:21:30 -0500
Received: from [218.244.176.102] ([218.244.176.102]:27908 "EHLO
	wideinfo.com.cn") by vger.kernel.org with ESMTP id <S261404AbTCOGV3>;
	Sat, 15 Mar 2003 01:21:29 -0500
From: "Zhenghui Zhou" <zzh@wideinfo.com.cn>
To: <linux-kernel@vger.kernel.org>
Subject: Problem with 2.4.20: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Date: Sat, 15 Mar 2003 14:33:53 +0800
Message-ID: <000501c2eabc$d92188c0$a9b0f4da@wideinfo.com.cn>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Authenticated-Sender: zzh@wideinfo.com.cn
X-MDRemoteIP: 192.168.0.1
X-Return-Path: zzh@wideinfo.com.cn
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I runing a heavy stress on a linux system with kernel 2.4.20, and I
got the error messages now and again when start a new process, the
frequence is get higher as the heavity, but all the running processes
is ok.

I don't know what's the problem?

Code: 8b 51 04 83 fa ff 0f 84 56 01 00 00 83 fa fc 77 07 c7 41 04
 <1>Unable to handle kernel NULL pointer dereference at virtual
address 00000004
 printing eip:
dfd7d718
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<dfd7d718>]    Not tainted
EFLAGS: 00010286
eax: bffffd44   ebx: ddd16000   ecx: 00000000   edx: ddd16000
esi: c0106c33   edi: 0000000b   ebp: ddd17fb8   esp: ddd17f84
ds: 0018   es: 0018   ss: 0018
Process killall (pid: 32346, stackpage=ddd17000)
Stack: ddd16000 c0106c33 0000000b 00000000 da3a9000 0000000b ddd17fbc
c0105987
       bffffd44 c01059a7 00000000 00000a3a 00000020 bffff934 dfd7d8e8
00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00000000
0000002b
Call Trace:    [<c0106c33>] [<c0105987>] [<c01059a7>]


