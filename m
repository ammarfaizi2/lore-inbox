Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266565AbUHOJiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266565AbUHOJiI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 05:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266567AbUHOJiI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 05:38:08 -0400
Received: from devel.lbsd.net ([196.25.111.100]:1472 "EHLO mail.lbsd.net")
	by vger.kernel.org with ESMTP id S266565AbUHOJiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 05:38:04 -0400
Date: Sun, 15 Aug 2004 11:37:59 +0200
From: Nigel Kukard <nkukard@lbsd.net>
To: linux-kernel@vger.kernel.org
Subject: external drive size differences
Message-ID: <20040815093759.GK31901@lbsd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-PHP-Key: http://www.lbsd.net/~nkukard/keys/gpg_public.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something very very interesting... below is an external drive enclosure
supporting both USB2 and Firwire, fitted with a 200Gb IDE Hdd.

When plugged into the firewire bus, i get 137Gb size, when plugged into
the usb bus, i get 200Gb size.

Could this be a bug in the kernel? or external hardware?

<snip>
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
  Vendor: WDC WD20  Model: 00JB-00FUA0       Rev:
  Type:   Direct-Access                      ANSI SCSI revision: 06
SCSI device sdb: 268435455 512-byte hdwr sectors (137439 MB)
sdb: asking for cache data failed
sdb: assuming drive cache: write through
 sdb: sdb1
</snip>

<snip>
scsi7 : SCSI emulation for USB Mass Storage devices
  Vendor: USB 2.0   Model: Storage Device    Rev: 0100
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
sdb: assuming drive cache: write through
 sdb: sdb1
</snip>


Regards
Nigel Kukard


