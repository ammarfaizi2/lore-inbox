Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262327AbSIPPsY>; Mon, 16 Sep 2002 11:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262338AbSIPPsY>; Mon, 16 Sep 2002 11:48:24 -0400
Received: from stone.bestlinux.net ([194.126.122.26]:3079 "EHLO deimos")
	by vger.kernel.org with ESMTP id <S262327AbSIPPsX>;
	Mon, 16 Sep 2002 11:48:23 -0400
Message-ID: <3D861182.2090909@sot.com>
Date: Mon, 16 Sep 2002 19:14:42 +0200
From: Yaroslav Popovitch <yp@sot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel Panic (2.4.19-release) at sched.c:566
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I prepared boot kernel for  cdboot image and got such error message.


Schelduling in interrupt
kernel BUG at sched.c:566!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0116f59>]   Not tainted
EFLAGS: 00010296
 
eax: 00000018   ebx: c0106c70  ecx: 00000001 edx: 00000001
esi: 00000000   edi: c0242000  ebp: c0243fd4 esp: c0243fac
ds: 0018  es: 0018  ss: 0018
Process swapper (pid: 0, stackpage=c0243000)
Stack: c01fed7e 00098700 c0105000 c0242000 00000000 00000000 00000018 
c0106c70
       00098700 c0105000 0008e000 c0106d04 00000000 c0244687 c01f6f40 
00003ffc
       00003ffc 00003ffc 00003ffc c0264440 c01001c9
 
Call Trace: [<c0105000>] [<c0106c70>] [<c0105000>] [<c0106d04>]
 
Code: 0f 0b 36 02 76 ed 1f c0 5b e9 87 fb ff ff 0f 0b 2f 02 76 ed
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

-- 
Mr. Yaroslav Popovitch     			- tel. +372 6419975
SOT Finnish Software Engineering Ltd.   	- fax  +372 6419876
Kreutzwaldi 7-4, 10124  TALLINN         	- http://www.sot.com/
ESTONIA                                 	- http://sotlinux.net/


