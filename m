Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267493AbUBSTUD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 14:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267495AbUBSTSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 14:18:47 -0500
Received: from mail.kroah.org ([65.200.24.183]:52367 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267493AbUBSTSD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 14:18:03 -0500
Date: Thu, 19 Feb 2004 11:13:15 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 018 release
Message-ID: <20040219191315.GB10527@kroah.com>
References: <20040219185932.GA10527@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040219185932.GA10527@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 10:59:32AM -0800, Greg KH wrote:
> I've released the 018 version of udev.  It can be found at:
>  	kernel.org/pub/linux/utils/kernel/hotplug/udev-018.tar.gz

As of this release, I've been running with udev managing my /dev for me
exclusively on my main email and development machine.  This is a major
milestone for udev and it proves that it is a viable solution.

I'd like to say thanks to everyone who has made this possible to do:
	- Pat Mochel for creating sysfs and listening to my crazy ideas
	  about how we could create a userspace devfs all those years
	  ago.
	- Dan Stekloff for prodding me to actually implement this crazy
	  idea and who came up with a solid initial design document,
	  without which this project would have never left the dream
	  stage.
	- Kay Sievers for almost single-handedly taking over the whole
	  udev TODO list and converting udev from a small "proof of
	  concept" toy into a powerful and useful tool.
	- Pat Mansfield for creating the scsi_id tool and enabling udev
	  to call external programs, which instantly made udev a real
	  tool in the fine Unix tradition.
	- All of the Gentoo developers who integrated udev into their
	  distro and showed me that it can actually run a machine.
	- everyone who has sent in udev patches, bug reports, and
	  feature requests.  Without these udev would only work for me,
	  and not the rest of the world.  A community is very important.
	- the distros for picking up udev without me having to beg :)
	- everyone else who I know I've forgotten...

udev development isn't done, but for anyone who has not checked it out
yet, I suggest you do so.  I'll post a small HOWTO that shows how to
configure udev to manage your /dev without any problems or legacy issues
(the 2.4 kernel will still work just fine on the same box.)

If anyone has any suggestions for things that are lacking in udev,
please let me and the linux-hotplug-devel mailing list.  This especially
goes for any distro developers who are trying to integrate it into their
systems.

thanks again,

greg k-h
