Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266009AbUIDUAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUIDUAL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 16:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUIDUAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 16:00:11 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:16251 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266013AbUIDUAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 16:00:07 -0400
Message-ID: <9e4733910409041300139dabe0@mail.gmail.com>
Date: Sat, 4 Sep 2004 16:00:04 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: multi-domain PCI and sysfs
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do multiple PCI domains appear in sysfs? I don't own a machine
with these so I can't just look.

Do they appear like:
/sys/devices/pci0000:00
/sys/devices/pci0001:00
/sys/devices/pci0002:00

I'm trying to figure out where to attach a sysfs attribute for turning
vga off in a domain. I'd like to do something like:
/sys/devices/pci0000:00/vga
/sys/devices/pci0001:00/vga
/sys/devices/pci0002:00/vga

I need to know what the domains look like in sysfs in order to pick
the right place for the attribute.

-- 
Jon Smirl
jonsmirl@gmail.com
