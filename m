Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266046AbUBJRDS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 12:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266030AbUBJRCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 12:02:45 -0500
Received: from mail.kroah.org ([65.200.24.183]:9696 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266037AbUBJRB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 12:01:57 -0500
Date: Tue, 10 Feb 2004 09:01:57 -0800
From: Greg KH <greg@kroah.com>
To: Mike Bell <kernel@mikebell.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040210170157.GA27421@kroah.com>
References: <20040210113417.GD4421@tinyvaio.nome.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210113417.GD4421@tinyvaio.nome.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 03:34:18AM -0800, Mike Bell wrote:
> I've been reading a lot lately about udev and how it's both very
> different to and much better than devfs, and with _most_ of the reasons
> given, I can't see how either is the case. I'd like to lay out why I
> think that is.

Did you read:
	http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev_vs_devfs

> Basically, udev relies on sysfs exporting
> device numbers. Well, imagine for a moment sysfs exported actual device
> files instead of just the numbers you'd need to make a device file (a
> pretty minor change, though not one I'm advocating).

But that is not what sysfs does.  And sysfs will not do this.  So this
point is moot.

> Sorry if any of these points has already been discussed on
> linux-kernel, I don't have time to read the list so I'm going based on
> what's been reported in things like kernel-traffic.

They pretty much all have been in the past.  Try reading the archives,
that's what they are there for :)

greg k-h
