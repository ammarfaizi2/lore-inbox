Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWINTof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWINTof (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 15:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbWINTof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 15:44:35 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:19464 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751073AbWINToe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 15:44:34 -0400
Date: Thu, 14 Sep 2006 21:44:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC patch] MAINTAINERS:  encourage testers to volunteer
Message-ID: <20060914194411.GA669@stusta.de>
References: <4509AA10.4050907@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4509AA10.4050907@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2006 at 01:14:24PM -0600, Jim Cromie wrote:
> 
> Add a new entry-type into MAINTAINERS whereby folks with hardware can 
> volunteer to
> test patches to the driver.  It should encourage folks to put themselves 
> "on the hook"
> in trade for a little bit of notoriety.
> 
> Hopefully this will help improve:
> - support for rare hardware
> - QA on that hardware
> - connections between hackers & testers
> - would-be hackers can find new things to do, esp in less visited parts 
> of the dist.
> 
> Additions should be approved by maintainers etc, but thats no different 
> than is currently done.

There are currently 97 different saa7134 card types supported by the 
kernel. Do we need an entry for each of them (each card type has it's 
own specific support)?

And this information will become outdated much faster than updated
(even the maintainers entries are sometimes outdated).

> --- doc-touches/MAINTAINERS~	2006-09-14 11:50:03.000000000 -0600
> +++ doc-touches/MAINTAINERS	2006-09-14 12:19:13.000000000 -0600
> @@ -80,6 +80,12 @@
> 			it has been replaced by a better system and you
> 			should be using that.
> 
> +V: Validation/Test contact and hardware they can test.
> +
> +	Identifies folks who are willing to test driver patches, etc.
> +	Also can identify lack of hardware for otherwize maintained drivers
> +	by using 'none'
> +
> 3C359 NETWORK DRIVER
> P:	Mike Phillips
> M:	mikep@linuxtr.net

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

