Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262134AbSJQUUe>; Thu, 17 Oct 2002 16:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262135AbSJQUUe>; Thu, 17 Oct 2002 16:20:34 -0400
Received: from mx2.elte.hu ([157.181.151.9]:61897 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262134AbSJQUUc>;
	Thu, 17 Oct 2002 16:20:32 -0400
Date: Thu, 17 Oct 2002 22:39:12 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>, Crispin Cowan <crispin@wirex.com>,
       Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make LSM register functions GPLonly exports
In-Reply-To: <Pine.LNX.4.44.0210171015440.7066-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0210172221370.27339-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 17 Oct 2002, Linus Torvalds wrote:

>    (In other words: for provably non-derived works, whatever kernel
>    license we choose is totally irrelevant)

one more addition here: as long as those works do not copy any part of the
kernel, be that source code or binary code. Ie. they:

 - dont play fancy games binary-patching the kernel or something to that
   extent.

There's been a precedent created in the US just two days ago, at the
appelate level, that makes certain types of functionality-enhancing
'binary-patching' practices fall under the copyright of the patched work.

Ie. the GPL qualifies even if the main body of the work in question is not
derived from the kernel, but the work depends on modifying the kernel. So
it's a questionable practice even for non-derived bin-only modules to
patch the kernel or modify it in any not originally intended way.

and the well-known issues of:

 - dont use inline functions in headers

 - probably even the structure definitions in headers qualify

both can be independently created via the rules of reverse engineering.
(whatever they are in the country it's done - but be prepared for the US
to attempt to take jurisdiction over your acts, wherever you are ...)

	Ingo


