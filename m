Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129662AbQKAQ5N>; Wed, 1 Nov 2000 11:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129739AbQKAQ4y>; Wed, 1 Nov 2000 11:56:54 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:54770 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129662AbQKAQ4u>; Wed, 1 Nov 2000 11:56:50 -0500
Date: Wed, 1 Nov 2000 14:56:18 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Jonathan George <Jonathan.George@trcinc.com>
cc: "'matthew@mattshouse.com'" <matthew@mattshouse.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.0-test10 Sluggish After Load
In-Reply-To: <790BC7A85246D41195770000D11C56F21C847C@trc-tpaexc01.trcinc.com>
Message-ID: <Pine.LNX.4.21.0011011440390.11112-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, Jonathan George wrote:

> It sounded to me as if his machine never actually recovered from
> thrashing.

That's the nature of thrashing ... nothing in the system
is able to make any progress, hence it takes ages until
the situation changes...

> Futhermore, even a thrashing case on a machine like that
> shouldn't last for more than about 10 minutes.  It would be
> interesting to contrast FreeBSD's behavior if "simple" cleanup
> was the problem.

FreeBSD has 2 methods of thrashing control. Current Linux 2.4
VM has none. I have been experimenting with some thrashing
control stuff here, but haven't gotten anything clean and
obviously right yet...

> BTW, I think that everyone is happy with the direction of the
> new VM.  I'm looking forward to your upcoming enhancements which
> I hope will make it in to a later 2.4 release.

I'm working on it. I have no idea if it'll be ready in time
for other 2.4 releases ... maybe stuff will be there, maybe
it'll be 2.5 work.

Of course, this also depends on the amount of people willing
to test out new VM patches and/or help with development.

Now that the 2.4 tree is frozen, I'll periodically upload new
patches to my home page for people to test. I don't want to
touch 2.4 except with the most trivial fixes, and accumulate
a big set of more invasive improvements for 2.5.

The URL where I (after I return from .nl in 2 weeks) will put
my VM patches:

	http://www.surriel.com/patches/

regards,

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
