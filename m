Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130030AbQLFDV6>; Tue, 5 Dec 2000 22:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130312AbQLFDVs>; Tue, 5 Dec 2000 22:21:48 -0500
Received: from br4.qld-remote.bigpond.net.au ([24.192.64.19]:37380 "EHLO
	br4.qld-remote.bigpond.net.au") by vger.kernel.org with ESMTP
	id <S130030AbQLFDVf>; Tue, 5 Dec 2000 22:21:35 -0500
Date: Wed, 6 Dec 2000 12:53:29 -0500 (EST)
From: Dave <djdave@bigpond.net.au>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.0-test12-3 - swap_free / Bad swap file messages
Message-ID: <Pine.LNX.4.30.0012061230090.1074-100000@athlon.internal>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Got this last night while running 2.4.0-test12-pre3.  Not sure what I did
to trigger it.  X4/keyboard hung shortly afterwards.  Had to ssh in to
reboot.

Dec  6 01:16:04 athlon kernel: Bad swap file entry c17a1558
Dec  6 01:16:04 athlon last message repeated 3 times
Dec  6 01:16:05 athlon kernel: swap_free: Trying to free nonexistent swap-page
Dec  6 01:16:05 athlon kernel: swap_free: Trying to free nonexistent swap-page
Dec  6 01:16:07 athlon kernel: Bad swap file entry c17a1558
Dec  6 01:16:07 athlon kernel: Bad swap file entry c17a1558
Dec  6 01:16:07 athlon kernel: swap_free: Trying to free nonexistent swap-page
Dec  6 01:16:07 athlon kernel: swap_free: Trying to free nonexistent swap-page
Dec  6 01:16:08 athlon kernel: Bad swap file entry c17a1558
Dec  6 01:16:37 athlon last message repeated 5 times
Dec  6 01:16:37 athlon kernel: swap_free: Trying to free nonexistent swap-page
Dec  6 01:16:52 athlon last message repeated 5 times
...
Dec  6 01:16:57 athlon kernel: swap_free: Trying to free nonexistent swap-page
Dec  6 01:16:57 athlon last message repeated 3 times

It may not be relevent, but the NVidia module was loaded at the time.

Any ideas?  Any further info required?

David.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
