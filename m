Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288738AbSADT7n>; Fri, 4 Jan 2002 14:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284691AbSADT7Z>; Fri, 4 Jan 2002 14:59:25 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:22547 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288735AbSADT4u>;
	Fri, 4 Jan 2002 14:56:50 -0500
Date: Fri, 4 Jan 2002 11:55:27 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] dietHotplug 0.3 release
Message-ID: <20020104195527.GC17028@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just released a new version of the dietHotplug package.  It can be
found at:
	http://prdownloads.sourceforge.net/linux-hotplug/diethotplug-0.3.tar.gz
or:
	kernel.org/pub/linux/utils/kernel/hotplug/diethotplug-0.3.tar.gz
	kernel.org/pub/linux/utils/kernel/hotplug/diethotplug-0.3.tar.bz2

Changes since the last release:
	- added support for IEEE1394 hotplug devices.  This hasn't been
	  tested very well due to my lack of devices.  Testing is
	  welcome :)

	- moved the library files that hotplug needed from dietlibc into
	  the release tree.  This removes the external dependency on
	  dietlibc.  I have only tested the i386 arch build.  People
	  with different architectures are encouraged to test and send
	  me patches for where I messed up the build process for their
	  machines.

	- now tries to load _all_ modules that match the signature of
	  the inserted device.  Previously only the first found one
	  would be loaded, which is a bad thing for some drivers (mostly
	  pci drivers.)  This fixes a number of reported problems from
	  different users.

thanks,

greg k-h
