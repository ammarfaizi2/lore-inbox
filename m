Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265857AbTBXJSM>; Mon, 24 Feb 2003 04:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265865AbTBXJSM>; Mon, 24 Feb 2003 04:18:12 -0500
Received: from mx1.elte.hu ([157.181.1.137]:32927 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S265857AbTBXJSL>;
	Mon, 24 Feb 2003 04:18:11 -0500
Date: Mon, 24 Feb 2003 10:28:06 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: procps-list@redhat.com
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <alexl@redhat.com>, Alexander Viro <viro@math.psu.edu>
Subject: Re: [patch] procfs/procps threading performance speedup, 2.5.62
In-Reply-To: <200302232151.h1NLp1x260213@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.44.0302241020010.20069-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Feb 2003, Albert D. Cahalan wrote:

> Surely you realize that I have seen this code?

have you actually tried it?

> Proper "ps m" behavior groups threads in the output. The hacked-up
> procps being used by Red Hat fails to do this. You chould change that...
> at the cost of reading all processes and sorting them. There goes all of
> your performance improvement.

Albert, the new code properly reads all threads and sorts them, in the
"ps m" case. Had you truly read my emails you'd notice where the overhead
lies, and what steps were taken to get rid of it.

	Ingo

