Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131141AbQLWDFv>; Fri, 22 Dec 2000 22:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131570AbQLWDFl>; Fri, 22 Dec 2000 22:05:41 -0500
Received: from [203.36.158.121] ([203.36.158.121]:18059 "HELO kabuki.eyep.net")
	by vger.kernel.org with SMTP id <S131141AbQLWDFe>;
	Fri, 22 Dec 2000 22:05:34 -0500
To: linux-kernel@vger.kernel.org
Subject: test13-pre4-ac2 - part of diff fails
Date: Sat, 23 Dec 2000 13:37:26 +1100
From: Daniel Stone <daniel@kabuki.eyep.net>
Message-Id: <20001223030539Z131141-439+5796@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this when patch'ing in test13-pre4-ac2 (with ReiserFS and Netfilter
patches, none of which touch SMP).

patching file arch/i386/kernel/smp.c
Reversed (or previously applied) patch detected!  Assume -R? [n] 
Apply anyway? [n] y
Hunk #1 FAILED at 278.
Hunk #2 succeeded at 511 (offset 9 lines).
1 out of 2 hunks FAILED -- saving rejects to file arch/i386/kernel/smp.c.rej

Works fine if I reverse it and then put it back in. ?
d
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
