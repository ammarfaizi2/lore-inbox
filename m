Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269176AbUJTTNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269176AbUJTTNS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269175AbUJTTNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:13:10 -0400
Received: from gprs214-236.eurotel.cz ([160.218.214.236]:46723 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S269152AbUJTTJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:09:10 -0400
Date: Wed, 20 Oct 2004 21:08:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Message-ID: <20041020190846.GA21315@elf.ucw.cz>
References: <41740384.5783.12A07B14@localhost> <41763777.26324.1B3B684C@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41763777.26324.1B3B684C@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Open Firmware may be a 'nicer' solution, but I guarantee that if the 
> > > vendors started supporting that it would be just a bug ridden as any 16-
> > > bit real mode BIOS code. For the Video BIOS the code always works for 
> > > what it is tested for. Some vendors spend more time testing the VBE BIOS 
> > > side of things fully (if they are smart they have licensed our VBETest 
> > > tools for this purpose). Unfortunatley some vendors do not test this 
> > > stuff thoroughly and it has problems. But the same testing issues would 
> > > exist whether the firmware was written as a 16-bit x86 blob or as an Open 
> > > Firmware blob.
> > 
> > Actually that 16-bit x86 blob can access any PC hardware, and that's
> > where the stuff gets hard.
> 
> Yes, but there is only a very small set of PC hardware features you need 
> to implement, and most BIOS'es only look at those things for timing 
> purposes. Unfortunately there is no standard for how BIOS'es do internal 
> timing and delay loops, so we emulate them all (8253 timers, speaker 
> ports and CMOS time/date support ;-).

Hmm, that does not seem that bad. Did you need to emulate interrupt
controller, too? That one seemed most scary to me.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
