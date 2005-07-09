Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263176AbVGIK4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbVGIK4Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 06:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263181AbVGIK4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 06:56:23 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:36801 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S263176AbVGIK4W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 06:56:22 -0400
Date: Sat, 9 Jul 2005 11:56:21 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [git tree] DRM 32/64 tree merge
Message-ID: <Pine.LNX.4.58.0507091153240.6297@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,
	Can you pull the 'drm-3264' tree from
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git

This contains 32/64 compatibility changes for MGA/i915 and r128.

Dave.

 Makefile     |    3
 i915_drv.c   |    3
 i915_drv.h   |    4 +
 i915_ioc32.c |  221 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mga_drv.c    |    3
 mga_drv.h    |    2
 mga_ioc32.c  |  167 ++++++++++++++++++++++++++++++++++++++++++++
 r128_drv.c   |    3
 r128_drv.h   |    3
 r128_ioc32.c |  219 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 10 files changed, 628 insertions(+)
