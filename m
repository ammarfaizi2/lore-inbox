Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbVGIKx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbVGIKx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 06:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbVGIKx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 06:53:28 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:12993 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261612AbVGIKx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 06:53:27 -0400
Date: Sat, 9 Jul 2005 11:53:17 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [git tree] DRM VIA driver merge
Message-ID: <Pine.LNX.4.58.0507091149490.6297@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,
	Can you please pull the 'drm-via' branch from
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git

This contains the driver for the VIA unichrome chipset from the Unichrome
project.

Dave.

 Kconfig        |    7
 Makefile       |    2
 drm_pciids.h   |    7
 via_3d_reg.h   | 1651
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++ via_dma.c      |
741 +++++++++++++++++++++++++
 via_drm.h      |  243 ++++++++
 via_drv.c      |  126 ++++
 via_drv.h      |  118 ++++
 via_ds.c       |  280 +++++++++
 via_ds.h       |  104 +++
 via_irq.c      |  339 +++++++++++
 via_map.c      |  110 +++
 via_mm.c       |  358 ++++++++++++
 via_mm.h       |   40 +
 via_verifier.c | 1061 ++++++++++++++++++++++++++++++++++++
 via_verifier.h |   61 ++
 via_video.c    |   97 +++
 17 files changed, 5345 insertions(+)


