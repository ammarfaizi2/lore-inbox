Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264939AbTF0Xhn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 19:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264942AbTF0Xhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 19:37:43 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:21703 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S264939AbTF0Xhl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 19:37:41 -0400
Date: Fri, 27 Jun 2003 16:51:50 -0700
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: CaT <cat@zip.com.au>, nick@snowman.net, Larry McVoy <lm@bitmover.com>,
       Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bkbits.net is down
Message-ID: <20030627235150.GA21243@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, CaT <cat@zip.com.au>,
	nick@snowman.net, Larry McVoy <lm@bitmover.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030627145727.GB18676@work.bitmover.com> <Pine.LNX.4.21.0306271228200.17138-100000@ns.snowman.net> <20030627163720.GF357@zip.com.au> <1056732854.3172.56.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056732854.3172.56.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone know what this means?  This is from the supposedly superduper
rackspace machine which has a Mylex SCSI RAID (see below):

DAC960#0: Physical Device 0:0 Sense Data Received
DAC960#0: Physical Device 0:0 Request Sense: Sense Key = 3, ASC = 11, ASCQ = 00
DAC960#0: Physical Device 0:0 Request Sense: Information = 0380A6CA 00000000
DAC960#0: Physical Device 0:0 Sense Data Received
DAC960#0: Physical Device 0:0 Request Sense: Sense Key = 3, ASC = 11, ASCQ = 00
DAC960#0: Physical Device 0:0 Request Sense: Information = 0380A6CA 00000000
DAC960#0: Physical Device 0:0 Errors: Parity = 0, Soft = 0, Hard = 0, Misc = 0
DAC960#0: Physical Device 0:0 Errors: Timeouts = 0, Retries = 0, Aborts = 0, Predicted = 0

Boot messages:

DAC960: ***** DAC960 RAID Driver Version 2.4.10 of 23 July 2001 *****
DAC960: Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
DAC960#0: Configuring Mylex AcceleRAID 170 PCI RAID Controller
DAC960#0:   Firmware Version: 7.01-00, Channels: 1, Memory Size: 32MB
DAC960#0:   PCI Bus: 0, Device: 10, Function: 0, I/O Address: Unassigned
DAC960#0:   PCI Address: 0xF6000000 mapped at 0xF883F000, IRQ Channel: 18
DAC960#0:   Controller Queue Depth: 512, Maximum Blocks per Command: 2048
DAC960#0:   Driver Queue Depth: 511, Scatter/Gather Limit: 128 of 257 Segments
DAC960#0:   Physical Devices:
DAC960#0:     0:0  Vendor: IBM       Model: IC35L036UCD210-0  Revision: S5BS
DAC960#0:          Wide Synchronous at 160 MB/sec
DAC960#0:          Serial Number:         KQZ3S401
DAC960#0:          Disk Status: Online, 71651328 blocks
DAC960#0:     0:1  Vendor: IBM       Model: IC35L036UCD210-0  Revision: S5BS
DAC960#0:          Wide Synchronous at 160 MB/sec
DAC960#0:          Serial Number:         KQZ3E613
DAC960#0:          Disk Status: Online, 71651328 blocks
DAC960#0:     0:2  Vendor: IBM       Model: IC35L036UCD210-0  Revision: S5BS
DAC960#0:          Wide Synchronous at 160 MB/sec
DAC960#0:          Serial Number:         KQZ39942
DAC960#0:          Disk Status: Online, 71651328 blocks
DAC960#0:     0:7  Vendor: MYLEX     Model: AcceleRAID 170    Revision: 0701
DAC960#0:          Wide Synchronous at 160 MB/sec
DAC960#0:          Serial Number:   
DAC960#0:   Logical Drives:
DAC960#0:     /dev/rd/c0d0: RAID-5, Online, 143302656 blocks
DAC960#0:                   Logical Device Uninitialized, BIOS Geometry: 255/63
DAC960#0:                   Stripe Size: 64KB, Segment Size: 8KB
DAC960#0:                   Read Cache Disabled, Write Cache Disabled
Partition check:
 rd/c0d0: rd/c0d0p1 rd/c0d0p2 rd/c0d0p3

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
