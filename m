Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270200AbTGMKNE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 06:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270201AbTGMKNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 06:13:04 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59640 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270200AbTGMKNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 06:13:02 -0400
Date: Sun, 13 Jul 2003 12:27:41 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.75: parse error in pci.h if !CONFIG_PCI
Message-ID: <20030713102740.GY12104@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error when trying to compile 2.5.75 with 
!CONFIG_PCI:

<--  snip  -->

...
  CC      drivers/message/fusion/mptscsih.o
In file included from drivers/message/fusion/linux_compat.h:10,
                 from drivers/message/fusion/mptbase.h:58,
                 from drivers/message/fusion/mptscsih.c:82:
include/linux/pci.h:718: error: syntax error before "int"
drivers/message/fusion/mptscsih.c:6924: warning: `mptscsih_setup' 
defined but not used
make[3]: *** [drivers/message/fusion/mptscsih.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

