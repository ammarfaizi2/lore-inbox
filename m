Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWG3Rzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWG3Rzn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 13:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWG3Rzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 13:55:43 -0400
Received: from cantor2.suse.de ([195.135.220.15]:57561 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932396AbWG3Rzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 13:55:42 -0400
Date: Sun, 30 Jul 2006 10:51:09 -0700
From: Greg KH <greg@kroah.com>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, stable@kernel.org,
       akpm@osdl.org, chrisw@sous-sol.org, grim@undead.cc
Subject: Re: [stable] [PATCH] initramfs: Allow rootfs to use tmpfs instead of ramfs
Message-ID: <20060730175109.GA20777@kroah.com>
References: <200607301808.14299.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607301808.14299.a1426z@gawab.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 06:08:14PM +0300, Al Boldi wrote:
> 
> Replugs rootfs to use tmpfs instead of ramfs as a Kconfig option.
> 
> This patch is based on John Zielinski's 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107013630212011&w=4 patch.
> 
> Modified for 2.6.17.
> 
> RunTime tested on i386.
> 
> This trivial patch should go into 2.6.18.

This looks like a new feature.  What problem does it fix that would make
it acceptable to add to the -stable tree?

thanks,

greg k-h
