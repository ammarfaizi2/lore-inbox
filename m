Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbUKBXLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbUKBXLJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 18:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262616AbUKBXLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 18:11:08 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:46607 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261531AbUKBXKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 18:10:33 -0500
Date: Wed, 3 Nov 2004 00:16:38 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc1-bk12 still hangs when starting X on a radeon 9200 SE card
Message-ID: <20041102231638.GA12983@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reported this for 2.6.9, the problem
still exist in 2.6.10-rc1-bk12

Linux dies if I try to start x on my radeon 9200 SE pci card.
The screen goes black, and there is no response from the keyboard.
Even sysrq doesn't work, I have to use the reset button.

2.6.8.1 does not have this problem.  This is an
opteron machine, running a x86 kernel.

$ lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8385 [K8T800 AGP] Host Bridge (rev 01)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800 South]
0000:00:05.0 SCSI storage controller: LSI Logic / Symbios Logic 53c895 (rev 01)
0000:00:06.0 Multimedia audio controller: Trident Microsystems 4DWave NX (rev 02)
0000:00:08.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01)
0000:00:08.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (Secondary) (rev 01)
0000:00:0b.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705 Gigabit Ethernet (rev 03)
0000:00:0f.0 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev 01)

Helge Hafting
