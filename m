Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316453AbSEORxs>; Wed, 15 May 2002 13:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316454AbSEORxs>; Wed, 15 May 2002 13:53:48 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:7685 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316453AbSEORxr>; Wed, 15 May 2002 13:53:47 -0400
Date: Wed, 15 May 2002 13:50:23 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.19-pre8-ac* module compile issue
Message-ID: <Pine.LNX.3.96.1020515134741.5713A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling sc520cdp as a module gives missing symbols. Since I don't need
this right now I probably won't get to look at it before the weekend. last
seen in 2.4.19-pre8-ac4.


Kernel version: 2.4.19-pre8-ac3.1p
Starting modules_install
   installing modules
depmod: *** Unresolved symbols in /lib/modules/2.4.19-pre8-ac3.1p/kernel/drivers/mtd/maps/sc520cdp.o
depmod:         mtd_concat_create_R606fc87b
depmod:         mtd_concat_destroy_R9c645004
   copy config
   copy map and kernel
   save config
Building initrd...
Using modules:
Using loopback device /dev/loop0
/sbin/nash -> /tmp/initrd.Z7Wxgk/bin/nash
/sbin/insmod.static -> /tmp/initrd.Z7Wxgk/bin/insmod
done
   writing a LILO stanza in /tmp
done


-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

