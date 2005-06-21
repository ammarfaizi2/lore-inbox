Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVFUING@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVFUING (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 04:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVFUILx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 04:11:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21655 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261541AbVFUGy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:54:26 -0400
Date: Mon, 20 Jun 2005 23:54:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <gregkh@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Message-Id: <20050620235403.45bf9613.akpm@osdl.org>
In-Reply-To: <20050621062926.GB15062@kroah.com>
References: <20050621062926.GB15062@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de> wrote:
>
>  Just in time for a July release, here's a patch series that removes
>  devfs from the kernel tree as promised.

Whimper.

Maybe we should cook this in -mm for a bit, get a feeling for how many
users hate us, and how much?

This is going to hurt:

bix:/usr/src/25> grep -l devfs patches/*.patch
patches/areca-raid-linux-scsi-driver-fix.patch
patches/areca-raid-linux-scsi-driver.patch
patches/bk-ide-dev.patch
patches/git-input.patch
patches/git-mtd.patch
patches/git-ocfs.patch
patches/git-scsi-misc-drivers-scsi-chc-remove-devfs-stuff.patch
patches/gregkh-driver-class-02-tty.patch
patches/gregkh-driver-class-03-input.patch
patches/gregkh-driver-class-05-sound.patch
patches/gregkh-driver-class-06-block.patch
patches/gregkh-driver-class-07-char.patch
patches/gregkh-driver-class-08-ieee1394.patch
patches/gregkh-driver-class-09-scsi.patch
patches/gregkh-driver-class-11-drivers.patch
patches/gregkh-driver-class-12-the_rest.patch
patches/gregkh-driver-ipmi-class_simple-fixes.patch
patches/gregkh-i2c-i2c-config_cleanup-01.patch
patches/kdump-accessing-dump-file-in-linear-raw-format.patch
patches/linus.patch
patches/md-add-interface-for-userspace-monitoring-of-events.patch
patches/md-optimised-resync-using-bitmap-based-intent-logging.patch
patches/post-halloween-doc.patch
patches/st-warning-fix.patch

