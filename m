Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266353AbRGTAsL>; Thu, 19 Jul 2001 20:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266377AbRGTAsB>; Thu, 19 Jul 2001 20:48:01 -0400
Received: from smtp1.ihug.co.nz ([203.109.252.7]:37127 "EHLO smtp1.ihug.co.nz")
	by vger.kernel.org with ESMTP id <S266353AbRGTArl>;
	Thu, 19 Jul 2001 20:47:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Matthew Gardiner <kiwiunix@ihug.co.nz>
To: linux-kernel@vger.kernel.org
Subject: MTD compiling error
Date: Fri, 20 Jul 2001 12:46:08 +1200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01072012460800.09910@kiwiunix.ihug.co.nz>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In file included from cfi_probe.c:17:
/usr/src/linux-2.4.6/include/linux/mtd/cfi.h: In function `cfi_spin_unlock':
/usr/src/linux-2.4.6/include/linux/mtd/cfi.h:387: `do_softirq' undeclared 
(first use in this function)
/usr/src/linux-2.4.6/include/linux/mtd/cfi.h:387: (Each undeclared identifier 
is reported only once
/usr/src/linux-2.4.6/include/linux/mtd/cfi.h:387: for each function it 
appears in.)
make[3]: *** [cfi_probe.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.6/drivers/mtd/chips'
make[2]: *** [_modsubdir_chips] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.6/drivers/mtd'
make[1]: *** [_modsubdir_mtd] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.6/drivers'
make: *** [_mod_drivers] Error 2
[root@kiwiunix linux]#

mtd is buggered. Found out when compiling the modules.

Matthew Gardiner
-- 
WARNING:

This email was written on an OS using the viral 'GPL' as its license.

Please check with Bill Gates before continuing to read this email/posting.
