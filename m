Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286316AbSAEWu2>; Sat, 5 Jan 2002 17:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286317AbSAEWuS>; Sat, 5 Jan 2002 17:50:18 -0500
Received: from [210.55.25.134] ([210.55.25.134]:45841 "EHLO schutz.cce.co.nz")
	by vger.kernel.org with ESMTP id <S286316AbSAEWuB>;
	Sat, 5 Jan 2002 17:50:01 -0500
Date: Sun, 6 Jan 2002 11:49:56 +1300 (NZDT)
From: "Phillip O'Donnell" <phillip@cce.co.nz>
To: linux-kernel@vger.kernel.org
Subject: UNIX sockets stop responding on 2.4.14
Message-ID: <Pine.LNX.4.21.0201061145280.382-100000@schutz.cce.co.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This isn't a very complete bug report.

I've been running a database server on 2.4.14, and this morning I noticed
that MySQL was crashing whenever I tried to login. I thought this was
really really weird, so I figured I'd upgrade MySQL and see if it
helped. No luck. So, being a not-terribly-well-used database, I thought
"bah, lets try something else." So I installed PostgreSQL. Which exhibited
exactly the same symptoms. Anyway, I eventually tracked it down to it
crashing as soon as it tried to do anything on the unix sockets. Both
ends, client and server, were crashing. 

It had been running fine previously, and after a reboot, ran fine
again. The system had been up for about 34 days, so I really don't have a
clue.

Unfortunately, I don't have any core files or anything else to help debug
it. I'm gonna go install 2.4.17 now and see if it happens again. 

Phillip O'Donnell
phillip@cce.co.nz


