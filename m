Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbUBXBwj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 20:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbUBXBwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 20:52:38 -0500
Received: from mail.kroah.org ([65.200.24.183]:131 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262136AbUBXBwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 20:52:37 -0500
Date: Mon, 23 Feb 2004 17:49:37 -0800
From: Greg KH <greg@kroah.com>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 018 release
Message-ID: <20040224014935.GA25334@kroah.com>
References: <20040219185932.GA10527@kroah.com> <4037934E.2000306@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4037934E.2000306@gmx.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 21, 2004 at 06:20:14PM +0100, Prakash K. Cheemplavam wrote:
> Hi Greg,
> 
> could it be that udev 018 deosn't compile against 2.6.3 kernel headers? 
> I am not sure if this is the case or if the gentoo ebuild or archive has 
> some trouble:
> In Datei, eingefügt von 
> /var/tmp/portage/udev-018/work/udev-018/libsysfs/sysfs_bus.c:23:
> /var/tmp/portage/udev-018/work/udev-018/libsysfs/sysfs/libsysfs.h:27:19: 
> dlist.h: Datei oder Verzeichnis nicht gefunden
> /
> 
> And then a hunk of errors. (Above states that libsysfs.h cannot find 
> dlist.h.)

It's a build error.  I've fixed this in the udev tree, and a patch to
fix this can be found at:
	http://bugs.gentoo.org/attachment.cgi?id=26204&action=view

thanks,

greg k-h
