Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968540AbWLESBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968540AbWLESBx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 13:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968541AbWLESBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 13:01:53 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58922 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968540AbWLESBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 13:01:52 -0500
Date: Tue, 5 Dec 2006 10:01:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org, Yu Luming <luming.yu@gmail.com>,
       Miguel Ojeda Sandonis <maxextreme@gmail.com>
Subject: Re: -mm merge plans for 2.6.20
Message-Id: <20061205100140.24888a96.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612051538280.15711@pentafluge.infradead.org>
References: <20061204204024.2401148d.akpm@osdl.org>
	<Pine.LNX.4.64.0612051538280.15711@pentafluge.infradead.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006 17:35:20 +0000 (GMT)
James Simmons <jsimmons@infradead.org> wrote:

> 
> > video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register.patch
> 
> Does this patch update the fbdev drivers?

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc6/2.6.19-rc6-mm2/broken-out/video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register.patch

Seems not.  Should it?

> > add-display-output-class-support.patch
> > add-output-class-document.patch
> > drivers-add-lcd-support-3.patch
> > drivers-add-lcd-support-3-Kconfig-fix.patch
> > drivers-add-lcd-support-update-4.patch
> > drivers-add-lcd-support-update-5.patch
> > drivers-add-lcd-support-update6.patch
> > drivers-add-lcd-support-update-7.patch
> > drivers-add-lcd-support-update-8.patch
> 
> Ug. We have alot of interfaces attempting to do the same thing. We also 
> have the lcd class_dev in drivers/video/backlight. I did some work which I 
> will post to interested parties in the hopes of getting one interface to 
> make everyone happy. 

Well can you please work out what we should do with Miguel?
