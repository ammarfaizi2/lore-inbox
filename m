Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbTKBWDF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 17:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbTKBWDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 17:03:05 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:56744 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S261842AbTKBWDD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 17:03:03 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: vfat file system over usb fails for 2.6.0.test9
Date: Sun, 2 Nov 2003 17:03:01 -0500
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311021703.01269.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.10.219] at Sun, 2 Nov 2003 16:03:01 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two bug reports:

I just hooked up my camera, an Olympus that looks like a vfat 
filesystem over usb, and had to reboot from 2.6.0.test9 back to 
2.4.23-pre8 before I could get it to mount.  mount kept claiming that 
/dev/sda1 was not a block device until the reboot to the older 
kernel..

During the reboot, shutdown was hung for a few seconds per partition 
mounted claiming a bunch of illegal seeks and such.  This has been 
occuring with module-init-tools-0.9.15pre installed, but did not 
occur when I was running the 0.9.13pre version.  I'm gonna put 
0.9.13pre back in unless there is a good reason not to, so hit me 
with it, please.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

