Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264407AbTGGVGd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 17:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbTGGVGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 17:06:33 -0400
Received: from zero.dsl.niluge.net ([80.65.224.59]:37505 "EHLO mx.niluge.net")
	by vger.kernel.org with ESMTP id S264407AbTGGVGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 17:06:30 -0400
Date: Mon, 7 Jul 2003 23:21:04 +0200
From: "juan L." <jcb@niluge.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21 and 2.5.74 freeze on dell c600 laptop
Message-ID: <20030707212104.GA11953@athena>
Mail-Followup-To: "juan L." <jcb@niluge.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


when i load 3x59x + snd-maestro3 and start X, the machine freeze
i suspect an ioports / pci problem

any help apprecited


00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
00:03.0 CardBus bridge: Texas Instruments PCI1420
00:03.1 CardBus bridge: Texas Instruments PCI1420
00:07.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
00:08.0 Multimedia audio controller: ESS Technology ES1983S Maestro-3i PCI Audio Accelerator (rev 10)
00:10.0 Ethernet controller: 3Com Corporation 3c556 Hurricane CardBus (rev 10)
00:10.1 Communication controller: 3Com Corporation Mini PCI 56k Winmodem (rev 10)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility M3 AGP 2x (rev 02)


0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial
0800-083f : Intel Corp. 82371AB/EB/MB PIIX4 
0840-085f : Intel Corp. 82371AB/EB/MB PIIX4 
0860-086f : Intel Corp. 82371AB/EB/MB PIIX4 
  0860-0867 : ide0
0cf8-0cff : PCI conf1
d000-d0ff : 3Com Corporation Mini PCI 56k Winmode
d400-d4ff : 3Com Corporation 3c556 Hurricane Card
  d400-d47f : 0000:00:10.0
d800-d8ff : ESS Technology ES1983S Maestro-3i P
dce0-dcff : Intel Corp. 82371AB/EB/MB PIIX4 
  dce0-dcff : uhci-hcd
e000-efff : PCI Bus #01
  ec00-ecff : ATI Technologies Inc Rage Mobility M3 AGP

