Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267631AbTAMQ2g>; Mon, 13 Jan 2003 11:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267828AbTAMQ2g>; Mon, 13 Jan 2003 11:28:36 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:65392 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267631AbTAMQ2e>; Mon, 13 Jan 2003 11:28:34 -0500
Date: Mon, 13 Jan 2003 11:37:21 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: =?iso-8859-1?Q?Philip_K=2EF=2E_H=F6lzenspies?= 
	<p.k.f.holzenspies@student.utwente.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20030113113721.A18786@devserv.devel.redhat.com>
References: <000001c2ba3e$84695730$53a85982@tomwaits>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <000001c2ba3e$84695730$53a85982@tomwaits>; from p.k.f.holzenspies@student.utwente.nl on Sun, Jan 12, 2003 at 02:28:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linux version 2.4.20 (root@tomwaits) (gcc version 3.2) #1 SMP Sat Jan 11 18:46:51 CET 2003
> Intel MultiProcessor Specification v1.4
>     Virtual Wire compatibility mode.
>[...]
> PCI: Using IRQ router AMD768 [1022/7443] at 00:07.3
> PCI->APIC IRQ transform: (B1,I5,P0) -> 16
> PCI->APIC IRQ transform: (B2,I5,P0) -> 18

> PCI: Enabling device 02:08.2 (0014 -> 0016)
> PCI: No IRQ known for interrupt pin C of device 02:08.2. Probably buggy
> MP table.

I am sorry to say, I cannot help you. This is the department
of Manfred, most likely. The 95% bet is that your BIOS is crap,
and you have to poke ASUS. However, you might want to explore
a possiblity of a bug. The best way to do it is to run "mptable"
program to dump the table and then get someone who makes
a sense of the data. Try to figure out who wrote the code
to support AMD IRQ router. He may be the culprit (5%, but...)

 http://people.redhat.com/zaitcev/linux/mptable-2.0.15a-1.i386.rpm
 http://people.redhat.com/zaitcev/linux/mptable-2.0.15a-1.src.rpm

-- Pete
