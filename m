Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269464AbUICL2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269464AbUICL2e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 07:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269621AbUICL2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 07:28:34 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:30671 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S269464AbUICL2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 07:28:32 -0400
Date: Fri, 3 Sep 2004 13:28:33 +0200
From: Roeland Moors <roelandmoors@telenet.be>
To: linux-kernel@vger.kernel.org
Subject: udev removable media
Message-ID: <20040903112833.GA3584@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an USB zip drive in combination with udev.

When I connect the drive with a disk inserted, everything works
fine. Here is the udev rule:
BUS="usb", SYSFS{product}="USB Zip 750", KERNEL="sd?1",
NAME="%k", SYMLINK="zip"

When connecting the drive without a disk the symlink is not
created. This is ok, beceause there is no disk.

But if I now insert a disk, there is still no symlink?

I've search a bit on google and if I understand correctly the
main problem is the SCSI protocol.

Is there a solution to this problem?

I hope this is the right list to ask this.

-- 
Roeland
