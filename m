Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263143AbSKZXXD>; Tue, 26 Nov 2002 18:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263105AbSKZXXD>; Tue, 26 Nov 2002 18:23:03 -0500
Received: from marvin.cdf.toronto.edu ([128.100.31.3]:24490 "HELO
	marvin.cdf.toronto.edu") by vger.kernel.org with SMTP
	id <S263143AbSKZXXC>; Tue, 26 Nov 2002 18:23:02 -0500
Date: Tue, 26 Nov 2002 18:29:32 -0500 (EST)
From: Andrew Park <apark@cdf.toronto.edu>
To: <linux-kernel@vger.kernel.org>
Subject: modules.conf entry help
Message-ID: <Pine.LNX.4.30.0211261821200.26638-100000@werewolf.cdf>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I feel silly asking this, but ...

I have hooked up my linux box to FC RAID using qlogic card.  The module
I need to load is qlogicfc.o and then devices will map to /dev/sde[1234]
and /dev/sdf[1234].  Now the problem is that I just cannot get the module
to load during the boot time.  So when it tries to mount some of these
devices to a mount point, it fails.  I have been altering the entry
in /etc/modules.conf to various different things (such as scsi_hostadapter1
qlogicfc, scsi2 qlogicfc, block-major-8 qlogicfc, etc) to see if it'll
succeed, but to no avail.  Manually inserting the module after the boot
works.  I do not want to put it in rc.local - it just doesn't seem elegant.
Anyone know a good way of doing this?
Thanks

Andrew Park

