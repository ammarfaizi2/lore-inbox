Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129250AbRB1UT3>; Wed, 28 Feb 2001 15:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129259AbRB1UTU>; Wed, 28 Feb 2001 15:19:20 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:46864 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S129250AbRB1UTN>;
	Wed, 28 Feb 2001 15:19:13 -0500
Date: Wed, 28 Feb 2001 12:18:31 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net,
        Linux-usb-users@lists.sourceforge.net
Subject: 2001-02-28 release of hotplug scripts
Message-ID: <20010228121831.B29281@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.18-immunix (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just packaged up the latest hotplug scripts into a release, and
they can be found at:
	http://download.sourceforge.net/linux-hotplug/hotplug-2001_02_28.tar.gz
	http://download.sourceforge.net/linux-hotplug/hotplug-2001_02_28-1.noarch.rpm
	http://download.sourceforge.net/linux-hotplug/hotplug-2001_02_28-1.src.rpm
depending on which format you prefer.

The package fixes some problems that kept the last release from working
properly on RedHat 6.x based machines.  There is also a bit of RedHat
init script assumptions in the package, due to the support of patches
from RedHat engineers :)
If people have problems with other distro bases, please let us know on
the linux-hotplug-devel mailing list.

Changes in this version from the last release are:
        - added keyspan to the list of modules to be unloaded
        - more network interface special cases: lo, plip
        - cleanup, enable '#' comment lines (Gioele Barabuci)
        - add 'usbcore' and comments to usb.handmap for hub device class
        - cope with bash1 vs bash2 issue ("unset IFS")
        - add /etc/hotplug/blacklist
        - update README
	- added patch from Trond Glomsrød to make the scripts able to
	  handle i18n properly.  Might not work so well on older
	  initscript packages, especially non-redhat based systems.
	  Tweaked the patch to handle different locations of the
	  'functions' script.
	- added patch from Trond Glomsrød to keep the ppp, ippp, and
	  isdn network interfaces from being called in the network
	  script.
	- added patch from Adam Richter that removes dependency on /tmp
	  being writable.


greg k-h

-- 
greg@(kroah|wirex).com
