Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293618AbSBZWoU>; Tue, 26 Feb 2002 17:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293619AbSBZWoL>; Tue, 26 Feb 2002 17:44:11 -0500
Received: from wildsau.idv-edu.uni-linz.ac.at ([140.78.40.25]:27911 "EHLO
	wildsau.idv-edu.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id <S293618AbSBZWn6>; Tue, 26 Feb 2002 17:43:58 -0500
From: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
Message-Id: <200202262243.g1QMh9F13742@wildsau.idv-edu.uni-linz.ac.at>
Subject: please remove CONFIG_PNP, CONFIG_PNPBIOS
To: linux-kernel@vger.kernel.org
Date: Tue, 26 Feb 2002 23:43:09 +0100 (MET)
X-Mailer: ELM [version 2.4ME+ PL37 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

by checking 2.4.18, I saw that "CONFIG_PNP" is not in use in the
source anymore except in Documentation/Configure.help and as a
variable that CONFIG_ISAPNP depends on.

=> remove.

as a side note, I'd want to know how linux is configuring
the PCI devices, when e.g. in the Bios Settings I say
"Yes - PNP aware OS installed".

reason I ask is because I get IRQ routing conflicts
with cardbus (PCI to PCMCIA bridge) / PC-Card Adapter / FlashRAM.

can also someone tell me which variable the "CONFIG_PNPBIOS" options
depends on? this seems to be another variable which is only
"used" on Documentation/Configure.help.

according to the documentation of "CONFIG_PNP", Linux configures
my Plug and Play devices. Alternatively ... the user space utils
from isapnptools. this sounds like linux does not configure
PCI devices and therefore, the "PNP Aware OS" should always be
set to "N" in the BIOS - is this correct?

/herp



