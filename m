Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVFUNzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVFUNzm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 09:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVFUNxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 09:53:13 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:16648 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261326AbVFUNuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 09:50:07 -0400
Date: Tue, 21 Jun 2005 15:50:05 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <gregkh@suse.de>, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Message-ID: <20050621135005.GN3666@stusta.de>
References: <20050621062926.GB15062@kroah.com> <20050620235403.45bf9613.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620235403.45bf9613.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2005 at 11:54:03PM -0700, Andrew Morton wrote:
> Greg KH <gregkh@suse.de> wrote:
> >
> >  Just in time for a July release, here's a patch series that removes
> >  devfs from the kernel tree as promised.
> 
> Whimper.
> 
> Maybe we should cook this in -mm for a bit, get a feeling for how many
> users hate us, and how much?
> 
> This is going to hurt:
> 
> bix:/usr/src/25> grep -l devfs patches/*.patch
> patches/areca-raid-linux-scsi-driver-fix.patch
> patches/areca-raid-linux-scsi-driver.patch
> patches/bk-ide-dev.patch
> patches/git-input.patch
> patches/git-mtd.patch
> patches/git-ocfs.patch
> patches/git-scsi-misc-drivers-scsi-chc-remove-devfs-stuff.patch
> patches/gregkh-driver-class-02-tty.patch
> patches/gregkh-driver-class-03-input.patch
> patches/gregkh-driver-class-05-sound.patch
> patches/gregkh-driver-class-06-block.patch
> patches/gregkh-driver-class-07-char.patch
> patches/gregkh-driver-class-08-ieee1394.patch
> patches/gregkh-driver-class-09-scsi.patch
> patches/gregkh-driver-class-11-drivers.patch
> patches/gregkh-driver-class-12-the_rest.patch
> patches/gregkh-driver-ipmi-class_simple-fixes.patch
> patches/gregkh-i2c-i2c-config_cleanup-01.patch
> patches/kdump-accessing-dump-file-in-linear-raw-format.patch
> patches/linus.patch
> patches/md-add-interface-for-userspace-monitoring-of-events.patch
> patches/md-optimised-resync-using-bitmap-based-intent-logging.patch
> patches/post-halloween-doc.patch
> patches/st-warning-fix.patch

I don't see any place where this is not either:
- in documentation or
- already removed again in a second patch in -mm or
- only in patch context

Since the patch context issues are all in patches by Greg that went into 
Linus' tree after 2.6.12-mm1 I doubt there will be many problems after 
merging them.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

