Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbSKVWBw>; Fri, 22 Nov 2002 17:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbSKVWBw>; Fri, 22 Nov 2002 17:01:52 -0500
Received: from [200.255.184.113] ([200.255.184.113]:50892 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S265277AbSKVWBv>; Fri, 22 Nov 2002 17:01:51 -0500
Date: Fri, 22 Nov 2002 20:08:42 -0200
From: =?iso-8859-1?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <0@pervalidus.net>
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
Cc: linux-kernel@vger.kernel.org
Subject: sis.patch.20020808 and 2.4.20 ?
Message-ID: <20021122220842.GE25050@pervalidus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: Mutt/1.5.1i - Linux 2.4.19
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Any reason to not have sis.patch.20020808 in 2.4.20 ?

I have been using it with 2.4.19 in the last 3 months without any
noticeable problems.

Against 2.4.20-rc3 I get:

patching file drivers/ide/sis5513.c
patching file include/linux/pci_ids.h
Hunk #1 FAILED at 475.
1 out of 1 hunk FAILED -- saving rejects to file include/linux/pci_ids.h.rej

There were no changes to sis5513.c. I can manually fix pci_ids.h.

BTW, what does

{ "SiS745",     PCI_DEVICE_ID_SI_745,   ATA_133,        0 },

"ATA_133" mean ?

I have an ASUS A7S333 and SiS745 is ATA100, like the SiS735
from my old K7S5A.

SIS5513: IDE controller on PCI bus 00 dev 15                                    
SIS5513: chipset revision 208                                                   
SIS5513: not 100% native mode: will probe irqs later                            
SiS735    ATA 100 controller

SIS5513: IDE controller on PCI bus 00 dev 15                                    
SIS5513: chipset revision 208                                                   
SIS5513: not 100% native mode: will probe irqs later                            
SiS745    ATA 100 controller

-- 
0@pervalidus.{net, {dyndns.}org}
