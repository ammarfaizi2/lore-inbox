Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbTBXMmh>; Mon, 24 Feb 2003 07:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266615AbTBXMmh>; Mon, 24 Feb 2003 07:42:37 -0500
Received: from mx2.elte.hu ([157.181.151.9]:5817 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S264844AbTBXMmh>;
	Mon, 24 Feb 2003 07:42:37 -0500
Date: Mon, 24 Feb 2003 13:52:38 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: procps-list@redhat.com, <linux-kernel@vger.kernel.org>, <alexl@redhat.com>
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
In-Reply-To: <200302241229.h1OCTRF331287@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.44.0302241348550.26977-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Albert, you, as a contributor to procps, have you ever run a high number
of (eg. more than 10K) threads and tested procps for that workload? Just
try it - start up eg. 10,000 threads (which just sleep) under 2.5.62, and
time all the various procps utilities. Then you'll see it first-hand,
where all the overhead lies.

	Ingo

