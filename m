Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbTFGOUe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 10:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTFGOUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 10:20:34 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:7893 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262367AbTFGOUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 10:20:32 -0400
Date: Sat, 7 Jun 2003 16:34:01 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.70-mm5: sc1200.c compile error if !CONFIG_PROC_FS
Message-ID: <20030607143401.GN15311@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following compile error in drivers/ide/pci/sc1200.c if 
!CONFIG_PROC_FS:

<--  snip  -->

...
  CC      drivers/ide/pci/sc1200.o
drivers/ide/pci/sc1200.c: In function `sc1200_config_dma2':
drivers/ide/pci/sc1200.c:228: warning: implicit declaration of function `sc1200_get_pci_clock'
drivers/ide/pci/sc1200.c:240: `PCI_CLK_33' undeclared (first use in this function)
drivers/ide/pci/sc1200.c:240: (Each undeclared identifier is reported only once
drivers/ide/pci/sc1200.c:240: for each function it appears in.)
drivers/ide/pci/sc1200.c:241: `PCI_CLK_48' undeclared (first use in this function)
drivers/ide/pci/sc1200.c:242: `PCI_CLK_66' undeclared (first use in this function)
make[3]: *** [drivers/ide/pci/sc1200.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

