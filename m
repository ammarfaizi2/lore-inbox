Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751687AbWJAJNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbWJAJNz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 05:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbWJAJNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 05:13:54 -0400
Received: from natreg.rzone.de ([81.169.145.183]:63450 "EHLO natreg.rzone.de")
	by vger.kernel.org with ESMTP id S1751687AbWJAJNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 05:13:54 -0400
Date: Sun, 1 Oct 2006 11:07:17 +0200
From: Olaf Hering <olaf@aepfle.de>
To: David Brownell <david-b@pacbell.net>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 2.6.18-git] RTC class uses subsys_init
Message-ID: <20061001090717.GA14885@aepfle.de>
References: <200609282333.34224.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <200609282333.34224.david-b@pacbell.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, David Brownell wrote:


> +++ linux/drivers/rtc/rtc-sysfs.c	2006-07-30 16:15:50.000000000 -0700
> @@ -116,7 +116,7 @@
>  	class_interface_unregister(&rtc_sysfs_interface);
>  }
>  
> -module_init(rtc_sysfs_init);
> +subsys_init(rtc_sysfs_init);
>  module_exit(rtc_sysfs_exit);

subsys_init is not defined, but the change is in Linus tree now.
