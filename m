Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265934AbUBJPBp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 10:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265937AbUBJPBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 10:01:44 -0500
Received: from web41203.mail.yahoo.com ([66.218.93.36]:23208 "HELO
	web41203.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265934AbUBJPBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 10:01:43 -0500
Message-ID: <20040210150125.71542.qmail@web41203.mail.yahoo.com>
Date: Tue, 10 Feb 2004 07:01:25 -0800 (PST)
From: Jin Suh <jinssuh@yahoo.com>
Subject: 2.6.2 with ide cdrom drive problem
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linux-kernel folks,

I built a bootable cdrom using 2.6.2 kernel. It bootd up from a scsi cdrom
drive (11, 0) but not from ide cdrom drive which is /dev/hdc (22, 0). I use
BICK (Bootable Iso Construction Kit). Since it doesn't boot from ide cddrive, I
enabled the scsi aic7xxx and made 2 bootcds. I put one in the scsi cddrive and
the other in the ide cddrive. The kernel loads from ide cddrive and cdinit1
from BICK scans cdrom drives (hda, hdb, hdc, hdd and sr0 and sr1). The scanning
doesn't find hdc cddrive (major 22, minor 0) and finds sr0 and continue the
rest of the booting. Is 2.6.2 different from 2.4.20 in the device name (22,0)?
What is the correct device number? When I looked at the /proc/ide/hdc/model
file, it says "Samsung DVD-ROM SD-616T. It used to work fine with 2.4.20
kernel. Could you please help me to fix this?

__________________________________
Do you Yahoo!?
Yahoo! Finance: Get your refund fast by filing online.
http://taxes.yahoo.com/filing.html
