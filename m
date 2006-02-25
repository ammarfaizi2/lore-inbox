Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbWBYELr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbWBYELr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 23:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbWBYELr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 23:11:47 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:33810 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932621AbWBYELq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 23:11:46 -0500
Date: Sat, 25 Feb 2006 05:11:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.16-rc4-mm2: useless acpi_pmtmr_buggy
Message-ID: <20060225041143.GH3674@stusta.de>
References: <20060224031002.0f7ff92a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224031002.0f7ff92a.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 03:10:02AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc4-mm1:
>...
> +time-i386-clocksource-drivers-backout-pmtmr-changes.patch
> 
>  Various updates, fixes and cleanups for the time management patches in -mm.
>...

Both before and after this patch, acpi_pmtmr_buggy is useless since it 
never gets any value assigned.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

