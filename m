Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131474AbQKVVhZ>; Wed, 22 Nov 2000 16:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131473AbQKVVhP>; Wed, 22 Nov 2000 16:37:15 -0500
Received: from roc-24-93-10-55.rochester.rr.com ([24.93.10.55]:62716 "EHLO
        suzaku.fynet.org") by vger.kernel.org with ESMTP id <S131214AbQKVVhE>;
        Wed, 22 Nov 2000 16:37:04 -0500
Message-ID: <3A1C3523.A111CDD9@fsc-usa.com>
Date: Wed, 22 Nov 2000 16:05:39 -0500
From: Brian Kress <kressb@fsc-usa.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: /proc/partitions for LVM
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Question about /proc/partitions and LVM.  LVM devices in 
/proc/partitions currently show up as lvma, lvmb, etc, depending on
their device number.  This breaks things like mount by filesystem
name.  Back when LVM existed as a patch, I believe there was some
support in fs/partitions/check.c for showing the proper name for
the device (something like <vgname>/<lvname>).  
	Are their any plans for something like this to be added
or is their a reason it was taken out?


	BTW, 2.4.0-test11 is the first "perfect" kernel for me.  It
finally has everything I use working correctly.  (well, with a 
small raid5 patch, anyway).


Brian Kress
kressb@fsc-usa.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
