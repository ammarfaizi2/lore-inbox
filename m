Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130535AbQKYADR>; Fri, 24 Nov 2000 19:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130650AbQKYAC6>; Fri, 24 Nov 2000 19:02:58 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:65293 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S130535AbQKYACv>; Fri, 24 Nov 2000 19:02:51 -0500
Message-ID: <3A1EF9A5.2E335F0C@timpanogas.org>
Date: Fri, 24 Nov 2000 16:28:37 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops on 2.2.18-23 as pppd dial in server
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

Was able to reproduce this Oops, but it took several days.   Oops occurs
against 2.2.18-23.  I had to copy this info from the console -- the
system was hard hung after the oops and even ksymoops was locked solid.

Jeff

unable to handle kernel paing request virtual address 90C16C24
CR3-01870000 pde=0

Oops: 0002
CPU:  0
EIP   0010: C0137596
EFLAGS: 00010206
eax:  90c16c20  ebx:  c16c6145  ecx: 00000000 edx: c0226e2c 
esi:  c0259200  edi:  c16c614d  ebp: c0259200 esp: c17f9ee8
ds: 18  es: 18  ss: 18
process solcate pid: 1109 nr: 45 stack=c17f9000
Call Trace:  c01377fe  c0137816  c0144bbc  c0131238  c0131434  c013151c 
c012f532 c010a2fc
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
