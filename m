Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWH3XgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWH3XgT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 19:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWH3XgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 19:36:19 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51461 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751170AbWH3XgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 19:36:19 -0400
Date: Thu, 31 Aug 2006 01:36:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [-mm patch] drivers/input/misc/wistron_btns.c: fix section mismatch
Message-ID: <20060830233617.GS18276@stusta.de>
References: <20060826160922.3324a707.akpm@osdl.org> <20060830203520.GM18276@stusta.de> <200608301926.37928.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608301926.37928.dtor@insightbb.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2006 at 07:26:37PM -0400, Dmitry Torokhov wrote:
> On Wednesday 30 August 2006 16:35, Adrian Bunk wrote:
> > This patch fixes the following section mismatch
> > (dmi_matched() is referenced from struct dmi_ids):
> >
> 
> dmi_ids is only used in select_keymap, which is __init. Moreover,
> dmi_ids is marked __initdata so I do not see what the problem is...

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm3/broken-out/revert-input-wistron-fix-section-reference-mismatches.patch

> Dmitry

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

