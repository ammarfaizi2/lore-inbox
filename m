Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbTEFPKZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 11:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263790AbTEFPKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 11:10:25 -0400
Received: from mail.pharm.uu.nl ([131.211.16.17]:17630 "HELO mail.pharm.uu.nl")
	by vger.kernel.org with SMTP id S263788AbTEFPKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 11:10:24 -0400
Subject: [patch/2.5.69] zoran driver update
From: Ronald Bultje <R.S.Bultje@pharm.uu.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, mjpeg-developer@lists.sourceforge.net,
       Gerd Knorr <kraxel@bytesex.org>, Frank Davis <fdavis@si.rr.com>,
       Greg KH <greg@kroah.com>
Content-Type: text/plain
Organization: Universiteit Utrecht
Message-Id: <1052234524.2482.70.camel@shrek.bitfreak.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2 (1.3.2-1) (Preview Release)
Date: 06 May 2003 17:22:05 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus/all,

http://mjpeg.sourceforge.net/driver-zoran/linux-zoran-driver.patch.gz
contains a patch that updates the current zoran driver (v4l/v4l2 driver
for zr36057/zr36067-based MJPEG cards) in kernel 2.5.x to the newest
stable version that we have. Patch is against 2.5.69.

Differences between old and new driver:
* this one actually compiles
* this one uses the new i2c stack
* this one supports video4linux2
* this one supports new cards (LML33R10 and Miro DC30/DC30+ - we already
supported the LML33, Miro DC10/DC10+ and Iomega Buz)

It also adds some additional PCI IDs and I2C IDs that are used by the
driver, updates documentation and adds this driver + me to the
maintainer list.

The i2c changes have been reviewed by Greg KH and Frank Davis (april
7th/8th, 2003 - the 2.5.67 patch), the v4l part is in review by Gerd
Knorr.

Could this please be applied?

Thanks,

Ronald

