Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263436AbTEITix (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 15:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263438AbTEITix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 15:38:53 -0400
Received: from lineaAP162.velocom.com.ar ([200.59.47.162]:3848 "EHLO
	soraya.nixe.com") by vger.kernel.org with ESMTP id S263436AbTEITiu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 15:38:50 -0400
Date: Fri, 9 May 2003 16:42:44 -0300 (ART)
From: Alan Glait <aglait@nixe.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel problems
Message-ID: <Pine.LNX.4.10.10305091637200.2732-100000@soraya.nixe.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ! 
Iam compiling a 2.4.20 in a RH 7 ... in Pentium III ... 
It work a time .. .when crash with:
Unable to handle kernel paging request at virtual address 00005700
 printing eip:
00005700
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00005700>]    Not tainted
EFLAGS: 00010202
eax: 00000001   ebx: c0290300   ecx: c8000000   edx: 00000057
esi: 00000057   edi: c5743900   ebp: c71b5da0   esp: c4d1de9c
ds: 0018   es: 0018   ss: 0018
Process kwm (pid: 1225, stackpage=c4d1d000)
Stack: c10b36c4 c01257d6 c0290300 00000001 40240864 00000000 c71b5da0
c56e3c80
       c0125bcb c71b5da0 c56e3c80 40240864 c5743900 00005700 00000000
c40aa150
       c4d1df58 00000000 00000040 c4d1df0c c4d1c000 00000000 00003213
c71b5da0
Call Trace:    [<c01257d6>] [<c0125bcb>] [<c0114656>] [<c014208a>]
[<c01bc418>]
  [<c0134f33>] [<c01144d0>] [<c0106ed4>]

Code:  Bad EIP value.
 <1>Unable to handle kernel paging request at virtual address 00003800
 printing eip:
00003800
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00003800>]    Not tainted
EFLAGS: 00010203
eax: 00000000   ebx: c0290300   ecx: c8000000   edx: 0001025d
esi: 00000038   edi: c10d22d8   ebp: 40016000   esp: c4d1dca4
ds: 0018   es: 0018   ss: 0018
Process kwm (pid: 1225, stackpage=c4d1d000)
Stack: c10d22d8 c012fa20 c0290300 c0290300 c0290300 c01300bf c10d22d8
00003800
       00001000 00000000 c0124859 00003800 00000000 c5743058 00000000
40017000
       c4d02400 40016000 00000000 40017000 c4d02400 00000006 c0197d45
00000006
Call Trace:    [<c012fa20>] [<c01300bf>] [<c0124859>] [<c0197d45>]
[<c0135b96>]
  [<c0127231>] [<c0116961>] [<c011aa9f>] [<c01144be>] [<c01073fd>]
[<c0114867>]
  [<c01bf33b>] [<c01bf476>] [<c01f76f2>] [<c01bf18c>] [<c01144d0>]
[<c0106ed4>]
  [<c01257d6>] [<c0125bcb>] [<c0114656>] [<c014208a>] [<c01bc418>]
[<c0134f33>]
  [<c01144d0>] [<c0106ed4>]

Code:  Bad EIP value.
 <1>Unable to handle kernel paging request at virtual address 00003700
 printing eip:
00003700
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00003700>]    Not tainted
EFLAGS: 00010203
eax: 00000000   ebx: c0290300   ecx: c8000000   edx: 0001025e
esi: 00000037   edi: c1122718   ebp: c1122770   esp: c6999e0c
ds: 0018   es: 0018   ss: 0018
Process klogd (pid: 343, stackpage=c6999000)
Stack: c1122718 c012fa20 c0290300 c0290300 c0290300 c01300bf c1122718
00003700
       00004000 00003000 c0124859 00003700 00000002 c6f7c504 00000000
40142000
       c699a400 4013e000 00000000 40142000 c699a400 000001f0 c70f7014
00000046
Call Trace:    [<c012fa20>] [<c01300bf>] [<c0124859>] [<c0135b96>]
[<c0127231>]
  [<c0116961>] [<c011aa9f>] [<c011fb14>] [<c0106c53>] [<c01bc4be>]
[<c0135023>]
  [<c011b551>] [<c01144d0>] [<c0106e04>]

Code:  Bad EIP value.


I change options of the procesor, add drivers for the VIA mother, but it
doesnt work good .... 
can you help me .. ?? 

ThanX 


