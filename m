Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262901AbRFQVUK>; Sun, 17 Jun 2001 17:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262915AbRFQVUA>; Sun, 17 Jun 2001 17:20:00 -0400
Received: from tomts5.bellnexxia.net ([209.226.175.25]:30661 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S262901AbRFQVTu>; Sun, 17 Jun 2001 17:19:50 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: David Flynn <Dave@keston.u-net.com>,
        Daniel Phillips <phillips@bonn-fries.net>, rjd@xyzzy.clara.co.uk,
        linux-kernel@vger.kernel.org
Subject: Re: Newbie idiotic questions.
In-Reply-To: <200106171227.f5HCRZu10829@xyzzy.clara.co.uk> <0106171701100P.00879@starship> <3B2CC7DC.EEAF3253@mandrakesoft.com> <00c301c0f743$9da4d9f0$1901a8c0@node0.idium.eu.org> <3B2CD29E.948D6BF2@mandrakesoft.com>
From: Bill Pringlemeir <bpringle@sympatico.ca>
Date: 17 Jun 2001 17:17:30 -0400
In-Reply-To: Jeff Garzik's message of "Sun, 17 Jun 2001 11:54:06 -0400"
Message-ID: <m2g0cy24d1.fsf@sympatico.ca>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jeff" == Jeff Garzik <jgarzik@mandrakesoft.com> writes:
[snip]
 Jeff> It's the preference of the maintainer.  It's a tossup: using
 Jeff> the type in the kmalloc makes the type being allocated obvious.
 Jeff> But using sizeof(*var) is a tiny bit more resistant to change.

Ok, thanks.  I was looking at fixing an `actual bug' in this driver
and I was wonder what else I could/should do while there.  I didn't
necessarily want to change `sizeof(struct Type)' to `sizeof(*value)'.
I considered that change to be somewhat dubious, even though I like
`sizeof(*value)'.  Of course, I unwittingly demonstrated what dangers
lie in making cosmetic changes [I was on my way to a party at the time
and my girlfriend was calling, excuses, excuses...].

So, It looks like I might fix the actual race condition, post that
diff, fix any other small oddities, post that diff.  If no one
complains, etc I can ask the maintainer.  Of course I will test it
myself as well.

regards,
Bill Pringlemeir.



