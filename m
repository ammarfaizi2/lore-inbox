Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWIIIQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWIIIQi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 04:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbWIIIQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 04:16:38 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:64473 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932351AbWIIIQh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 04:16:37 -0400
Date: Sat, 9 Sep 2006 10:16:18 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Matthias Lederhofer <matled@gmx.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG/PATCH] make deb-pkg: optionally use fakeroot
In-Reply-To: <20060908185316.GA20352@moooo.ath.cx>
Message-ID: <Pine.LNX.4.61.0609091015350.30551@yvahk01.tjqt.qr>
References: <20060908185316.GA20352@moooo.ath.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>diff --git a/scripts/package/Makefile b/scripts/package/Makefile
>index 7c434e0..d77e21a 100644
>--- a/scripts/package/Makefile
>+++ b/scripts/package/Makefile
>@@ -72,7 +72,7 @@ # Deb target
> # ---------------------------------------------------------------------------
> deb-pkg: FORCE
> 	$(MAKE) KBUILD_SRC=
>-	$(CONFIG_SHELL) $(srctree)/scripts/package/builddeb
>+	$(FAKEROOT) $(CONFIG_SHELL) $(srctree)/scripts/package/builddeb

Why are distribution-specific things/objects/targets even included?



Jan Engelhardt
-- 
