Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292143AbSBAXln>; Fri, 1 Feb 2002 18:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292145AbSBAXld>; Fri, 1 Feb 2002 18:41:33 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:26892 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292143AbSBAXl3>; Fri, 1 Feb 2002 18:41:29 -0500
Subject: Re: PCI Problems [was Re: NIC lockup in 2.4.17 (SMP/APIC/Intel 82557)]
To: esm@logic.net (Edward S. Marshall)
Date: Fri, 1 Feb 2002 23:54:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1012585929.1843.45.camel@localhost.localdomain> from "Edward S. Marshall" at Feb 01, 2002 11:52:06 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16WnVr-0006Wm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jan 23 10:11:37 x kernel: Uhhuh. NMI received. Dazed and confused, but
> trying to continue
> Jan 23 10:11:37 x kernel: eth0: Host error, FIFO diagnostic register
> 0000.
> Jan 23 10:11:37 x kernel: eth0: PCI bus error, bus status 80000020
> Jan 23 10:11:37 x kernel: You probably have a hardware problem with your
> RAM chips
> Jan 23 10:11:37 x kernel: eth0: Host error, FIFO diagnostic register
> 0000.
> Jan 23 10:11:37 x kernel: eth0: PCI bus error, bus status 80000020

Your machine took an NMI and a PCI bus diagnostic. That generally points
hard to a bus problem. 
