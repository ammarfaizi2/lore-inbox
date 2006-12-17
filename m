Return-Path: <linux-kernel-owner+w=401wt.eu-S1752638AbWLQNyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbWLQNyg (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 08:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752636AbWLQNyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 08:54:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57806 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752635AbWLQNyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 08:54:33 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ricardo Galli <gallir@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules
References: <200612161927.13860.gallir@gmail.com>
	<Pine.LNX.4.64.0612161253390.3479@woody.osdl.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat OS Tools Group
Date: Sun, 17 Dec 2006 11:54:17 -0200
In-Reply-To: <Pine.LNX.4.64.0612161253390.3479@woody.osdl.org> (Linus Torvalds's message of "Sat\, 16 Dec 2006 13\:01\:04 -0800 \(PST\)")
Message-ID: <orwt4qaara.fsf@redhat.com>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 16, 2006, Linus Torvalds <torvalds@osdl.org> wrote:

> The whole reason the LGPL exists is that people realized that if they 
> don't do something like that, the GPL would have been tried in court, and 
> the FSF's position that anything that touches GPL'd code would probably 
> have been shown to be bogus.

Or that people would feel uncomfortable about the gray area and avoid
using the GPLed code in cases in which this would be perfectly legal
and advantageous to Free Software.  Sure enough, when people create
and distribute proprietary code by taking advantage of Free Software,
that's something to be avoided, but since there are other Free
Software licenses that are not compatible with the GNU GPL, it made
sense to enable software licensed under them to be combined with these
few libraries.  Letting concerns about copyright infringement, be such
acts permissible by law or not, scare Free Software developers away
from Free Software was not good for Free Software.

> Do you REALLY believe that a binary becomes a "derived work" of any random 
> library that it gets linked against? If that's not "fair use" of a library 
> that implements a standard library definition, I don't know what is.

There are many factors involved and you're oversimplifying the issue.

Some claim that, in the case of static linking, since there part of
the library copied to the binary, it is definitely a case of derived
work.

Some then take this notion that linking creates derived works and
further extend the claim that using dynamic linking is just a trick to
avoid making the binary a derived work, and thus it shouldn't be taken
into account, even if there still is *some* information from the
dynamic library that affects the linked binary.

Others then introduce exceptions such as the existence of another
implementation of the library that is binary- and license-compatible,
and that thus might make the license of the library actually used to
create the binary irrelevant.

Some disregard the fact that header files sometimes aren't just
interface definitions, but they also contain functional code, in the
form of preprocessor macros and inline functions, that, if used, do
make it to the binary.

All of these arguments have their strengths and weaknesses.  As you
and others point out, and it matches my personal knowledge, none of
them has been tried in court, and the outcome of a court dispute will
often depend on specifics anyway.

So calling these arguments idiocy is as presumptuous as FSF's alleged
behavior.  While at that, I feel you allegation is groundless, and I
hope this message makes it clear why, so I wish you'd take it back.


The gray area between what is clearly permitted by a license and the
murky lines that determine what constitutes a derived work, and what
is fair use even if it's a derived work, is not for any of us to
decide.  The best we can do is to offer interpretations on intent of
license authors and software authors, and of laws.  Even though we're
not lawyers or judges, such interpretations may be taken into account
in court disputes.

When the FSF says a license does not permit such and such behavior,
you apparently interpret that as a statement that the FSF thinks this
behavior wouldn't be permissible by fair use either.  This is an
incorrect interpretation.  As we've seen above, there *is* a gray area
beyond what is permitted by the license.  But the FSF must not give
anyone the impression that the *license* permits actions that would
make it less effective in fulfilling its intent, this would just
weaken the license.

Similarly, when you make an unqualified statement that some action is
permitted, because you mean it's permitted by fair use even if not by
the license, this might be mis-interpreted as something explicitly
permitted by the license.  So this weakens the license, one of our
most valuable tools to make the world a better place.  Is this what
you intend to do?  I hope not.

Thanks,

-- 
Alexandre Oliva         http://www.lsd.ic.unicamp.br/~oliva/
FSF Latin America Board Member         http://www.fsfla.org/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
