Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbUK0GC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbUK0GC7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 01:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUK0Dql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:46:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:46772 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262593AbUK0D0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 22:26:07 -0500
Date: Fri, 26 Nov 2004 19:25:45 -0800
From: Greg KH <greg@kroah.com>
To: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb-storage/HAL oddity in 2.6.10-rc?
Message-ID: <20041127032545.GC10536@kroah.com>
References: <1101469110.6185.9.camel@ukabzc383.uk.saic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101469110.6185.9.camel@ukabzc383.uk.saic.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2004 at 11:38:30AM +0000, Eamonn Hamilton wrote:
> Hi,
> 
> Since I started using 2.6.10-rc kernels, my usb flashdrive only seems to
> be partially detected by HAL. It shows up fine in dmesg, the device is
> detected and the partitions recognised, however in the HAL device
> manager it shows as a SCSI host interface, without the volume being
> detected underneath it. This all works fine on 2.6.9 running the same
> kernel options.
> 
> Anybody got any ideas, before I go compiling kernels to find out where
> it changed?

This is a known HAL issue.  Please see the HAL mailing lists for more
details.

That being said, hotplug stuff did change in the kernel recently, but
it's still not completly finished changing to get this all worked out.
I think the HAL people have a workaround for the current situation.

thanks,

greg k-h
