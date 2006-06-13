Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWFMP6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWFMP6y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 11:58:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWFMP6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 11:58:54 -0400
Received: from mail.gmx.net ([213.165.64.21]:35043 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932162AbWFMP6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 11:58:54 -0400
X-Authenticated: #5598835
From: Christian =?iso-8859-1?q?H=E4rtwig?= <christian.haertwig@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: How does RAID work with IT8212 RAID PCI card?
Date: Tue, 13 Jun 2006 17:58:45 +0200
User-Agent: KMail/1.9.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606131758.45704.christian.haertwig@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

i need some advise regarding the usage of the above kernel module. Today i 
have plugged a PCI RAID card into my computer, IT8212 chip on it, and two 
identical hard drives on the primary and secondary master of that controller. 
In the controller BIOS i defined a mirror set out of those both disks and 
booted linux afterwards.

Loading the kernel module dmesg showed that the controller was found and that 
2 harddiscs are attached to it.

The thing that i wonder about is, that i still can "see" both harddisks 
independently, but i would expect to see only one harddisk at all, that 
represents the RAID set. Udev also registers /dev/hde and /dev/hdg, but (as 
far as i can see) no further device.

Is there anything wrong about my setup? Is this i driver issue? Or is this the 
normal and expected behaviour and its me who doesn't "use" the module 
properly? How to i access the RAID set instead of the two seperate disks?

Thanks in advance. Yours sincerely,
Christian Haertwig
