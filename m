Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261446AbSLSNQr>; Thu, 19 Dec 2002 08:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261721AbSLSNQr>; Thu, 19 Dec 2002 08:16:47 -0500
Received: from [81.2.122.30] ([81.2.122.30]:17669 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S261446AbSLSNQp>;
	Thu, 19 Dec 2002 08:16:45 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212191335.gBJDZRDL000704@darkstar.example.net>
Subject: Dedicated kernel bug database
To: linux-kernel@vger.kernel.org
Date: Thu, 19 Dec 2002 13:35:27 +0000 (GMT)
Cc: davej@codemonkey.org.uk, alan@lxorguk.ukuu.org.uk, lm@bitmover.com,
       lm@work.bitmover.com, torvalds@transmeta.com, vonbrand@inf.utfsm.cl,
       akpm@digeo.com
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following on from yesterday's discussion about there not being much
interaction between the kernel Bugzilla and the developers, I began
wondering whether Bugzilla might be a bit too generic to be suited to
kernel development, and that maybe a system written from the ground up
for reporting kernel bugs would be better?

I.E. I am prepared to write it myself, if people think it's
worthwhile.

For example, we get a lot of posts on LKML like this:

"Hi, foobar doesn't work in 2.4.19"

Now, does that mean:

* The bug first appeared in 2.4.19, and is still in 2.4.20
* The bug reporter hasn't tested 2.4.20
* The bug reporter can't test 2.4.20 because something else is broken
* The bug actually first appeared in 2.4.10, but it didn't irritate
  them enough to complain until now.

A bug database designed from scratch could allow such information to
be indexed in a way that could be processed and searched usefully.  A
list of tick-boxes for worked/didn't work/didn't test/couldn't test
for several kernel versions could be presented.

Also, we could have a non-web interface, (telnet or gopher to the bug
DB, or control it by E-Mail).

It could warn the user if they attach an un-decoded oops that their
bug report isn't as useful as it could be, and if they mention a
distribution kernel version, that it's not a tree that the developers
will necessarily be familiar with.

I'm not criticising the fact that we've got Bugzilla up and running,
but just pointing out that we could do better, (and I'm prepared to
put in the time and effort).  I just need ideas, really.

John.
