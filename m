Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbTFOHtR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 03:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbTFOHtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 03:49:17 -0400
Received: from mailc.telia.com ([194.22.190.4]:10472 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id S261998AbTFOHtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 03:49:16 -0400
X-Original-Recipient: <linux-kernel@vger.kernel.org>
Message-ID: <3EEC2811.2040500@telia.com>
Date: Sun, 15 Jun 2003 10:02:25 +0200
From: Peter Lundkvist <p.lundkvist@telia.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Cardbus devices added twice since 2.5.69-bk10
X-Enigmail-Version: 0.74.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I can't get any cardbus (network) devices to work since 2.5.69-bk10.
I have tested this with 2.5.70 and 2.5.71 with same result. Output
of lspci lists the cardbus device twice with same device number.
Also tried with acpi=off, but same result.


Peter

--
lspci:
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03)
00:03.0 CardBus bridge: Texas Instruments PCI1420
00:03.1 CardBus bridge: Texas Instruments PCI1420
00:07.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
00:08.0 Multimedia audio controller: ESS Technology ES1983S Maestro-3i PCI Audio Accelerator (rev 10)
00:10.0 Communication controller: Lucent Microelectronics WinModem 56k (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility M3 AGP 2x (rev 02)
06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)

cardctl status:
Socket 0:
  no card
Socket 1:
  3.3V CardBus card
  function 0: [ready]


