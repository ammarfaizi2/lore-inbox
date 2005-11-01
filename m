Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbVKAQvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbVKAQvl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 11:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbVKAQvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 11:51:41 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43780 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750948AbVKAQvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 11:51:40 -0500
Date: Tue, 1 Nov 2005 17:51:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Luke Yang <luke.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ADI Blackfin patch for kernel 2.6.14
Message-ID: <20051101165136.GU8009@stusta.de>
References: <489ecd0c0511010128x41d39643x37893ad48a8ef42a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <489ecd0c0511010128x41d39643x37893ad48a8ef42a@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 05:28:30PM +0800, Luke Yang wrote:

> Hi all,

Hi,

>   This is the new Blackfin patch for kernel 2.6.14. Mainly includes
> arch/Blackfin and include/asm-blackfin files. We decided not to put in
> all the drivers for this version.
> 
>  Here is the patch URL:
>  http://blackfin.uclinux.org/frs/download.php/606/bfin4kernel-2.6.14.patch
> . Please reiview and merge it into the kernel. Thank you very much.

some comments:
- the changes to the toplevel Makefile should go to 
  arch/blackfin/kernel/Makefile
- please use drivers/Kconfig
- include/asm-blackfin/pci.h contains some ^M characters
- please replace "extern inline" and "extern __inline__" with
  "static inline"
- CONFIG_CLEAN_COMPILE=n is not a good choice for a defconfig

> Luke Yang

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

