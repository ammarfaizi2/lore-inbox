Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276247AbRJGVZJ>; Sun, 7 Oct 2001 17:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276297AbRJGVY6>; Sun, 7 Oct 2001 17:24:58 -0400
Received: from apollos.ttu.ee ([193.40.254.143]:7951 "EHLO apollos.ttu.ee")
	by vger.kernel.org with ESMTP id <S276247AbRJGVYu>;
	Sun, 7 Oct 2001 17:24:50 -0400
Date: Sun, 7 Oct 2001 23:25:19 +0200 (EET)
From: david <david@apollos.ttu.ee>
To: <linux-kernel@vger.kernel.org>
Subject: PCI problem with 2.4.10 on 82434LX chipset
Message-ID: <Pine.LNX.4.33.0110072319040.2878-100000@apollos.ttu.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

 PCI stopped working after upgrading kernel from redhat 2.4.3 to 2.4.10,
ISA devices are fine. Here are dmesg output fragments:

redhat 2.4.3-12:

PCI: PCI BIOS revision 2.10 entry at 0xfd6f2, last bus=0
PCI: Using configuration type 2
PCI: Probing PCI hardware

also lspci output of pci hardware:

00:00.0 Host bridge: Intel Corporation 82434LX [Mercury/Neptune] (rev 11)
        Flags: bus master, slow devsel, latency 32

But using 2.4.10:

PCI: PCI BIOS revision 2.10 entry at 0xfd6f2, last bus=0
PCI: System does not support PCI

Any hope getting PCI bus working on this box? Maybe some hints? Thanx :)




Taavi Tuisk

