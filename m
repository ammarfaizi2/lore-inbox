Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132167AbQKVCAZ>; Tue, 21 Nov 2000 21:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132168AbQKVCAQ>; Tue, 21 Nov 2000 21:00:16 -0500
Received: from hera.cwi.nl ([192.16.191.1]:48556 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S132125AbQKVB74>;
	Tue, 21 Nov 2000 20:59:56 -0500
Date: Wed, 22 Nov 2000 02:29:53 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200011220129.CAA136848.aeb@aak.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: problem with 2.4.0test8 and 2.4.0test11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A few days ago, and again half an hour ago, X stopped working.
Both times this happened in a period of heavy and continuous
IDE disk access (copying a 12 GB tree from one disk to another,
and doing a diff between two 5 GB trees on different disks).

No mouse movement, no reaction to Ctrl-Alt-Backspace.
After killing the cp/diff process, X used 100% CPU,
and chvt would hang. After killing X and starting a
new one all was well. (Of course the vt will be garbled
again when I leave X.)

The kernels involved were 2.4.0test11preX and 2.4.0test8.
(2.4.0test11 dies here when masquerading, but 2.4.0test10
and earlier are OK.)

Andries

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
