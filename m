Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135741AbRDXUkx>; Tue, 24 Apr 2001 16:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135742AbRDXUkn>; Tue, 24 Apr 2001 16:40:43 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:45577 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S135741AbRDXUkb>;
	Tue, 24 Apr 2001 16:40:31 -0400
Date: Tue, 24 Apr 2001 12:41:16 -0700
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net,
        Linux-usb-users@lists.sourceforge.net
Subject: 2001-04-24 release of hotplug scripts
Message-ID: <20010424124116.A13291@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just packaged up the latest Linux hotplug scripts into a release,
which can be found at:
	http://sourceforge.net/project/showfiles.php?group_id=17679
 
This release adds the Debian scripts to the tarball, although all of the
debian specific changes were not merged into the main scripts, it would
have caused too much conflict, sorry.  But the Debian patch is now much
smaller :)  It also adds a hotplug manpage donated by Debian developer
Fumitoshi UKAI.

Numerous little changes were also added to the scripts, here is the full
changelog:
        - added debian hotplug.8 manpage by Fumitoshi UKAI
        - bugfixes to modprobing
        - make sure setup scripts run even when there is no module
        - "event not supported" only seen if debugging
        - added debian directory filled with things needed to package
          the scripts for a debian release.
        - make sure setup scripts (for usermode drivers/apps) will
          run even without a kernel driver
        - bugfix match_flags support from Gioele Barabuci; might
          require bash2-isms
        - add kernel 2.2.18 bcdDevice bug workaround (Ben Woodard)
        - cleanups from Gioele Barabuci
        - tweaked the post and preun sections to fix problem of hotplug
          not starting automatically when the package is upgraded.

I've built RedHat 6.x and 7.x specific rpms due to some small
differences in where the two version place their documentation.  The
individual releases are at:

For RedHat 6.x:
	http://prdownloads.sourceforge.net/linux-hotplug/hotplug-2001_04_24-1_6.x.noarch.rpm
	http://prdownloads.sourceforge.net/linux-hotplug/hotplug-2001_04_24-1_6.x.src.rpm

For RedHat 7.x:
	http://prdownloads.sourceforge.net/linux-hotplug/hotplug-2001_04_24-1_7.x.noarch.rpm
	http://prdownloads.sourceforge.net/linux-hotplug/hotplug-2001_04_24-1_7.x.src.rpm

Source tarball:
	http://prdownloads.sourceforge.net/linux-hotplug/hotplug-2001_04_24.tar.gz
	

greg k-h
