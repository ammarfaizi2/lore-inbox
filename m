Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131448AbQLMPM0>; Wed, 13 Dec 2000 10:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131579AbQLMPMP>; Wed, 13 Dec 2000 10:12:15 -0500
Received: from mx3.sac.fedex.com ([199.81.208.11]:49670 "EHLO
	mx3.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S131448AbQLMPMH>; Wed, 13 Dec 2000 10:12:07 -0500
Date: Wed, 13 Dec 2000 22:38:28 +0800
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
Message-Id: <200012131438.eBDEcSK12203@silk.corp.fedex.com>
To: linux-kernel@silk.corp.fedex.com
Subject: ramdisk on P3 vs Celeron failure!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Boot up using:
        Loadlin-1.6a
        Win98
        ramdisk_size=18000
        initrd=ram.gz (this is the gzip'ed root filesystem)


Kernel 2.2.x (up to 2.2.18)
- on P3 and Celeron
        ram.gz must be <3862544 bytes

Kernel 2.4.x (up to 2.4.0-test12)
- on Celeron
        ram.gz must be <3862544 bytes
- on P3
        ram.gz has no such limit!!!


Failure I got was ...
        System Halted
        Less than 4MB!


Same ram.gz and bzimage tested on P3 and Celeron.


Jeff
jchua@fedex.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
