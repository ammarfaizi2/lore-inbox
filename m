Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266514AbRGDGan>; Wed, 4 Jul 2001 02:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266510AbRGDGad>; Wed, 4 Jul 2001 02:30:33 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:30748 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S266514AbRGDGaW>; Wed, 4 Jul 2001 02:30:22 -0400
Date: Wed, 4 Jul 2001 08:29:04 +0200 (MEST)
From: Armin Schindler <mac@melware.de>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
cc: <acs@sysgo.de>
Subject: Checking 'hlt' instruction
Message-ID: <Pine.LNX.4.31.0107040821020.24472-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a problem with the startup of my 2.4.3 kernel on
a STPC Atlas (486), it hangs on the 'hlt' check.

With a standard BIOS it works, but I'm writing my own
bootloader to remove the BIOS, which works pretty good
so far.

Only when I use the 'no-hlt' parameter the kernel boots.

Can someone tell me what settings of a x86 causes the
CPU to halt forever on a 'hlt' instruction, which the
kernel doesn't set correctly at boot time and the BIOS
needs to do ?

Thanx,
Armin

