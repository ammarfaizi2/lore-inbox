Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266725AbUITPyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266725AbUITPyk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 11:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266749AbUITPyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 11:54:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:17800 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266725AbUITPyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 11:54:21 -0400
Date: Mon, 20 Sep 2004 08:52:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net
Subject: Re: [Linux-fbdev-devel] fbdev broken in current bk for PPC
Message-Id: <20040920085214.0abe33a0.akpm@osdl.org>
In-Reply-To: <1095672428.13735.3.camel@gaston>
References: <1094783022.2667.106.camel@gaston>
	<200409110504.09812.adaplas@hotpop.com>
	<1095672428.13735.3.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>  Andrew, Any reason why this patch isn't upstream ? The recent changes
>  to fbdev in 2.6.9-* are a regression and we need this patch to get bac
>  the video=ofonly feature.

Well I have a whole bunch of fbcon/fbdev patches here, but at some point
one needs to plug the flow so we can get 2.6.9 out the door.  And nobody
told me (until now) that we had a problem.

Tony, which of the below shold be merged into 2.6.9?

fbdev-remove-unnecessary-banshee_wait_idle-from-tdfxfb.patch
fbdev-fix-logo-drawing-failure-for-vga16fb.patch
fbdev-initialize-i810fb-after-agpgart.patch
fbdev-fix-userland-compile-breakage.patch
fbcon-fix-setup-boot-options-of-fbcon.patch
fbdev-pass-struct-device-to-class_simple_device_add.patch
fbdev-add-tile-blitting-support.patch
fbcon-fix-fbcons-setup-routine.patch
fbdev-arrange-driver-order-in-makefile.patch
fbdev-fix-scrolling-corruption.patch
radeonfb-fix-warnings-about-uninitialized-variables.patch
fbdev-remove-i810fb-explicit-agp-initialization-hack.patch

