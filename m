Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUH0Kql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUH0Kql (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 06:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUH0Kqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 06:46:40 -0400
Received: from mproxy.gmail.com ([216.239.56.244]:30417 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262071AbUH0KqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 06:46:23 -0400
Message-ID: <21d7e99704082703463c48908a@mail.gmail.com>
Date: Fri, 27 Aug 2004 20:46:22 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Dave Airlie <airlied@linux.ie>
Subject: Re: [bk pull] DRM tree - i915 driver only..
Cc: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0408271123060.32411@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0408271123060.32411@skynet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is an additional one liner changeset in the tree, __NO_VERSION__
sneaked in, I've just applied a patch to the DRM CVS killing
NO_VERSION for ever.. we don't support 2.2/3 anyways...

Dave.

On Fri, 27 Aug 2004 11:28:34 +0100 (IST), Dave Airlie <airlied@linux.ie> wrote:
> 
> Hi Linus,
> 
> Please do a
>         bk pull bk://drm.bkbits.net/drm-2.6
> 
> This is just the i915 driver, which is required for the upcoming Xorg
> release,
> 
> the patch is quite large so I've not attached it, its also at
> http://www.skynet.ie/~airlied/patches/dri/i915_linux.diff
> 
> It's been run through Lindent.
> 
> Dave.
> 
>  drivers/char/drm/Kconfig        |   13
>  drivers/char/drm/Makefile       |    2
>  drivers/char/drm/drm_os_linux.h |    4
>  drivers/char/drm/drm_pciids.h   |    8
>  drivers/char/drm/i915.h         |   88 ++++
>  drivers/char/drm/i915_dma.c     |  714 ++++++++++++++++++++++++++++++++++++++++
>  drivers/char/drm/i915_drm.h     |  154 ++++++++
>  drivers/char/drm/i915_drv.c     |   31 +
>  drivers/char/drm/i915_drv.h     |  214 +++++++++++
>  drivers/char/drm/i915_irq.c     |  162 +++++++++
>  drivers/char/drm/i915_mem.c     |  347 +++++++++++++++++++
>  11 files changed, 1736 insertions(+), 1 deletion(-)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
