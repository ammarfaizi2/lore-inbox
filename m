Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264183AbUEMNiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbUEMNiS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 09:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264186AbUEMNiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 09:38:18 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27128 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264183AbUEMNiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 09:38:14 -0400
Date: Thu, 13 May 2004 15:38:06 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       matthew.e.tolentino@intel.com, Matt_Domsch@dell.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.6-mm2: EFI_VARS=m is broken
Message-ID: <20040513133806.GD22202@fs.tum.de>
References: <20040513032736.40651f8e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513032736.40651f8e.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2004 at 03:27:36AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.6-mm1:
>...
> +efivars-fix.patch
> 
>  Fix oops with efivars enabled but not avaialble.
>...

This patch broke EFI_VARS=m:

<--  snip  -->

WARNING: /lib/modules/2.6.6-mm2/kernel/drivers/firmware/efivars.ko needs unknown symbol efi_enabled

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

