Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267237AbUHEMi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267237AbUHEMi7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 08:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266749AbUHEMi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 08:38:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:17870 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266692AbUHEMiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 08:38:19 -0400
Date: Thu, 5 Aug 2004 14:38:09 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.8-rc3-mm1: ip2mainc-add-missing-pci_enable_device breaks compilation
Message-ID: <20040805123809.GF2746@fs.tum.de>
References: <20040805031918.08790a82.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805031918.08790a82.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 03:19:18AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.8-rc2-mm2:
>...
> +ip2mainc-add-missing-pci_enable_device.patch
>...
>  Fix PCI handling in various drivers
>...

This causes the following compile error:

<--  snip  -->

...
  CC [M]  drivers/char/ip2main.o
drivers/char/ip2main.c: In function `cleanup_module':
drivers/char/ip2main.c:445: request for member `pci_dev' in something not a structure or union
...
make[2]: *** [drivers/char/ip2main.o] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

