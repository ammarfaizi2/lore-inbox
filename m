Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130772AbQKVN4D>; Wed, 22 Nov 2000 08:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131912AbQKVNzx>; Wed, 22 Nov 2000 08:55:53 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:10245 "EHLO
        tellus.mine.nu") by vger.kernel.org with ESMTP id <S130772AbQKVNzq>;
        Wed, 22 Nov 2000 08:55:46 -0500
Date: Wed, 22 Nov 2000 14:25:01 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Linus Torvalds <torvalds@transmeta.com>,
        David Hinds <dhinds@zen.stanford.edu>, Martin Mares <mj@suse.cz>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Cardbus bridge problems
Message-ID: <Pine.LNX.4.21.0011221410100.31073-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not that I like it, but I need to boot Win98, and then warm boot into
Linux, or the Cardbus is not working.  This is using Linux-2.4.0-test11 on
a Mitac 7233 laptop.

Using lspci, I can see that the secondary and subordinate busses of the
Cardbus bridges are unconfigured/incorrect. I have attached dmesg and
lspci -vvvxxx output from the two cases (ok=Win98+warm-boot and
fail=cold-boot). I have enabled all PCI debug things I could find. Bw, it
would be really nice to have ONE place to enable the PCI debug info.

Any advice?

/Tobias



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
