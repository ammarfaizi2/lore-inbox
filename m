Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318631AbSGZXcr>; Fri, 26 Jul 2002 19:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318636AbSGZXcq>; Fri, 26 Jul 2002 19:32:46 -0400
Received: from cicero2.cybercity.dk ([212.242.40.53]:30479 "EHLO
	cicero2.cybercity.dk") by vger.kernel.org with ESMTP
	id <S318631AbSGZXcn>; Fri, 26 Jul 2002 19:32:43 -0400
Date: Sat, 27 Jul 2002 01:39:56 +0200
From: Daniel Mose <imcol@unicyclist.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Alright, I give up.  What does the "i" in "inode" stand for?
Message-ID: <20020727013956.A4492@unicyclist.com>
Mail-Followup-To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200207190432.g6J4WD2366706@pimout5-int.prodigy.net> <20020725022454.A8711@unicyclist.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20020725022454.A8711@unicyclist.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Daniel Mose <imcol@unicyclist.com> wrote
>Rob Landley wrote:
>> I've been sitting on this question for years, hoping I'd come across the 
>> answer, and I STILL don't know what the "i" is short for.  Somebody here has 
>> got to know this. :)

{  foobar.. }

>I have followed the LKML for only about 2 months. I have been 
>thinking of posting something similar. ( just not 'bout i-nodes )

I' ve cut and pasted among the anwers a bit, since 
everone seems to be quoting similar parts, and I made 
it into one longer answer instead of several (long) 
answers. By doing so anybody will also be able to quote
the answers in this letter without adding one subthread 
for each person that is quoted. If this method feels 
uncomfortable. Do say so. It is basically the good old
Q+A method.


As I my self am not a LK developer, I will direct any 
further feedback directly to persons that target this topic
and my older posting, to save bandwith and threads. Anyone 
that recieves a letter from me is of course free to quote 
it on LKML.

Before I continue on I am a bit curious about another 
question that seems a bit related to topic 
" Alright, I give up..."

Q : I'm wondering how many out of a 100 linux developers
it is that does NOT actually have an old Unix back ground ?

It would interest me to know even if it is just a brief
and uncertain calculation 

{ fubar..}

>a Linux kernel "Alienate" topic. 

[snip]

ah! that word felt much better!

===========================================================

Kevin Buhr <buhr@telus.net> wrote

>| Boy, how newbie can you get?  Fortunately, you've got lots of people
>| setting you straight, and they've given you all those different
>| answers to choose from!  ;)
>
>(Get it?  The obvious, "newbie" question is answered by the experts in
>a dozen different ways.  HAW HAW.)
>
>Anyway, I hope you realized that.

Dear Kevin 

I wanted to clear out a point that no-one had mentioned 
earlier in the topic, so I used your previous words in doing so. 
It was not a personal remark. That's why I chose to only focus 
on your words and not on your person. 

I wrote:
>> I can easily cope with the Idea that the I in I-node stands for
>> whatever one likes it to be.  The I-node context makes very good 
>> sense to me when you put it to work in FS context. The name 
>> I-node is as I see it, close to semantic rape. (as I also find 
>> some of the K&R/ANSI C keywords to be ) 
>
>Is "semantic rape" supposed to be good or bad?

Perhaps one could say enforced connection to context instead, but 
I find "semantic rape" to be more in tune with my own perception.

I do suppose that we have somewhat different ways in
approach towards Unix:
  
>The name "inode" (or i-node or I-node or eye-node---haw haw) doesn't
>have to mean anything as long as it's conveniently short and
>immediately evocative to people who use the name.

If I were to use words like f ex I-nodes when I describe f ex
ext2fs storage layout to a unknowing but receptive friend,
he would either assume that I was turning into a geek, or that 
he was being bullied by me. ( I have tried once. )

>calling something a "widget" isn't very descriptive either, yet its
>meaning is obvious enough in the context of GUI programming.  

I actually find the word "widget" to be fairly clear.

>See also the Linux kernel's "dentry" and "skbuff".

I have only read about "d-entries" as yet, I didn't have any 
problems with the IMO semantically sane reference from "dir_ent".

>People don't invent these shared languages to alienate newcomers.

Are you sure ? =-0

>They are invented to facilitate efficient communication and, just as
>importantly, to encapsulate big, complicated ideas in tiny,
>manipulable pretend-words.  They facilitate *thought* (and, so, the
>design process) as much as they facilitate communciation.

Apparently to you and to a lot of others perhaps.

I guess that this is where we don't agree, and I prove to  
be an "Alienate."
I consider great ideas to be small and fairly simple, for instance.
And, yes I do consider Linux as a system to be a Great Idea
so far.

>That's good, right?

Do we really have to share the same points of view?  

kind regards 
/Daniel Mose
====================================================================0
====================================================================0

>On Thu, Jul 25, 2002 at 02:24:54AM +0200, Daniel Mose wrote:
>> What bothers my self a bit more in the kernel context, and thus 
>> makes me an even more eager "Kernel alienate" than I believe Rob
>> to be, are the "atomic_" calls/functions and their semantic origin.
>> I believe that every Unix has "atomic_" calls all though perhaps 
>> differently designed. And I totally fail to understand why some 
>> one decided to name theese functions "atomic_"

Albert D. Cahalan <acahalan@cs.uml.edu> wrote
>
>To be an "atom" is to be indivisible. The term comes from
>ancient philosophy. An atomic operation happens all at once.
>
Thank's Albert for making your time mine. 

========================================================================
 
Andrew Rodland <arodland@noln.com> wrote

>Well, this one is easy enough.
>"Atomic" comes from the older-than-old meaning of the word, which is,
>roughly, "unsplittable" or "undivisible". Whether it uses magical CPU
>instructions, or just some sort of locking mechanism, an atomic
>operation is one that cannot be observed, or interfered with, "half
>done".
>>This has lots of uses with databases, and is a major requirement there
>(and a basic database book will probably explain it better than I), but
>it's a big thing when you're designing an SMP/preemptive/preemptible
>kernel, too. :)
>
>Hope I was enlightening and not just boring
>--hobbs

Same here. Thank you For giving me something more than a link
It's all the different angles that makes this comprehensible 
to me.

=====================================================================

jw schultz <jw@pegasys.ws> wrote

>In programming we describe as atomic any action that cannot
>be split (a read(2) from a serial device cannot return just 3
>bits) or an action containing multiple sub-actions that if
>split/interrupted causes breakage.  If you interrupt an
>atomic_* it will set of a chain reaction and the OS will
>explode :)
>
Thanks, this is what made the choice of "atomic_" seem as 
a clear  choice in Unix words (in a post WW2 perspective).

Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil> wrote

>This reference has to do with operations that must be completed
>against memory WITHOUT any intervening accesses. The reference "atomic_"
>comes from "non-divisible" operations where the operation cannot
>or must not be subdivided any further (also from physics where atoms
>cannot normally be subdivided).

-[snip]-

Thank you VERY much Jesse!
 Your very nice reference will not fit here. It is quite thorough
 as well as comprehensive, and must have taken a good bit of time 
 to write down. I do suppose  that there aren't any typos ? Most
 of It does make sense to me. Is it published anywhere ?  
 

=================================================================0
=================================================================0

>> Other words in this ML (and in too many other places =( ) that
>> make my own brain go rivetted and short circuit are the "foo" 
>> and/or "bar", not to mention the "foobar" place holder.
>>  
>> I realize that most folks In LKML use "foo", "bar" and it's dad,
>> "foobar" with outmost joy and that there is complete and utter 
>> understanding of what the "foos" and "bars" actually stand for 
>> in your contemporary discussion partners reasoning scheeme. 
>> 
>> Or is it? 

Albert D. Cahalan <acahalan@cs.uml.edu> wrote
>
>You could use ExampleOne, ExampleTwo, and ExampleThree,
>but the CS convention is foo, bar, and baz.
>
>foo  -- the 1st metasyntactic variable
>bar  -- the 2nd metasyntactic variable
>baz  -- the 3rd metasyntactic variable

Thanks again Albert. Now I know that It is actually a 
"CS-convention" =-(

=======================================================

jw schultz <jw@pegasys.ws> wrote
>
>The terms foo, bar, foobar, sna, etc in psuedocode stand for
>"something having a name" We use them in places where the
>actual name doesn't matter for the sake of the discussion.

This rhimes well with the rest of my answers.

>The "good replacer words" can often be almost-real or
>unintentially real name and cause confusion or divert the

A possible fix for this problem in pseudo - C could be:

// void *good_replacer_word(specified_arg1);
or
/* void *good_replacer_word(specified_arg1) */

>functional discussion into a discussion (argument) over
>names.  They are sometimes also used to mean "you make up a
>name that has meaning for your purpose".

Yes do I believe that I have seen this on LKML quite often.

>________________________________________________________________
>	J.W. Schultz            Pegasystems Technologies
>	email address:		jw@pegasys.ws
===========================================================

From: Thunder from the hill <thunder@ngforever.de>

>Well, there's indeed a meaning behind it, apart from "fucked over and over 
>beyond all repair."
Hi thunder.

Thanks for taking time with me. Yes maybe you have 
written some of the linux jargon file at tuxedo.org ?
;)

==========================================================================

Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil> wrote

>ie:
>	void *foobar()
>
>would mean "a function returning a pointer to a void type" where the actual
>NAME of the function is not really relevent to the topic. This can be carried
>to connect things like the above together as a form of prototype specification,
>used only in describing the prototype, and is not the prototype itself.
>
>No, it isn't 100% accurate. And it is easily misunderstood, especially if
>english (the US style) is mixed with the (British syle) and mixed with
>non-english transliterations of other idiomatic language structures.

How "fruchtbar"!
;)

>But it means the participants in the discussion LEARN more about communicating
>with others - sometimes emotionally, sometimes with laughter, sometimes just
>a "oh, so that is what you mean...".

Yeah? Well this is rather hard to promote against ..., =-/
but I would feel rather stupid if I was to try and debug 
other peoples "fubars" at the level I am now anyway..
I often notice angry reactions. like 
"I'm not going to try and read your buggy peace of crap again"
Is that what you call "emotional" ?
 
>Sometimes it may take a little longer to get to a solution, but it seems to
>be more fun, and the result is usually much better than what happens in more
>regimented organizations.

But don't you sort of get tired of it ?

>-------------------------------------------------------------------------
>Jesse I Pollard, II
>Email: pollard@navo.hpc.mil
>
>Any opinions expressed are solely my own.

Same here.

Kevin Buhr <buhr@telus.net> wrote

>This has been explained by others, but let me note that the Jargon
>File is an excellent resource for these types of questions:
>
>        http://www.tuxedo.org/~esr/jargon/


Yes It was, but as I pointed out above, It is the different angles 
that makes me comprehend. Thanks again for the link. I think  
that this dictionary will be of great value. 

But It doesn't contain the word "alienate" though ;)

>
>By definition, "foo"s and "bar"s are ambiguous.  That's why they
>should be used sparingly.  Typically they're used in little examples
>of shell or C code where you need a *name*, but it's exact value and
>meaning aren't important, like so:

>>> Hey, there's a bug in the kernel!  Do "ln -s foo foo; mkdir foo"
>>> and watch the fireworks.
>
>They're rarely used to talk about new data structures except at the
>earliest speculative design state.

Isn't the earliest speculative design state rather crucial
for a mutual understanding?

We seem to agree somewhat here at least? 
=)
>-- 
>Kevin Buhr <buhr@telus.net>
>

Kind regards. and thanks again everybody.
Daniel Mose

