Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932694AbWCIB2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbWCIB2w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 20:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbWCIB2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 20:28:52 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27663 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932694AbWCIB2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 20:28:51 -0500
Date: Thu, 9 Mar 2006 02:28:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alessandro Zummo <a.zummo@towertech.it>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au, akpm@digeo.com
Subject: Re: [PATCH 01/16] RTC Subsystem, library functions
Message-ID: <20060309012850.GY4006@stusta.de>
References: <20060306015008.858209000@towertech.it> <20060306015009.110961000@towertech.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306015009.110961000@towertech.it>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 02:50:09AM +0100, Alessandro Zummo wrote:
>...
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-rtc/drivers/rtc/Kconfig	2006-03-05 02:48:31.000000000 +0100
> @@ -0,0 +1,6 @@
> +#
> +# RTC class/drivers configuration
> +#
> +
> +config RTC_LIB
> +	bool
>...

I'd still say this should be a tristate (a MODULE_LICENSE("GPL") in
rtc-lib.c seems to be the only other change required for this).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

