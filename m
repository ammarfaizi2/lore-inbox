Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWBZSzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWBZSzU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 13:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWBZSzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 13:55:20 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33039 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750851AbWBZSzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 13:55:19 -0500
Date: Sun, 26 Feb 2006 19:55:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.6.16-rc4-mm2: drivers/rtc/utils.c should become part of a generic implementation
Message-ID: <20060226185518.GM3674@stusta.de>
References: <20060224031002.0f7ff92a.akpm@osdl.org> <20060225033118.GF3674@stusta.de> <20060225054619.149db264@inspiron> <20060225131025.GK3674@stusta.de> <20060226194116.50f7ad2e@inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060226194116.50f7ad2e@inspiron>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2006 at 07:41:16PM +0100, Alessandro Zummo wrote:
> On Sat, 25 Feb 2006 14:10:25 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
> 
> > 
> > Sounds good, but for generic functions, two adjustments are required:
> > - move the code to lib/
> > - remove rtc_ prefixes from the functions
> 
>  Moved. I'm not sure about renaming them.. 
> 
>  the functions are:
> 
> rtc_month_days
> rtc_time_to_tm
> rtc_valid_tm
> rtc_tm_to_time
> 
>  I think they make more sense with the rtc prefix

None of these functions is in any way specicific to RTC drivers.

>  Best regards,
>  Alessandro Zummo,

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

