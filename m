Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129625AbQKWBJ0>; Wed, 22 Nov 2000 20:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131060AbQKWBJH>; Wed, 22 Nov 2000 20:09:07 -0500
Received: from hera.cwi.nl ([192.16.191.1]:39383 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S129625AbQKWBJA>;
        Wed, 22 Nov 2000 20:09:00 -0500
Date: Thu, 23 Nov 2000 01:38:53 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200011230038.BAA142694.aeb@aak.cwi.nl>
To: Andries.Brouwer@cwi.nl, rmk@arm.linux.org.uk
Subject: Re: silly [< >] and other excess
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From rmk@caramon.arm.linux.org.uk Thu Nov 23 00:17:21 2000

    Well, in my experience, values of PC (or EIP is x86 speak) rarely
    appear over column 50 on the screen.  Therefore, removing them is
    only going to save width, not height.

The EIP is not pushed out of sight horizontally, but vertically.
(Maybe you never saw a i386 oops. With [<>] the call trace takes
twice as many lines (on a 25x80 screen) as without.)

    Also, have you considered that not every oops is formatted exactly
    the same way on every architecture?

    Do you propose to teach klogd and ksymoops every single oops format style?

It is a triviality.
Besides, the patch only modified i386.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
