Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289054AbSAIWUv>; Wed, 9 Jan 2002 17:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289055AbSAIWUi>; Wed, 9 Jan 2002 17:20:38 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:58128 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S289054AbSAIWTm>;
	Wed, 9 Jan 2002 17:19:42 -0500
Date: Wed, 9 Jan 2002 14:17:21 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] dietHotplug 0.4 release
Message-ID: <20020109221721.GA22938@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just released a new version of the dietHotplug package.  It can be
found at:
	http://prdownloads.sourceforge.net/linux-hotplug/diethotplug-0.4.tar.gz
or:
 	kernel.org/pub/linux/utils/kernel/hotplug/diethotplug-0.4.tar.gz
 	kernel.org/pub/linux/utils/kernel/hotplug/diethotplug-0.4.tar.bz2

No functional changes since the last release, but the resulting binary
is about 1.2K smaller now thanks to Erik Anderson.

The project is now being hosted at:
	http://linuxusb.bitkeeper.com:8088/dietHotplug
instead of the previous cvs tree at sf.net in the linux-hotplug
directory.

Changes since the last release:
	- patch for the Makefile and dietlibc stuff from Erik Andersen
	  (now can cross compile much easier, can build with uClibc,
	  and some size savings.)
	- renamed the dietlibc subdirectory to klibc
	- synced with my previous klibc changes
	- cleaned up remaining compiler warnings.
	- further Makefile tweaks.
	- more klibc tweaks, now binary is even smaller.
thanks,

greg k-h
