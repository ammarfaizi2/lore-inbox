Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290203AbSAQTdx>; Thu, 17 Jan 2002 14:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290200AbSAQTdn>; Thu, 17 Jan 2002 14:33:43 -0500
Received: from suhkur.cc.ioc.ee ([193.40.251.100]:47865 "HELO suhkur.cc.ioc.ee")
	by vger.kernel.org with SMTP id <S290203AbSAQTde>;
	Thu, 17 Jan 2002 14:33:34 -0500
Date: Thu, 17 Jan 2002 21:33:31 +0200 (GMT)
From: Juhan Ernits <juhan@cc.ioc.ee>
To: linux-kernel@vger.kernel.org
Subject: misconfiguration of ne.o module in 2.2.19 damaged hardware. Is it
 normal?
Message-ID: <Pine.GSO.4.21.0201172119110.18678-100000@suhkur.cc.ioc.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

Is the following normal procedure? I've configured many ne2000 nics (and
also doing some guesswork on their parameters), but never managed to break
any of them with this.

The hw setup was the following:

P166MMX
Intel 430TX Chipset (Chaintech 5TDM1)
128MB RAM
Matrox Millennium graphics adapter
SB AWE 64 Gold sound card
DLink DE-250 (ne2000 compatible) 0x280, irq 3
COM2 disabled in bios
(the same setup had been working as stable as is possible under MS)

I installed linux on this box (Debian 2.2r4, kernel version 2.2.19).
Then when configuring the network the module ne.o was chosen. 
I was sure about the io address but not so sure about the irq. So I
configured the module with only io address parameter.
At this point no problems occurred.

Then I configured the network address but the device eth0 did not appear
to be available (naturally, due to misconfiguration). Since it was part of
automated install I decided to reboot after this.

Shutdown went fine, but the computer never reached the "beep" at the
beginning of the boot process, when bios checks memory.
The computer stopped behaving like this when the nic was removed . Another
computer behaved in exactly the same way, when the broken nic was
inserted.

How can such hardware damaging behaviour be avoided (assuming there are
more such dumb users as me :-)?

Best regards,

Juhan Ernits



