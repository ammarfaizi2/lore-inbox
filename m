Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262652AbVEGDk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbVEGDk0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 23:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbVEGDk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 23:40:26 -0400
Received: from zorg.st.net.au ([203.16.233.9]:22755 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S262644AbVEGDkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 23:40:18 -0400
Message-ID: <427C37D6.3080507@torque.net>
Date: Sat, 07 May 2005 13:36:54 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] sdparm 0.91
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sdparm is a command line utility designed to get and set
SCSI disk parameters (cf hdparm for ATA disks). More generally
it gets and sets mode page information on SCSI devices or devices
that use a SCSI command set (e.g. CD/DVD drives (any transport)
and SCSI tape drives). It also can list device identification
descriptors from VPD pages.

For more information and downloads (tarball, rpms and deb
packages) see:
http://www.torque.net/sg/sdparm.html

This utility overlaps in functionality somewhat with
blktool by Jeff Garzik.

sdparm 0.90 was the original version released.
ChangeLog for sdparm-0.91 [20050506]
   - if lk 2.4 detected, map primary SCSI node to sg node for
     ease of use
   - add support for '--inquiry' (VPD pages, defaults to
     device identification)
   - decode format and rigid disk mode pages (sbc2)
     [both pages are obsolete but common]


Doug Gilbert
