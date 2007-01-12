Return-Path: <linux-kernel-owner+w=401wt.eu-S1161135AbXALWYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161135AbXALWYh (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 17:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161099AbXALWYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 17:24:37 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4892 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161135AbXALWYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 17:24:36 -0500
Date: Fri, 12 Jan 2007 14:41:03 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Alberto Alonso <alberto@ggsys.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Ext3 mounted as ext2 but journal still in effect.
Message-ID: <20070112144103.GA7685@ucw.cz>
References: <1168578496.9707.6.camel@w100> <20070111212545.efd5d8c5.akpm@osdl.org> <1168585021.9707.25.camel@w100>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168585021.9707.25.camel@w100>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> You were right, even after making the changes, it seems to be 
> telling lies:
> 
> # mount
> /dev/hda2 on / type ext2 (rw,usrquota)
> [...]
> 
> However, I think I am still not mounting as ext2:
> 
> # dmesg | grep 'Kernel command'
> Kernel command line: ro root=/dev/hda2 rootfstype=ext2
...
> rootfs / rootfs rw 0 0
> /dev/root / ext3 rw 0 0


> Do I need to mess with the initrd? My grub lines look like
> this:

Yes, probably.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
