Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270480AbRIBJ00>; Sun, 2 Sep 2001 05:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271598AbRIBJ0Q>; Sun, 2 Sep 2001 05:26:16 -0400
Received: from mustard.heime.net ([194.234.65.222]:3490 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S270480AbRIBJ0J>; Sun, 2 Sep 2001 05:26:09 -0400
Date: Sun, 2 Sep 2001 11:26:27 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
cc: Lars Christian Nygaard <lars@snart.com>
Subject: 2.4.6 error
Message-ID: <Pine.LNX.4.30.0109021117260.2609-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

I just got a whole bunch of the following error on my 2.4.6 installation.
Virtual address (EIP), pde, pte, eflags, edx, esi, edi, the first quad in
the stack and the call trace remains stable. The others are varying. The
oops comes whenever sa1 (in sysstat) is run.

please cc: to me as I'm not on the list

roy

Code:  Bad EIP value.
Unable to handle kernel paging request at virtual address c9049180
 printing eip:
c9049180
*pde = 07f8b067
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c9049180>]
EFLAGS: 00010282
eax: c1903f68   ebx: c6c5d960   ecx: c6c5d980   edx: c9049180
esi: 00000400   edi: 00000000   ebp: c3b7c000   esp: c1903f40
ds: 0018   es: 0018   ss: 0018
Process sadc (pid: 9922, stackpage=c1903000)
Stack: c0149fcd c3b7c000 c1903f68 00000000 00000400 c1903f64 c90500e0 c7f7b8c0
       00000000 00000000 00000000 c6c5d960 ffffffea 00000000 00000400 c012ea28
       c6c5d960 40017000 00000400 c6c5d980 00000000 00001000 00000003 00000022
Call Trace: [<c0149fcd>] [<c012ea28>] [<c0106d43>]



