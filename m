Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbVDKUJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbVDKUJu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 16:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVDKUJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 16:09:31 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41138 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261917AbVDKUJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 16:09:18 -0400
Date: Mon, 11 Apr 2005 22:08:48 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Shawn Starr <shawn.starr@rogers.com>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6.12-rc2][suspend] Suspending Thinkpad: drive bay light in S3 mode stays on
Message-ID: <20050411200848.GC23530@elf.ucw.cz>
References: <20050411200341.39635.qmail@web88008.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411200341.39635.qmail@web88008.mail.re2.yahoo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I notice in Linux and in XP the drive bay light
> remains on while the laptop is in suspend-to-RAM. I
> know the ACPI  thinkpad extras added to the kernel
> recently can turn this off. I wonder if we can/or need
> to write hooks to turn the light off so to conserve
> power when we're in S3
> 
> Thoughts?

You probably want to expand the extras driver to turn it off during
S3.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
