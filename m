Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262716AbVDALdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262716AbVDALdy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 06:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbVDALdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 06:33:54 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34992 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262716AbVDALdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 06:33:53 -0500
Date: Fri, 1 Apr 2005 13:33:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Norbert Preining <preining@logic.at>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: 2.6.12-rc1-mm4 and suspend2ram (and synaptics)
Message-ID: <20050401113335.GA13160@elf.ucw.cz>
References: <20050331220822.GA22418@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331220822.GA22418@gamma.logic.tuwien.ac.at>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Since 2.6.12-rc1-mmX I cannot get suspend2ram working again as it was
> with 2.6.11-mm4 with the same .config.
> 
> I suspends fine, but never resumes. No CapsLock, no sysrq, no network is
> working. Nothing in the log files. Is there anything which may cause
> these troubles when compiled into the kernel and not loaded as module?
> (as it was with my usb stuff until 2.6.11-mm2, after this I had to stop
> hotplug, before I could go with usb running).

Try suspend2disk, first, and try suspend2ram with minimal kernel
config.
							Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
