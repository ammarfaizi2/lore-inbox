Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262076AbSKCPzA>; Sun, 3 Nov 2002 10:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262080AbSKCPzA>; Sun, 3 Nov 2002 10:55:00 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:13200 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262076AbSKCPy7>; Sun, 3 Nov 2002 10:54:59 -0500
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Oliver Xymoron <oxymoron@waste.org>, "Theodore Ts'o" <tytso@mit.edu>,
       Dax Kelson <dax@gurulabs.com>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org, davej@suse.de
References: <Pine.GSO.4.21.0211030904340.25010-100000@steklov.math.psu.edu>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: Filesystem Capabilities in 2.6?
Date: Sun, 03 Nov 2002 17:01:10 +0100
Message-ID: <87u1iymym1.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> writes:

> On Sun, 3 Nov 2002, Olaf Dietsche wrote:
>
>> > And as Al points out, new security features don't mean that you can just
>> > stop being careful. 
>> 
>> Stating the obvious. Capabilities are not an end in itself, nor is suid
>> root. It's just another line of defense to help with these binaries,
>> which are _not_ capability aware.
>
> Bullshit.  To _be_ careful you need to understand the implications of
> what you are doing.

Where did I, or anyone else, state the opposite?

> To do so in a more complicated model is harder,
> not easier.

Because it's harder for you to do a proper job, doesn't mean it is for
everybody else.

> More features != better security.  Quite often it's exact opposite.
> Human do make errors, otherwise suid-root stuff wouldn't be a problem
> to start with.  And when security mechanism increases probability
> of error it becomes a menace.

Capabilities are not about adding features, they are about reducing.
Face it, you just don't get it.

> Odds of getting screwed are 0 if programs contain no bugs.  We are dealing
> with real world and there are non-zero odds of exploitable holes being there
> and getting found.  What we want is to decrease the odds of compromise,
> right?  So how are ACLs/capabilities/etc. settings different from program
> internals?  Either can contain bugs.  Neither is guaranteed to be done
> correctly.  Odds of compromise depend on odds of bugs in both.  Yet you
> seem to imply that metadata *will* be set correctly.  By the same vendors
> that had shipped vulnerable binary in the first place.  Even though the
> complexity of metadata had grown.

Agreed in _every_ _single_ _point_. But because there might be stupid
vendors out there, doesn't mean I have to bow down to their level.
And that is, what this is all about. I want to have this choice and
fortunately, I have it.

> Please, get real.  "Completely understood" is much more important than
> "versatile" when it comes to security models.  And as for additional lines

So, what's your point? Like with suid root, capability settings need
to be debugged, bug reports filed and people educated.

> of defense...  How did it go?  "For extra privacy that message had been
> twice encrypted with ROT13"...

Well, _that_ is bullshit.

Regards, Olaf.
