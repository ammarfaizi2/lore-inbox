Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968603AbWLES0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968603AbWLES0A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 13:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968605AbWLES0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 13:26:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41802 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968603AbWLES0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 13:26:00 -0500
Date: Tue, 5 Dec 2006 18:25:58 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Yu Luming <luming.yu@gmail.com>,
       Miguel Ojeda Sandonis <maxextreme@gmail.com>
Subject: Re: -mm merge plans for 2.6.20
In-Reply-To: <20061205100140.24888a96.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612051822140.7917@pentafluge.infradead.org>
References: <20061204204024.2401148d.akpm@osdl.org>
 <Pine.LNX.4.64.0612051538280.15711@pentafluge.infradead.org>
 <20061205100140.24888a96.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register.patch
> > 
> > Does this patch update the fbdev drivers?
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc6/2.6.19-rc6-mm2/broken-out/video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register.patch
> 
> Seems not.  Should it?

Yes. Its bizarre. The drivers compile with the wrong method prototype. I 
updated the fbdev drivers to the new backlight_device_register and it 
compiled as expect. There are a few other problems with teh fbdev drivers. 
I will send a patch.

> > > add-display-output-class-support.patch
> > > add-output-class-document.patch
> > > drivers-add-lcd-support-3.patch
> > > drivers-add-lcd-support-3-Kconfig-fix.patch
> > > drivers-add-lcd-support-update-4.patch
> > > drivers-add-lcd-support-update-5.patch
> > > drivers-add-lcd-support-update6.patch
> > > drivers-add-lcd-support-update-7.patch
> > > drivers-add-lcd-support-update-8.patch
> > 
> > Ug. We have alot of interfaces attempting to do the same thing. We also 
> > have the lcd class_dev in drivers/video/backlight. I did some work which I 
> > will post to interested parties in the hopes of getting one interface to 
> > make everyone happy. 
> 
> Well can you please work out what we should do with Miguel?

I sent a email already. The details will be hammered out.

