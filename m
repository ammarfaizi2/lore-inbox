Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbVBIWOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbVBIWOH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 17:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVBIWOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 17:14:07 -0500
Received: from gprs215-196.eurotel.cz ([160.218.215.196]:64655 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261943AbVBIWOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 17:14:04 -0500
Date: Wed, 9 Feb 2005 23:07:50 +0100
From: Pavel Machek <pavel@ucw.cz>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp logic error?
Message-ID: <20050209220750.GB2065@elf.ucw.cz>
References: <20050208203950.GA21623@cirrus.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208203950.GA21623@cirrus.madduck.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I am trying to get swsusp working on a 2.6.10 Debian kernel
> (2.6.10-1-686, custom compile, enabling only CONFIG_SOFTWARE_SUSPEND
> and leaving CONFIG_PM_STD_PARTITION empty) on this Sony Vaio Z1RSP
> Centrino 1.7 Pentium M laptop... without much success. Whenever
> I enter swsusp mode, the kernel reports that it cannot find the swap
> space and aborts.

Try doing it on vanilla, just one swapfile, and pass
resume=/dev/your_swapdevice.

Oh, and cc me next time if you want faster reply...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
