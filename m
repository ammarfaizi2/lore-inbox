Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUH0K2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUH0K2j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 06:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263709AbUH0K2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 06:28:39 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:57841 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S263540AbUH0K2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 06:28:35 -0400
Date: Fri, 27 Aug 2004 11:28:34 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [bk pull] DRM tree - i915 driver only..
Message-ID: <Pine.LNX.4.58.0408271123060.32411@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please do a
	bk pull bk://drm.bkbits.net/drm-2.6

This is just the i915 driver, which is required for the upcoming Xorg
release,

the patch is quite large so I've not attached it, its also at
http://www.skynet.ie/~airlied/patches/dri/i915_linux.diff

It's been run through Lindent.

Dave.

 drivers/char/drm/Kconfig        |   13
 drivers/char/drm/Makefile       |    2
 drivers/char/drm/drm_os_linux.h |    4
 drivers/char/drm/drm_pciids.h   |    8
 drivers/char/drm/i915.h         |   88 ++++
 drivers/char/drm/i915_dma.c     |  714 ++++++++++++++++++++++++++++++++++++++++
 drivers/char/drm/i915_drm.h     |  154 ++++++++
 drivers/char/drm/i915_drv.c     |   31 +
 drivers/char/drm/i915_drv.h     |  214 +++++++++++
 drivers/char/drm/i915_irq.c     |  162 +++++++++
 drivers/char/drm/i915_mem.c     |  347 +++++++++++++++++++
 11 files changed, 1736 insertions(+), 1 deletion(-)


