Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262542AbSJBTr6>; Wed, 2 Oct 2002 15:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262556AbSJBTr6>; Wed, 2 Oct 2002 15:47:58 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:24517 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262542AbSJBTr6>; Wed, 2 Oct 2002 15:47:58 -0400
Message-Id: <5.1.0.14.0.20021002134528.00b0ac50@mail.cantor.fr>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 02 Oct 2002 21:53:51 +0200
To: linux-kernel@vger.kernel.org
From: Philippe Finkel <pfinkel@cantor.fr>
Subject: VIA chipsets support ?
Mime-Version: 1.0
Content-Type: multipart/mixed; x-avg-checked=avg-ok-19B24BEB; boundary="=======778B77F6======="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=======778B77F6=======
Content-Type: text/plain; x-avg-checked=avg-ok-19B24BEB; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 8bit

hi,

with the VIA EPIA-mini-ITX motherboards (with VIA 8601A north bridge and 
VT8231 south bridge), when booting, the
following message is displayed :
	Jun 23 21:21:30 look1 kernel: Unknown bridge resource 0: assuming transparent
	Jun 23 21:21:30 look1 kernel: Unknown bridge resource 2: assuming transparent
	Jun 23 21:21:30 look1 kernel: PCI: Using IRQ router default [1106/0601] at 
00:00.0
and the local APIC is then disabled.

is a VIA chipset missing in pci-irq.c 8601A (1106/0601) missing in 
pirq_routers table in arch/i386/kernel/pci-irq.c (arch/i386pci/pci-irq.c 
for 2.5.x)  ?

I'm new to this ML and tried to give just the necessary info. if needed, I 
can give more details ...


Philippe Finkel

--=======778B77F6=======--

