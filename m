Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbTJDCUg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 22:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbTJDCUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 22:20:36 -0400
Received: from bgp01360964bgs.sandia01.nm.comcast.net ([68.35.68.128]:4992
	"EHLO orion.dwf.com") by vger.kernel.org with ESMTP id S261719AbTJDCUf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 22:20:35 -0400
Message-Id: <200310040220.h942KVT9004376@orion.dwf.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: trying to get udev running with 2.6.0-test6
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Oct 2003 20:20:31 -0600
From: reg@dwf.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Im trying to get udev working with 2.6.0 (as a replacement for devfs).

Im following the instructions as I read them, but *nada*.
So, I must be mis-interpreting something...

OK, I made sysfs, actually I added the line

    none       /sysfs      sysfs   defaults        0 0

to /etc/fstab, and did a 'mount -a'.
There is 'stuff' below this node.

I built udev-0.2, and put udev in /sbin/udev

I put /sbin/udev into /proc/sys/kernel/hotplug (replacing /bin/true) with

    echo /sbin/udev > /proc/sys/kernel/hotplug

doing a cat /proc/sys/kernel/hotplug shows that it is there.

I have then plugged and unplugged a USB device and /udev does not appear.
So I did a 'mkdir /udev'.
Plug and unplug again.

Still nothing.

So, what am I missing???
[[ there are numerous messages in the /var/log/messages for each plug/unplug
of the USB device ]]
-- 
                                        Reg.Clemens
                                        reg@dwf.com


