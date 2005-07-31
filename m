Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVGaVVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVGaVVk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 17:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVGaVVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 17:21:40 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32897 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261908AbVGaVVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 17:21:37 -0400
Date: Sun, 31 Jul 2005 23:20:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: ambx1@neo.rr.com
Cc: Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: revert yenta free_irq on suspend
Message-ID: <20050731212058.GC27433@elf.ucw.cz>
References: <2e00842e116e.2e116e2e0084@columbus.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e00842e116e.2e116e2e0084@columbus.rr.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Also I'd like to point out that this patch broke APM suspend-to-ram,
> not ACPI S3.  IMO, it may not be possible to support both APM and ACPI
> on every system, as their specs are not intended to be compatible.
> Progress toward proper suspend-to-ram support will, in many cases, be
> a small setback for APM.  This really can't be avoided.

Actually, for APM, OS theoretically does *not* need to FREEZE the
devices (or do anything else). "Doing nothing" should be easy...
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
