Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbVI2EQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbVI2EQZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 00:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVI2EQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 00:16:24 -0400
Received: from zorg.st.net.au ([203.16.233.9]:39563 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S1751169AbVI2EQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 00:16:24 -0400
Message-ID: <433B6AC3.2070903@torque.net>
Date: Thu, 29 Sep 2005 14:17:07 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [Announce] sg3_utils-1.17 available
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sg3_utils is a package of command line utilities for sending
SCSI (and some ATA) commands to devices. This package targets
the lk 2.6 and lk 2.4 series. In the lk 2.6 series these
utilities (except sgp_dd) can be used with any devices that
support the SG_IO ioctl.

This version improves support for ATA(PI) devices in the sg_inq
utility. For example, assuming /dev/hdc is an ATAPI DVD drive,
"sg_inq /dev/hdc" shows the response to a SCSI INQUIRY command,
while "sg_inq -A /dev/hdc" shows the response to an ATA IDENTIFY
PACKET DEVICE command. See CHANGELOG for more information.

A tarball, rpm and deb can be found on (see table 2):
http://www.torque.net/sg
For an overview of sg3_utils see this page:
http://www.torque.net/sg/u_index.html
The sg_dd utility has its own page at:
http://www.torque.net/sg/sg_dd.html
A changelog can be found at:
http://www.torque.net/sg/p/sg3_utils.CHANGELOG

A release announcement has been sent to freshmeat.net .

Doug Gilbert
