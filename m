Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbVG0L5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVG0L5n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 07:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262203AbVG0L5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 07:57:43 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:34265 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262198AbVG0L5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 07:57:42 -0400
Message-Id: <200507270126.j6R1QfYN003662@laptop11.inf.utfsm.cl>
To: robertk@ps.pl
cc: linux-kernel@vger.kernel.org
In-Reply-To: Message from robertk@ps.pl 
   of "Tue, 26 Jul 2005 15:02:00 +0200." <1122382920.42e6344831310@www.ps.pl> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 26 Jul 2005 21:26:41 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 27 Jul 2005 07:57:33 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

robertk@ps.pl wrote:

> I am currently using Slackware 10.1 with 2.4.29 kernel and encountered
> following problem:

> I use Sagem Fast 800 ADSL modem of my provider and use my linux station
> as a router (iptables+masquerade). The problem is that after a few hours
> of working my linux crashes with the message:

> "
> 
> serwer login: Unable to handle kernel NULL pointer dereference at virtual
> address 00000020
> *pde = 00000000
> 0opss: 0002
> CPU: 0
> EIP: 0010:[<c4958ca3>] Not tainted
> EFLAGS: 00010087
> eax: c11c56 ebx:c11c56c8 ecx:c11a1604 edx: c3139e34
> esi: 00000000 edi: c3139e34 ebp: c11c56dc esp: c3385f50
> ds: 0018 es: 0018 ss: 0018
> Process klogd (pid: 63, stackpage=c3385000)
> Stack: 0000246 00000000 c111c5660 00000001 0000ff80 c4958d51 c11c5660 c11c5660
> c3527ee0 04000001 c3385fc4 0000000a c0109fbd 0000000a c11c55660 c3385fc4
> c03829a0 0000000a c3527ee0 c3385fc4 c010a138 0000000a c3385fc4  c3527ee0
> Call Trace: [<c4958d51>] [<c0109fbd>] [<c010a138>] [<c010c428>]
> 
> Code: c7 46 20 98 ff ff ff 8b 43 10 8b 80 d8 00 00 00 8b 40 2c 8b
> <0>Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing"

First check if there are updates for your distribution, apply them /all/.

Another thing to consider is memory problems. In my experience, this is
often due to CPU overheating (busted fan), bad power, or perhaps bad RAM
(check out memtest86+ <http://www.memtest.org>).

Hope this helps
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
