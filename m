Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266564AbUFWPMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266564AbUFWPMz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 11:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266562AbUFWPMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 11:12:55 -0400
Received: from grouse.mail.pas.earthlink.net ([207.217.120.116]:26803 "EHLO
	grouse.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S266558AbUFWPMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 11:12:51 -0400
Message-ID: <8782538.1088003570736.JavaMail.root@dewey.psp.pas.earthlink.net>
Date: Wed, 23 Jun 2004 11:12:50 -0400 (GMT-04:00)
From: David Knierim <david_knierim@earthlink.net>
Reply-To: David Knierim <david_knierim@earthlink.net>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.7 Vitesse 7174 issues
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: Earthlink Zoo Mail 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have been trying to use the use the libata Vitesse 7174 driver in the 2.6.7 kernel.  We have seen two different issues.

The first issue:
In all cases, the attached SATA drives are not recognized the first time the driver is loaded.   After removing the driver using rmmod, loading the driver for the second time will consistently recognize all SATA hard drives attached.

The second issue:
A Silicon Image 3611 SATA-to-IDE bridge card (vendor evaluation design) does not work when attached to the Vitesse 71714.  

When an IDE drive is attached to this card, the following errors are printed the second time the kernel driver is loaded (X was 9 or 17): 
ataX slow to respond, please be patient
ataX failed to respond

When an ATAPI  cdrom is attached on this card, modprobe gave no response 5 times (out of 5 tries). The system simply returned another command line.

The Silicon Image 3611 bridge has been tested using Windows XP.  It was attached to a Silicon Image controller for that test.

Our hardware:
- custom server based on Intel E7501 server chipsed and single Xeon 2.4Ghz processor
- onboard Vitesse 7174 controller
- pci reference card from Vitesse with 7174 controller.

The software:
- Fedora core 2 updated with 2.6.7 kernel.

Any clues as to how to get resolution on these issues would be most appreciated.  We have dedicated equipment and manpower to test anything that may help get the Vitesse 7174 driver stable.

Please CC: me on any responses, since I am not subscribed to this mailing list.

Many thanks,
   David Knierim

