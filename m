Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbTJ2KLI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 05:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbTJ2KLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 05:11:08 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:18183 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261950AbTJ2KLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 05:11:05 -0500
Subject: Re: [PATCH] Fix PCMCIA card detection
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-pcmcia@lists.infradead.org
In-Reply-To: <20031028212749.B31337@flint.arm.linux.org.uk>
References: <20031028212749.B31337@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1067422257.798.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-5) 
Date: Wed, 29 Oct 2003 11:10:57 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-10-28 at 22:27, Russell King wrote:
> I'm intending sending Linus the following patch to fix PCMCIA card
> detection about 24 hours (on 21:26 GMT on Oct 29th.)  A couple of
> people have tested it and reported that it fixes their card detection
> problems.  I'd like people _without_ this problem to try the patch
> and report if they see any breakages.

There seems to be no problems while using this patch.

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
(rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge
(rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
00:09.0 Multimedia audio controller: Yamaha Corporation YMF-754 [DS-1E
Audio Controller]
00:0c.0 CardBus bridge: Texas Instruments PCI4450 PC card Cardbus
Controller
00:0c.1 CardBus bridge: Texas Instruments PCI4450 PC card Cardbus
Controller
00:0c.2 FireWire (IEEE 1394): Texas Instruments: Unknown device 8011
00:0f.0 Communication controller: Lucent Microelectronics LT WinModem
01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility
P/M AGP 2x (rev 64)
02:00.0 Ethernet controller: 3Com Corporation 3CCFE575CT Cyclone CardBus
(rev 10)


