Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264960AbUFVRIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbUFVRIc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 13:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264229AbUFVRHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 13:07:14 -0400
Received: from tossu.ebaana.net ([62.121.33.10]:57361 "EHLO tossu.ssp.fi")
	by vger.kernel.org with ESMTP id S264855AbUFVQx4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 12:53:56 -0400
Message-ID: <200406221954150026.009597B0@smtp.ebaana.net>
X-Mailer: Calypso Version 3.30.00.00 (4)
Date: Tue, 22 Jun 2004 19:54:15 +0300
From: "Juhani Pirttilahti" <juhani.pirttilahti@mbnet.fi>
To: linux-kernel@vger.kernel.org
Subject: Kernel problem
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is going on? I can't boot ANY version of kernel 2.2.x, 2.4.x or 2.6.x on this computer.
I was trying to install Debian to this computer...

There is nothing wrong with memory. I can also install Windows 98 to it.

Hardware:
motherboard: Micro Star MS-6163, Slot 1
processor: 350 MHz Pentium 2
memory: 128 MB + 64 MB + 32 MB PC100 SDRAM (Non ECC)
hard disk: Maxtor Diamondmax 9+ 30 GB
network controller: 3com 3C905C
graphics: Matrox Millenium G100 (AGP)
cd-rom: Generic 52x :-)

Software:
Debian testing installer beta 4 (netinstall cd)
Kernel 2.4.26-1-386 (and others)

"Screenshot":
Unable to handle kernel paging request at virtual address 591bb01c
printing eip: c0142104 *pde = 00000000
Oops: 0002
CPU: 0
EIP: 0010:[<c0142104>] Not tainted
EFLAGS: 00010202
eax: 00000001 ebx: 591bafc0 ecx: 00000000 edx: 591bb01c
esi: c02177cd edi: 591bb01c ebp: 00000000 esp: c0285f40
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 0, stackpage=c0285000)
Stack: 00000000 c12143e0 c0246540 00000000 c0142235 00000000 c0285f5c c02177cd 00000001 00000000 c0246540 c1216800 c014d8ca c12143e0 c1216800 00000000 c0136b0c c1216800 00000000 00000000 cbfcc190 c0246540 fffffff4
Call Trace: [<c0142235>] [<c0136b0c>] [<c0136bad>] [c0105000>] [<c0136cfc>]
Code: a4 8b 4c 24 18 8b 41 04 c6 04 10 00 c7 03 01 00 00 00 c7 43
<0>Kernel Panic: Attempted to kill the idle task!
In idle task - not syncing


