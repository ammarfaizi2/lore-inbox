Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261757AbSITI6j>; Fri, 20 Sep 2002 04:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261791AbSITI6j>; Fri, 20 Sep 2002 04:58:39 -0400
Received: from mx2.elte.hu ([157.181.151.9]:60645 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261757AbSITI6i>;
	Fri, 20 Sep 2002 04:58:38 -0400
Date: Fri, 20 Sep 2002 11:11:12 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Anton Blanchard <anton@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] pidhash-fix-2.5.36-A0
In-Reply-To: <Pine.LNX.4.44.0209201104300.30613-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209201110580.30822-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> the attached patch (against BK-curr) fixes a bug in the new PID
> allocator, which bug can cause incorrect hashing of the PID structure
> which causes infinite loops in find_pid(). [and potentially other
> problems.]

the patch is also a small speedup :-)

	Ingo

