Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267506AbSLLV5W>; Thu, 12 Dec 2002 16:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267502AbSLLV5W>; Thu, 12 Dec 2002 16:57:22 -0500
Received: from trained-monkey.org ([209.217.122.11]:48398 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S267501AbSLLV5T>; Thu, 12 Dec 2002 16:57:19 -0500
To: Stephan van Hienen <ultra@a2000.nu>
Cc: sparclinux@vger.kernel.org, "" <linux-kernel@vger.kernel.org>
Subject: Re: Alteon AceNIC Coper Seen as Fibre ? (and incorrect settings)
References: <Pine.LNX.4.50.0212102157440.1634-100000@ddx.a2000.nu>
From: Jes Sorensen <jes@wildopensource.com>
Date: 12 Dec 2002 17:00:02 -0500
In-Reply-To: Stephan van Hienen's message of "Tue, 10 Dec 2002 22:03:03 +0100 (CET)"
Message-ID: <m37keej3tp.fsf@trained-monkey.org>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Stephan" == Stephan van Hienen <ultra@a2000.nu> writes:

Stephan> Sun UltraSparc 10 kernel 2.4.20

Stephan> eth2: Alteon AceNIC Gigabit Ethernet at 0x1ff02900000, irq
Stephan> 6,7d0 Tigon II (Rev. 6), Firmware: 12.4.11, MAC:
Stephan> 00:60:cf:20:92:fc PCI bus width: 32 bits, speed: 33MHz,
Stephan> latency: 64 clks eth2: Firmware up and running

Stephan> unplugging the utp cable, and plugging back in gives :

Stephan> eth2: 10/100BaseT link UP eth2: Optical link DOWN eth2:
Stephan> 10/100BaseT link UP

This is purely cosmetic. Basically the firmware sends a link down
event but not media info with it. At the time I wrote the code copper
cards weren't available and I just never got around to changing
it. It's trivial to fix, but really makes no difference whatsoever.

Jes
