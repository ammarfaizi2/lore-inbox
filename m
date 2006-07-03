Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWGCHYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWGCHYD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 03:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWGCHYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 03:24:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:716 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750812AbWGCHYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 03:24:01 -0400
Message-ID: <44A8C5FD.8050201@suse.de>
Date: Mon, 03 Jul 2006 09:23:41 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, Jeff Bailey <jbailey@ubuntu.com>,
       "H. Peter Anvin" <hpa@zytor.com>, Michael Tokarev <mjt@tls.msk.ru>,
       Roman Zippel <zippel@linux-m68k.org>, torvalds@osdl.org,
       klibc@zytor.com, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [klibc] klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060630181131.GA1709@elf.ucw.cz> <44A5AE17.4080106@tls.msk.ru> <44A5B07E.9040007@zytor.com> <1151751417.2553.8.camel@localhost.localdomain> <20060701150506.GA10517@thunk.org>
In-Reply-To: <20060701150506.GA10517@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> particular distro's non-standard "value add".  Maybe that means we
> need to have hooks so that the distro's can add their non-standard
> "value add" without breaking the ability for users to upgrade to newer
> kernels.

Sure we need that.  Not only for distro's "value add", but basically for
everything which depends on utilities not shipped with the kernel
(rootfs-on-lvm for example, udev & /dev setup, ...).  It's probably also
very handy for users and hackers to have a standard way to add stuff to
the initramfs during normal kernel build, without having to build their own.

cheers,

  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
http://www.suse.de/~kraxel/julika-dora.jpeg
