Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbVD1XbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbVD1XbM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 19:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbVD1XbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 19:31:12 -0400
Received: from fire.osdl.org ([65.172.181.4]:30928 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262335AbVD1XbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 19:31:02 -0400
Date: Thu, 28 Apr 2005 16:31:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       sensors@stimpy.netroedge.com
Subject: Re: kernel maintainer's HOWTO for quilt and -mm
Message-Id: <20050428163121.1343aa6c.akpm@osdl.org>
In-Reply-To: <20050428223622.GC22785@kroah.com>
References: <20050428223414.GA22785@kroah.com>
	<20050428223622.GC22785@kroah.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Thu, Apr 28, 2005 at 03:34:14PM -0700, Greg KH wrote:
> > Examples of the output of this script can be seen at:
> > 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/
> 
> Andrew, I'm now putting my broken out patches in this directory so you
> can apply them to the -mm tree.  You can take them in the 4 big chunks
> (they all apply one after each other), or you can take the individual
> patches if you want too (they also apply, one after each other.)  It's
> up to you what is easier for you to handle.
> 
> Does this work out for you?

Yes, it does.  I'm now sucking

	gregkh-01-driver
	gregkh-02-i2c
	gregkh-03-pci
	gregkh-04-USB
	cpufreq
	agp
	alsa

as individual patches and

	linus.patch
	git-ia64.patch
	git-net.patch
	git-scsi-misc.patch
	git-scsi-rc-fixes.patch

from git repos.

It's a bit of a hassle that your patches aren't based on latest -linus.

