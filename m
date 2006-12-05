Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968505AbWLERfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968505AbWLERfX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 12:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968508AbWLERfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 12:35:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41258 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968505AbWLERfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 12:35:21 -0500
Date: Tue, 5 Dec 2006 17:35:20 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: -mm merge plans for 2.6.20
In-Reply-To: <20061204204024.2401148d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612051538280.15711@pentafluge.infradead.org>
References: <20061204204024.2401148d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> video-sysfs-support-take-2-add-dev-argument-for-backlight_device_register.patch

Does this patch update the fbdev drivers?

> add-display-output-class-support.patch
> add-output-class-document.patch
> drivers-add-lcd-support-3.patch
> drivers-add-lcd-support-3-Kconfig-fix.patch
> drivers-add-lcd-support-update-4.patch
> drivers-add-lcd-support-update-5.patch
> drivers-add-lcd-support-update6.patch
> drivers-add-lcd-support-update-7.patch
> drivers-add-lcd-support-update-8.patch

Ug. We have alot of interfaces attempting to do the same thing. We also 
have the lcd class_dev in drivers/video/backlight. I did some work which I 
will post to interested parties in the hopes of getting one interface to 
make everyone happy. 
