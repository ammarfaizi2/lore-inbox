Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbVLXXch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbVLXXch (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 18:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVLXXch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 18:32:37 -0500
Received: from lucidpixels.com ([66.45.37.187]:56459 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1750752AbVLXXch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 18:32:37 -0500
Date: Sat, 24 Dec 2005 18:32:35 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
Subject: 2.6.15-rc6 - Success with ICH5/SATA + S.M.A.R.T.
Message-ID: <Pine.LNX.4.64.0512241830010.2700@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A very nice addition / release to the kernel, S.M.A.R.T. working through 
the ATA passthru.

smartmontools is going to have to be updated, but I can finally see the 
temperature of my SATA drives!!  Nice work Jeff!

Dec 24 18:29:20 p34 smartd[2707]: Opened configuration file 
/etc/smartd.conf
Dec 24 18:29:20 p34 smartd[2707]: Configuration file /etc/smartd.conf 
parsed.
Dec 24 18:29:20 p34 smartd[2707]: Device: /dev/sda, opened
Dec 24 18:29:20 p34 smartd[2707]: Device /dev/sda: SATA disks accessed via 
libata are not currently supported by smartmontools. By the time you read 
this, support may have been added in recent kernels. Try a '-d ata' device 
typeargument.
Dec 24 18:29:20 p34 smartd[2707]: Unable to register SCSI device /dev/sda 
at line 101 of file /etc/smartd.conf
Dec 24 18:29:20 p34 smartd[2707]: Unable to register device /dev/sda (no 
Directive -d removable). Exiting.

p34:/var/log# hddtemp /dev/sda 
/dev/sda: WDC WD740GD-00FLC0: 38C

p34:/var/log# hddtemp /dev/sdb
/dev/sdb: Maxtor 6B250S0: 40C

Justin.
