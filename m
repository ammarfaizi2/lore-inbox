Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262667AbVCJPsr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbVCJPsr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 10:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbVCJPsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 10:48:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:17025 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262667AbVCJPsh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 10:48:37 -0500
Date: Thu, 10 Mar 2005 16:48:31 +0100
From: Jens Axboe <axboe@suse.de>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: current linus bk, error mounting root
Message-ID: <20050310154830.GB2578@suse.de>
References: <422F2F7C.3010605@pobox.com> <9e4733910503091023474eb377@mail.gmail.com> <422F5D0E.7020004@pobox.com> <9e473391050309125118f2e979@mail.gmail.com> <20050309210926.GZ28855@suse.de> <9e473391050309171643733a12@mail.gmail.com> <20050310075049.GA30243@suse.de> <9e4733910503100658ff440e3@mail.gmail.com> <20050310153151.GY2578@suse.de> <9e473391050310074556aad6b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e473391050310074556aad6b0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10 2005, Jon Smirl wrote:
> On Thu, 10 Mar 2005 16:31:51 +0100, Jens Axboe <axboe@suse.de> wrote:
> > On Thu, Mar 10 2005, Jon Smirl wrote:
> > > LABEL=/                 /                       ext3    defaults        1 1
> > > label / is on /dev/sda6
> > >
> > > Creating root device
> > > Mounting root filesystem
> > > mount: error 6 mounting ext3
> > 
> > if 6 is the errno, it looks like it is trying to open a device that does
> > not exist (ENXIO). Can you up the verbosity of those commands, I'd like
> > to see what it is doing exactly.
> 
> Jeff, how can I up the verbosity? This is on Fedora Core 3 but before
> user space is up. Is there some way to tell the boot ramdisk to
> display more info?

Perhaps you can mount the initrd and change the script to echo the
commands before executing them? Then boot with the modified initrd.

-- 
Jens Axboe

