Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315627AbSGYSDD>; Thu, 25 Jul 2002 14:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316088AbSGYSDD>; Thu, 25 Jul 2002 14:03:03 -0400
Received: from asie314yy33z9.bc.hsia.telus.net ([216.232.196.3]:7298 "EHLO
	saurus.asaurus.invalid") by vger.kernel.org with ESMTP
	id <S315627AbSGYSDB>; Thu, 25 Jul 2002 14:03:01 -0400
To: Daniel Mose <imcol@unicyclist.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alright, I give up.  What does the "i" in "inode" stand for?
References: <200207190432.g6J4WD2366706@pimout5-int.prodigy.net> <20020725022454.A8711@unicyclist.com>
From: Kevin Buhr <buhr@telus.net>
In-Reply-To: <20020725022454.A8711@unicyclist.com>
Date: 25 Jul 2002 11:06:11 -0700
Message-ID: <87k7njsmwc.fsf@saurus.asaurus.invalid>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Mose <imcol@unicyclist.com> writes:
> 
> Someone pointed out earlier in this thread: 
> "How Newbie can one get?" 

*I* said that, and it should be noted that it was completely obvious
from context that it was tongue in cheek:

| Boy, how newbie can you get?  Fortunately, you've got lots of people
| setting you straight, and they've given you all those different
| answers to choose from!  ;)

(Get it?  The obvious, "newbie" question is answered by the experts in
a dozen different ways.  HAW HAW.)

Anyway, I hope you realized that.

> I can easily cope with the Idea that the I in I-node stands for
> whatever one likes it to be.  The I-node context makes very good 
> sense to me when you put it to work in FS context. The name 
> I-node is as I see it, close to semantic rape. (as I also find 
> some of the K&R/ANSI C keywords to be ) 

Is "semantic rape" supposed to be good or bad?

The name "inode" (or i-node or I-node or eye-node---haw haw) doesn't
have to mean anything as long as it's conveniently short and
immediately evocative to people who use the name.  On its face,
calling something a "widget" isn't very descriptive either, yet its
meaning is obvious enough in the context of GUI programming.  See also
the Linux kernel's "dentry" and "skbuff".

People don't invent these shared languages to alienate newcomers.
They are invented to facilitate efficient communication and, just as
importantly, to encapsulate big, complicated ideas in tiny,
manipulable pretend-words.  They facilitate *thought* (and, so, the
design process) as much as they facilitate communciation.

That's good, right?

> What bothers my self a bit more in the kernel context, and thus 
> makes me an even more eager "Kernel alienate" than I believe Rob
> to be, are the "atomic_" calls/functions and their semantic origin.

This has been explained by others, but let me note that the Jargon
File is an excellent resource for these types of questions:

        http://www.tuxedo.org/~esr/jargon/

It doesn't include "inode" (which falls a little outside its scope),
but it has entries for "atomic", "foo", "bar", and "foobar".

> Suppose that you do missunderstand your discussion partner frequently.
> 
> So you each type in some related patches and send them of to linus(?) 
> linus (or whom-ever) sends them back, saying "half is buggy" So you're 
> back discussing again. This time you have half the code bugfree so 
> you only need to discuss the buggy half. You discuss it, missunder-
> stand each others frequently again because of some "foos" and "bars" 
> and thus send in another patch, which is refused as being 
> "quarterly-buggy", and so on...

By definition, "foo"s and "bar"s are ambiguous.  That's why they
should be used sparingly.  Typically they're used in little examples
of shell or C code where you need a *name*, but it's exact value and
meaning aren't important, like so:

>> Hey, there's a bug in the kernel!  Do "ln -s foo foo; mkdir foo"
>> and watch the fireworks.

They're rarely used to talk about new data structures except at the
earliest speculative design state.

-- 
Kevin Buhr <buhr@telus.net>
