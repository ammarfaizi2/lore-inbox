Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284787AbRLHUij>; Sat, 8 Dec 2001 15:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284805AbRLHUia>; Sat, 8 Dec 2001 15:38:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39945 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284787AbRLHUiU>; Sat, 8 Dec 2001 15:38:20 -0500
Subject: Re: 2.4.14/16 load reboots
To: belg4mit@dirty-bastard.pthbb.org (Jerrad Pierce)
Date: Sat, 8 Dec 2001 20:47:30 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200112081644.fB8GiSJ27360@dirty-bastard.pthbb.org> from "Jerrad Pierce" at Dec 08, 2001 11:44:28 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16CoNe-0002bu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a DEC Venutris 5120 (Pentium 120) with a Phoenix BIOS.
> After LILO loads and uncompresses these kernels the machine
> reboots. I have ecountered sombody else with the same problem.

There are a set of old machines that do this sort of stuff with all 2.4.x
kernels. Right now I don't know why. The Digital celebris has the same
bug.

> CONFIG_PCI_BIOS=y
> CONFIG_PM=y

Turn both of these off

> CONFIG_PNP=y
> CONFIG_ISAPNP=y

And these

Let me know if that helps at all. Whats the last kernel that did work on it
?
