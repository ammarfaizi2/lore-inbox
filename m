Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135670AbRD2CIa>; Sat, 28 Apr 2001 22:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135671AbRD2CIV>; Sat, 28 Apr 2001 22:08:21 -0400
Received: from smarty.smart.net ([207.176.80.102]:46855 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S135670AbRD2CIJ>;
	Sat, 28 Apr 2001 22:08:09 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200104290209.WAA03368@smarty.smart.net>
Subject: seeoops, 3k all-Bash ksymoops alternative
To: linux-kernel@vger.kernel.org
Date: Sat, 28 Apr 2001 22:09:16 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In another few minutes I'll be posting the script itself to
fa.linux.kernel that produced this....

...................................................................
FLAGS....                                00010282
0 0 0 0 0 0 1 0 1 0 0 0 0 0 1 0
  N     O D I T S Z   A   P   C
  e     v i n r i e   u   a   r
  s     e r t a g r   x   r   r
  T     r c E p n o   O   i   y

eax:    0000000a

ebx:    c012d175
c012d175        t       dsH3sm
ecx:    00000000

edx:    00000004

esi:    c0132696
c0132690        t       crH3sm
c01326b0        t       dofileCFA
edi:    c012d179
c012d175        t       dsH3sm
c012f175        t       BYTESH3sm
ebp:    c012d075
c012d075        t       psH3sm

STACK TRACE     starting 4 calls out from oops

        c01080d3
    c01080b0    T       kernel_thread
c01080e0        T       exit_thread

        c0105000
    c0105000    T       empty_bad_page

        c012a17d
    c012a150    T       kspamd
c012a180        t       rw_swap_page_base

        c012d073
    c012d06e    t       reepeeetH3sm
c012d075        t       psH3sm
....................................................................

It takes 8 seconds on a P166, it's <4k, it's 100% Bash. FLAGS looks funny,
but I dono. Season to taste.

Rick Hohensee
www.clienux.com
