Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284902AbSAGS06>; Mon, 7 Jan 2002 13:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284860AbSAGS0s>; Mon, 7 Jan 2002 13:26:48 -0500
Received: from mx2.elte.hu ([157.181.151.9]:56992 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S284886AbSAGS0j>;
	Mon, 7 Jan 2002 13:26:39 -0500
Date: Mon, 7 Jan 2002 21:24:05 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>, george anzinger <george@mvista.com>,
        Davide Libenzi <davidel@xmailserver.org>
Subject: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
Message-ID: <Pine.LNX.4.33.0201072122290.14092-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-D1 is a quick update over -D0:

 	http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.2-D1.patch
 	http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-D1.patch

this should fix the child-inherits-parent-priority-boost issue that causes
interactivity problems during compilation.

	Ingo

