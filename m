Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVAMMS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVAMMS0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 07:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVAMMS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 07:18:26 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:44981 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S261605AbVAMMSV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 07:18:21 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org, Rahul Karnik <deathdruid@gmail.com>
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.10.0
Date: Thu, 13 Jan 2005 12:18:13 +0000
User-Agent: KMail/1.7.2
Cc: Mariusz Mazur <mmazur@kernel.pl>
References: <200501081613.27460.mmazur@kernel.pl> <200501131100.19500.andrew@walrond.org> <5b64f7f050113034640e28eb9@mail.gmail.com>
In-Reply-To: <5b64f7f050113034640e28eb9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501131218.13428.andrew@walrond.org>
X-Spam-Score: 4.3 (++++)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 January 2005 11:46, Rahul Karnik wrote:
>
> Let's be clear here: these are not regular X11 files, but those meant
> to compile kernel modules. Are you surprised that config.h is needed?
>

Not at all. But different packages seem to have very different expectations of 
what should be in <linux/config.h>...

As it stands, It would seem necessary to rewrite it to suit whichever package 
I happen to need to build.

andrew@orac x11-XORG-6_8_1 $ grep -rF linux/config.h *
extras/drm/linux/i810_drv.c:#include <linux/config.h>
extras/drm/linux/ffb_drv.c:#include <linux/config.h>
extras/drm/linux/mga_drv.c:#include <linux/config.h>
extras/drm/linux/savage_drv.c:#include <linux/config.h>
extras/drm/linux/sis_drv.c:#include <linux/config.h>
extras/drm/linux/drm_memory.h:#include <linux/config.h>
extras/drm/linux/mach64_drv.c:#include <linux/config.h>
extras/drm/linux/gamma_drv.c:#include <linux/config.h>
extras/drm/linux/i830_drv.c:#include <linux/config.h>
extras/drm/linux/r128_drv.c:#include <linux/config.h>
extras/drm/linux/drm_scatter.h:#include <linux/config.h>
extras/drm/linux/radeon_drv.c:#include <linux/config.h>
extras/drm/linux/drm_memory_debug.h:#include <linux/config.h>
extras/drm/linux/drmP.h:#include <linux/config.h>
extras/drm/linux/tdfx_drv.c:#include <linux/config.h>
extras/drm/shared/via_drv.c:#include <linux/config.h>
extras/drm/shared/drm.h:#include <linux/config.h>
programs/Xserver/hw/xfree86/drivers/sis/osdef.h:#include <linux/config.h>
programs/Xserver/hw/xfree86/drivers/sis/init301.h:#include <linux/config.h>
programs/Xserver/hw/xfree86/drivers/sis/init.h:#include <linux/config.h>

Andrew Walrond
