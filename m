Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271835AbTGRRfX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 13:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271861AbTGRRfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 13:35:23 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:61993 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S271835AbTGRRfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 13:35:17 -0400
Subject: 2.4.22-pre6-dis6 released
From: Disconnect <kernel@gotontheinter.net>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1058550582.16137.51.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 18 Jul 2003 13:49:42 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After a long wait, 2.4.22-pre6-dis6 is finally out.  It includes both
preempt and swsusp-1.0.2, the two things I was waiting for.

*New webpage* Details and downloads at www.gotontheinter.net/ 

If other people using this have custom DSDTs, send them to me and I'll
add them in as a config option to save some effort.  Ditto for any other
useful patches you'd like to see in dis7 (which should be out a lot
faster than dis6 was.  Unless I get more requests, it'll just be an
update of existing features/patches to the newest version.)

The only known issue so far is that usb-uhci and swsusp don't get along
(khubd can't be refridgerated).  Rmmod usb-uhci or (suggested) stop
hotplug before suspending.

If anyone other than myself and Mighty are using this, toss a comment
into that page to let me know what you think.. (if its just us I'll stop
bothering the list with announcements ;) ..)

New Stuff: 
- Swsusp 1.0.2 
- Preempt 
Old Stuff: 
- Low-latency 
- Supermount-NG 1.2.7 
- New DSDT (from Adrian Dewhurst) for the Inspiron 8500. Fixes lots of
vendor bugs and is basically the fix I was hoping to avoid doing. Thanks
Adrian! 
- New Radeon DRM (so you no longer need the one listed below) 
- BootSplash 3.0.7, with a new Configure.help entry and swsusp patches 
- O_DIRECT 
- Packet mode for 2.4.21 
- Newest ACPI 
- BCM4400 driver integrated (module only for now; there is a backport of
the proper driver from 2.5 in progress) 
- CPUfreq 
- Orinoco monitor mode (for airsnort/kismet) 
- Vfat-symlink - show windows .lnk files as symlinks 
- No-trackpad-while-typing (latest)

-- 
Disconnect <kernel@gotontheinter.net>

