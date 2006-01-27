Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030251AbWA0BlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbWA0BlO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 20:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbWA0BlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 20:41:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42199 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030251AbWA0BlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 20:41:13 -0500
Date: Thu, 26 Jan 2006 20:41:05 -0500
From: Dave Jones <davej@redhat.com>
To: alan@redhat.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: noisy edac
Message-ID: <20060127014105.GD16422@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, alan@redhat.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

e752x_edac is very noisy on my PCIE system..
my dmesg is filled with these...

[91671.488379] Non-Fatal Error PCI Express B
[91671.492468] Non-Fatal Error PCI Express B
[91901.100576] Non-Fatal Error PCI Express B
[91901.104675] Non-Fatal Error PCI Express B

Something need whitelisting? 

		Dave

00:00.0 Host bridge: Intel Corporation E7525 Memory Controller Hub (rev 09)
00:00.1 Class ff00: Intel Corporation E7525/E7520 Error Reporting Registers (rev 09)
00:02.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express Port A (rev 09)
00:03.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express Port A1 (rev 09)
00:04.0 PCI bridge: Intel Corporation E7525/E7520 PCI Express Port B (rev 09)
00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #2 (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #3 (rev 02)
00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI Controller #4 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC Interface Bridge (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE Controller (rev 02)
00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controlle r (rev 02)
01:00.0 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge A
01:00.2 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge B
03:0e.0 Ethernet controller: Intel Corporation 82545GM Gigabit Ethernet Controller (rev 04)
05:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60 [Radeon X300 (PCIE)]
05:00.1 Display controller: ATI Technologies Inc RV370 [Radeon X300SE]
06:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 04)
06:0d.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 01)

