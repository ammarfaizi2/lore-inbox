Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269676AbTHFQJP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 12:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269900AbTHFQJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 12:09:15 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:55766 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S269676AbTHFQJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 12:09:14 -0400
Subject: [Patchset] 2.4.22-rc1-dis7 released
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1060186101.2016.49.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 06 Aug 2003 12:08:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've rolled out 2.4.22-rc1-dis7. Not as well tested as some of the
others (hey, gimme a break, rc1 was only out for about 2 hours when I
released this..) but its about due, and I've been running it with the
newer -pre kernels for quite a while.

As always, its available at http://www.gotontheinter.net/

This patch contains:
 - Swsusp 1.1-pre3
 - Swsuspctl
 - Laptop-mode
 - Preempt
 - Standard BCM4400 driver (backported from 2.5); the old driver has not
been removed, just disabled in the menus
 - Warmboot by default
 - Updated Inspiron 8500 DSDT
 - Updated Radeon DRM
 - Bootsplash (www.bootsplash.org)
 - Supermount
 - O_Direct
 - Packet mode for cd/dvd writing
 - Optionally disable trackpad while typing
 - Handle windows .lnk files as symlinks under vfat
 - O_Streaming
 - Monitor mode for Orinoco pcmcia/mini-pci cards
 - CPUfreq
 - Allow network devices to contribute to /dev/random

This one should cover most everything thats been requested; if there is
anything you'd love to see, let me know where to find it and I'll see
what I can do.

-- 
Disconnect <lkml@sigkill.net>

