Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130816AbQLWTlw>; Sat, 23 Dec 2000 14:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130760AbQLWTln>; Sat, 23 Dec 2000 14:41:43 -0500
Received: from mout0.freenet.de ([194.97.50.131]:34435 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S130751AbQLWTlf>;
	Sat, 23 Dec 2000 14:41:35 -0500
From: Andreas Franck <afranck@gmx.de>
Date: Sat, 23 Dec 2000 20:14:49 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
To: Mike Galbraith <mikeg@wen-online.de>
In-Reply-To: <Pine.Linu.4.10.10012231826350.645-100000@mikeg.weiden.de>
In-Reply-To: <Pine.Linu.4.10.10012231826350.645-100000@mikeg.weiden.de>
Subject: Re: Fatal Oops on boot with 2.4.0testX and recent GCC snapshots
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <00122320144900.00517@dg1kfa.ampr.org>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike, hello linux-kernel audience,

> I had the same, with the last few snapshots I tried, but 20001218 seems
> to work ok.
> dmesg|head -1
> Linux version 2.4.0-test13ikd (root@el-kaboom) (gcc version gcc-2.97
> 20001218 (experimental)) #18 Sat Dec 23 17:43:29 CET 2000

Hmm, would have been nice, but it crashes here with 20001222, nevertheless. 
For which CPU do you have your kernel configured? It might be a CPU specific 
issue, I'll try to compile for Pentium I and 486, now, and report my results.

It would also be nice to know if this is a gcc issue or a kernel issue - if I 
knew which precise file was responsible for the crash, I could compare the 
assembly output for stable and snapshot GCC. My suspect is kernel/sched.c, 
but this might be wrong, as the story begins on the launch of kupdate in 
fs/buffer.c.

But now I have almost no clue what really goes wrong.

Geetings and a nice christmas to everybody!
Andreas

-- 
->>>----------------------- Andreas Franck --------<<<-
---<<<---- Andreas.Franck@post.rwth-aachen.de --->>>---
->>>---- Keep smiling! ----------------------------<<<-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
