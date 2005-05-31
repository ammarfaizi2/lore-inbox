Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVEaTgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVEaTgi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 15:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVEaTgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 15:36:38 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6415 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261263AbVEaTge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 15:36:34 -0400
Date: Tue, 31 May 2005 21:36:32 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Alexey Dobriyan <adobriyan@gmail.com>, Len Brown <len.brown@intel.com>
Cc: akpm@osdl.org, peterc@gelato.unsw.edu.au, tony.luck@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: pcdp-build-fix.patch added to -mm tree
Message-ID: <20050531193632.GY3627@stusta.de>
References: <200505310925.j4V9PNoS009318@shell0.pdx.osdl.net> <200505312022.44479.adobriyan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505312022.44479.adobriyan@gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 08:22:44PM +0400, Alexey Dobriyan wrote:
> 
> Does this patch make sense?
>...
> --- linux-vanilla/include/linux/acpi.h	2005-05-28 02:59:59.000000000 +0400
> +++ linux-8250/include/linux/acpi.h	2005-05-28 03:39:25.000000000 +0400
> @@ -25,6 +25,8 @@
>  #ifndef _LINUX_ACPI_H
>  #define _LINUX_ACPI_H
>  
> +#include <linux/config.h>
> +
>...

Len said one month ago that he applied a patch from me that included 
both this change and a similar one in acpi_bus.h .

Are there any problems with getting recent ACPI code into -mm?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

