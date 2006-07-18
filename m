Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbWGRSSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbWGRSSG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 14:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWGRSSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 14:18:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:3994 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932341AbWGRSSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 14:18:04 -0400
Date: Tue, 18 Jul 2006 10:59:59 -0700
From: Greg KH <greg@kroah.com>
To: Gustavo Guillermo P?rez <gustavo@compunauta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] devfs is obsolete, but dbus/hald/ivman does not spend more resources at boot time?
Message-ID: <20060718175959.GA9311@kroah.com>
References: <200607181211.32092.gustavo@compunauta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607181211.32092.gustavo@compunauta.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2006 at 12:11:31PM -0500, Gustavo Guillermo P?rez wrote:
> I was used to mount devfs in a separate folder, to search for a ZISO file on 
> hard drives or DVD/CD units in my boot ram rescue disks, and Gentoo live DVD, 
> in last kernel versions devfs still there but not anymore in config, we still 
> able to use it, touching some files.
> 
> Just to know ?How many releases will still there?

devfs has been fully removed from the kernel for 2.6.18, but had been
disabled and really not working at all since 2.6.13, which has been for
a year now.

> How do you a search for drives with hald/dbus at boot time on a ramdisk it is 
> not more complex?!?!?!.

What exactly are you trying to do?  Look at /sys/block/ for all block
devices in the system.  If you want to do it in a more portable and
cross-OS way, use HAL, and ask those developers on how to do it.

thanks,

greg k-h
