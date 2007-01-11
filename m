Return-Path: <linux-kernel-owner+w=401wt.eu-S1030211AbXAKIFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbXAKIFT (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 03:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbXAKIFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 03:05:19 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:38663 "EHLO
	calculon.skynet.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030211AbXAKIFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 03:05:18 -0500
Date: Thu, 11 Jan 2007 08:05:16 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [git pull] urgent drm patch for 2.6.20-rc4 - repost
Message-ID: <Pine.LNX.4.64.0701110802520.19266@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Can you please pull the 'drm-patches' branch from
git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git drm-patches

It only contains one fix for an error printout that will spam the logs 
with all current X servers...

Dave.

drivers/char/drm/i915_irq.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

commit eac681b3aec226c83f52d307254d88393aab5eb9
Author: =?utf-8?q?Michel_D=C3=A4nzer?= <michel@tungstengraphics.com>
Date:   Mon Jan 8 20:38:34 2007 +1100

     i915: Fix a DRM_ERROR that should be DRM_DEBUG.

     It would clutter up the kernel output in a situation which is legitimate 
before
     X.org 7.2 and handled correctly by the 3D driver.

     Signed-off-by: Dave Airlie <airlied@linux.ie>
