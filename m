Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130121AbQKLHtP>; Sun, 12 Nov 2000 02:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130215AbQKLHtG>; Sun, 12 Nov 2000 02:49:06 -0500
Received: from dfw-smtpout2.email.verio.net ([129.250.36.42]:35576 "EHLO
	dfw-smtpout2.email.verio.net") by vger.kernel.org with ESMTP
	id <S130121AbQKLHsy>; Sun, 12 Nov 2000 02:48:54 -0500
Date: Sun, 12 Nov 2000 13:55:31 -0600
From: Eric Shattow <radoni@crosswinds.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test11pre2 ram size detect incorrect
Reply-To: radoni@crosswinds.net
X-Mailer: Spruce 0.7.5 for X11 w/smtpio 0.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E13ursj-000112-00@dfw-mmp1.email.verio.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am happy to report that I finally got a 2.4.x kernel booted and running.
To get the kernel booting without an oops, I had to use the kernel option
"mem=64M" (I have 64 megabytes of ram installed). Aparently, without this
option the kernel was detecting an absurdly large amount of installed
memory, and thus dereferenced a null pointer. Should i help find out how to
get the kernel to recognize the proper amount of memory in my computer
without the kernel option?  What information should i make available? I am
new to actual linux development, and do not know if this is something i
should help fix or if it is just something that requires the kernel option.

regards to the kernel-hackers,

eric shattow [radoni@crosswinds.net]


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
