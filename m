Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbVF1W0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVF1W0Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 18:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVF1WYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 18:24:31 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:6613 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261168AbVF1WXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 18:23:13 -0400
Date: Tue, 28 Jun 2005 15:23:09 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Olaf Hering <olh@suse.de>, Greg KH <greg@kroah.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050628222309.GB26772@smtp.west.cox.net>
References: <20050624081808.GA26174@kroah.com> <9EE4350F-5791-4787-950B-14E5C2B9ADB8@mac.com> <20050628074145.GC3577@kroah.com> <20050628195633.GA26131@smtp.west.cox.net> <20050628210804.GA26713@suse.de> <20050628212518.GA26772@smtp.west.cox.net> <42C1CA69.7060901@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C1CA69.7060901@tls.msk.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 02:08:41AM +0400, Michael Tokarev wrote:
> Tom Rini wrote:
> >On Tue, Jun 28, 2005 at 11:08:04PM +0200, Olaf Hering wrote:
> []
> >>>Er, don't you need /dev/console for console output to happen? (And that
> >>>it's a good idea to have /dev/null around too).  Or has that changed?
> >>
> >>scripts/gen_initramfs_list.sh creates that for every kernel.
> >
> >I get "Warning: unable to open initial console", so on post 2.6.12 (but
> >now stale) git.  Does userspace need to be doing something as well?
> 
> Are you using initramfs (cpio archive of the root fs)?
> Or "ol'good" initrd (cramfs, romfs, whatever)?

I'm just booting the kernel as normal, and assuming that the initramfs
that's built by default is used before my real rootfs happens.

-- 
Tom Rini
http://gate.crashing.org/~trini/
