Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272337AbTGYVfM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 17:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272338AbTGYVfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 17:35:12 -0400
Received: from mail.kroah.org ([65.200.24.183]:27355 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272337AbTGYVfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 17:35:04 -0400
Date: Fri, 25 Jul 2003 17:47:45 -0400
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] udev 0.2 release
Message-ID: <20030725214745.GA4223@kroah.com>
Reply-To: linux-hotplug-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've released the 0.2 version of udev into the wild, after surviving a
live demo at the 2003 Ottawa Linux Symposium during a presentation.  It
can be found at:
	kernel.org/pub/linux/utils/kernel/hotplug/udev-0.2.tar.gz

udev is a implementation of devfs in userspace using sysfs and
/sbin/hotplug.  It requires a 2.5/2.6 kernel to run properly.  The major
changes since the last release is that persistent device naming schemes
are now implemented.  Yeah, it's pretty rough, but it does prove that
the concept is sane and will end up working well for users.

There's a BitKeeper tree of the latest stuff available at:
	bk://kernel.bkbits.net/gregkh/udev/

I've also placed the slides from my OLS talk up at:
	http://www.kroah.com/linux/talks/ols_2003_udev_talk/

The paper which attempts to explain the background of udev, what it
does, and where it is going is at:
	http://archive.linuxsymposium.org/ols2003/Proceedings/All-Reprints/Reprint-Kroah-Hartman-OLS2003.pdf


Due to the rush of the development of udev in this past week (hacking at
it during the conference in an attempt to have something to show) there
are still a number of very rough corners present, a few known memory
leaks, and at least one hard coded path to my home directory for a
config file...  Please feel free to take it for a spin to see how well
things are progressing.

Patches are always welcome, and discussions of the implementation, and
future directions that the project should entail are welcome for now on
the linux-hotplug-devel mailing list (if it's over-run, a new list will
be started up, but I don't think that's necessary for now.)

thanks,

greg k-h
