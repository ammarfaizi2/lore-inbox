Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264683AbTA1JxF>; Tue, 28 Jan 2003 04:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264702AbTA1JxF>; Tue, 28 Jan 2003 04:53:05 -0500
Received: from fmr02.intel.com ([192.55.52.25]:50902 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S264683AbTA1JxE>; Tue, 28 Jan 2003 04:53:04 -0500
Date: Tue, 28 Jan 2003 17:59:28 +0800 (CST)
From: Stanley Wang <stanley.wang@linux.co.intel.com>
X-X-Sender: stanley@manticore.sh.intel.com
To: Greg KH <greg@kroah.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCI_Hot_Plug_Discuss <pcihpd-discuss@lists.sourceforge.net>
Subject: [RFC] Get rid of all procfs stuff for PCI subsystem.
Message-ID: <Pine.LNX.4.44.0301281747230.3171-100000@manticore.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg
When did I try to remove all procfs stuff from pci_hotplug_core.c,
I found I could only cut little codes off. So I suggest:
How about to get rid of all procfs stuff for PCI subsystem?
It could reduce about 700 lines codes from the kernel.
I think we could get all information from sysfs, right?
But it may break some user mode utilities.

What do you think about it?

Regards,
-Stan
-- 
Opinions expressed are those of the author and do not represent Intel
Corporation


