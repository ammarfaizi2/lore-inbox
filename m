Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264581AbRFUFEL>; Thu, 21 Jun 2001 01:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264844AbRFUFDv>; Thu, 21 Jun 2001 01:03:51 -0400
Received: from [32.97.182.101] ([32.97.182.101]:32710 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264581AbRFUFDp>;
	Thu, 21 Jun 2001 01:03:45 -0400
From: mdaljeet@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA256A72.001BA0E4.00@d73mta01.au.ibm.com>
Date: Thu, 21 Jun 2001 10:22:13 +0530
Subject: harddisk support
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I do not know whether I should ask this question on this mailing list, but
it definitely has to do either with the kernel confiuration or kernel
support.

In the '/dev' tree, the device file entries for SCSI harddisks ranges from
'/dev/sda' to '/dev/sdp'. If I attach 17 scsi harddisks to a system, the
17th harddisk is shown  as '/dev/sdq' in '/proc/partitions' but there is no
entry in the '/dev' tree. If I try to access '/dev/sdq' either through
fdisk or through   any other simple C programs, it gives error saying, can
not open device '/dev/sdq'.

How can I access more than 16 harddisks?

Regards,
Daljeet.


