Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKOAWt>; Tue, 14 Nov 2000 19:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130414AbQKOAW3>; Tue, 14 Nov 2000 19:22:29 -0500
Received: from burdell.cc.gatech.edu ([130.207.3.207]:3077 "EHLO
	burdell.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S129047AbQKOAWX>; Tue, 14 Nov 2000 19:22:23 -0500
Date: Tue, 14 Nov 2000 18:52:21 -0500 (EST)
From: Zhiruo Cao <zhiruo@cc.gatech.edu>
To: linux-kernel@vger.kernel.org
Subject: Question on bdflush
Message-ID: <Pine.GSU.4.21.0011141847460.26147-100000@lennon.cc.gatech.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

Why does bdflush (kupdated and kflushed) writes to disk periodically even
though the system is apparently idle.  I think if no more new buffers
becomes dirty, kflushed show not write anything to disk.   I'm working
on a notebook, and I found the periodic disk access is very annoying and
consuming a lot of power.

Thanks!

Joe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
