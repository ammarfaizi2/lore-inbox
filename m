Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285227AbRLVAT5>; Fri, 21 Dec 2001 19:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285230AbRLVATr>; Fri, 21 Dec 2001 19:19:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46598 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285227AbRLVATg>; Fri, 21 Dec 2001 19:19:36 -0500
Subject: Re: conclusion: arp.c *must* be (still) defective
To: mail_ker@xarch.tu-graz.ac.at (Alex)
Date: Sat, 22 Dec 2001 00:29:03 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10112211952010.6988-100000@xarch.tu-graz.ac.at> from "Alex" at Dec 21, 2001 07:52:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Ha2B-00026Y-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Sounds like you have the card on the wrong port or the IRQ not set in the
> > BIOS to be routed to ISA
> 
> Sir! It's PLUG AND PLAY! Isapnp! I ought not to care about IRQ or Bios?

IMHO you have an overdeveloped faith in technology 8)

Things to check

1.	Does tcpdump show anything if you ping the box from another machine
2.	Is the link light on
3.	Does the irq count in /proc/interrupts for the card rise
	appropriately ?
4.	What does the 3c5x9 diagnostic tool say (http://www.scyld.com)

The reason I ask is that Linux 2.2 and on some platforms 2.4 will be relying
on BIOS IRQ routing where Windows 9x will do the work itself. So I've seen
precisely these symptoms before
