Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262447AbSI2LVL>; Sun, 29 Sep 2002 07:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262448AbSI2LVL>; Sun, 29 Sep 2002 07:21:11 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:36787 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S262447AbSI2LVL>;
	Sun, 29 Sep 2002 07:21:11 -0400
Date: Sun, 29 Sep 2002 13:26:25 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200209291126.NAA21248@harpo.it.uu.se>
To: greearb@candelatech.com, linux-kernel@vger.kernel.org
Subject: Re: APIC error on CPU0: 00(02)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Sep 2002 19:44:08 -0700, Ben Greear wrote:
>Kernel: 2.4.20-pre8
>
>Machine: dual 1.66Ghz AMD machine, Tyan motherboard 64/66 PCI,
>...
>APIC error on CPU0: 00(02)
>APIC error on CPU1: 00(02)

Receive Checksum Error on the APIC bus.

This indicates a hardware problem. Dual-Athlon boards
have a reputation for being unstable unless everything
is exactly right: power supply, cooling, not overclocked,
MP not XP CPUs, correct type memory modules. BIOS MP 1.1
or 1.4 settings may also be critical.

Also double-check all connectors between the mainboard and
the case: at least one board (the ASUS a7m266-d I think)
has or had bugs in its manual.

/Mikael
