Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWIGNeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWIGNeA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 09:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWIGNeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 09:34:00 -0400
Received: from ipx20189.ipxserver.de ([80.190.249.56]:1245 "EHLO
	ipx20189.ipxserver.de") by vger.kernel.org with ESMTP
	id S932101AbWIGNeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 09:34:00 -0400
Date: Thu, 7 Sep 2006 15:33:57 +0200
From: Christian Leber <christian@leber.de>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.6.18-rc6: hda is allready "IN USE" when booting (non-deterministic)
Message-ID: <20060907133357.GA30888@core>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Accept-Language: de en
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i keep hitting this since 2.6.18-rc3, the imo relevant messages are:

ide0: I/O resource 0x3F6-0x3F6
hda: ERROR, PORTS ALREADY IN USE
ide0 ad 0x1f0-0x1f7,0x3f6 on irq 14
hdb: HL-DT-STDVD-ROM GDR8081N, ATAPI CD/DVD-ROM drive
ide1: I/O resource 0x376-0x376 not free
ide0: ports already in use, skipping probe
register_blkdev: cannot get major 3 for ide0

the probablity for this is about 70%, so with some patience i can use
the box, but that also means it's very odd.
Between the tries i allways switch it completly off.

It's a Dell Latitude C810 laptop with a Pentium 3m 1133 Mhz with Intel 82815
chipset that has a ICH2M south-bridge.

Unfortunally it's not a hardware defect, with <= 2.6.17 it allways
works with imo the same config.
for reference i dumped it here:
http://debian.christian-leber.de/config-craptop-2.6.18-rc6


Christian Leber

-- 
  "Omnis enim res, quae dando non deficit, dum habetur et non datur,
   nondum habetur, quomodo habenda est."       (Aurelius Augustinus)

