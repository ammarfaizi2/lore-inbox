Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136148AbREHCsN>; Mon, 7 May 2001 22:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136738AbREHCsD>; Mon, 7 May 2001 22:48:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:22956 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S136148AbREHCr4>;
	Mon, 7 May 2001 22:47:56 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15095.24153.737361.998494@pizda.ninka.net>
Date: Mon, 7 May 2001 19:47:53 -0700 (PDT)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105071929190.8237-100000@penguin.transmeta.com>
In-Reply-To: <15095.15091.45238.172746@pizda.ninka.net>
	<Pine.LNX.4.21.0105071929190.8237-100000@penguin.transmeta.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds writes:
 > YOUR HEURISTIC IS WRONG!

Please start the conversation this way next time.

 > I call that a bug. You don't. Fine.

You made it sound like a data corrupter, a kernel crasher, and that
any bug against a kernel with that patch indicates my patch caused it.
There is an important distinction between "this is doing something
silly" and "this will scramble your disk and crash the kernel".

The latter is the conclusion several people came to.

And I wanted a clarification on this, nothing more.

I wanted this clarification from you _BECAUSE_ the original posting in
this thread saw data corruption which went away after reverting my
patch.  But there is no possible connection between my patch and the
crashes he saw.

Many people have already concluded that "Linus says davem's patch is
crap so it must have been causing the corruptions of the original
reporter."

Like you and I, most people are lazy.  And a lazy person is likely
to treat "bug goes away with reverting patch" plus "Linus says the
patch is crap" as "get rid of the patch, this'll fix the bug".  And
that'll be the end of it, nobody will investigate the true cause of
the problem until it shows up again later for some different reason.

 > But that code isn't coming anywhere _close_ to my tree until the two
 > match. And I stand by my assertion that it should be reverted from Alans
 > tree too.

I have no intent to ever submit that patch to your tree, I know it's
not the right way to solve this problem.

In fact I submitted that patch to you as an "[RFC]" a long time ago
and it fell on deaf ears.  Or perhaps you happened to have laser eye
surgery that particular day, who knows. :-)

Later,
David S. Miller
davem@redhat.com
