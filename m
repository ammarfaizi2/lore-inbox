Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130329AbRABBiz>; Mon, 1 Jan 2001 20:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130357AbRABBip>; Mon, 1 Jan 2001 20:38:45 -0500
Received: from wep10a-3.wep.tudelft.nl ([130.161.65.38]:46086 "EHLO
	wep10a-3.wep.tudelft.nl") by vger.kernel.org with ESMTP
	id <S130329AbRABBii>; Mon, 1 Jan 2001 20:38:38 -0500
Date: Tue, 2 Jan 2001 02:08:10 +0100 (CET)
From: Taco IJsselmuiden <taco@wep.tudelft.nl>
Reply-To: Taco IJsselmuiden <taco@wep.tudelft.nl>
To: linux-kernel@vger.kernel.org
Subject: ne2000 (ISA) & test11+
Message-ID: <Pine.LNX.4.21.0101020157290.637-100000@hewpac.taco.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

First off: I wish everyone a very happy and coded 2001.
Second: I'm having problems loading my ne2000 (ISA) card as a module since
test11 (test10 + 2.2.17 works perfectly. Haven't tried 2.2.18...):

When loading the module with 'modprobe ne io=0x360 irq=4' it says:

/lib/modules/2.4.0-prerelease/kernel/drivers/net/ne.o: init_module: No
such device or address
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters
/lib/modules/2.4.0-prerelease/kernel/drivers/net/ne.o: insmod
/lib/modules/2.4.0-prerelease/kernel/drivers/net/ne.o failed
/lib/modules/2.4.0-prerelease/kernel/drivers/net/ne.o: insmod ne failed

When using test10 or 2.2.17 it works ;)
I'm I just being plain stupid (as in: did I miss something...), or is
something wrong ??

system specs:
2.4.0-prerelease
debian woody
gcc version 2.95.2 20000220 (Debian GNU/Linux)
GNU Make version 3.79.1, by Richard Stallman and Roland McGrath.
GNU ld version 2.10.91 (with BFD 2.10.1.0.2)
insmod version 2.3.23
tune2fs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09

Cheers,
Taco.
P.S.: I'm not linux-kernel, so please cc me (I read web-archives...)
---
"I was only 75 years old when I met her and I was still a kid...."
          -- Duncan McLeod

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
