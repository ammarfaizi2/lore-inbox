Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbVIJXDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbVIJXDI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 19:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbVIJXDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 19:03:07 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27608 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932371AbVIJXDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 19:03:05 -0400
Date: Sun, 11 Sep 2005 01:02:55 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org, dwmw2@infradead.org,
       stern@rowland.harvard.edu, greg@kroah.com, linux-kernel@vger.kernel.org,
       Dave Airlie <airlied@linux.ie>
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
Message-ID: <20050910230255.GE1836@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0509101655520.7081-100000@netrider.rowland.org> <Pine.LNX.4.58.0509101410300.30958@g5.osdl.org> <43235707.7050909@pobox.com> <20050910153110.36a44eba.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050910153110.36a44eba.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  As for pm_register(), there are tons of users remaining.
> 
> Well it would kinda help if people knew what to _do_ about pm_register(). 
> Documentation/pm.txt cheerfully tells everyone how to use it in new code
> and the comment over the pm_register() implementation doesn't say that it's
> deprecated and doesn't tell people what to replace it with.

Well, we want people to properly register their devices into sysfs,
and use sysfs suspend()/resume() callbacks.

They do not map too closely to pm_register, however.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
