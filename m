Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262674AbVCJQFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbVCJQFT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 11:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbVCJQFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 11:05:18 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:24200 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262674AbVCJQCC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 11:02:02 -0500
Date: Thu, 10 Mar 2005 17:01:55 +0100
From: Jens Axboe <axboe@suse.de>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: current linus bk, error mounting root
Message-ID: <20050310160155.GC2578@suse.de>
References: <422F5D0E.7020004@pobox.com> <9e473391050309125118f2e979@mail.gmail.com> <20050309210926.GZ28855@suse.de> <9e473391050309171643733a12@mail.gmail.com> <20050310075049.GA30243@suse.de> <9e4733910503100658ff440e3@mail.gmail.com> <20050310153151.GY2578@suse.de> <9e473391050310074556aad6b0@mail.gmail.com> <20050310154830.GB2578@suse.de> <9e47339105031007595b1e0cc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105031007595b1e0cc3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10 2005, Jon Smirl wrote:
> Here's what it is doing... looks like the first mount is failing
> 
> echo Creating root device
> mkrootdev /dev/root
> umount /sys
> echo Mounting root filesystem
> mount -o defaults --ro -t ext3 /dev/root /sysroot
> mount -t tmpfs --bind /dev /sysroot/dev
> echo Switching to new root
> switchroot /sysroot
> umount /initrd/dev

what are the major/minor numbers of /dev/root?

-- 
Jens Axboe

