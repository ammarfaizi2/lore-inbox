Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbTIXCDr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 22:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbTIXCDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 22:03:46 -0400
Received: from web14905.mail.yahoo.com ([216.136.225.57]:29959 "HELO
	web14905.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261271AbTIXCDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 22:03:46 -0400
Message-ID: <20030924020344.55460.qmail@web14905.mail.yahoo.com>
Date: Tue, 23 Sep 2003 19:03:44 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: sysfs - which driver for a device?
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In sysfs it is easy to see which devices a driver is supporting.
For example /sys/bus/pci/drivers/e1000 links to 0000:02:0c.0 in my system.

But how do you go the other way; starting from 0000:02:0c.0 to determine the
driver? Is the best solution to loop though the drivers directories searching
for the device? Or would it be better to change sysfs to add an attribute to
each device containing the driver name?

In /proc/bus/pci/devices the driver name is the last field.


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
