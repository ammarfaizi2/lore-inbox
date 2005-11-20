Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVKTGY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVKTGY6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 01:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbVKTGY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 01:24:58 -0500
Received: from zorg.st.net.au ([203.16.233.9]:6579 "EHLO borg.st.net.au")
	by vger.kernel.org with ESMTP id S1750707AbVKTGY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 01:24:57 -0500
Message-ID: <438016FF.2070202@torque.net>
Date: Sun, 20 Nov 2005 16:26:07 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [Announce] sg3_utils-1.18 available
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

This version adds the sg_map26 utility which maps between
a primary scsi device node (e.g. /dev/hdc) and the
corresponding scsi generic node (e.g. /dev/sg5) or vice
versa. Uses major/minor numbers and sysfs (thus only works
for the lk 2.6 series).
sg_dd now takes iflag and oflag options similar to those
found in recent GNU dd versions.
"sg_inq -rr" outputs an ATA IDENTIFY response in a form
suitable to be piped to "hdparm --Istdin" for decoding.
See CHANGELOG for more information.

A tarball, rpm and deb can be found at (see table 2):
http://www.torque.net/sg
For an overview of sg3_utils see this page:
http://www.torque.net/sg/u_index.html
The sg_dd utility has its own page at:
http://www.torque.net/sg/sg_dd.html
The SG_IO ioctl is discussed at:
http://www.torque.net/sg/sg_io.html
A changelog can be found at:
http://www.torque.net/sg/p/sg3_utils.CHANGELOG

A release announcement has been sent to freshmeat.net .

Doug Gilbert
