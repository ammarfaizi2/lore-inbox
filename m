Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbVIMDyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbVIMDyR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 23:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbVIMDyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 23:54:17 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:42702
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1750781AbVIMDyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 23:54:16 -0400
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
Reply-To: abonilla@linuxwireless.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
Content-Type: text/plain
Date: Mon, 12 Sep 2005 21:54:29 -0600
Message-Id: <1126583669.5708.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-12 at 20:34 -0700, Linus Torvalds wrote:

> 
> drm, watchdog, hwmon, i2c, infiniband, input layer, md, dvb, v4l, network,
> pci, pcmcia, scsi, usb and sound driver updates. People may appreciate
> that the most common wireless network drivers got merged - centrino
> support is now in the standard kernel.

Kudos for merging IPW in.

> 
> 	git-rev-list --no-merges --pretty=short v2.6.14-rc1 ^v2.6.13 |
> 		git-shortlog | less -S

I have these 2 "commands" I Run to get the latest git.
debian:~# cat getkernel
#! /bin/bash
git clone
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
linux-2.6
cd linux-2.6
rsync -a --verbose --stats --progress \
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ \
.git/

getkernel was the first I used to get the whole thing and only used it
once.

debian:~# cat getkernelupdate
#! /bin/bash
cd linux-2.6
git pull
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
git checkout


I use getkernelupdate to "download the updated git with the new patches
sent.

If I do make menuconfig, it still says 2.6.13 instead of 2.6.14-rc1.

Do I have something missing?

I do git commit and git checkout after those scripts above.

Any answers are appreciated!!

.Alejandro

> 
> which is actually pretty informative.
> 
> 			Linus


