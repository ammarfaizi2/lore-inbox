Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278160AbRJLVt6>; Fri, 12 Oct 2001 17:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278162AbRJLVts>; Fri, 12 Oct 2001 17:49:48 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:24583 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S278160AbRJLVt2>;
	Fri, 12 Oct 2001 17:49:28 -0400
Date: Fri, 12 Oct 2001 14:42:00 -0700
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] dietHotplug 0.2 release
Message-ID: <20011012144159.A21518@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just released a new version of the dietHotplug package.  It can be
found at:
	http://prdownloads.sourceforge.net/linux-hotplug/diethotplug-0.2.tar.gz

Changes since the last release:
	- added support for PCI hotplug.  This has been tested with my
	  latest Hotplug PCI patch:
	  	http://marc.theaimsgroup.com/?l=linux-kernel&m=100291212826608

	- greatly shrunk the executable size.  The sum of the
	  modules.usbmap and modules.pcimap for my kernel is 65k.
	  dietHotplug is only 13k, and that is self contained (no
	  libraries needed, dietLibc is used.)  This version is also
	  even smaller than the last one, which had no support for PCI
	  hotplug.

thanks,

greg k-h
