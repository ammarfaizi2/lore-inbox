Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbTKLNnO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 08:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbTKLNnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 08:43:14 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:20899 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S262068AbTKLNnN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 08:43:13 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: wrong grub install, do I need to fdisk -mbr on that drive?
Date: Wed, 12 Nov 2003 08:43:10 -0500
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311120843.10782.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.205.63.173] at Wed, 12 Nov 2003 07:43:12 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

In the process of getting ready to swap to a new boot drive, a 
"grub-install" put everything on /dev/hdd since it was mapped to 
'(hd1)' in the /boot/grub/device.list.

I fixed the device.list on the current boot drive, hda, and reran the 
grub-install script.  But do I need to undo what it did to /dev/hdd 
before I make /dev/hdb into /dev/hda, and make /dev/hda into /dev/hdb 
by swapping jumpers on the drive and rebooting?  I've fixed the 
/etc/fstab copy put on the new drive to reflect the new partition 
numbers for this and that.

With 3 drives stacked up, they are running very hot, and I'd like to 
get /dev/hdd out of there, and space the old /dev/hda up into its 
location giveing an empty space between the drives so they'll run 
cooler as quickly as I can.  I think I'll need to edit the copy of 
grub.conf on the new drive to boot from the correct / partition too.

Have I missed anything?

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

