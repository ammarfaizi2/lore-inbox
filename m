Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261452AbTCGJTu>; Fri, 7 Mar 2003 04:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261458AbTCGJTt>; Fri, 7 Mar 2003 04:19:49 -0500
Received: from mx2.elte.hu ([157.181.151.9]:27800 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261452AbTCGJTp>;
	Fri, 7 Mar 2003 04:19:45 -0500
Date: Fri, 7 Mar 2003 10:30:01 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Mike Galbraith <efault@gmx.de>
Cc: Andrew Morton <akpm@digeo.com>, Linus Torvalds <torvalds@transmeta.com>,
       <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <5.2.0.9.2.20030307093435.01a8fe88@pop.gmx.net>
Message-ID: <Pine.LNX.4.44.0303071029280.6944-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ok, forget the -B0 patch, it's broken - we cannot change the current
task's priority without unqueueing it first. -B1 will have the right code.

	Ingo

