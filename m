Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264453AbTLVUm1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 15:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264455AbTLVUm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 15:42:27 -0500
Received: from mail.kroah.org ([65.200.24.183]:56295 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264453AbTLVUmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 15:42:21 -0500
Date: Mon, 22 Dec 2003 12:40:24 -0800
From: Greg KH <greg@kroah.com>
To: Scott James Remnant <scott@netsplit.com>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: udev LABEL not working: sysfs_path_is_file: stat() failed
Message-ID: <20031222204024.GF3195@kroah.com>
References: <1072054829.1225.11.camel@descent.netsplit.com> <20031222092329.GA30235@kroah.com> <1072090725.1225.19.camel@descent.netsplit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1072090725.1225.19.camel@descent.netsplit.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 10:58:45AM +0000, Scott James Remnant wrote:
> One question though, it only ever seems to create a device for the
> actual usb-storage disk and not the partition.  Is there some magic to
> create the partition device instead?

Do you have a partition show up in /sys/block?  If not, then udev will
not create it.  It works here for my usb-storage devices that have
partitions on them.

thanks,

greg k-h
