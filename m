Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261819AbVCZKQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVCZKQV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 05:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbVCZKQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 05:16:21 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:37841 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261819AbVCZKQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 05:16:19 -0500
Date: Sat, 26 Mar 2005 11:16:09 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Luca <kronos@kronoz.cjb.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Garbage on serial console after serial driver loads
In-Reply-To: <20050325210132.GA11201@dreamland.darkstar.lan>
Message-ID: <Pine.LNX.4.61.0503261115480.28431@yvahk01.tjqt.qr>
References: <20050325202414.GA9929@dreamland.darkstar.lan>
 <20050325203853.C12715@flint.arm.linux.org.uk> <20050325210132.GA11201@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Well, serial_core seems to think so:
>
>Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
>ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
>ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
>ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A

Does it work if you set the baud rate manually, as a bootloader option?



Jan Engelhardt
-- 
No TOFU for me, please.
