Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269645AbUJSWS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269645AbUJSWS5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 18:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268745AbUJSWSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:18:22 -0400
Received: from gprs214-24.eurotel.cz ([160.218.214.24]:6272 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269645AbUJSVsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 17:48:35 -0400
Date: Tue, 19 Oct 2004 23:48:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: Richard Smith <rsmith@bitworks.com>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Message-ID: <20041019214818.GF1142@elf.ucw.cz>
References: <9e47339104101814166bf4cfe5@mail.gmail.com> <41740384.5783.12A07B14@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41740384.5783.12A07B14@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Its a sad fact though that we are (x86 anyway) dependant on some
> > amazingly fragile, stupid, usually binary only, legacy bloated, and
> > quite often buggy, 16-bit realmode video init code that should have
> > been put to pasture many years ago. 
> 
> Actually there is nothing wrong with the x86 BIOS from the perspective of 
> functionality and useability (or bloat for that matter). It contains all 
> the functionality we need and armed with something like the x86 emulator 
> we can use it for what we need on any platform.
> 
> Open Firmware may be a 'nicer' solution, but I guarantee that if the 
> vendors started supporting that it would be just a bug ridden as any 16-
> bit real mode BIOS code. For the Video BIOS the code always works for 
> what it is tested for. Some vendors spend more time testing the VBE BIOS 
> side of things fully (if they are smart they have licensed our VBETest 
> tools for this purpose). Unfortunatley some vendors do not test this 
> stuff thoroughly and it has problems. But the same testing issues would 
> exist whether the firmware was written as a 16-bit x86 blob or as an Open 
> Firmware blob.

Actually that 16-bit x86 blob can access any PC hardware, and that's
where the stuff gets hard.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
