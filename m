Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129040AbQKMHYW>; Mon, 13 Nov 2000 02:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129178AbQKMHYN>; Mon, 13 Nov 2000 02:24:13 -0500
Received: from ns1.crl.go.jp ([133.243.3.1]:48882 "EHLO ns1.crl.go.jp")
	by vger.kernel.org with ESMTP id <S129040AbQKMHYC>;
	Mon, 13 Nov 2000 02:24:02 -0500
Date: Mon, 13 Nov 2000 16:23:53 +0900 (JST)
From: Tom Holroyd <tomh@po.crl.go.jp>
To: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: memory.c:83: bad pmd 0000000000000001
Message-ID: <Pine.LNX.4.30.0011131606420.16958-100000@holly.crl.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

memory.c:83: bad pmd 0000000000000001

Alpha DP264 UP

2.4.0-test10 (not pre)

I never got a bad pmd before.  I booted test10 on Nov 6, and I've gotten
bad pmd's about once a day (5 so far) since then.  I don't think it's
hardware.  I was running test10preX (circa Oct 24) for a while, and never
got it (and various test1-9 before that), so it has to be something in one
of the later test10pre versions.

It's coming from mm/memory.c:free_one_pmd().

Compiled with gcc 2.95.2 19991024 (release).

Dr. Tom Holroyd
"I am, as I said, inspired by the biological phenomena in which
chemical forces are used in repetitious fashion to produce all
kinds of weird effects (one of which is the author)."
	-- Richard Feynman, _There's Plenty of Room at the Bottom_

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
