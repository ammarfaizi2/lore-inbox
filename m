Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272593AbRI0Ma1>; Thu, 27 Sep 2001 08:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272619AbRI0MaR>; Thu, 27 Sep 2001 08:30:17 -0400
Received: from tara.mozcom.com ([202.47.132.50]:62402 "HELO tara.mozcom.com")
	by vger.kernel.org with SMTP id <S272593AbRI0MaF>;
	Thu, 27 Sep 2001 08:30:05 -0400
Date: Thu, 27 Sep 2001 20:30:25 +0800 (PHT)
From: Orlando Andico <orly@mozcom.com>
To: <linux-kernel@vger.kernel.org>
Cc: PLUG Mailing List <plug@lists.q-linux.com>
Subject: PCI resource allocation problem in 2.4.10
Message-ID: <Pine.LNX.4.33.0109272025110.10139-100000@tara.mozcom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just upgraded from 2.4.9 to 2.4.10, and now I get this problem which I
did not have before (cannot allocate resources, plus the error with the
Quadro2). This is a definite showstopper as it prevents the NVIDIA
(closed-source) kernel module from working properly.

....
PCI: PCI BIOS revision 2.10 entry at 0xfb3a0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI: Found IRQ 5 for device 00:07.2
PCI: Sharing IRQ 5 with 00:07.3
PCI: Sharing IRQ 5 with 00:0c.0
PCI: Cannot allocate resource region 0 of device 00:00.0
PCI: Cannot allocate resource region 0 of device 01:00.0
PCI: Error while updating region 01:00.0/0 (b8000000 != a8000000)
  got res[b8000000:b8ffffff] for resource 0 of nVidia Corporation NV15 GL
  (Quadro2)
....


-- 
Orlando Andico <orly@mozcom.com>
Mosaic Communications, Inc.

