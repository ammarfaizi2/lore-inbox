Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbUCLAHJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 19:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbUCLAHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 19:07:09 -0500
Received: from mail.kroah.org ([65.200.24.183]:21177 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261852AbUCLAGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 19:06:46 -0500
Date: Thu, 11 Mar 2004 16:06:31 -0800
From: Greg KH <greg@kroah.com>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: [ANNOUNCE] 2004-03-11 release of hotplug scripts
Message-ID: <20040312000631.GA26449@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just packaged up the latest Linux hotplug scripts into a release,
which can be found at:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2004_03_11.tar.gz
or for those who like bz2 packages:
	kernel.org/pub/linux/utils/kernel/hotplug/hotplug-2004_03_11.tar.bz2

This is a snapshot of the recent development in the scripts, and should
be used by anyone who has reported a bug or sent me a patch against the
last release, to check if your fix is in or not.

If I have missed any changes, please let me know and send the patch to
me and the linux-hotplug-devel mailing list.  I'll collect them all and
make a "official" release afterwards.

Sorry for delaying so long since the last hotplug release.

A changelog of all the stuff in this release is below.

thanks,

greg k-h

------------------

Thu Mar 11 2004 kroah
        - 2004_03_11 release
        - From Dmitry Torokhov <dtor_core@ameritech.net>:
                add evbug to the blacklist of modules
        - From Kay Sievers <kay.sievers@vrfy.org>:
                We should mention the DEVPATH in the hotplug man page too,
                as someone missed it and got confused.
        - 5 patches from Marco d'Itri <md@Linux.IT>:
                - 000_small_fixes: fixed some small bugs.
                - 001_no_bashisms: removed bashisms from all scripts.
                - 003_no_useless_includes: removed some unused code.
                - 004_2.6_pci_synthesis: added sysfs support to pci.rc,
                  enabling boot time events synthesis on lacking the
                  pcimodules program.
                - 004_2.6_usb_sysfs: improved sysfs support in the USB
                  scripts. Please review the changes marked with the FIXME
                  comment: this works on my system and others, but I'm not
                  sure that it's the proper way.

Fri Feb 13 2004 dbrownell
        - scsi.agent waits for /sys$DEVPATH/type to appear before
          modprobing higher level drivers.  Patch from Patrick
          Mansfield <patmans@us.ibm.com>


