Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVC1WVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVC1WVK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 17:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbVC1WVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 17:21:10 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27789 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262089AbVC1WVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 17:21:01 -0500
Date: Tue, 29 Mar 2005 00:20:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ulrich Lauther <ulrich.lauther@siemens.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: problem with suspending linux-2.6.12-rc1
Message-ID: <20050328222049.GE1389@elf.ucw.cz>
References: <20050326165853.GB1434@elf.ucw.cz> <200503280803.j2S8366R008085@mail-q.mchp.siemens.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503280803.j2S8366R008085@mail-q.mchp.siemens.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 28-03-05 10:03:06, Ulrich Lauther wrote:
> > Hi!
> > 
> > > since upgrading from 2.6.11 to 2.6.12-rc1 software suspend doesn't work 
> > > anymore for me:
> > > The last I see when suspending (echo 4 > /proc/acpi/sleep) is a
> > > message refering to eth0, then when "writing to swap space" should appear,
> > > the system stops.
> > > 
> > > Please let me know if you need more information.
> > 
> > Standard debugging: try again with init=/bin/bash and minimal set of
> > drivers, and get me last few messages...
> > 
> > 								Pavel
> with init=/bin/bash it works.
> 
> Further experimentation showed that the problem occurs only when X11 is
> running. I then tried to work without the evdev driver (and without the
> alps module in X11, that needs evdev), but that didn't make a
> difference).

Do you have 3D acceleration enabled in X? Does it work if you have X
running but on the background console? Does it work if you quit X then
suspend from console?
									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
