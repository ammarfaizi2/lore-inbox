Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbTLZX0q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 18:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265260AbTLZXYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 18:24:46 -0500
Received: from www.gawab.com ([204.97.230.36]:19973 "HELO gawab.com")
	by vger.kernel.org with SMTP id S265256AbTLZXXv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 18:23:51 -0500
Message-ID: <20031226232652.40543.qmail@gawab.com>
From: "xander vanwiggen" <xander@alexandria.cc>
To: linux-kernel@vger.kernel.org
Subject: atapi cd reported twice in dmesg??
Date: Fri, 26 Dec 2003 23:26:52 GMT
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.211.234.50]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,
I'm migrating to 2.6 after having used 2.0,2.2,2.4 for quite
some years now.
At a first glance, I read ide-scsi is dropped. Okay, no SCSI
support at all for me then. I have one CD writer, and now it
gets reported twice, which I don't understand. I have
CONFIG_IDE,CONFIG_BLK_DEV_IDE,CONFIG_BLK_DEV_IDEDSK,CONFIG_IDEDISK_MULTIMODE,CONFIG_BLK_DEV_IDECD
set. dmesg reports: "hdc: PCRW804, ATAPI CD/DVD-ROM drive" first
(ok), then "hdc: ATAPI 32X CDROM CD-R/RW drive, 2048kB Cache,
DMA". Prior to the second report, an error is generated:
"end_request: I/O error, dev hdc, sector 0". Reading works fine,
haven't tested writing yet (nor installed X, hence the omission
of blank lines in this mail). Is this a RTFM problem...? Kindest
regards, Xander.

--------------------------------------------------------------------------------
Get your free 15 Mb POP3 email @alexandria.cc
Click here -> http://www.alexandria.cc/
