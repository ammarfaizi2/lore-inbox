Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWFRXJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWFRXJF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 19:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWFRXJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 19:09:05 -0400
Received: from mail.suse.de ([195.135.220.2]:1995 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751181AbWFRXJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 19:09:04 -0400
Date: Sun, 18 Jun 2006 16:06:08 -0700
From: Greg KH <gregkh@suse.de>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [GIT PATCH] Remove devfs from 2.6.17
Message-ID: <20060618230608.GA2212@suse.de>
References: <20060618221343.GA20277@kroah.com> <6bffcb0e0606181545v72926ffas88561f9532030cfb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0606181545v72926ffas88561f9532030cfb@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 12:45:16AM +0200, Michal Piotrowski wrote:
> Hi Greg,
> 
> On 19/06/06, Greg KH <gregkh@suse.de> wrote:
> [snip]
> >I've posted all of these patches before, but if people really want to look 
> >at them, they can be found at:
> >        http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-05-devfs/
> >
> 
> devfs-remove-devfs_fs_kernel.h.patch doesn't apply clean.
> 
> [michal@ltg01-fedora linux-work2]$ quilt push devfs-feature-removal.patch
> Applying patch patches/devfs-die-die-die.patch
> patching file fs/Makefile
> patching file fs/compat_ioctl.c
> [..]
> patching file drivers/video/fbmem.c
> patching file fs/coda/psdev.c
> patching file fs/partitions/check.c
> Hunk #1 FAILED at 320.
> 1 out of 1 hunk FAILED -- rejects in file fs/partitions/check.c
> patching file include/linux/devfs_fs_kernel.h
> Patch patches/devfs-remove-devfs_remove.patch does not apply (enforce with 
> -f)

You need to have the other patches in my quilt tree in order to be able
to apply this one from the kernel.org directory.  I fixed this up by
hand for the git tree that I pointed Linus at.

thanks,

greg k-h
