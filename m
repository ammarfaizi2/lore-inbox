Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbULHU3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbULHU3F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 15:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbULHU3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 15:29:05 -0500
Received: from gprs214-70.eurotel.cz ([160.218.214.70]:61318 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261352AbULHU2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 15:28:53 -0500
Date: Wed, 8 Dec 2004 21:28:32 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, Felix Dorner <felix_do@web.de>,
       linux-kernel@vger.kernel.org, linux-laptop@mobilix.org
Subject: Re: internal card reader support
Message-ID: <20041208202832.GA15615@elf.ucw.cz>
References: <41B74174.3080908@web.de> <20041208182134.GB2345@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041208182134.GB2345@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > My notebook (hp nx9105) has an integrated 5in1 card-reader. I would 
>  > really like to use this with linux.
>  > Since I do not think it is supported yet, I d like to know if it might 
>  > be possible to write a module or so for this.
>  > I am just an average C programmer, but always wanted to dive into kernel 
>  > developement. My knowledge on computer architecture is also no more than 
>  > basic, so this might be something to really learn a lot...
>  > So I start at zero knowledge now. First of course I need to find out if  
>  > what I want to do is possible at all.
> 
> All of these devices that I've seen use the usb-storage module.
> You might need to futz with the scsi_mod module max_luns argument to make it
> see all the slots though.

Unfortunately, that's not the case. At least hp nx5000 has something
custom for reading MMC/SD cards, definitely not usb reader. There's
partial docs somewhere, you just need to bitbang it over PCI.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
