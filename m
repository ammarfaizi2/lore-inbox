Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129480AbQLWNQi>; Sat, 23 Dec 2000 08:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129652AbQLWNQ2>; Sat, 23 Dec 2000 08:16:28 -0500
Received: from csa.iisc.ernet.in ([144.16.67.8]:32008 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S129480AbQLWNQS>;
	Sat, 23 Dec 2000 08:16:18 -0500
Date: Sat, 23 Dec 2000 18:15:41 +0530 (IST)
From: Sourav Sen <sourav@csa.iisc.ernet.in>
To: lkml <linux-kernel@vger.kernel.org>
Subject: why both kernel lock as well as semaphore
Message-ID: <Pine.SOL.3.96.1001223181204.13045B-100000@kohinoor.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In many parts of the kernel, I have seen both semaphore is taken
(eg. down(&current->mm->mmap_sem)) as well as kernel lock (lock_kernel())
is also taken, why both are required? Whats the purpose of each?

~sourav

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
