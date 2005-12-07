Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbVLHJfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbVLHJfr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 04:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbVLHJfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 04:35:47 -0500
Received: from mail.macqel.be ([194.78.208.39]:34067 "EHLO mail.macqel.be")
	by vger.kernel.org with ESMTP id S1750870AbVLHJfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 04:35:46 -0500
Subject: Re: [PATCH 2.6.15-rc5] v4l2/compat_ioctl : add v4l2 framegrabber
	support
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Philippe De Muyter <phdm@macqel.be>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200512061838.jB6IcEW07561@mail.macqel.be>
References: <200512061838.jB6IcEW07561@mail.macqel.be>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 07 Dec 2005 13:47:34 -0200
Message-Id: <1133970454.7047.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2-1mdk 
Content-Transfer-Encoding: 8bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[200.181.87.61 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[200.181.87.61 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Ter, 2005-12-06 às 19:30 +0100, Philippe De Muyter escreveu:
> This patch add 32-bit compatibility for v4l2 framegrabber ioctls.
> 
> Signed-off-by: Philippe De Muyter <phdm@macqel.be>
	Thanks for you patch. It was added at V4L tree, available at
http://linuxtv.org/downloads/quilt

	Please notice that in v4l tree, compat32 functions were moved to
drivers/media/video/compat_ioctl32.c, and will be sent to kernel after
more tests.

	Please test all compat32 patches to check it if works properly. They
are at the beginning of patches/series files (against -rc5 or -git):

patches/v4l_0926_2_compat32_ioctl.diff
patches/v4l_0957_subject_compat_ioctl32_installation_fixes.patch
patches/v4l_0963_em28xx_ir_fixup_and_explicit_compat_ioctl32_handler.patch
patches/v4l_0972_more_build_fixes_for_compat_ioctl32_c.patch
patches/v4l_0973_another_build_fix_for_compat_ioctl32_c.patch
patches/v4l_0978_64_bit_fixes_esp_for_broken_compat_ioctl32.patch
patches/v4l_dvb_3120_adds_32_bit_compatibility_for_v4l2_framegrabber_ioctls.patch


cheers,
Mauro.

