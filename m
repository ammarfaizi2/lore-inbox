Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135217AbRD3NTC>; Mon, 30 Apr 2001 09:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135216AbRD3NSn>; Mon, 30 Apr 2001 09:18:43 -0400
Received: from p3EE1D444.dip.t-dialin.net ([62.225.212.68]:12805 "HELO
	spot.local") by vger.kernel.org with SMTP id <S135217AbRD3NSg>;
	Mon, 30 Apr 2001 09:18:36 -0400
Date: Mon, 30 Apr 2001 15:19:05 +0200
From: Oliver Feiler <kiza@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: pci/quirks.c - VIA PCI latency in 2.4.4
Message-ID: <20010430151905.A12136@munich.netsurf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.4.4 i686
X-Species: Snow Leopard
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	pci/quirks.c in Linux 2.4.4 contains the latency patch for the VIA 
686B southbridge. However the line 315 in the file reads:

        { PCI_FIXUP_FINAL,      PCI_VENDOR_ID_VIA,      PCI_DEVICE_ID_VIA_8363_0
,       quirk_vialatency },


	Doesn't this only activate the patch on KT133 boards and not on AMD760
boards for example that use the 686B southbridge as well? So shouldn't be
PCI_DEVICE_ID_VIA_82C686 (I don't know the correct ID for the 686B chip)  
placed there instead? Is this correct?

Bye

Oliver


-- 
Oliver Feiler                                               kiza@gmx.net
http://www.lionking.org/~kiza/pgpkey              PGP key ID: 0x561D4FD2
http://www.lionking.org/~kiza/
