Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131338AbQLFCgs>; Tue, 5 Dec 2000 21:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131360AbQLFCgj>; Tue, 5 Dec 2000 21:36:39 -0500
Received: from wep10a-3.wep.tudelft.nl ([130.161.65.38]:56845 "EHLO
	wep10a-3.wep.tudelft.nl") by vger.kernel.org with ESMTP
	id <S131338AbQLFCg0>; Tue, 5 Dec 2000 21:36:26 -0500
Date: Wed, 6 Dec 2000 03:05:59 +0100 (CET)
From: Taco IJsselmuiden <taco@wep.tudelft.nl>
Reply-To: Taco IJsselmuiden <taco@wep.tudelft.nl>
To: linux-kernel@vger.kernel.org
Subject: NE2000 (ISA) not loading on test11
Message-ID: <Pine.LNX.4.21.0012060257090.19232-100000@hewpac.taco.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just found out that I can't load the ne2000 (ne.o) module under test11.
test10 works fine ... Did I miss some big change between test10 and test11
or are the params io / irq just working different right now ??

Greetz,
Taco.

error-msg:

athlon:~# modprobe ne io=0x360 irq=4
/lib/modules/2.4.0-test12-pre5/kernel/drivers/net/ne.o: init_module: No
such device or address
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters
/lib/modules/2.4.0-test12-pre5/kernel/drivers/net/ne.o: insmod
/lib/modules/2.4.0-test12-pre5/kernel/drivers/net/ne.o failed
/lib/modules/2.4.0-test12-pre5/kernel/drivers/net/ne.o: insmod ne failed
athlon:~# 

---
"I was only 75 years old when I met her and I was still a kid...."
          -- Duncan McLeod

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
