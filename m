Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUDISV0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 14:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUDISVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 14:21:25 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:36035 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261358AbUDISVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 14:21:24 -0400
Date: Fri, 9 Apr 2004 14:21:41 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Stefano Rivoir <s.rivoir@gts.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.5-mc3] radeon module not working anymore
In-Reply-To: <200404091344.47822.s.rivoir@gts.it>
Message-ID: <Pine.LNX.4.58.0404091419330.16677@montezuma.fsmlabs.com>
References: <200404091344.47822.s.rivoir@gts.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.58.0404091419332.16677@montezuma.fsmlabs.com>
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Apr 2004, Stefano Rivoir wrote:

>
> Hi all.
>
> When using radeon DRM module I get these on syslog:
>
> Apr  9 10:14:15 nbsteu kernel: [drm:radeon_cp_init] *ERROR* radeon_cp_init
> called without lock held
> Apr  9 10:14:15 nbsteu kernel: [drm:radeon_unlock] *ERROR* Process 1602 using
> kernel context 0
>
> Then the module is regularly shown by lsmod, but DRI in X doesn't work. This
> didn't happen in 2.6.4-mm2: I thought it was a matter of CONFIG_4KSTACKS, but
> in 2.6.5-mc3 it defaults to "no"...

Have you had a look at /var/log/XFree86.0.log? That may yield more
information. Does it work built into the kernel?

