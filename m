Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVETLMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVETLMz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 07:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVETLMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 07:12:55 -0400
Received: from zorg.st.net.au ([203.16.233.9]:26037 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S261376AbVETLMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 07:12:49 -0400
Message-ID: <428DC633.5050403@torque.net>
Date: Fri, 20 May 2005 21:12:51 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] sdparm 0.92
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sdparm is a command line utility designed to get and set
SCSI disk parameters (cf hdparm for ATA disks). More generally
it gets and sets mode page information on SCSI devices or devices
that use a SCSI command set (e.g. CD/DVD drives (any transport)
and SCSI tape drives). It also can list VPD pages including
the device identification page.

For more information and downloads (tarball, rpm and deb
packages) see:
http://www.torque.net/sg/sdparm.html

There are now more than 150 parameters accessed by sdparm.
Thanks to Kai Makisara for interface and sanity checking
suggestions.

ChangeLog for sdparm-0.92 [20050520]
   - add data compression and device configuration mode
     pages (ssc3)
   - add timeout + protect plus write parameters mode
     pages (mmc5)
   - add XOR control mode page (sbc2)
   - add SES management mode page (ses2)
   - discriminate mode pages based on device's peripheral
     device type
   - disallow set/clear acronyms whose pdt doesn't match
     current device
   - with option "-ll" decode more of INQUIRY standard
     response
   - improve error checking when getting non-existent
     fields
   - use double fetch technique when fetching mode pages
   - add RBC device parameters mode page (rbc)
   - add '--flexible' option for mode sense 6/10 response
     mixup
   - '--inquiry -all' now outputs supported VPD pages page

Doug Gilbert
