Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVBGDPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVBGDPM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 22:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVBGDPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 22:15:12 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:46051 "EHLO
	fe.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id S261327AbVBGDPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 22:15:08 -0500
Subject: Regression? in USB support w/r/t libusb
From: Thomas Frayne <TomF@sjpc.org>
To: fedora-list <fedora-list@redhat.com>,
       linux-kernel ml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 06 Feb 2005 19:15:56 -0800
Message-Id: <1107746156.1479.2.camel@PCasus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel developer's, if you don't think this is a kernel regression,
please ignore this note.

In FC3, with kernel 2.6.9-1.715_FC3smp, I hotplugged a formatted mini
external hard drive in a new enclosure into a USB 2.0 hub.  I expected
to find its device node, but could not find it in my maze of USB
devices.  I might have searched further, but, instead, I unplugged it,
and plugged it into another PC running FC1, with kernel 2.4.22-1.2174.
I expected to have to reboot to see it, but hotplug worked, and I found
the hard drive in the Hardware Browser, mounted its partitions, and used
NFS to copy data into the FC3 machine.

FC1 provided me an easy way to find the device node for a hotplugged USB
hard drive, but I found no such easy way in FC3.  Is this a regression,
or is there an easy way that I missed?

I am sending this note to both the Fedora mailing list and the kernel
mailing list to find out where the regression is, if any.


