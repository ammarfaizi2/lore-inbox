Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbVKGRhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbVKGRhe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbVKGRhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:37:34 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17936 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964883AbVKGRhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:37:33 -0500
Date: Mon, 7 Nov 2005 18:37:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, greg@kroah.com, kristen.c.accardi@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: 2.6.14-mm1: drivers/pci/hotplug/: namespace clashes
Message-ID: <20051107173732.GG3847@stusta.de>
References: <20051106182447.5f571a46.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051106182447.5f571a46.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<--  snip  -->

...
  LD      drivers/pci/hotplug/built-in.o
drivers/pci/hotplug/shpchp.o: In function `get_hp_hw_control_from_firmware':
: multiple definition of `get_hp_hw_control_from_firmware'
drivers/pci/hotplug/pciehp.o:: first defined here
ld: Warning: size of symbol `get_hp_hw_control_from_firmware' changed from 472 in drivers/pci/hotplug/pciehp.o to 25 in drivers/pci/hotplug/shpchp.o
drivers/pci/hotplug/shpchp.o: In function `get_hp_params_from_firmware':
: multiple definition of `get_hp_params_from_firmware'
drivers/pci/hotplug/pciehp.o:: first defined here
make[3]: *** [drivers/pci/hotplug/built-in.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

