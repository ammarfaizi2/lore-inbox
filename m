Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWGVPhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWGVPhu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 11:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWGVPha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 11:37:30 -0400
Received: from wm402rot.66.ADSL.NetSurf.Net ([66.135.97.66]:32386 "EHLO
	png3r11.pngxnet.com") by vger.kernel.org with ESMTP
	id S1750807AbWGVPh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 11:37:28 -0400
From: Dave Airlie <airlied@linux.ie>
To: linux-kernel@vger.kernel.org
Subject: [RFC] GPU device layer patchset (00/07)
Date: Sun, 23 Jul 2006 01:38:26 +1000
Message-Id: <11535827134076-git-send-email-airlied@linux.ie>
X-Mailer: git-send-email 1.4.1.ga3e6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patchset contains 7 patches to implement the GPU device layer.

0001-drm-remove-local-copies-of-pci-bus-slot-func.txt
0002-drm-remove-pci-domain-local-copy.txt
0003-gpu-Initial-GPU-layer-addition.txt
0004-gpu-radeon-add-a-radeon-lowlevel-GPU-driver.txt
0005-gpu-radeonfb-add-GPU-support-to-radeonfb.txt
0006-gpu-drm-Add-GPU-layer-support-to-generic-DRM.txt
0007-drm-gpu-radeon-Add-radeon-DRM-support-to-use-GPU-layer.txt

The first two patches are changes to the DRM layer that I will submit separately
later but are required for this work.

The GPU layer generic code is in 0003 and 0006, radeon gpu driver 0004,
radeonfb in 0005 and radeon drm in 0007.

The code is also available in a git repo branch: 'gpu-branch'
git://git.kernel.org/pub/scm/linux/kernel/git/airlied/gpu-2.6

This is the initial implementation for review.

Dave.
