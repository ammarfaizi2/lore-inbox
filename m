Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbVKBLLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbVKBLLE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 06:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbVKBLLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 06:11:04 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51383 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932508AbVKBLLC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 06:11:02 -0500
Date: Wed, 2 Nov 2005 12:10:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Russell King <rmk@arm.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Make spitz compile again
Message-ID: <20051102111045.GA30194@elf.ucw.cz>
References: <20051031134255.GA8093@elf.ucw.cz> <1130773530.8353.39.camel@localhost.localdomain> <20051101200516.GA7172@elf.ucw.cz> <1130881612.8489.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130881612.8489.33.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I did compile fixing, but it still will not boot. With neither my
> > config, not with yours. Just blank screen. Any ideas?
> > 
> > > http://www.rpsys.net/openzaurus/temp/total-2.6.14-git3-r0-defconfig-cxx00
> 
> I've worked out a patch to revert the change that broke things for c7x0:
> 
> http://www.rpsys.net/openzaurus/patches/revert_bootmem-r0.patch
> 
> I'd be interested to know if this helps your spitz kernel as its gets
> c7x0 working again. Obviously the next step is to work out why this
> breaks things but reverting it gets my Zaurus dev tree working again
> which stops users c7x0 complaining :)

I do not know what happened, but now I used your kernel, again
(without revert_bootmem patch), and it works. Strange. sorry for
confusion.
							Pavel
-- 
Thanks, Sharp!
