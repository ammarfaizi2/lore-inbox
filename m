Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270521AbRHNIbU>; Tue, 14 Aug 2001 04:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270522AbRHNIbK>; Tue, 14 Aug 2001 04:31:10 -0400
Received: from mail.erste.de ([195.243.98.251]:39274 "EHLO RalfBurger.com")
	by vger.kernel.org with ESMTP id <S270521AbRHNIbF>;
	Tue, 14 Aug 2001 04:31:05 -0400
Date: Tue, 14 Aug 2001 10:30:58 +0200 (CEST)
From: "Victoria W." <wicki@terror.de>
To: linux-kernel@vger.kernel.org
Subject: module agpgart in 2.4.7
Message-ID: <Pine.LNX.4.10.10108141022000.4218-100000@csb.terror.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

I'm not shure, if this is the right place for this question, but I'll try
it.

On a new mini-pc "lspci" shows the following:

00:01.0 Class 0300: 8086:7125 (rev 03)
or
00:01.0 VGA compatible controller: Intel Corporation: Unknown device 7125
(rev 03)

I have complied the agpgart-module with intel-support, but "insmod
agpgart" results in:

kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
kernel: agpgart: Maximum main memory to use for agp memory: 93M
kernel: agpgart: no supported devices found.

Is there a driver availiable, which supports this chipset?


best regards

wicki 

------------------------------------------------------
CONFIG_AGP=m
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
CONFIG_AGP_SWORKS=y
CONFIG_DRM=y
CONFIG_DRM_TDFX=m
CONFIG_DRM_GAMMA=m
CONFIG_DRM_R128=m
CONFIG_DRM_RADEON=m
CONFIG_DRM_I810=m
CONFIG_DRM_MGA=m



