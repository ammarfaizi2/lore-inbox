Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbUCKNAW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 08:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbUCKNAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 08:00:22 -0500
Received: from athmta03.forthnet.gr ([193.92.150.22]:28266 "EHLO forthnet.gr")
	by vger.kernel.org with ESMTP id S261230AbUCKNAQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 08:00:16 -0500
Subject: Kernel panics on VIA motherboard with USB devices
From: Emm Vasilakis <evas@agn.forthnet.gr>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1079010015.30872.12.camel@sylvester.rd.forthnet.gr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 11 Mar 2004 15:00:15 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm trying to get my new machine to work with Linux, but I'm having some
problems.

Machine specs:
ASUS A7V600-X motherboard (KT600 & VIA 8237)
Athlon XP 2400+
512MB RAM
WD 80G HD on primary IDE
TV-Tuner (bt848)
Initio UW-SCSI card
Nvidia Ti 4200 gfx card

I'm running gentoo linux, 2.4.25-pre kernel and the latest hotplug.

The mobo has a total of 4 USB ports 2.0 at the back. The problem lies at
the usb devices, and hotplug. 

I have a usb bluetooth dongle connected, and a usb to serial adaptor.
This setup gets me to KDE ok, and everything works, including some usb
storage devices that I may plug during up-time.

But, if I try to restart hotplug, I get kernel oops. From there on,
pretty much everything will seg fault when I try to load it, I can not
login to a console, and when the machine tries to reboot, it hangs.
strace shows that apps hang when trying to access /dev/tty.

Similar problems exist even with kernel 2.6.4. I have tried the same usb
devices in 2 more similar PC's (with the same mobo), and all produce the
same error. When more usb devices are connected at boot, things can lead
to a total lockup during boot.

Anyone has any ideas what I can do about this? Are there any known
problems with VIA chips and linux? I have the results from ksymoops on
those oop'ses at home, if anyone is interested, I can send them.

Thanks,
Emmanuel


