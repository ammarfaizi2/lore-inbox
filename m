Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVGZNCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVGZNCF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 09:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVGZNCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 09:02:05 -0400
Received: from mail1.tuniv.szczecin.pl ([212.14.26.3]:25578 "EHLO
	mail1.tuniv.szczecin.pl") by vger.kernel.org with ESMTP
	id S261405AbVGZNCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 09:02:03 -0400
Message-ID: <1122382920.42e6344831310@www.ps.pl>
Date: Tue, 26 Jul 2005 15:02:00 +0200
From: robertk@ps.pl
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.4
X-Originating-IP: 83.22.237.47
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I am currently using Slackware 10.1 with 2.4.29 kernel and encountered following
problem:

I use Sagem Fast 800 ADSL modem of my provider and use my linux station as a
router (iptables+masquerade). The problem is that after a few hours of working
my linux crashes with the message:

"

serwer login: Unable to handle kernel NULL pointer dereference at virtual
address 00000020
*pde = 00000000
0opss: 0002
CPU: 0
EIP: 0010:[<c4958ca3>] Not tainted
EFLAGS: 00010087
eax: c11c56 ebx:c11c56c8 ecx:c11a1604 edx: c3139e34
esi: 00000000 edi: c3139e34 ebp: c11c56dc esp: c3385f50
ds: 0018 es: 0018 ss: 0018
Process klogd (pid: 63, stackpage=c3385000)
Stack: 0000246 00000000 c111c5660 00000001 0000ff80 c4958d51 c11c5660 c11c5660
c3527ee0 04000001 c3385fc4 0000000a c0109fbd 0000000a c11c55660 c3385fc4
c03829a0 0000000a c3527ee0 c3385fc4 c010a138 0000000a c3385fc4  c3527ee0
Call Trace: [<c4958d51>] [<c0109fbd>] [<c010a138>] [<c010c428>]

Code: c7 46 20 98 ff ff ff 8b 43 10 8b 80 d8 00 00 00 8b 40 2c 8b
<0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing"

I tried rekompiling the kernel and chose MMX architekture in "Processor Type and
Features -> Processor Family" but it did not help. I also tried different
versions of Sagem drivers but the problem is still present.

I am a newbie to linux and would be very thankful for any solutions or just
hints about solving this problem. I don't know if the problem is caused by
sagem drivers but on the second PC station (Athlon Xp2000+, 384 MB RAM, 80GB
Samsung) nothing like this happened.
