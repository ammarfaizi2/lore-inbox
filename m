Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262799AbVCDCbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbVCDCbW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 21:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262867AbVCDCYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 21:24:51 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:18848 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S262799AbVCDCTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 21:19:09 -0500
Date: Thu, 03 Mar 2005 21:19:04 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: 2.6.11 vs DVB cx88 stuffs
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200503032119.04675.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I've a new pcHDTV-3000 card, and I thought maybe it would
be a good idea to build the cx88 stuff in the DVB section
of a make xconfig.

It doesn't build, spitting out this bailout:

  CC [M]  drivers/media/video/cx88/cx88-cards.o
drivers/media/video/cx88/cx88-cards.c: In function `hauppauge_eeprom_dvb':
drivers/media/video/cx88/cx88-cards.c:694: error: `PLLTYPE_DTT7595' undeclared (first use in this function)
drivers/media/video/cx88/cx88-cards.c:694: error: (Each undeclared identifier is reported only once
drivers/media/video/cx88/cx88-cards.c:694: error: for each function it appears in.)
drivers/media/video/cx88/cx88-cards.c:698: error: `PLLTYPE_DTT7592' undeclared (first use in this function)
drivers/media/video/cx88/cx88-cards.c: In function `cx88_card_setup':
drivers/media/video/cx88/cx88-cards.c:856: error: `PLLTYPE_DTT7579' undeclared (first use in this function)
make[4]: *** [drivers/media/video/cx88/cx88-cards.o] Error 1
make[3]: *** [drivers/media/video/cx88] Error 2
make[2]: *** [drivers/media/video] Error 2

This is from a freshly unpacked src tree for 2.6.11, with only the
bk-ieee1394 patch applied.  That doesn't touch this.

Comments?

Another patch needed maybe?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
