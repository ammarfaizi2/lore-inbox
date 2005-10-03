Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932485AbVJCSFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbVJCSFf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbVJCSFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:05:35 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12548 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932485AbVJCSFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:05:34 -0400
Date: Mon, 3 Oct 2005 20:05:32 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] AMD Geode GX/LX support
Message-ID: <20051003180532.GE3652@stusta.de>
References: <20051003174738.GC29264@cosmic.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003174738.GC29264@cosmic.amd.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 11:47:38AM -0600, Jordan Crouse wrote:
> This patch adds support for the GX processor including processor
> identification, and enabling / disabling the appropriate configuration
> options.  Please apply against linux-2.4.14-rc2-mm2.
> 
> Signed off by:  Jordan Crouse (jordan.crouse@amd.com)
> 
> Index: linux-2.6.14-rc2-mm2/MAINTAINERS
> ===================================================================
> --- linux-2.6.14-rc2-mm2.orig/MAINTAINERS
> +++ linux-2.6.14-rc2-mm2/MAINTAINERS
> @@ -259,6 +259,13 @@ P:	Ivan Kokshaysky
>  M:	ink@jurassic.park.msu.ru
>  S:	Maintained for 2.4; PCI support for 2.6.
>  
> +AMD GEODE PROCESSOR/CHIPSET SUPPORT
> +P:
> +M:
> +L:	info-linux@geode.amd.com
> +W:	http://www.amd.com/us-en/ConnectivitySolutions/TechnicalResources/0,,50_2334_2452_11363,00.html
> +S:	Supported
>...

Could you add yourself in the P: and M: lines?

> +config MGEODE_GX
> +	bool "Geode GX"
> +	help
> +	  Select this for AMD Geode GX processors.  Enables use of some extended
> +	  instructions, and passes appropriate optimization flags to GCC.
>...

The "and passes appropriate optimization flags to GCC" part seems to be 
missing in your patches.

And it's not clear to me how your new MGEODE_GX option relates to the 
already existing MGEODEGX1 option.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

