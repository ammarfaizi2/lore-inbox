Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUGODgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUGODgD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 23:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUGODgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 23:36:03 -0400
Received: from penguin.linuxhardware.org ([63.173.68.170]:18305 "EHLO
	penguin.linuxhardware.org") by vger.kernel.org with ESMTP
	id S265773AbUGODf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 23:35:57 -0400
Date: Wed, 14 Jul 2004 23:40:54 -0400 (EDT)
From: augustus@linuxhardware.org
To: linux-kernel@vger.kernel.org
Subject: Via Velocity Concerns
Message-ID: <Pine.LNX.4.58.0407142336280.7017@penguin.linuxhardware.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am testing the via velocity gigabit ethernet drivers in the 2.6.8-rc1 
kernel.  It seems to work fine unless it is compiled into the kernel.  If 
it is compiled in then it kernel panics as soon as it tries to bring up 
the device with dhcpcd.  If you load the driver as a module though, all is 
fine.

The other concern is that the driver is under 10/100 driver and not 1000 
drivers.  It should be moved to avoid confusion.  There is also a typo in 
the help that states that the driver will be called via-rhine.o.  It 
should be via-velocity.o.

Please CC me on any replies.  I am not subscribed to this list.

Thanks,
Kris Kersey (Augustus)
LinuxHardware.org Site Manager
augustus@linuxhardware.org
Gentoo Linux AMD64 Developer
augustus@gentoo.org
